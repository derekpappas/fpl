/******************************************************/
/*** simulation parameters ****************************/
/******************************************************/

// simulation
`define SIM_TIME        0.10  // simulation time in seconds
`define MSG_TIME       0.001
`define DUMP               0  // save waveforms
`define DEBUG              1  // display debug msgs

// general definitions
`define BUFFER_SIZE       12  // buffer size for non-real-time packets
`define NUM_OF_STATIONS  100  // maximum number of stations

// frequency of packets
`define RT_FILE_DELAY    0.1  // number of second between two real-time files (average)
`define NRT_PACKETS_FRQ  500  // number of non-real-time packets per second (average)
                              // set NRT_PACKETS_FRQ=0 for always packet available

// sizes
`define RT_FRAME_SIZE     23  // number of bytes in a 'frame' in the head/tail
`define OVERHEAD          26  // number of bytes in a packet, in addition to the data
`define JAM_SIZE          32  // number of bits in the jamming
`define MIN_PACKET_SIZE   46  // in bytes, not including the overhead
`define MAX_PACKET_SIZE 1500  // in bytes, not including the overhead
`define RT_PACKET_SIZE  1000  // in bytes, not including the overhead
`define RT_MIN_PACKETS  1000  // packets per file
`define RT_MAX_PACKETS  5000  // packets per file

// timings
`define INTER_FRAME_GAP  960  // idle time between two succsesive transmisions
`define TAU             2500  // max delay on the bus between two stations
`define BIT_TIME          10  // 10[ns] per bit <=> 100Mb/sec
`define RT_TIME          5e6  // 5[ms] between transmisions of real-time packets
`define TAIL_TIME (2 * `TAU + `RT_FRAME_SIZE * 8 * `BIT_TIME)
`define SLOT_TIME (2 * `TAU + `JAM_SIZE * `BIT_TIME)

