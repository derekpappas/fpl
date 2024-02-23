`include "defines.v"

module ssm(gbl_clk,
           gbl_reset_,
           gbl_enable);
// Location of source csl unit: file name = /Volumes/s2/unfuddle_ssm_repo/ssm_ssmrepo/ssm/hw/ssm/ssm_demo.csl line number = 97
  input [1 - 1:0] gbl_clk;
  input [1 - 1:0] gbl_reset_;
  input [1 - 1:0] gbl_enable;
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
  wire [32 - 1:0] slave_Va2r_tap_arm_read_data;
  wire [1 - 1:0] slave_Va2r_tap_arm_ready;
  wire [1 - 1:0] slave_Va2r_tap_arm_error;
  wire [20 - 1:0] slave_Va2r_tap_arm_address;
  wire [32 - 1:0] slave_Va2r_tap_arm_data;
  wire [1 - 1:0] slave_Va2r_tap_arm_read;
  wire [1 - 1:0] slave_Va2r_tap_arm_write;
  wire [32 - 1:0] slave_Va2r_tap_dsp_read_data;
  wire [1 - 1:0] slave_Va2r_tap_dsp_ready;
  wire [1 - 1:0] slave_Va2r_tap_dsp_error;
  wire [20 - 1:0] slave_Va2r_tap_dsp_address;
  wire [32 - 1:0] slave_Va2r_tap_dsp_data;
  wire [1 - 1:0] slave_Va2r_tap_dsp_read;
  wire [1 - 1:0] slave_Va2r_tap_dsp_write;
  wire [32 - 1:0] slave_Va2r_tap_h264_read_data;
  wire [1 - 1:0] slave_Va2r_tap_h264_ready;
  wire [1 - 1:0] slave_Va2r_tap_h264_error;
  wire [20 - 1:0] slave_Va2r_tap_h264_address;
  wire [32 - 1:0] slave_Va2r_tap_h264_data;
  wire [1 - 1:0] slave_Va2r_tap_h264_read;
  wire [1 - 1:0] slave_Va2r_tap_h264_write;
  wire [32 - 1:0] slave_Va2r_tap_cmpr_read_data;
  wire [1 - 1:0] slave_Va2r_tap_cmpr_ready;
  wire [1 - 1:0] slave_Va2r_tap_cmpr_error;
  wire [20 - 1:0] slave_Va2r_tap_cmpr_address;
  wire [32 - 1:0] slave_Va2r_tap_cmpr_data;
  wire [1 - 1:0] slave_Va2r_tap_cmpr_read;
  wire [1 - 1:0] slave_Va2r_tap_cmpr_write;
  arm arm(.gbl_clk(gbl_clk),
          .gbl_enable(gbl_enable),
          .gbl_reset_(gbl_reset_),
          .slave_Va2r_tap_arm_address(slave_Va2r_tap_arm_address),
          .slave_Va2r_tap_arm_data(slave_Va2r_tap_arm_data),
          .slave_Va2r_tap_arm_error(slave_Va2r_tap_arm_error),
          .slave_Va2r_tap_arm_read(slave_Va2r_tap_arm_read),
          .slave_Va2r_tap_arm_read_data(slave_Va2r_tap_arm_read_data),
          .slave_Va2r_tap_arm_ready(slave_Va2r_tap_arm_ready),
          .slave_Va2r_tap_arm_write(slave_Va2r_tap_arm_write));
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
  Va2r_tap Va2r_tap_arm(.Va2r_tap_master_ifc_address(master_a2p_arm_address),
                        .Va2r_tap_master_ifc_error(master_a2p_arm_error),
                        .Va2r_tap_master_ifc_read(master_a2p_arm_read),
                        .Va2r_tap_master_ifc_read_data(master_a2p_arm_read_data),
                        .Va2r_tap_master_ifc_ready(master_a2p_arm_ready),
                        .Va2r_tap_master_ifc_write(master_a2p_arm_write),
                        .Va2r_tap_master_ifc_write_data(master_a2p_arm_write_data),
                        .Va2r_tap_slave_out_ifc_address(slave_Va2r_tap_arm_address),
                        .Va2r_tap_slave_out_ifc_data(slave_Va2r_tap_arm_data),
                        .Va2r_tap_slave_out_ifc_error(slave_Va2r_tap_arm_error),
                        .Va2r_tap_slave_out_ifc_read(slave_Va2r_tap_arm_read),
                        .Va2r_tap_slave_out_ifc_read_data(slave_Va2r_tap_arm_read_data),
                        .Va2r_tap_slave_out_ifc_ready(slave_Va2r_tap_arm_ready),
                        .Va2r_tap_slave_out_ifc_write(slave_Va2r_tap_arm_write),
                        .gbl_clk(gbl_clk),
                        .gbl_enable(gbl_enable),
                        .gbl_reset_(gbl_reset_),
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
  dsp dsp(.gbl_clk(gbl_clk),
          .gbl_enable(gbl_enable),
          .gbl_reset_(gbl_reset_),
          .slave_Va2r_tap_dsp_address(slave_Va2r_tap_dsp_address),
          .slave_Va2r_tap_dsp_data(slave_Va2r_tap_dsp_data),
          .slave_Va2r_tap_dsp_error(slave_Va2r_tap_dsp_error),
          .slave_Va2r_tap_dsp_read(slave_Va2r_tap_dsp_read),
          .slave_Va2r_tap_dsp_read_data(slave_Va2r_tap_dsp_read_data),
          .slave_Va2r_tap_dsp_ready(slave_Va2r_tap_dsp_ready),
          .slave_Va2r_tap_dsp_write(slave_Va2r_tap_dsp_write));
  Va2r_tap Va2r_tap_cmpr(.Va2r_tap_master_ifc_address(master_dummy3_address),
                         .Va2r_tap_master_ifc_error(master_dummy3_error),
                         .Va2r_tap_master_ifc_read(master_dummy3_read),
                         .Va2r_tap_master_ifc_read_data(master_dummy3_read_data),
                         .Va2r_tap_master_ifc_ready(master_dummy3_ready),
                         .Va2r_tap_master_ifc_write(master_dummy3_write),
                         .Va2r_tap_master_ifc_write_data(master_dummy3_write_data),
                         .Va2r_tap_slave_out_ifc_address(slave_Va2r_tap_cmpr_address),
                         .Va2r_tap_slave_out_ifc_data(slave_Va2r_tap_cmpr_data),
                         .Va2r_tap_slave_out_ifc_error(slave_Va2r_tap_cmpr_error),
                         .Va2r_tap_slave_out_ifc_read(slave_Va2r_tap_cmpr_read),
                         .Va2r_tap_slave_out_ifc_read_data(slave_Va2r_tap_cmpr_read_data),
                         .Va2r_tap_slave_out_ifc_ready(slave_Va2r_tap_cmpr_ready),
                         .Va2r_tap_slave_out_ifc_write(slave_Va2r_tap_cmpr_write),
                         .gbl_clk(gbl_clk),
                         .gbl_enable(gbl_enable),
                         .gbl_reset_(gbl_reset_),
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
  cmpr cmpr(.gbl_clk(gbl_clk),
            .gbl_enable(gbl_enable),
            .gbl_reset_(gbl_reset_),
            .slave_Va2r_tap_cmpr_address(slave_Va2r_tap_cmpr_address),
            .slave_Va2r_tap_cmpr_data(slave_Va2r_tap_cmpr_data),
            .slave_Va2r_tap_cmpr_error(slave_Va2r_tap_cmpr_error),
            .slave_Va2r_tap_cmpr_read(slave_Va2r_tap_cmpr_read),
            .slave_Va2r_tap_cmpr_read_data(slave_Va2r_tap_cmpr_read_data),
            .slave_Va2r_tap_cmpr_ready(slave_Va2r_tap_cmpr_ready),
            .slave_Va2r_tap_cmpr_write(slave_Va2r_tap_cmpr_write));
  Va2r_tap Va2r_tap_dsp(.Va2r_tap_master_ifc_address(master_dummy1_address),
                        .Va2r_tap_master_ifc_error(master_dummy1_error),
                        .Va2r_tap_master_ifc_read(master_dummy1_read),
                        .Va2r_tap_master_ifc_read_data(master_dummy1_read_data),
                        .Va2r_tap_master_ifc_ready(master_dummy1_ready),
                        .Va2r_tap_master_ifc_write(master_dummy1_write),
                        .Va2r_tap_master_ifc_write_data(master_dummy1_write_data),
                        .Va2r_tap_slave_out_ifc_address(slave_Va2r_tap_dsp_address),
                        .Va2r_tap_slave_out_ifc_data(slave_Va2r_tap_dsp_data),
                        .Va2r_tap_slave_out_ifc_error(slave_Va2r_tap_dsp_error),
                        .Va2r_tap_slave_out_ifc_read(slave_Va2r_tap_dsp_read),
                        .Va2r_tap_slave_out_ifc_read_data(slave_Va2r_tap_dsp_read_data),
                        .Va2r_tap_slave_out_ifc_ready(slave_Va2r_tap_dsp_ready),
                        .Va2r_tap_slave_out_ifc_write(slave_Va2r_tap_dsp_write),
                        .gbl_clk(gbl_clk),
                        .gbl_enable(gbl_enable),
                        .gbl_reset_(gbl_reset_),
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
  Va2r_tap Va2r_tap_h264(.Va2r_tap_master_ifc_address(master_dummy2_address),
                         .Va2r_tap_master_ifc_error(master_dummy2_error),
                         .Va2r_tap_master_ifc_read(master_dummy2_read),
                         .Va2r_tap_master_ifc_read_data(master_dummy2_read_data),
                         .Va2r_tap_master_ifc_ready(master_dummy2_ready),
                         .Va2r_tap_master_ifc_write(master_dummy2_write),
                         .Va2r_tap_master_ifc_write_data(master_dummy2_write_data),
                         .Va2r_tap_slave_out_ifc_address(slave_Va2r_tap_h264_address),
                         .Va2r_tap_slave_out_ifc_data(slave_Va2r_tap_h264_data),
                         .Va2r_tap_slave_out_ifc_error(slave_Va2r_tap_h264_error),
                         .Va2r_tap_slave_out_ifc_read(slave_Va2r_tap_h264_read),
                         .Va2r_tap_slave_out_ifc_read_data(slave_Va2r_tap_h264_read_data),
                         .Va2r_tap_slave_out_ifc_ready(slave_Va2r_tap_h264_ready),
                         .Va2r_tap_slave_out_ifc_write(slave_Va2r_tap_h264_write),
                         .gbl_clk(gbl_clk),
                         .gbl_enable(gbl_enable),
                         .gbl_reset_(gbl_reset_),
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
  ssm_master ssm_master(.Va2r_tap_master_ifc_address(master_a2p_arm_address),
                        .Va2r_tap_master_ifc_error(master_a2p_arm_error),
                        .Va2r_tap_master_ifc_read(master_a2p_arm_read),
                        .Va2r_tap_master_ifc_read_data(master_a2p_arm_read_data),
                        .Va2r_tap_master_ifc_ready(master_a2p_arm_ready),
                        .Va2r_tap_master_ifc_write(master_a2p_arm_write),
                        .Va2r_tap_master_ifc_write_data(master_a2p_arm_write_data),
                        .gbl_clk(gbl_clk),
                        .gbl_enable(gbl_enable),
                        .gbl_reset_(gbl_reset_));
  h264 h264(.gbl_clk(gbl_clk),
            .gbl_enable(gbl_enable),
            .gbl_reset_(gbl_reset_),
            .slave_Va2r_tap_h264_address(slave_Va2r_tap_h264_address),
            .slave_Va2r_tap_h264_data(slave_Va2r_tap_h264_data),
            .slave_Va2r_tap_h264_error(slave_Va2r_tap_h264_error),
            .slave_Va2r_tap_h264_read(slave_Va2r_tap_h264_read),
            .slave_Va2r_tap_h264_read_data(slave_Va2r_tap_h264_read_data),
            .slave_Va2r_tap_h264_ready(slave_Va2r_tap_h264_ready),
            .slave_Va2r_tap_h264_write(slave_Va2r_tap_h264_write));
  `include "ssm.logic.vh"
endmodule

