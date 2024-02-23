`include "defines.v"

module ssm_demo();
// Location of source csl unit: file name = /opt/new_aurora_fpl_repo/repos/trunk/cslc/misc/projects/ssm/ssm_demo.csl line number = 140
  wire [1 - 1:0] master_a2p_arm_address;
  wire [1 - 1:0] master_a2p_arm_write_data;
  wire [1 - 1:0] master_a2p_arm_read;
  wire [1 - 1:0] master_a2p_arm_write;
  wire [1 - 1:0] master_a2p_arm_read_data;
  wire [1 - 1:0] master_a2p_arm_ready;
  wire [1 - 1:0] master_a2p_arm_error;
  wire [1 - 1:0] master_dummy1_address;
  wire [1 - 1:0] master_dummy1_write_data;
  wire [1 - 1:0] master_dummy1_read;
  wire [1 - 1:0] master_dummy1_write;
  wire [1 - 1:0] master_dummy1_read_data;
  wire [1 - 1:0] master_dummy1_ready;
  wire [1 - 1:0] master_dummy1_error;
  wire [1 - 1:0] master_dummy2_address;
  wire [1 - 1:0] master_dummy2_write_data;
  wire [1 - 1:0] master_dummy2_read;
  wire [1 - 1:0] master_dummy2_write;
  wire [1 - 1:0] master_dummy2_read_data;
  wire [1 - 1:0] master_dummy2_ready;
  wire [1 - 1:0] master_dummy2_error;
  wire [1 - 1:0] master_dummy3_address;
  wire [1 - 1:0] master_dummy3_write_data;
  wire [1 - 1:0] master_dummy3_read;
  wire [1 - 1:0] master_dummy3_write;
  wire [1 - 1:0] master_dummy3_read_data;
  wire [1 - 1:0] master_dummy3_ready;
  wire [1 - 1:0] master_dummy3_error;
  wire [1 - 1:0] ring_arm_dsp_grant;
  wire [1 - 1:0] ring_arm_dsp_request;
  wire [1 - 1:0] ring_arm_dsp_in;
  wire [1 - 1:0] ring_arm_dsp_aphi;
  wire [1 - 1:0] ring_arm_dsp_write;
  wire [1 - 1:0] ring_arm_dsp_read;
  wire [1 - 1:0] ring_arm_dsp_ready;
  wire [1 - 1:0] ring_arm_dsp_error;
  wire [1 - 1:0] ring_dsp_h264_grant;
  wire [1 - 1:0] ring_dsp_h264_request;
  wire [1 - 1:0] ring_dsp_h264_in;
  wire [1 - 1:0] ring_dsp_h264_aphi;
  wire [1 - 1:0] ring_dsp_h264_write;
  wire [1 - 1:0] ring_dsp_h264_read;
  wire [1 - 1:0] ring_dsp_h264_ready;
  wire [1 - 1:0] ring_dsp_h264_error;
  wire [1 - 1:0] ring_h264_cmpr_grant;
  wire [1 - 1:0] ring_h264_cmpr_request;
  wire [1 - 1:0] ring_h264_cmpr_in;
  wire [1 - 1:0] ring_h264_cmpr_aphi;
  wire [1 - 1:0] ring_h264_cmpr_write;
  wire [1 - 1:0] ring_h264_cmpr_read;
  wire [1 - 1:0] ring_h264_cmpr_ready;
  wire [1 - 1:0] ring_h264_cmpr_error;
  wire [1 - 1:0] ring_cmpr_arm_grant;
  wire [1 - 1:0] ring_cmpr_arm_request;
  wire [1 - 1:0] ring_cmpr_arm_in;
  wire [1 - 1:0] ring_cmpr_arm_aphi;
  wire [1 - 1:0] ring_cmpr_arm_write;
  wire [1 - 1:0] ring_cmpr_arm_read;
  wire [1 - 1:0] ring_cmpr_arm_ready;
  wire [1 - 1:0] ring_cmpr_arm_error;
  wire [32 - 1:0] slave_taparm_mbc_read_data;
  wire [1 - 1:0] slave_taparm_mbc_ready;
  wire [1 - 1:0] slave_taparm_mbc_error;
  wire [20 - 1:0] slave_taparm_mbc_address;
  wire [32 - 1:0] slave_taparm_mbc_data;
  wire [1 - 1:0] slave_taparm_mbc_read;
  wire [1 - 1:0] slave_taparm_mbc_write;
  wire [32 - 1:0] slave_tapdsp_mbc_read_data;
  wire [1 - 1:0] slave_tapdsp_mbc_ready;
  wire [1 - 1:0] slave_tapdsp_mbc_error;
  wire [20 - 1:0] slave_tapdsp_mbc_address;
  wire [32 - 1:0] slave_tapdsp_mbc_data;
  wire [1 - 1:0] slave_tapdsp_mbc_read;
  wire [1 - 1:0] slave_tapdsp_mbc_write;
  wire [32 - 1:0] slave_taph264_mbc_read_data;
  wire [1 - 1:0] slave_taph264_mbc_ready;
  wire [1 - 1:0] slave_taph264_mbc_error;
  wire [20 - 1:0] slave_taph264_mbc_address;
  wire [32 - 1:0] slave_taph264_mbc_data;
  wire [1 - 1:0] slave_taph264_mbc_read;
  wire [1 - 1:0] slave_taph264_mbc_write;
  wire [32 - 1:0] slave_tapcmpr_mbc_read_data;
  wire [1 - 1:0] slave_tapcmpr_mbc_ready;
  wire [1 - 1:0] slave_tapcmpr_mbc_error;
  wire [20 - 1:0] slave_tapcmpr_mbc_address;
  wire [32 - 1:0] slave_tapcmpr_mbc_data;
  wire [1 - 1:0] slave_tapcmpr_mbc_read;
  wire [1 - 1:0] slave_tapcmpr_mbc_write;
  wire [32 - 1:0] mbc_arm_mbc_address;
  wire [32 - 1:0] mbc_arm_mbc_write_data;
  wire [1 - 1:0] mbc_arm_mbc_write;
  wire [1 - 1:0] mbc_arm_mbc_read;
  wire [32 - 1:0] mbc_arm_mbc_read_data;
  wire [32 - 1:0] mbc_arm_mbc_control;
  wire [32 - 1:0] mbc_dsp_mbc_address;
  wire [32 - 1:0] mbc_dsp_mbc_write_data;
  wire [1 - 1:0] mbc_dsp_mbc_write;
  wire [1 - 1:0] mbc_dsp_mbc_read;
  wire [32 - 1:0] mbc_dsp_mbc_read_data;
  wire [32 - 1:0] mbc_dsp_mbc_control;
  wire [32 - 1:0] mbc_h264_mbc_address;
  wire [32 - 1:0] mbc_h264_mbc_write_data;
  wire [1 - 1:0] mbc_h264_mbc_write;
  wire [1 - 1:0] mbc_h264_mbc_read;
  wire [32 - 1:0] mbc_h264_mbc_read_data;
  wire [32 - 1:0] mbc_h264_mbc_control;
  wire [32 - 1:0] mbc_cmpr_mbc_address;
  wire [32 - 1:0] mbc_cmpr_mbc_write_data;
  wire [1 - 1:0] mbc_cmpr_mbc_write;
  wire [1 - 1:0] mbc_cmpr_mbc_read;
  wire [32 - 1:0] mbc_cmpr_mbc_read_data;
  wire [32 - 1:0] mbc_cmpr_mbc_control;
  h264 h264(.mbc_out_ifc_address(mbc_h264_mbc_address),
            .mbc_out_ifc_control(mbc_h264_mbc_control),
            .mbc_out_ifc_read(mbc_h264_mbc_read),
            .mbc_out_ifc_read_data(mbc_h264_mbc_read_data),
            .mbc_out_ifc_write(mbc_h264_mbc_write),
            .mbc_out_ifc_write_data(mbc_h264_mbc_write_data));
  a2rtap a2rtap_arm(.a2rtap_master_ifc_address(master_a2p_arm_address),
                    .a2rtap_master_ifc_error(master_a2p_arm_error),
                    .a2rtap_master_ifc_read(master_a2p_arm_read),
                    .a2rtap_master_ifc_read_data(master_a2p_arm_read_data),
                    .a2rtap_master_ifc_ready(master_a2p_arm_ready),
                    .a2rtap_master_ifc_write(master_a2p_arm_write),
                    .a2rtap_master_ifc_write_data(master_a2p_arm_write_data),
                    .a2rtap_slave_out_ifc_address(slave_taparm_mbc_address),
                    .a2rtap_slave_out_ifc_data(slave_taparm_mbc_data),
                    .a2rtap_slave_out_ifc_error(slave_taparm_mbc_error),
                    .a2rtap_slave_out_ifc_read(slave_taparm_mbc_read),
                    .a2rtap_slave_out_ifc_read_data(slave_taparm_mbc_read_data),
                    .a2rtap_slave_out_ifc_ready(slave_taparm_mbc_ready),
                    .a2rtap_slave_out_ifc_write(slave_taparm_mbc_write),
                    .ring_in_ifc_aphi(ring_cmpr_arm_aphi),
                    .ring_in_ifc_error(ring_cmpr_arm_error),
                    .ring_in_ifc_grant(ring_cmpr_arm_grant),
                    .ring_in_ifc_in(ring_cmpr_arm_in),
                    .ring_in_ifc_read(ring_cmpr_arm_read),
                    .ring_in_ifc_ready(ring_cmpr_arm_ready),
                    .ring_in_ifc_request(ring_cmpr_arm_request),
                    .ring_in_ifc_write(ring_cmpr_arm_write),
                    .ring_out_ifc_aphi(ring_arm_dsp_aphi),
                    .ring_out_ifc_error(ring_arm_dsp_error),
                    .ring_out_ifc_grant(ring_arm_dsp_grant),
                    .ring_out_ifc_in(ring_arm_dsp_in),
                    .ring_out_ifc_read(ring_arm_dsp_read),
                    .ring_out_ifc_ready(ring_arm_dsp_ready),
                    .ring_out_ifc_request(ring_arm_dsp_request),
                    .ring_out_ifc_write(ring_arm_dsp_write));
  mcb mcb_h264(.a2rtap_slave_in_ifc_address(slave_taph264_mbc_address),
               .a2rtap_slave_in_ifc_data(slave_taph264_mbc_data),
               .a2rtap_slave_in_ifc_error(slave_taph264_mbc_error),
               .a2rtap_slave_in_ifc_read(slave_taph264_mbc_read),
               .a2rtap_slave_in_ifc_read_data(slave_taph264_mbc_read_data),
               .a2rtap_slave_in_ifc_ready(slave_taph264_mbc_ready),
               .a2rtap_slave_in_ifc_write(slave_taph264_mbc_write),
               .mbc_in_ifc_address(mbc_h264_mbc_address),
               .mbc_in_ifc_control(mbc_h264_mbc_control),
               .mbc_in_ifc_read(mbc_h264_mbc_read),
               .mbc_in_ifc_read_data(mbc_h264_mbc_read_data),
               .mbc_in_ifc_write(mbc_h264_mbc_write),
               .mbc_in_ifc_write_data(mbc_h264_mbc_write_data));
  cmpr cmpr(.mbc_out_ifc_address(mbc_cmpr_mbc_address),
            .mbc_out_ifc_control(mbc_cmpr_mbc_control),
            .mbc_out_ifc_read(mbc_cmpr_mbc_read),
            .mbc_out_ifc_read_data(mbc_cmpr_mbc_read_data),
            .mbc_out_ifc_write(mbc_cmpr_mbc_write),
            .mbc_out_ifc_write_data(mbc_cmpr_mbc_write_data));
  host_processor host_processor(.mbc_out_ifc_address(mbc_arm_mbc_address),
                                .mbc_out_ifc_control(mbc_arm_mbc_control),
                                .mbc_out_ifc_read(mbc_arm_mbc_read),
                                .mbc_out_ifc_read_data(mbc_arm_mbc_read_data),
                                .mbc_out_ifc_write(mbc_arm_mbc_write),
                                .mbc_out_ifc_write_data(mbc_arm_mbc_write_data));
  mcb mcb_arm(.a2rtap_slave_in_ifc_address(slave_taparm_mbc_address),
              .a2rtap_slave_in_ifc_data(slave_taparm_mbc_data),
              .a2rtap_slave_in_ifc_error(slave_taparm_mbc_error),
              .a2rtap_slave_in_ifc_read(slave_taparm_mbc_read),
              .a2rtap_slave_in_ifc_read_data(slave_taparm_mbc_read_data),
              .a2rtap_slave_in_ifc_ready(slave_taparm_mbc_ready),
              .a2rtap_slave_in_ifc_write(slave_taparm_mbc_write),
              .mbc_in_ifc_address(mbc_arm_mbc_address),
              .mbc_in_ifc_control(mbc_arm_mbc_control),
              .mbc_in_ifc_read(mbc_arm_mbc_read),
              .mbc_in_ifc_read_data(mbc_arm_mbc_read_data),
              .mbc_in_ifc_write(mbc_arm_mbc_write),
              .mbc_in_ifc_write_data(mbc_arm_mbc_write_data));
  a2rtap a2rtap_dsp(.a2rtap_master_ifc_address(master_dummy1_address),
                    .a2rtap_master_ifc_error(master_dummy1_error),
                    .a2rtap_master_ifc_read(master_dummy1_read),
                    .a2rtap_master_ifc_read_data(master_dummy1_read_data),
                    .a2rtap_master_ifc_ready(master_dummy1_ready),
                    .a2rtap_master_ifc_write(master_dummy1_write),
                    .a2rtap_master_ifc_write_data(master_dummy1_write_data),
                    .a2rtap_slave_out_ifc_address(slave_tapdsp_mbc_address),
                    .a2rtap_slave_out_ifc_data(slave_tapdsp_mbc_data),
                    .a2rtap_slave_out_ifc_error(slave_tapdsp_mbc_error),
                    .a2rtap_slave_out_ifc_read(slave_tapdsp_mbc_read),
                    .a2rtap_slave_out_ifc_read_data(slave_tapdsp_mbc_read_data),
                    .a2rtap_slave_out_ifc_ready(slave_tapdsp_mbc_ready),
                    .a2rtap_slave_out_ifc_write(slave_tapdsp_mbc_write),
                    .ring_in_ifc_aphi(ring_arm_dsp_aphi),
                    .ring_in_ifc_error(ring_arm_dsp_error),
                    .ring_in_ifc_grant(ring_arm_dsp_grant),
                    .ring_in_ifc_in(ring_arm_dsp_in),
                    .ring_in_ifc_read(ring_arm_dsp_read),
                    .ring_in_ifc_ready(ring_arm_dsp_ready),
                    .ring_in_ifc_request(ring_arm_dsp_request),
                    .ring_in_ifc_write(ring_arm_dsp_write),
                    .ring_out_ifc_aphi(ring_dsp_h264_aphi),
                    .ring_out_ifc_error(ring_dsp_h264_error),
                    .ring_out_ifc_grant(ring_dsp_h264_grant),
                    .ring_out_ifc_in(ring_dsp_h264_in),
                    .ring_out_ifc_read(ring_dsp_h264_read),
                    .ring_out_ifc_ready(ring_dsp_h264_ready),
                    .ring_out_ifc_request(ring_dsp_h264_request),
                    .ring_out_ifc_write(ring_dsp_h264_write));
  mcb mcb_dsp(.a2rtap_slave_in_ifc_address(slave_tapdsp_mbc_address),
              .a2rtap_slave_in_ifc_data(slave_tapdsp_mbc_data),
              .a2rtap_slave_in_ifc_error(slave_tapdsp_mbc_error),
              .a2rtap_slave_in_ifc_read(slave_tapdsp_mbc_read),
              .a2rtap_slave_in_ifc_read_data(slave_tapdsp_mbc_read_data),
              .a2rtap_slave_in_ifc_ready(slave_tapdsp_mbc_ready),
              .a2rtap_slave_in_ifc_write(slave_tapdsp_mbc_write),
              .mbc_in_ifc_address(mbc_dsp_mbc_address),
              .mbc_in_ifc_control(mbc_dsp_mbc_control),
              .mbc_in_ifc_read(mbc_dsp_mbc_read),
              .mbc_in_ifc_read_data(mbc_dsp_mbc_read_data),
              .mbc_in_ifc_write(mbc_dsp_mbc_write),
              .mbc_in_ifc_write_data(mbc_dsp_mbc_write_data));
  dsp dsp(.mbc_out_ifc_address(mbc_dsp_mbc_address),
          .mbc_out_ifc_control(mbc_dsp_mbc_control),
          .mbc_out_ifc_read(mbc_dsp_mbc_read),
          .mbc_out_ifc_read_data(mbc_dsp_mbc_read_data),
          .mbc_out_ifc_write(mbc_dsp_mbc_write),
          .mbc_out_ifc_write_data(mbc_dsp_mbc_write_data));
  a2rtap a2rtap_cmpr(.a2rtap_master_ifc_address(master_dummy3_address),
                     .a2rtap_master_ifc_error(master_dummy3_error),
                     .a2rtap_master_ifc_read(master_dummy3_read),
                     .a2rtap_master_ifc_read_data(master_dummy3_read_data),
                     .a2rtap_master_ifc_ready(master_dummy3_ready),
                     .a2rtap_master_ifc_write(master_dummy3_write),
                     .a2rtap_master_ifc_write_data(master_dummy3_write_data),
                     .a2rtap_slave_out_ifc_address(slave_tapcmpr_mbc_address),
                     .a2rtap_slave_out_ifc_data(slave_tapcmpr_mbc_data),
                     .a2rtap_slave_out_ifc_error(slave_tapcmpr_mbc_error),
                     .a2rtap_slave_out_ifc_read(slave_tapcmpr_mbc_read),
                     .a2rtap_slave_out_ifc_read_data(slave_tapcmpr_mbc_read_data),
                     .a2rtap_slave_out_ifc_ready(slave_tapcmpr_mbc_ready),
                     .a2rtap_slave_out_ifc_write(slave_tapcmpr_mbc_write),
                     .ring_in_ifc_aphi(ring_h264_cmpr_aphi),
                     .ring_in_ifc_error(ring_h264_cmpr_error),
                     .ring_in_ifc_grant(ring_h264_cmpr_grant),
                     .ring_in_ifc_in(ring_h264_cmpr_in),
                     .ring_in_ifc_read(ring_h264_cmpr_read),
                     .ring_in_ifc_ready(ring_h264_cmpr_ready),
                     .ring_in_ifc_request(ring_h264_cmpr_request),
                     .ring_in_ifc_write(ring_h264_cmpr_write),
                     .ring_out_ifc_aphi(ring_cmpr_arm_aphi),
                     .ring_out_ifc_error(ring_cmpr_arm_error),
                     .ring_out_ifc_grant(ring_cmpr_arm_grant),
                     .ring_out_ifc_in(ring_cmpr_arm_in),
                     .ring_out_ifc_read(ring_cmpr_arm_read),
                     .ring_out_ifc_ready(ring_cmpr_arm_ready),
                     .ring_out_ifc_request(ring_cmpr_arm_request),
                     .ring_out_ifc_write(ring_cmpr_arm_write));
  a2rtap a2rtap_h264(.a2rtap_master_ifc_address(master_dummy2_address),
                     .a2rtap_master_ifc_error(master_dummy2_error),
                     .a2rtap_master_ifc_read(master_dummy2_read),
                     .a2rtap_master_ifc_read_data(master_dummy2_read_data),
                     .a2rtap_master_ifc_ready(master_dummy2_ready),
                     .a2rtap_master_ifc_write(master_dummy2_write),
                     .a2rtap_master_ifc_write_data(master_dummy2_write_data),
                     .a2rtap_slave_out_ifc_address(slave_taph264_mbc_address),
                     .a2rtap_slave_out_ifc_data(slave_taph264_mbc_data),
                     .a2rtap_slave_out_ifc_error(slave_taph264_mbc_error),
                     .a2rtap_slave_out_ifc_read(slave_taph264_mbc_read),
                     .a2rtap_slave_out_ifc_read_data(slave_taph264_mbc_read_data),
                     .a2rtap_slave_out_ifc_ready(slave_taph264_mbc_ready),
                     .a2rtap_slave_out_ifc_write(slave_taph264_mbc_write),
                     .ring_in_ifc_aphi(ring_dsp_h264_aphi),
                     .ring_in_ifc_error(ring_dsp_h264_error),
                     .ring_in_ifc_grant(ring_dsp_h264_grant),
                     .ring_in_ifc_in(ring_dsp_h264_in),
                     .ring_in_ifc_read(ring_dsp_h264_read),
                     .ring_in_ifc_ready(ring_dsp_h264_ready),
                     .ring_in_ifc_request(ring_dsp_h264_request),
                     .ring_in_ifc_write(ring_dsp_h264_write),
                     .ring_out_ifc_aphi(ring_h264_cmpr_aphi),
                     .ring_out_ifc_error(ring_h264_cmpr_error),
                     .ring_out_ifc_grant(ring_h264_cmpr_grant),
                     .ring_out_ifc_in(ring_h264_cmpr_in),
                     .ring_out_ifc_read(ring_h264_cmpr_read),
                     .ring_out_ifc_ready(ring_h264_cmpr_ready),
                     .ring_out_ifc_request(ring_h264_cmpr_request),
                     .ring_out_ifc_write(ring_h264_cmpr_write));
  ssm_master ssm_master(.a2rtap_master_ifc_address(master_a2p_arm_address),
                        .a2rtap_master_ifc_error(master_a2p_arm_error),
                        .a2rtap_master_ifc_read(master_a2p_arm_read),
                        .a2rtap_master_ifc_read_data(master_a2p_arm_read_data),
                        .a2rtap_master_ifc_ready(master_a2p_arm_ready),
                        .a2rtap_master_ifc_write(master_a2p_arm_write),
                        .a2rtap_master_ifc_write_data(master_a2p_arm_write_data));
  dummy_unit_synth_removes dumb(.dummy1_master_ifc_address(master_dummy1_address),
                                .dummy1_master_ifc_error(master_dummy1_error),
                                .dummy1_master_ifc_read(master_dummy1_read),
                                .dummy1_master_ifc_read_data(master_dummy1_read_data),
                                .dummy1_master_ifc_ready(master_dummy1_ready),
                                .dummy1_master_ifc_write(master_dummy1_write),
                                .dummy1_master_ifc_write_data(master_dummy1_write_data),
                                .dummy2_master_ifc_address(master_dummy2_address),
                                .dummy2_master_ifc_error(master_dummy2_error),
                                .dummy2_master_ifc_read(master_dummy2_read),
                                .dummy2_master_ifc_read_data(master_dummy2_read_data),
                                .dummy2_master_ifc_ready(master_dummy2_ready),
                                .dummy2_master_ifc_write(master_dummy2_write),
                                .dummy2_master_ifc_write_data(master_dummy2_write_data),
                                .dummy3_master_ifc_address(master_dummy3_address),
                                .dummy3_master_ifc_error(master_dummy3_error),
                                .dummy3_master_ifc_read(master_dummy3_read),
                                .dummy3_master_ifc_read_data(master_dummy3_read_data),
                                .dummy3_master_ifc_ready(master_dummy3_ready),
                                .dummy3_master_ifc_write(master_dummy3_write),
                                .dummy3_master_ifc_write_data(master_dummy3_write_data));
  mcb mcb_cmpr(.a2rtap_slave_in_ifc_address(slave_tapcmpr_mbc_address),
               .a2rtap_slave_in_ifc_data(slave_tapcmpr_mbc_data),
               .a2rtap_slave_in_ifc_error(slave_tapcmpr_mbc_error),
               .a2rtap_slave_in_ifc_read(slave_tapcmpr_mbc_read),
               .a2rtap_slave_in_ifc_read_data(slave_tapcmpr_mbc_read_data),
               .a2rtap_slave_in_ifc_ready(slave_tapcmpr_mbc_ready),
               .a2rtap_slave_in_ifc_write(slave_tapcmpr_mbc_write),
               .mbc_in_ifc_address(mbc_cmpr_mbc_address),
               .mbc_in_ifc_control(mbc_cmpr_mbc_control),
               .mbc_in_ifc_read(mbc_cmpr_mbc_read),
               .mbc_in_ifc_read_data(mbc_cmpr_mbc_read_data),
               .mbc_in_ifc_write(mbc_cmpr_mbc_write),
               .mbc_in_ifc_write_data(mbc_cmpr_mbc_write_data));
  `include "ssm_demo.logic.vh"
endmodule

