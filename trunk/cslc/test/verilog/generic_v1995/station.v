module station(bus);

   parameter ID = 0;  // id number of the station
   parameter RT = 0;  // priority of real time (0 = non-real-time station)

   /******************************************************/
   /*** interface ****************************************/
   /******************************************************/

   inout bus;

   /******************************************************/
   /*** definitions **************************************/
   /******************************************************/

   reg [`ID_LNGTH-1:0] id;      // my id

   reg [`ID_LNGTH-1:0] my_next; // id of the station that transmit
                                // after me in the real-time chain

   wire [`NUM_OF_STATIONS-1:0] act_mask_n;
   wire [`NUM_OF_STATIONS-1:0] act_mask;   // mask my bit from 'act'
   reg  [`NUM_OF_STATIONS-1:0] act;        // active stations (one bit
                                           // per station) as I see it
                                           // (with delay for each station)

   wire other_trns;        // ==1 if other station transmit now
   wire collision;         // ==1 if other station transmit when I do

   reg sending;            // ==1 if I'm transmiting now

   reg [2:0] send_rt_status;   // status of sending a real-time packet:
   reg [2:0] send_nrt_status;  // status of sending a non-real-time packet:
                           // `SS_IDLE     - not in a sending process
                           // `SS_WAIT     - wait till can start transmiting
                           // `SS_HEAD     - transmiting head
                           // `SS_DATA     - transmiting data
                           // `SS_TAIL     - transmiting tail
                           // `SS_IFG      - waiting IFG (Inter Frame Gap) time
                           // `SS_JAM      - jamming (after collision detected)
                           // `SS_COL_WAIT - waiting random time after collision

   reg [1:0] state_rt;     // state of real-time:
                           // `RS_IDLE  - the station doesn't have a real-time file to send
                           // `RS_WAIT  - the station received a rt file, didn't start sending
                           // `RS_FIRST - the station is the first station in a rt chain
                           // `RS_CHAIN - the station is part of a rt chain (not the first)

   integer rt_packets_left;  // number of packets left to send
                             // until the end of the file

   reg  timer_active;      // is timer active (timer between real-time packets)
   wire active_chain;      // is there an active chain on the net
   reg  start_of_chain;    // active in the first 1[ns] of active_chain
   wire my_turn_in_chain;  // it's my turn to transmit in a real-time chain
   reg  time_to_send;      // active 1[ns] when time_to_send has arrived
   reg  end_of_timer;      // active 1[ns] timer is ended or chain was detected
   reg  first;             // am I going to be the first station in the chain

   integer bf;             // buffer fullness of non-real-time packets
   time t_new_packet;      // time until new packet is arrived
   time t_new_file;        // time until new rt file is arrived
   time t_end_timer;       // time in which the timer will go off
   time delay;             // temporary variable
   time next_time_to_send; // time to start sending the next real-time packet
   time t_started_trns;    // time in which first try of transmision started
   time t_started_wait;    // time of starting waiting for free bus
   time coming_time[`BUFFER_SIZE-1:0];
   integer index_in, index_out;

   // events
   event e_start_timer;       // start timer to check if there is an active chain
   event e_timer_to_send;     // activate timer to send next real-time packet
   event e_look_for_my_next;  // look for the next station that transmit after me

   // statistics
   integer incoming_packets;    // number of incoming 
                                // non-real-time packets
   integer lost_packet_bf;      // non-real-time packets that were
                                // lost due to full buffer
   integer nrt_packets_trns;    // non-real-time packets that were
                                // transmited successfully
   integer packets_droped;      // non-real-time packets that were
                                // droped after 16 backoffs
   real    nrt_total_size;      // total size (in bytes) of non-real-time
                                // packets that were sent successfully
   real    nrt_total_backoffs;  // total number of backoffs for all non-real-time
                                // packets that was transmited or droped
   real    nrt_total_wait_time; // time from first try to send packet until
                                // start of successful transmision
   real    total_wait_in_buffer;// waiting time in the buffer until
                                // first try to send packet
   integer n_wait_in_buffer;    // number of packets waited in buffer


   integer incoming_files;      // number of incoming 
                                // real-time files
   integer rt_packets_trns;     // real-time packets that were
                                // transmited successfully
   integer rt_f_packets_trns;   // real-time packets that were
                                // transmited successfully as first in chain
   real    rt_total_backoffs;   // total number of backoffs for all real-time
                                // packets (when trying to join a chain)
   real    rt_total_wait_time1; // time from first try to send first packet until
                                // start of successful transmision (join the chain)
   real    rt_total_wait_time2; // time from first try to send packet until
                                // start of successful transmision (in the chain)


   /******************************************************/
   /*** buffer management ********************************/
   /******************************************************/

   // initializations
   initial begin
      id = ID;
      bf = 0;
      index_in  = 0;
      index_out = 0;
      incoming_packets = 0;
      incoming_files   = 0;
      lost_packet_bf   = 0;
   end


   // get non-real-time packets into the buffer
   always begin

      // case packet is always available
      if(`NRT_PACKETS_FRQ == 0) begin

         incoming_packets = incoming_packets + 1;
         if(`DEBUG) $display($time," station #%d: packet is ready (as always...).",id);
         bf = bf + 1;   // actually bf=1 now
         wait(bf == 0); // next packet will be ready
                        // as soon as this one is handled
      end

      // case packets are coming with poison distribution
      else begin

         // incoming packets
         t_new_packet = rnd_exp(1.0e9 / `NRT_PACKETS_FRQ);
         #(t_new_packet);
         incoming_packets = incoming_packets + 1;

         // if there is room in the buffer
         if(bf < `BUFFER_SIZE) begin

            if(`DEBUG) $display($time," station #%d: receive packet.",id);
            bf = bf + 1;

            // store the time to check later how much time
            // the packet waited in the buffer
            coming_time[index_in] = $time;
            index_in = index_in + 1;
            if(index_in == `BUFFER_SIZE) index_in = 0;

         end

         // if the buffer is full
         else begin
            if(`DEBUG) $display($time," station #%d: can't receive packet (buffer is full).",id);
            lost_packet_bf = lost_packet_bf + 1;
         end

      end

   end


   // get real-time files
   always begin

      if(RT) begin

         // incoming files
         t_new_file = rnd_exp(1.0e9 * `RT_FILE_DELAY);
         #(t_new_file);
         incoming_files = incoming_files + 1;

         rt_packets_left = rnd_uniform_int(`RT_MIN_PACKETS, `RT_MAX_PACKETS);
         if(`DEBUG) $display($time," station #%d: receive real-time file of %0d packets.", id, rt_packets_left);
         -> e_start_timer;
         state_rt = `RS_WAIT;

         // wait until the file is sent
         // before enabling entrance of a new file
         wait(state_rt === `RS_IDLE);

      end

      else #(1e9);

   end


   /******************************************************/
   /*** send non-real-time packet ************************/
   /******************************************************/

   // initializations
   initial begin
      send_nrt_status = `SS_IDLE;
      nrt_packets_trns     = 0;
      packets_droped       = 0;
      nrt_total_size       = 0;
      nrt_total_backoffs   = 0;
      nrt_total_wait_time  = 0;
      total_wait_in_buffer = 0;
      n_wait_in_buffer     = 0;
   end


   // task: send non-real-time packet
   task send_nrt_packet;

      integer size;     // packet size in bytes (only data)
      integer backoffs; // number of backoffs
      reg packet_sent;  // was the packet sent yet
      time wait_time;   // wait-time after collision
      integer max_intervals;  // maximum time intervals to wait until
                              // next try to send packet, after collision

      begin

         // choose size of packet
         size = rnd_uniform_int(`MIN_PACKET_SIZE, `MAX_PACKET_SIZE);

         // initializations
         t_started_trns = $time;
         backoffs = 0;
         packet_sent = 1'b0;
         if(`DEBUG) $display($time," station #%d: starting send_nrt_packet. size=%0d", id, size);

         // loop, until sending the packet, or 16 backoffs
         while((~packet_sent) && (backoffs<16)) begin

            // wait until can start transmision
            if(`DEBUG) $display($time," station #%d: waiting for free bus.", id);
            send_nrt_status = `SS_WAIT;
            wait(~other_trns); #1;

            // transmit data
            send_data((size + `OVERHEAD) * 8); // total size in bits

            // if collision occured
            if(sending) begin
               backoffs = backoffs + 1;
               // send jam
               if(`DEBUG) $display($time," station #%d: collision #%0d occured. jamming", id, backoffs);
               send_nrt_status = `SS_JAM;
               #(`JAM_SIZE * `BIT_TIME);
               sending = 1'b0;
               // wait until next try
               max_intervals = 1 << ( (backoffs<10) ? backoffs : 10 );
               wait_time = `SLOT_TIME * rnd_uniform_int(0, max_intervals - 1);
               if(`DEBUG) $display($time," station #%d: waiting %0d (%0d slots) after collision #%0d", id, wait_time, wait_time/`SLOT_TIME, backoffs);
               send_nrt_status = `SS_COL_WAIT;
               #(wait_time);
            end

            // else: if packet was transmited successfully
            else begin
               packet_sent = 1'b1;
               if(`DEBUG) $display($time," station #%d: finished sending nrt packet. waiting IFG", id);
               send_nrt_status = `SS_IFG;
               #(`INTER_FRAME_GAP);
            end

         end // while((packet_sent===1'b0) && (backoffs<16)) begin

         // update variables
         if(packet_sent) begin
            if(`DEBUG) $display($time," station #%d: finished send_nrt_packet successfully", id);
            nrt_packets_trns = nrt_packets_trns + 1;
            nrt_total_size = nrt_total_size + size;
            nrt_total_wait_time = nrt_total_wait_time +
                                  $time - t_started_trns - 
                                  ((size + `OVERHEAD) * 8 * `BIT_TIME + `INTER_FRAME_GAP);
         end
         else begin
            if(`DEBUG) $display($time," station #%d: finished send_nrt_packet. packet droped", id);
            packets_droped = packets_droped + 1;
         end

         // statistics: how much time the packet waited in buffer
         // before start trying transmiting
         n_wait_in_buffer = n_wait_in_buffer + 1;
         if(`NRT_PACKETS_FRQ != 0) begin
            total_wait_in_buffer = total_wait_in_buffer +
                                   t_started_trns - coming_time[index_out];
            index_out = index_out + 1;
            if(index_out == `BUFFER_SIZE) index_out = 0;
         end

         bf = bf - 1; // whether sent or droped
         nrt_total_backoffs = nrt_total_backoffs + backoffs;
         send_nrt_status = `SS_IDLE;

      end
   endtask // send_nrt_packet


   // task: send_data
   task send_data;

      input size;   // overall size of packet in bits
      integer size;

      begin
         if( (state_rt === `RS_FIRST) &&
             ((next_time_to_send - $time) < (size * `BIT_TIME + `INTER_FRAME_GAP)) ) begin
             if(`DEBUG) $display($time," station #%d: waiting for next_time_to_send real-time packet.", id);
             wait(1'b0); // wait here until task disabled and send_rt_packet activated
         end
         if( (state_rt === `RS_WAIT) &&
             ((t_end_timer       - $time) < (size * `BIT_TIME + `INTER_FRAME_GAP)) ) begin
             if(`DEBUG) $display($time," station #%d: waiting for end of timer.", id);
             wait(1'b0); // wait here until task disabled and send_rt_packet activated
         end
         if(`DEBUG) $display($time," station #%d: sending nrt packet", id);
         send_nrt_status = `SS_DATA;
         sending = 1'b1;
         #(size * `BIT_TIME);
         sending = 1'b0;
      end

   endtask


   // collision
   always @(posedge collision) begin

      disable send_data;

   end


   /******************************************************/
   /*** send real-time packet ****************************/
   /******************************************************/

   // initializations
   initial begin
      send_rt_status = `SS_IDLE;
      state_rt = `RS_IDLE;
      my_next = `NO_ONE;
      rt_packets_trns     = 0;
      rt_f_packets_trns   = 0;
      rt_total_backoffs   = 0;
      rt_total_wait_time1 = 0;
      rt_total_wait_time2 = 0;
   end


   // task: send real-time packet
   task send_rt_packet;

      integer size;     // packet size in bytes (only data)
      integer delays;   // number of time intervals in delay
      integer backoffs; // number of backoffs
      reg joint;        // did I join the real-time chain yet
      time delay;       // temporary variable

      begin

         if(`DEBUG) $display($time," station #%d: starting send_rt_packet", id);

         // constant size of packet
         size = `RT_PACKET_SIZE;

         // wait until can start transmision
         begin: wait_for_send

            send_rt_status = `SS_WAIT;

            // first station in existing chain
            if(state_rt === `RS_FIRST) begin
               if($time != next_time_to_send) begin
                  $display($time," station #%d: ERROR. starting transmit in wrong time (exp=%0d)", id, next_time_to_send);
                  #10 $finish;
               end
               t_started_wait = $time;
               if(`DEBUG) $display($time," station #%d: wait for free bus", id);
               wait(~other_trns); #1;
               rt_f_packets_trns = rt_f_packets_trns + 1;
               rt_total_wait_time2 = rt_total_wait_time2 +
                                     $time - t_started_wait;
            end

            // first try of real-time (get here when can start transmit)
            else if (state_rt === `RS_WAIT) begin
            end

            // I'm part of an existing chain
            else if (state_rt === `RS_CHAIN) begin

               if(~my_turn_in_chain) begin
                  $display($time," station #%d: ERROR. starting transmit not on my turn", id);
                  #10 $finish;
               end

               // wait frame time, till I'm realy identify this fact
               #(8 * `RT_FRAME_SIZE * `BIT_TIME);

               // if current transmiter is the first in the chain,
               // and he's finishing transmiting, then
               // I'm going to be the first station in the chain.
               if(`fic & `finish) state_rt = `RS_FIRST;

               // wait the delay time on the net from the transmiter to me
               if(`trns>id) delay = (`trns - id) * `TAU / `NUM_OF_STATIONS;
               else         delay = (id - `trns) * `TAU / `NUM_OF_STATIONS;
               #(delay);

            end

            else begin
               $display($time," station #%d: ERROR. state_rt = %0d", id, state_rt);
               #10 $finish;
            end

         end // wait_for_send

         // transmit head
         begin: send_head
            joint = 1'b0;
            delays = 0;
            backoffs = 0;

            sending = 1'b1;
            t_started_trns = $time;

            `rts = `NS_HEAD;
            `trns = id;

            if(`DEBUG) $display($time," station #%d: start transmit head", id);
            send_rt_status = `SS_HEAD;
            #(`JAM_SIZE * `BIT_TIME);

            while(~joint) begin
               #(2 * `TAU);
               if(collision) begin
                  if(state_rt !== `RS_WAIT) begin
                     $display($time," station #%d: ERROR. collision detected on real-time packet in existing chain, state_rt = %0d", id, state_rt);
                     #10 $finish;
                  end
                  delays = delays + 1;
                  if(`DEBUG) $display($time," station #%d: collision #%0d on head", id, delays);
                  if(delays == RT) begin // maximum delays allowed
                     if(`DEBUG) $display($time," station #%d: giving up this time. wait to end of chain", id);
                     backoffs = backoffs + 1;
                     delays = 0;
                     first = 1'b0;
                     sending = 1'b0;
                     send_rt_status = `SS_WAIT;
                     wait((`rts === `NS_TAIL) && (`lic));
                     #(8 * `RT_FRAME_SIZE * `BIT_TIME);
                     if(`trns>id) delay = (`trns - id) * `TAU / `NUM_OF_STATIONS;
                     else         delay = (id - `trns) * `TAU / `NUM_OF_STATIONS;
                     #(delay);
                     if(`DEBUG) $display($time," station #%d: trying to join chain again", id);
                     send_rt_status = `SS_HEAD;
                     `rts = `NS_HEAD;
                     `trns = id;
                     sending = 1'b1;
                     #(`JAM_SIZE * `BIT_TIME);
                  end
               end
               else begin
                  if(`DEBUG) $display($time," station #%d: head transmited successfully", id);
                  joint = 1'b1;
               end
            end
            if(state_rt === `RS_WAIT) begin
               if(first) state_rt = `RS_FIRST; // created a new chain. now first in the chain
               else      state_rt = `RS_CHAIN; // joined an existing chain. now part of a chain
               rt_total_wait_time1 = rt_total_wait_time1 +
                                     $time - t_started_trns - 
                                     (`JAM_SIZE * `BIT_TIME + 2 * `TAU);
               if(`DEBUG) $display($time," station #%d: joined the chain%s", id, (state_rt === `RS_FIRST)?" as first":"");
            end
            if((state_rt === `RS_FIRST) && (rt_packets_left != 1)) begin
               next_time_to_send = $time - (`JAM_SIZE * `BIT_TIME + 2 * `TAU) + `RT_TIME;
               -> e_timer_to_send;
            end
         end

         // transmit data
         `rts = `NS_DATA;
         `trns = id;
         if(`DEBUG) $display($time," station #%d: transmiting data", id);
         send_rt_status = `SS_DATA;
         #((size + `OVERHEAD) * 8 * `BIT_TIME);

         // transmit tail
         begin: send_tail

            `rts = `NS_TAIL;
            `trns = id;
            `next = my_next;
            if(state_rt === `RS_FIRST) `fic = 1'b1;
            if(rt_packets_left == 1) `finish = 1'b1;

            if(`DEBUG) $display($time," station #%d: transmiting tail", id);
            send_rt_status = `SS_TAIL;
            #(`TAIL_TIME);

            if((my_next === `NO_ONE) && (~collision)) begin
               if((`rts !== `NS_TAIL) || (`trns !== id) || (!`lic)) begin
                  $display($time," station #%d: ERROR. someone touched the rts. rts=%0d ; trns=%0d ; next=%0d", id, `rts, `trns, `next);
                  #10 $finish;
               end
               `rts = `NS_IDLE;
               `trns = `NO_ONE;
            end

            rt_packets_left = rt_packets_left - 1;
            if(rt_packets_left == 0) state_rt = `RS_IDLE;

            `next = `UNKNOWN;
            `fic = 1'b0;
            `finish = 1'b0;
            sending = 1'b0;

            if(state_rt === `RS_IDLE) my_next = `NO_ONE;
            else                      -> e_look_for_my_next;

         end

         rt_packets_trns = rt_packets_trns + 1;
         rt_total_backoffs = rt_total_backoffs + backoffs;

         if(`DEBUG) $display($time," station #%d: finished sending rt packet. waiting IFG", id);
         send_rt_status = `SS_IFG;
         #(`INTER_FRAME_GAP);
         if(`DEBUG) $display($time," station #%d: finished send_rt_packet", id);
         send_rt_status = `SS_IDLE;

      end
   endtask // send_rt_packet


   // e_look_for_my_next
   always @(e_look_for_my_next) begin

      wait(   (`rts === `NS_IDLE)               ||
             ((`rts === `NS_TAIL) && ~`finish)    ); #1;

      if(`rts === `NS_IDLE) my_next = `NO_ONE;
      else                  my_next = `trns;

   end


   /******************************************************/
   /*** main state machine *******************************/
   /******************************************************/

   always begin

      if(`sim_end) begin
         #(`NUM_OF_STATIONS + 1); // until $finish
      end

      else if((state_rt === `RS_IDLE) ||        // no real-time file
              (state_rt === `RS_WAIT) ) begin   // real-time file arrived
         wait(end_of_timer || bf);
         if(end_of_timer)      send_rt_packet;
         else                  send_nrt_packet;
      end

      else if(state_rt === `RS_FIRST) begin     // I'm first in a chain
         wait(time_to_send || bf);
         if(time_to_send)      send_rt_packet;
         else                  send_nrt_packet;
      end

      else begin                                // I'm part of a chain
         wait(my_turn_in_chain || bf);
         if(my_turn_in_chain)  send_rt_packet;
         else                  send_nrt_packet;
      end

   end


   // identify my_turn_in_chain

   assign my_turn_in_chain = ((`rts === `NS_TAIL) && (`next === id));

   always @(posedge my_turn_in_chain) begin

      // check that we're part of existing chain
      if(state_rt !== `RS_CHAIN) begin
         $display($time," station #%d: ERROR. my_turn_in_chain but state_rt=%0d", id, state_rt);
         #10 $finish;
      end

      // check send_nrt_status
      if( ! ( (send_nrt_status === `SS_IDLE)     ||
              (send_nrt_status === `SS_WAIT)     ||
              (send_nrt_status === `SS_COL_WAIT)  )  ) begin
         $display($time," station #%d: ERROR. my_turn_in_chain but send_nrt_status=%0d", id, send_nrt_status);
         #10 $finish;
      end

      // disable current sending of non-real-time packet (if any)
      disable send_nrt_packet;
      send_nrt_status = `SS_IDLE;

   end


   // timer to check if there is an active chain
   initial timer_active = 1'b0;
   always @(e_start_timer) begin
      timer_active = 1'b1;
      #(`RT_TIME + 2);
      timer_active = 1'b0;
   end


   initial end_of_timer = 1'b0;
   always @(e_start_timer) begin

      first = 1'b0;
      t_end_timer = $time + (`RT_TIME + 2);

      if(`DEBUG) $display($time," station #%d: look for chain", id);
      #1;
      wait(~timer_active | start_of_chain);

      // case there is a chain
      if(start_of_chain) begin

         if(`DEBUG) $display($time," station #%d: found chain. wait to its end", id);

         // wait till there is a tail on the net, and it's the last in chain
         wait((`rts === `NS_TAIL) && (`lic));

         // wait frame time, till I'm realy identify this fact
         #(8 * `RT_FRAME_SIZE * `BIT_TIME);

         // if current transmiter is the first in the chain,
         // and he's finishing transmiting, then
         // I'm potentially going to be the first station in the chain.
         if(`fic & `finish) first = 1'b1;

         // wait the delay time on the net from the transmiter to me
         if(`trns>id) delay = (`trns - id) * `TAU / `NUM_OF_STATIONS;
         else         delay = (id - `trns) * `TAU / `NUM_OF_STATIONS;
         #(delay);

      end

      // case there isn't a chain
      else begin
         if(`DEBUG) $display($time," station #%d: there is no chain. wait for free bus", id);
         first = 1'b1;      // I'm going to be the first station in a chian
         wait(~other_trns); #1; // wait for free bus
      end

      // check send_nrt_status
      if( ! ( (send_nrt_status === `SS_IDLE)     ||
              (send_nrt_status === `SS_WAIT)     ||
              (send_nrt_status === `SS_COL_WAIT)  )  ) begin
         $display($time," station #%d: ERROR. end_of_timer but send_nrt_status=%0d", id, send_nrt_status);
         #10 $finish;
      end

      // disable current sending of non-real-time packet (if any)
      end_of_timer = 1'b1;
      disable send_nrt_packet;
      send_nrt_status = `SS_IDLE;
      #1;
      end_of_timer = 1'b0;

   end

   // identify start of chain
   assign active_chain = |`rts;

   initial start_of_chain = 1'b0;
   always @(posedge active_chain) begin
      start_of_chain = 1'b1;
      #1;
      start_of_chain = 1'b0;
   end


   // timer until time to send packet
   initial time_to_send = 1'b0;

   always @(e_timer_to_send) begin

      #(`RT_TIME - (`JAM_SIZE * `BIT_TIME + 2 * `TAU));

      if(state_rt !== `RS_FIRST) begin
         $display($time," station #%d: ERROR. time to send but state_rt = %0d", id, state_rt);
         #10 $finish;
      end

      // check send_nrt_status
      if( ! ( (send_nrt_status === `SS_IDLE)     ||
              (send_nrt_status === `SS_WAIT)     ||
              (send_nrt_status === `SS_COL_WAIT)  )  ) begin
         $display($time," station #%d: ERROR. time_to_send but send_nrt_status=%0d", id, send_nrt_status);
         #10 $finish;
      end

      if($time != next_time_to_send) begin
         $display($time," station #%d: ERROR. next_time_to_send = %0d", id, next_time_to_send);
         #10 $finish;
      end

      if(`DEBUG) $display($time," station #%d: time to send rt. disable nrt (%0d)", id, send_nrt_status);

      time_to_send = 1'b1;
      disable send_nrt_packet;
      send_nrt_status = `SS_IDLE;
      #1;
      time_to_send = 1'b0;

   end


   /******************************************************/
   /*** act management ***********************************/
   /******************************************************/

   /////////////
   // output  //
   /////////////
   initial begin
      sending = 1'b0;
   end

   always @(sending) `act[id] = sending;

   /////////////
   // input   //
   /////////////
   assign act_mask_n = (1'b1 << id);
   assign act_mask = ~act_mask_n;

   initial begin
      act = `NUM_OF_STATIONS'b0;
   end

   always @(`act) update_act;

   task update_act;
      integer i;
      time delay;

      begin
         for(i=0 ; i<`NUM_OF_STATIONS ; i=i+1) begin
            if(id>i) delay = (id - i) * `TAU / `NUM_OF_STATIONS;
            else     delay = (i - id) * `TAU / `NUM_OF_STATIONS;
            act[i] <= #(delay) `act[i];
         end
      end
   endtask

   assign other_trns = |(act & act_mask);

   assign collision = sending & other_trns;


   /******************************************************/
   /*** statistics ***************************************/
   /******************************************************/

   real avrg_nrt_size;
   real avrg_nrt_backoffs;
   real avrg_nrt_wait_time;
   real avrg_wait_in_buffer;
   real avrg_rt_backoffs;
   real avrg_rt_wait_time1;
   real avrg_rt_wait_time2;

   always @(posedge `sim_end) begin

      disable send_nrt_packet;
      send_nrt_status = `SS_IDLE;
      disable send_rt_packet;
      send_rt_status = `SS_IDLE;

      if(nrt_packets_trns)
         avrg_nrt_size       = nrt_total_size       /  nrt_packets_trns;
      else
         avrg_nrt_size       = 0;
      if(nrt_packets_trns || packets_droped)
         avrg_nrt_backoffs   = nrt_total_backoffs   / (nrt_packets_trns + packets_droped);
      else
         avrg_nrt_backoffs   = 0;
      if(nrt_packets_trns)
         avrg_nrt_wait_time  = nrt_total_wait_time  /  nrt_packets_trns;
      else
         avrg_nrt_wait_time  = 0;
      if(n_wait_in_buffer)
         avrg_wait_in_buffer = total_wait_in_buffer /  n_wait_in_buffer;
      else
         avrg_wait_in_buffer = 0;

      if(RT) begin
         if(state_rt === `RS_WAIT) incoming_files = incoming_files - 1;
         if(incoming_files)
            avrg_rt_backoffs   = rt_total_backoffs   / incoming_files;
         else
            avrg_rt_backoffs   = 0;
         if(incoming_files)
            avrg_rt_wait_time1 = rt_total_wait_time1 / incoming_files;
         else
            avrg_rt_wait_time1 = 0;
         if(rt_f_packets_trns)
            avrg_rt_wait_time2 = rt_total_wait_time2 / rt_f_packets_trns;
         else
            avrg_rt_wait_time2 = 0;
      end

      #(id);

      $display("station #%d statistics:", id);
      $display("=========================");
      $display("non-real-time");
      $display("-------------");
      $display("non-real-time incoming packets:                %d", incoming_packets);
      $display("packets lost due to full buffer:               %d", lost_packet_bf);
      $display("successfully transmited nrt packets:           %d", nrt_packets_trns);
      $display("number of droped packets after 16 backoffs:    %d", packets_droped);
      $display("number of packets left in buffer:              %d", bf);
      $display("");
      $display("average size of non-real-time packet :         %g [bytes]",    avrg_nrt_size);
      $display("average number of backoffs for a packet:       %g",            avrg_nrt_backoffs);
      $display("average wait time in the buffer:               %g [ns] (%0d)", avrg_wait_in_buffer, n_wait_in_buffer);
      $display("average wait time for start sending:           %g [ns]",       avrg_nrt_wait_time);
      $display("");
      if(RT) begin
      $display("real-time");
      $display("---------");
      $display("real-time incoming files:                      %d", incoming_files);
      $display("successfully transmited rt packets:            %d", rt_packets_trns);
      $display("number of packets left for end of file:        %d", rt_packets_left);
      $display("");
      $display("average number of backoffs for a file:         %g",            avrg_rt_backoffs);
      $display("average wait time for joining a chain:         %g [ns]",       avrg_rt_wait_time1);
      $display("average jitter wait time:                      %g [ns] (%0d)", avrg_rt_wait_time2, rt_f_packets_trns);
      $display("");
      end
      $display("");
   end


   /******************************************************/
   /*** functions ****************************************/
   /******************************************************/

   `include "functions.v"


endmodule


