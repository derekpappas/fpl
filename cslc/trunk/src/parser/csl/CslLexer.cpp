/* $ANTLR 2.7.7 (2006-11-01): "csl.lexer.g" -> "CslLexer.cpp"$ */
#include "CslLexer.hpp"
#include <antlr/CharBuffer.hpp>
#include <antlr/TokenStreamException.hpp>
#include <antlr/TokenStreamIOException.hpp>
#include <antlr/TokenStreamRecognitionException.hpp>
#include <antlr/CharStreamException.hpp>
#include <antlr/CharStreamIOException.hpp>
#include <antlr/NoViableAltForCharException.hpp>

#line 46 "csl.lexer.g"

ANTLR_USING_NAMESPACE(antlr);
#define _RS(str) (RefString(new string(str)))

#include <iostream>
#include "../../support/Base.hpp"
#include "CslToken.hpp"
#include "CslLexer.inc"

#line 22 "CslLexer.cpp"
CslLexer::CslLexer(ANTLR_USE_NAMESPACE(std)istream& in)
	: ANTLR_USE_NAMESPACE(antlr)CharScanner(new ANTLR_USE_NAMESPACE(antlr)CharBuffer(in),true)
{
	initLiterals();
}

CslLexer::CslLexer(ANTLR_USE_NAMESPACE(antlr)InputBuffer& ib)
	: ANTLR_USE_NAMESPACE(antlr)CharScanner(ib,true)
{
	initLiterals();
}

CslLexer::CslLexer(const ANTLR_USE_NAMESPACE(antlr)LexerSharedInputState& state)
	: ANTLR_USE_NAMESPACE(antlr)CharScanner(state,true)
{
	initLiterals();
}

void CslLexer::initLiterals()
{
	literals["set_reset_name"] = 175;
	literals["get_vc_module"] = 273;
	literals["auto_connect_filter"] = 312;
	literals["set_single_line"] = 73;
	literals["set_generator_type"] = 92;
	literals["create_signal"] = 396;
	literals["matrix"] = 326;
	literals["remove_signal_list"] = 337;
	literals["set_upper_index"] = 194;
	literals["set_data_word_width"] = 126;
	literals["get_vc_header_comment"] = 258;
	literals["get_enum"] = 238;
	literals["get_vc_timeout"] = 268;
	literals["v1995"] = 340;
	literals["get_dim_width"] = 215;
	literals["autorouter"] = 335;
	literals["connect_stall"] = 408;
	literals["set_model"] = 153;
	literals["csl_list"] = 5;
	literals["reset_init_value"] = 413;
	literals["csl_read_interface"] = 8;
	literals["csim_compare_level"] = 379;
	literals["get_value"] = 237;
	literals["branch"] = 410;
	literals["get_vc_start_generation_trigger"] = 263;
	literals["set_signal_name"] = 101;
	literals["set_vc_timeout"] = 64;
	literals["add_signal_list"] = 307;
	literals["set_next_pipestage"] = 160;
	literals["clk_output"] = 358;
	literals["do_not_gen_rtl"] = 420;
	literals["set_max_num_vectors"] = 81;
	literals["set_enum_item"] = 114;
	literals["csl_pipestage"] = 30;
	literals["get_name_length"] = 250;
	literals["set_pipestage_name"] = 162;
	literals["add_address_range"] = 397;
	literals["set_pli_socket_name"] = 89;
	literals["set_pop_name"] = 180;
	literals["set_direction"] = 80;
	literals["set_vc_output_filename"] = 86;
	literals["add_vector_instance"] = 360;
	literals["set_symbol_max_length"] = 138;
	literals["set_vc_max_number_of_capture_events"] = 173;
	literals["get_radix"] = 293;
	literals["int"] = 200;
	literals["get_symbol_length"] = 254;
	literals["get_max_error_count"] = 234;
	literals["get_alignment"] = 248;
	literals["get_valid_name"] = 285;
	literals["set_vc_reset"] = 169;
	literals["get_reset_name"] = 275;
	literals["get_vc_reset"] = 260;
	literals["set_testbench_verilog_filename"] = 63;
	literals["set_wr_clock_name"] = 178;
	literals["auto_gen_memory_map"] = 400;
	literals["set_valid_name"] = 185;
	literals["csl_fifo"] = 22;
	literals["set_generate_waves_filename"] = 69;
	literals["set_dut_compare_trigger"] = 68;
	literals["connect_by_pattern"] = 424;
	literals["set_final_shift_value"] = 49;
	literals["set_file_name"] = 141;
	literals["set_field_position"] = 120;
	literals["set_num_rd_ifc"] = 196;
	literals["set_mask"] = 44;
	literals["get_vc_name"] = 257;
	literals["set_const"] = 115;
	literals["no_prefix"] = 419;
	literals["column_name"] = 322;
	literals["add_enum"] = 393;
	literals["add_tb_read_event"] = 364;
	literals["set_feedback_mask"] = 45;
	literals["get_signal_prefix"] = 206;
	literals["set_connection_type"] = 78;
	literals["remove_port_list"] = 303;
	literals["MachineArch"] = 351;
	literals["set_method"] = 190;
	literals["gen_internal_unit_enable"] = 390;
	literals["set_isa"] = 102;
	literals["get_signal_value"] = 202;
	literals["csl_memory"] = 27;
	literals["get_type"] = 203;
	literals["associate_pipeline"] = 405;
	literals["register_ios"] = 422;
	literals["TA"] = 345;
	literals["csl_interface"] = 6;
	literals["gen_unique_rtl_modules"] = 418;
	literals["remove_port"] = 302;
	literals["generate_cpp_header"] = 386;
	literals["add_comment"] = 363;
	literals["add_column"] = 324;
	literals["set_pipestage"] = 191;
	literals["start_state_data_generation"] = 402;
	literals["get_vc_radix"] = 272;
	literals["set_dut_input_filename"] = 75;
	literals["generate_header_comment"] = 372;
	literals["set_duration"] = 97;
	literals["set_full_name"] = 181;
	literals["connect"] = 332;
	literals["get_vc_cpp_rd_name"] = 270;
	literals["get_vc_clock"] = 259;
	literals["set_rd_addr_name"] = 187;
	literals["csim_sample_level"] = 380;
	literals["set_clock_name"] = 176;
	literals["set_stimulus_filename"] = 84;
	literals["csl_signal"] = 12;
	literals["set_number_of_dimensions"] = 60;
	literals["set_lower_index"] = 195;
	literals["set_dim_range"] = 55;
	literals["set_instance_alteration_bit"] = 62;
	literals["get_filename"] = 232;
	literals["set_vc_start_generation_trigger"] = 144;
	literals["add_arch_state_instance"] = 361;
	literals["input_verilog_type"] = 333;
	literals["set_previous"] = 119;
	literals["set_next_address"] = 123;
	literals["add_equation"] = 415;
	literals["set_previous_pipestage"] = 159;
	literals["set_external"] = 39;
	literals["initialize"] = 296;
	literals["set_offset"] = 58;
	literals["get_output_field"] = 211;
	literals["get_wr_addr_name"] = 286;
	literals["set_pattern"] = 93;
	literals["set_name_length"] = 129;
	literals["csl_multi_dim_bitrange"] = 28;
	literals["set_decoder_name"] = 104;
	literals["set_range"] = 54;
	literals["inline_code"] = 412;
	literals["get_dim_bitrange"] = 217;
	literals["set_vc_valid_output_transaction"] = 147;
	literals["add_instruction_list"] = 384;
	literals["exclusion_list"] = 365;
	literals["set_vc_max_cycles"] = 157;
	literals["include_only"] = 366;
	literals["set_cell"] = 61;
	literals["get_data_word_width"] = 247;
	literals["set_wr_en_name"] = 188;
	literals["set_period"] = 65;
	literals["csl_isa_element"] = 19;
	literals["get_input_field"] = 210;
	literals["add_reserved_address_range"] = 398;
	literals["set_mem_instance_name"] = 82;
	literals["csl_event"] = 16;
	literals["csl_isa_field"] = 18;
	literals["csl_memory_map_page"] = 24;
	literals["sysv"] = 343;
	literals["set_default_value"] = 95;
	literals["set_pipestage_number"] = 161;
	literals["get_simulation_timeout_count"] = 228;
	literals["csl_field"] = 21;
	literals["user"] = 350;
	literals["const"] = 199;
	literals["get_endianess"] = 249;
	literals["clear_value"] = 319;
	literals["set_attr"] = 33;
	literals["add_unit_parameter"] = 308;
	literals["get_clock_name"] = 276;
	literals["get_max_num_vectors"] = 233;
	literals["set_num_wr_ifc"] = 197;
	literals["get_lsb"] = 292;
	literals["get_signal_prefix_local"] = 207;
	literals["set_vc_clock"] = 168;
	literals["set_vc_id"] = 74;
	literals["set_prefix"] = 131;
	literals["get_const"] = 240;
	literals["add_read_event"] = 369;
	literals["get_upper_bound"] = 246;
	literals["csl_enum"] = 20;
	literals["set_vc_max_number_of_valid_transactions"] = 146;
	literals["set_rd_data_name"] = 184;
	literals["set_name"] = 79;
	literals["get_vc_max_number_of_capture_events"] = 266;
	literals["set_address_increment"] = 122;
	literals["set_vc_max_num_of_transaction_events"] = 174;
	literals["SimVer"] = 347;
	literals["set_empty_name"] = 182;
	literals["set_dut_mem_init_file"] = 149;
	literals["get_cnt_dir_signal"] = 213;
	literals["set_suffix"] = 133;
	literals["initialize_random_values"] = 416;
	literals["set_dim_width"] = 51;
	literals["set_start_signal"] = 94;
	literals["set_cpp_vector_wr_name"] = 155;
	literals["add_port"] = 300;
	literals["print_signal_values_list"] = 371;
	literals["set_access_rights"] = 124;
	literals["csl_bitrange"] = 13;
	literals["set_compare_event"] = 140;
	literals["VecName"] = 346;
	literals["get_wr_en_name"] = 288;
	literals["set_shift_amount"] = 48;
	literals["set_decoder_out_name_prefix"] = 105;
	literals["add_dut_compare_trigger"] = 362;
	literals["set_lock_enable_bit"] = 43;
	literals["set_vc_capture_edge_type"] = 172;
	literals["get_push_name"] = 279;
	literals["get_upper"] = 221;
	literals["set_dut_output_filename"] = 76;
	literals["set_external_unit_enable"] = 111;
	literals["get_lower"] = 219;
	literals["generate_verilog_header"] = 387;
	literals["initialize_random"] = 417;
	literals["set_rd_clock_name"] = 177;
	literals["add_sample_event"] = 376;
	literals["set_depth"] = 37;
	literals["replicate"] = 406;
	literals["get_output_filename"] = 274;
	literals["set_addr_abs"] = 134;
	literals["add_logic"] = 317;
	literals["date"] = 349;
	literals["set_decoder_out_name_suffix"] = 106;
	literals["set_name_max_length"] = 137;
	literals["csl_unit"] = 4;
	literals["set_physical_implementation"] = 108;
	literals["add_allowed_range"] = 395;
	literals["set_alignment"] = 127;
	literals["add_signal"] = 306;
	literals["set_event_type"] = 83;
	literals["set_source"] = 139;
	literals["add_pipestage"] = 407;
	literals["csl_register_file"] = 7;
	literals["add_io_list"] = 374;
	literals["get_dim_lower"] = 220;
	literals["add_instance"] = 298;
	literals["stop_at_end_value"] = 320;
	literals["generate_decoder"] = 389;
	literals["csl_write_interface"] = 9;
	literals["set_shift_type"] = 47;
	literals["get_empty_name"] = 282;
	literals["include_file"] = 356;
	literals["set_msb"] = 192;
	literals["get_unit_prefix"] = 205;
	literals["get_offset"] = 223;
	literals["add_instruction_format_list"] = 382;
	literals["add_to_memory_map"] = 401;
	literals["add_missmatch_logic"] = 375;
	literals["csl_vector"] = 26;
	literals["set_dim_bitrange"] = 53;
	literals["set_dut_mem"] = 71;
	literals["set_expected_filename"] = 85;
	literals["csl_state_data"] = 25;
	literals["override_parameter"] = 309;
	literals["get_vc_compare_trigger"] = 262;
	literals["set_next"] = 118;
	literals["set_dut_mem_init"] = 72;
	literals["get_wr_data_name"] = 283;
	literals["get_wr_clock_name"] = 278;
	literals["get_address_increment"] = 255;
	literals["add_csim_unit"] = 377;
	literals["set_vc_name"] = 165;
	literals["class"] = 294;
	literals["get_vc_id"] = 229;
	literals["do_not_gen_cpp"] = 421;
	literals["oscillator"] = 352;
	literals["get_isa"] = 235;
	literals["set_width"] = 50;
	literals["public"] = 295;
	literals["set_attributes"] = 42;
	literals["print_signal_name_list"] = 370;
	literals["get_access_rights_enum"] = 244;
	literals["get_lower_bound"] = 245;
	literals["set_reset"] = 96;
	literals["get_cell"] = 226;
	literals["invert"] = 329;
	literals["set_unit_id"] = 110;
	literals["add_pipeline_delay"] = 414;
	literals["add_interface"] = 305;
	literals["index_data_pair"] = 316;
	literals["add_port_list"] = 301;
	literals["set_csim_unit_name"] = 88;
	literals["get_range"] = 218;
	literals["csl_port"] = 11;
	literals["get_prefix"] = 252;
	literals["set_unit_name"] = 132;
	literals["set_field"] = 116;
	literals["connect_by_name"] = 425;
	literals["connect_units"] = 423;
	literals["get_dim_upper"] = 222;
	literals["set_signal_prefix_local"] = 36;
	literals["get_attr"] = 204;
	literals["set_position"] = 117;
	literals["get_enum_item"] = 239;
	literals["get_pipestage"] = 290;
	literals["set_capture_event"] = 150;
	literals["set_wr_addr_name"] = 186;
	literals["set_vc_stall"] = 170;
	literals["set_cpp_vector_rd_name"] = 154;
	literals["get_vc_end_generation_trigger"] = 264;
	literals["csl_pipeline"] = 29;
	literals["get_vc_stall"] = 261;
	literals["get_suffix"] = 253;
	literals["set_tb_dut_name"] = 87;
	literals["add_reset"] = 359;
	literals["v2005"] = 342;
	literals["add_signal_group"] = 338;
	literals["get_depth"] = 208;
	literals["set_enum"] = 113;
	literals["set_clk_divider"] = 98;
	literals["csl_register"] = 10;
	literals["set_page_no"] = 136;
	literals["get_name"] = 231;
	literals["add_event"] = 367;
	literals["continuous"] = 354;
	literals["add_valid_to_register"] = 313;
	literals["set_signal_prefix"] = 35;
	literals["set_vc_cpp_wr_name"] = 143;
	literals["set_rd_en_name"] = 189;
	literals["set_radix"] = 91;
	literals["set_mnemonic"] = 103;
	literals["print"] = 388;
	literals["add_field"] = 385;
	literals["get_attributes"] = 209;
	literals["get_mnemonic"] = 236;
	literals["gen_mux"] = 392;
	literals["get_transaction_timeout_count"] = 227;
	literals["set_const_value"] = 38;
	literals["set_endianess"] = 128;
	literals["get_lock_enable_bit"] = 212;
	literals["get_address_visibility"] = 251;
	literals["add_value"] = 321;
	literals["set_unit_prefix"] = 34;
	literals["csl_memory_map"] = 23;
	literals["auto_connect_verilog_and_csl"] = 311;
	literals["get_vc_max_number_of_valid_transactions"] = 256;
	literals["add_fieldlist"] = 394;
	literals["pwl"] = 353;
	literals["get_number_of_dimensions"] = 225;
	literals["set_number_of_pipestages"] = 158;
	literals["v2001"] = 341;
	literals["set_vc_compare_trigger"] = 151;
	literals["add_instruction"] = 383;
	literals["concat"] = 331;
	literals["inline_file"] = 411;
	literals["get_dim_offset"] = 224;
	literals["directive"] = 315;
	literals["set_max_error_count"] = 90;
	literals["set_vc_max_num_states"] = 77;
	literals["set_addr_rel"] = 135;
	literals["connect_enable"] = 409;
	literals["set_address"] = 41;
	literals["get_interface"] = 201;
	literals["set_bitrange"] = 52;
	literals["remove_signal"] = 336;
	literals["set_feedback_element"] = 46;
	literals["set_transaction_type"] = 148;
	literals["set_dim_offset"] = 59;
	literals["get_rd_addr_name"] = 287;
	literals["get_bitrange"] = 216;
	literals["set_access_rights_enum"] = 125;
	literals["get_width"] = 214;
	literals["merge"] = 328;
	literals["reset_value"] = 318;
	literals["set_value"] = 112;
	literals["get_full_name"] = 281;
	literals["set_clk_multiplier"] = 99;
	literals["set_push_name"] = 179;
	literals["set_wr_data_name"] = 183;
	literals["set_vc_header_comment"] = 166;
	literals["connect_split"] = 327;
	literals["CA"] = 344;
	literals["get_rd_en_name"] = 289;
	literals["set_phase_difference"] = 100;
	literals["set_vc_end_generation_trigger"] = 171;
	literals["output_verilog_type"] = 334;
	literals["add_write_event"] = 368;
	literals["set_pipestage_valid_output"] = 164;
	literals["get_next_address"] = 243;
	literals["SimArgs"] = 348;
	literals["csl_testbench"] = 15;
	literals["add_dut_instance"] = 355;
	literals["csl_parameter"] = 31;
	literals["auto_connect_width_inference"] = 310;
	literals["get_field"] = 241;
	literals["set_type"] = 32;
	literals["get_vc_output_filename"] = 269;
	literals["set_dim_upper_index"] = 57;
	literals["set_clock"] = 198;
	literals["create_rtl_module"] = 314;
	literals["set_instance_name"] = 70;
	literals["set_number_of_ports"] = 40;
	literals["pipestage_naming_convention"] = 404;
	literals["gen_part_select"] = 391;
	literals["set_transaction_timeout_count"] = 67;
	literals["set_version"] = 167;
	literals["set_unit_id_address"] = 109;
	literals["buffer"] = 330;
	literals["rtl_compare_level"] = 378;
	literals["add_instruction_format"] = 381;
	literals["get_vc_max_number_of_mismatches"] = 267;
	literals["start_vector_generation"] = 403;
	literals["add_clock_gen"] = 357;
	literals["get_rd_clock_name"] = 277;
	literals["reverse"] = 304;
	literals["add_instance_list"] = 299;
	literals["set_max_num_of_vectors"] = 156;
	literals["#include"] = 297;
	literals["get_fieldlist"] = 242;
	literals["set_lsb"] = 193;
	literals["get_pop_name"] = 280;
	literals["add"] = 399;
	literals["set_top_unit"] = 121;
	literals["set_pipestage_valid_input"] = 163;
	literals["add_port_group"] = 339;
	literals["add_clock"] = 152;
	literals["set_address_visibility"] = 130;
	literals["get_msb"] = 291;
	literals["csl_include"] = 17;
	literals["add_row"] = 325;
	literals["add_valid_bit_to_last_vector"] = 373;
	literals["set_dim_lower_index"] = 56;
	literals["set_timebase"] = 66;
	literals["csl_signal_group"] = 14;
	literals["get_vc_cpp_wr_name"] = 271;
	literals["set_vc_max_number_of_mismatches"] = 145;
	literals["get_vc_capture_edge_type"] = 265;
	literals["row_name"] = 323;
	literals["set_vc_cpp_rd_name"] = 142;
	literals["set_dimensions"] = 107;
	literals["get_rd_data_name"] = 284;
	literals["get_vc_max_num_states"] = 230;
}

ANTLR_USE_NAMESPACE(antlr)RefToken CslLexer::nextToken()
{
	ANTLR_USE_NAMESPACE(antlr)RefToken theRetToken;
	for (;;) {
		ANTLR_USE_NAMESPACE(antlr)RefToken theRetToken;
		int _ttype = ANTLR_USE_NAMESPACE(antlr)Token::INVALID_TYPE;
		resetText();
		try {   // for lexical and char stream error handling
			switch ( LA(1)) {
			case 0x40 /* '@' */ :
			{
				mAT(true);
				theRetToken=_returnToken;
				break;
			}
			case 0x3a /* ':' */ :
			{
				mCOLON(true);
				theRetToken=_returnToken;
				break;
			}
			case 0x2c /* ',' */ :
			{
				mCOMMA(true);
				theRetToken=_returnToken;
				break;
			}
			case 0x2e /* '.' */ :
			{
				mDOT(true);
				theRetToken=_returnToken;
				break;
			}
			case 0x5b /* '[' */ :
			{
				mLBRACK(true);
				theRetToken=_returnToken;
				break;
			}
			case 0x5d /* ']' */ :
			{
				mRBRACK(true);
				theRetToken=_returnToken;
				break;
			}
			case 0x7b /* '{' */ :
			{
				mLCURLY(true);
				theRetToken=_returnToken;
				break;
			}
			case 0x7d /* '}' */ :
			{
				mRCURLY(true);
				theRetToken=_returnToken;
				break;
			}
			case 0x29 /* ')' */ :
			{
				mRPAREN(true);
				theRetToken=_returnToken;
				break;
			}
			case 0x23 /* '#' */ :
			{
				mPOUND(true);
				theRetToken=_returnToken;
				break;
			}
			case 0x3f /* '?' */ :
			{
				mQUESTION(true);
				theRetToken=_returnToken;
				break;
			}
			case 0x3b /* ';' */ :
			{
				mSEMI(true);
				theRetToken=_returnToken;
				break;
			}
			case 0x5e /* '^' */ :
			{
				mXOR(true);
				theRetToken=_returnToken;
				break;
			}
			case 0x25 /* '%' */ :
			{
				mMOD(true);
				theRetToken=_returnToken;
				break;
			}
			case 0x41 /* 'A' */ :
			case 0x42 /* 'B' */ :
			case 0x43 /* 'C' */ :
			case 0x44 /* 'D' */ :
			case 0x45 /* 'E' */ :
			case 0x46 /* 'F' */ :
			case 0x47 /* 'G' */ :
			case 0x48 /* 'H' */ :
			case 0x49 /* 'I' */ :
			case 0x4a /* 'J' */ :
			case 0x4b /* 'K' */ :
			case 0x4c /* 'L' */ :
			case 0x4d /* 'M' */ :
			case 0x4e /* 'N' */ :
			case 0x4f /* 'O' */ :
			case 0x50 /* 'P' */ :
			case 0x51 /* 'Q' */ :
			case 0x52 /* 'R' */ :
			case 0x53 /* 'S' */ :
			case 0x54 /* 'T' */ :
			case 0x55 /* 'U' */ :
			case 0x56 /* 'V' */ :
			case 0x57 /* 'W' */ :
			case 0x58 /* 'X' */ :
			case 0x59 /* 'Y' */ :
			case 0x5a /* 'Z' */ :
			case 0x5f /* '_' */ :
			case 0x61 /* 'a' */ :
			case 0x62 /* 'b' */ :
			case 0x63 /* 'c' */ :
			case 0x64 /* 'd' */ :
			case 0x65 /* 'e' */ :
			case 0x66 /* 'f' */ :
			case 0x67 /* 'g' */ :
			case 0x68 /* 'h' */ :
			case 0x69 /* 'i' */ :
			case 0x6a /* 'j' */ :
			case 0x6b /* 'k' */ :
			case 0x6c /* 'l' */ :
			case 0x6d /* 'm' */ :
			case 0x6e /* 'n' */ :
			case 0x6f /* 'o' */ :
			case 0x70 /* 'p' */ :
			case 0x71 /* 'q' */ :
			case 0x72 /* 'r' */ :
			case 0x73 /* 's' */ :
			case 0x74 /* 't' */ :
			case 0x75 /* 'u' */ :
			case 0x76 /* 'v' */ :
			case 0x77 /* 'w' */ :
			case 0x78 /* 'x' */ :
			case 0x79 /* 'y' */ :
			case 0x7a /* 'z' */ :
			{
				mIDENTIFIER(true);
				theRetToken=_returnToken;
				break;
			}
			case 0x5c /* '\\' */ :
			{
				mESCAPED_IDENTIFIER(true);
				theRetToken=_returnToken;
				break;
			}
			case 0x22 /* '\"' */ :
			{
				mSTRING(true);
				theRetToken=_returnToken;
				break;
			}
			case 0x27 /* '\'' */ :
			case 0x30 /* '0' */ :
			case 0x31 /* '1' */ :
			case 0x32 /* '2' */ :
			case 0x33 /* '3' */ :
			case 0x34 /* '4' */ :
			case 0x35 /* '5' */ :
			case 0x36 /* '6' */ :
			case 0x37 /* '7' */ :
			case 0x38 /* '8' */ :
			case 0x39 /* '9' */ :
			{
				mNUMBER(true);
				theRetToken=_returnToken;
				break;
			}
			case 0x24 /* '$' */ :
			{
				mSYSTEM_TASK_NAME(true);
				theRetToken=_returnToken;
				break;
			}
			case 0x8 /* '\10' */ :
			case 0x9 /* '\t' */ :
			case 0xa /* '\n' */ :
			case 0xc /* '\14' */ :
			case 0xd /* '\r' */ :
			case 0x20 /* ' ' */ :
			{
				mWS(true);
				theRetToken=_returnToken;
				break;
			}
			default:
				if ((LA(1) == 0x21 /* '!' */ ) && (LA(2) == 0x3d /* '=' */ ) && (LA(3) == 0x3d /* '=' */ )) {
					mNOT_EQ_CASE(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x3d /* '=' */ ) && (LA(2) == 0x3d /* '=' */ ) && (LA(3) == 0x3d /* '=' */ )) {
					mEQ_CASE(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x26 /* '&' */ ) && (LA(2) == 0x26 /* '&' */ ) && (LA(3) == 0x26 /* '&' */ )) {
					mTAND(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x3c /* '<' */ ) && (LA(2) == 0x3c /* '<' */ ) && (LA(3) == 0x3c /* '<' */ )) {
					mSSL(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x3e /* '>' */ ) && (LA(2) == 0x3e /* '>' */ ) && (LA(3) == 0x3e /* '>' */ )) {
					mSSR(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x7e /* '~' */ ) && (LA(2) == 0x26 /* '&' */ )) {
					mNAND(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x7e /* '~' */ ) && (LA(2) == 0x7c /* '|' */ )) {
					mNOR(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x7e /* '~' */ ) && (LA(2) == 0x5e /* '^' */ )) {
					mXNOR(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x2a /* '*' */ ) && (LA(2) == 0x2a /* '*' */ )) {
					mPOW(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x3d /* '=' */ ) && (LA(2) == 0x3d /* '=' */ ) && (true)) {
					mEQUAL(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x21 /* '!' */ ) && (LA(2) == 0x3d /* '=' */ ) && (true)) {
					mNOT_EQ(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x26 /* '&' */ ) && (LA(2) == 0x26 /* '&' */ ) && (true)) {
					mLAND(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x7c /* '|' */ ) && (LA(2) == 0x7c /* '|' */ )) {
					mLOR(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x3c /* '<' */ ) && (LA(2) == 0x3d /* '=' */ )) {
					mLE(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x3e /* '>' */ ) && (LA(2) == 0x3d /* '=' */ )) {
					mGE(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x3c /* '<' */ ) && (LA(2) == 0x3c /* '<' */ ) && (true)) {
					mSL(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x3e /* '>' */ ) && (LA(2) == 0x3e /* '>' */ ) && (true)) {
					mSR(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x2d /* '-' */ ) && (LA(2) == 0x3e /* '>' */ )) {
					mTRIGGER(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x3d /* '=' */ ) && (LA(2) == 0x3e /* '>' */ )) {
					mPPATH(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x2a /* '*' */ ) && (LA(2) == 0x3e /* '>' */ )) {
					mFPATH(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x2a /* '*' */ ) && (LA(2) == 0x29 /* ')' */ )) {
					mSTARP(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x2b /* '+' */ ) && (LA(2) == 0x3a /* ':' */ )) {
					mPO_POS(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x2d /* '-' */ ) && (LA(2) == 0x3a /* ':' */ )) {
					mPO_NEG(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x28 /* '(' */ ) && (LA(2) == 0x2a /* '*' */ )) {
					mSUPERSTAR(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x60 /* '`' */ ) && (_tokenSet_0.member(LA(2)))) {
					mDIRECTIVE(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x2f /* '/' */ ) && (LA(2) == 0x2f /* '/' */ )) {
					mSL_COMMENT(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x2f /* '/' */ ) && (LA(2) == 0x2a /* '*' */ )) {
					mML_COMMENT(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x60 /* '`' */ ) && (true)) {
					mBACKTICK(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x3d /* '=' */ ) && (true)) {
					mASSIGN(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x2d /* '-' */ ) && (true)) {
					mMINUS(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x28 /* '(' */ ) && (true)) {
					mLPAREN(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x2b /* '+' */ ) && (true)) {
					mPLUS(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x21 /* '!' */ ) && (true)) {
					mLNOT(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x7e /* '~' */ ) && (true)) {
					mNOT(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x26 /* '&' */ ) && (true)) {
					mAND(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x7c /* '|' */ ) && (true)) {
					mOR(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x2a /* '*' */ ) && (true)) {
					mSTAR(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x2f /* '/' */ ) && (true)) {
					mDIV(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x3c /* '<' */ ) && (true)) {
					mLT_(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x3e /* '>' */ ) && (true)) {
					mGT(true);
					theRetToken=_returnToken;
				}
			else {
				if (LA(1)==EOF_CHAR)
				{
					uponEOF();
					_returnToken = makeToken(ANTLR_USE_NAMESPACE(antlr)Token::EOF_TYPE);
				}
				else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltForCharException(LA(1), getFilename(), getLine(), getColumn());}
			}
			}
			if ( !_returnToken )
				goto tryAgain; // found SKIP token

			_ttype = _returnToken->getType();
			_returnToken->setType(_ttype);
			return _returnToken;
		}
		catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& e) {
				throw ANTLR_USE_NAMESPACE(antlr)TokenStreamRecognitionException(e);
		}
		catch (ANTLR_USE_NAMESPACE(antlr)CharStreamIOException& csie) {
			throw ANTLR_USE_NAMESPACE(antlr)TokenStreamIOException(csie.io);
		}
		catch (ANTLR_USE_NAMESPACE(antlr)CharStreamException& cse) {
			throw ANTLR_USE_NAMESPACE(antlr)TokenStreamException(cse.getMessage());
		}
tryAgain:;
	}
}

void CslLexer::mBACKTICK(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = BACKTICK;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match("`");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void CslLexer::mAT(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = AT;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match("@");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void CslLexer::mCOLON(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = COLON;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match(":");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void CslLexer::mCOMMA(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = COMMA;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match(",");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void CslLexer::mDOT(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = DOT;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match(".");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void CslLexer::mASSIGN(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = ASSIGN;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match("=");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void CslLexer::mMINUS(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = MINUS;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match("-");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void CslLexer::mLBRACK(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = LBRACK;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match("[");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void CslLexer::mRBRACK(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = RBRACK;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match("]");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void CslLexer::mLCURLY(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = LCURLY;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match("{");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void CslLexer::mRCURLY(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = RCURLY;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match("}");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void CslLexer::mLPAREN(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = LPAREN;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match("(");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void CslLexer::mRPAREN(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = RPAREN;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match(")");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void CslLexer::mPOUND(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = POUND;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match("#");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void CslLexer::mQUESTION(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = QUESTION;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match("?");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void CslLexer::mSEMI(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = SEMI;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match(";");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void CslLexer::mPLUS(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = PLUS;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match("+");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void CslLexer::mLNOT(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = LNOT;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match("!");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void CslLexer::mNOT(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = NOT;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match("~");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void CslLexer::mAND(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = AND;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match("&");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void CslLexer::mNAND(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = NAND;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match("~&");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void CslLexer::mOR(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = OR;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match("|");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void CslLexer::mNOR(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = NOR;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match("~|");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void CslLexer::mXOR(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = XOR;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
#line 585 "csl.lexer.g"
	bool test = false;
#line 1181 "CslLexer.cpp"
	
	match("^");
	{
	if ((LA(1) == 0x7e /* '~' */ )) {
		match("~");
		if ( inputState->guessing==0 ) {
#line 585 "csl.lexer.g"
			test=true;
#line 1190 "CslLexer.cpp"
		}
	}
	else {
	}
	
	}
	if ( inputState->guessing==0 ) {
#line 585 "csl.lexer.g"
		if(test) _ttype = XNOR;
#line 1200 "CslLexer.cpp"
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void CslLexer::mXNOR(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = XNOR;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match("~^");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void CslLexer::mSTAR(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = STAR;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match("*");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void CslLexer::mPOW(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = POW;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match("**");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void CslLexer::mDIV(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = DIV;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match("/");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void CslLexer::mMOD(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = MOD;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match("%");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void CslLexer::mEQUAL(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = EQUAL;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match("==");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void CslLexer::mNOT_EQ(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = NOT_EQ;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match("!=");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void CslLexer::mNOT_EQ_CASE(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = NOT_EQ_CASE;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match("!==");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void CslLexer::mEQ_CASE(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = EQ_CASE;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match("===");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void CslLexer::mLAND(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = LAND;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match("&&");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void CslLexer::mTAND(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = TAND;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match("&&&");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void CslLexer::mLOR(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = LOR;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match("||");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void CslLexer::mLT_(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = LT_;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match("<");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void CslLexer::mLE(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = LE;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match("<=");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void CslLexer::mGT(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = GT;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match(">");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void CslLexer::mGE(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = GE;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match(">=");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void CslLexer::mSL(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = SL;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match("<<");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void CslLexer::mSSL(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = SSL;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match("<<<");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void CslLexer::mSR(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = SR;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match(">>");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void CslLexer::mSSR(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = SSR;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match(">>>");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void CslLexer::mTRIGGER(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = TRIGGER;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match("->");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void CslLexer::mPPATH(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = PPATH;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match("=>");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void CslLexer::mFPATH(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = FPATH;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match("*>");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void CslLexer::mSTARP(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = STARP;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match("*)");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void CslLexer::mPO_POS(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = PO_POS;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match("+:");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void CslLexer::mPO_NEG(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = PO_NEG;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match("-:");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void CslLexer::mSUPERSTAR(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = SUPERSTAR;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match("(*)");
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void CslLexer::mW(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = W;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	{
	switch ( LA(1)) {
	case 0x20 /* ' ' */ :
	{
		match(' ' /* charlit */ );
		break;
	}
	case 0x9 /* '\t' */ :
	{
		match('\t' /* charlit */ );
		break;
	}
	case 0x8 /* '\10' */ :
	{
		match('\10' /* charlit */ );
		break;
	}
	case 0xc /* '\14' */ :
	{
		match('\14' /* charlit */ );
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltForCharException(LA(1), getFilename(), getLine(), getColumn());
	}
	}
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void CslLexer::mEND_OF_LINE(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = END_OF_LINE;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	{
	bool synPredMatched58 = false;
	if (((LA(1) == 0xd /* '\r' */ ) && (LA(2) == 0xa /* '\n' */ ) && (true))) {
		int _m58 = mark();
		synPredMatched58 = true;
		inputState->guessing++;
		try {
			{
			match("\r\n");
			}
		}
		catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& pe) {
			synPredMatched58 = false;
		}
		rewind(_m58);
		inputState->guessing--;
	}
	if ( synPredMatched58 ) {
		match("\r\n");
	}
	else if ((LA(1) == 0xd /* '\r' */ ) && (true) && (true)) {
		match('\r' /* charlit */ );
	}
	else if ((LA(1) == 0xa /* '\n' */ )) {
		match('\n' /* charlit */ );
	}
	else {
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltForCharException(LA(1), getFilename(), getLine(), getColumn());
	}
	
	}
	if ( inputState->guessing==0 ) {
#line 625 "csl.lexer.g"
		newline();
#line 1668 "CslLexer.cpp"
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void CslLexer::mVOCAB(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = VOCAB;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	matchRange('\3',static_cast<unsigned char>('\377'));
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void CslLexer::mALPHA(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = ALPHA;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	switch ( LA(1)) {
	case 0x61 /* 'a' */ :
	case 0x62 /* 'b' */ :
	case 0x63 /* 'c' */ :
	case 0x64 /* 'd' */ :
	case 0x65 /* 'e' */ :
	case 0x66 /* 'f' */ :
	case 0x67 /* 'g' */ :
	case 0x68 /* 'h' */ :
	case 0x69 /* 'i' */ :
	case 0x6a /* 'j' */ :
	case 0x6b /* 'k' */ :
	case 0x6c /* 'l' */ :
	case 0x6d /* 'm' */ :
	case 0x6e /* 'n' */ :
	case 0x6f /* 'o' */ :
	case 0x70 /* 'p' */ :
	case 0x71 /* 'q' */ :
	case 0x72 /* 'r' */ :
	case 0x73 /* 's' */ :
	case 0x74 /* 't' */ :
	case 0x75 /* 'u' */ :
	case 0x76 /* 'v' */ :
	case 0x77 /* 'w' */ :
	case 0x78 /* 'x' */ :
	case 0x79 /* 'y' */ :
	case 0x7a /* 'z' */ :
	{
		matchRange('a','z');
		break;
	}
	case 0x41 /* 'A' */ :
	case 0x42 /* 'B' */ :
	case 0x43 /* 'C' */ :
	case 0x44 /* 'D' */ :
	case 0x45 /* 'E' */ :
	case 0x46 /* 'F' */ :
	case 0x47 /* 'G' */ :
	case 0x48 /* 'H' */ :
	case 0x49 /* 'I' */ :
	case 0x4a /* 'J' */ :
	case 0x4b /* 'K' */ :
	case 0x4c /* 'L' */ :
	case 0x4d /* 'M' */ :
	case 0x4e /* 'N' */ :
	case 0x4f /* 'O' */ :
	case 0x50 /* 'P' */ :
	case 0x51 /* 'Q' */ :
	case 0x52 /* 'R' */ :
	case 0x53 /* 'S' */ :
	case 0x54 /* 'T' */ :
	case 0x55 /* 'U' */ :
	case 0x56 /* 'V' */ :
	case 0x57 /* 'W' */ :
	case 0x58 /* 'X' */ :
	case 0x59 /* 'Y' */ :
	case 0x5a /* 'Z' */ :
	{
		matchRange('A','Z');
		break;
	}
	case 0x5f /* '_' */ :
	{
		match('_' /* charlit */ );
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltForCharException(LA(1), getFilename(), getLine(), getColumn());
	}
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void CslLexer::mDIGIT(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = DIGIT;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	matchRange('0','9');
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void CslLexer::mNZ_DIGIT(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = NZ_DIGIT;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	matchRange('1','9');
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void CslLexer::mBIN_DIGIT(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = BIN_DIGIT;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	matchRange('0','1');
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void CslLexer::mOCT_DIGIT(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = OCT_DIGIT;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	matchRange('0','7');
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void CslLexer::mHEX_DIGIT(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = HEX_DIGIT;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	switch ( LA(1)) {
	case 0x30 /* '0' */ :
	case 0x31 /* '1' */ :
	case 0x32 /* '2' */ :
	case 0x33 /* '3' */ :
	case 0x34 /* '4' */ :
	case 0x35 /* '5' */ :
	case 0x36 /* '6' */ :
	case 0x37 /* '7' */ :
	case 0x38 /* '8' */ :
	case 0x39 /* '9' */ :
	{
		{
		matchRange('0','9');
		}
		break;
	}
	case 0x61 /* 'a' */ :
	case 0x62 /* 'b' */ :
	case 0x63 /* 'c' */ :
	case 0x64 /* 'd' */ :
	case 0x65 /* 'e' */ :
	case 0x66 /* 'f' */ :
	{
		{
		matchRange('a','f');
		}
		break;
	}
	case 0x41 /* 'A' */ :
	case 0x42 /* 'B' */ :
	case 0x43 /* 'C' */ :
	case 0x44 /* 'D' */ :
	case 0x45 /* 'E' */ :
	case 0x46 /* 'F' */ :
	{
		{
		matchRange('A','F');
		}
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltForCharException(LA(1), getFilename(), getLine(), getColumn());
	}
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void CslLexer::mXZ_DIGIT(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = XZ_DIGIT;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	switch ( LA(1)) {
	case 0x78 /* 'x' */ :
	{
		match('x' /* charlit */ );
		break;
	}
	case 0x58 /* 'X' */ :
	{
		match('X' /* charlit */ );
		break;
	}
	case 0x7a /* 'z' */ :
	{
		match('z' /* charlit */ );
		break;
	}
	case 0x5a /* 'Z' */ :
	{
		match('Z' /* charlit */ );
		break;
	}
	case 0x3f /* '?' */ :
	{
		match('?' /* charlit */ );
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltForCharException(LA(1), getFilename(), getLine(), getColumn());
	}
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void CslLexer::mIDENTIFIER(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = IDENTIFIER;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	mALPHA(false);
	{ // ( ... )*
	for (;;) {
		switch ( LA(1)) {
		case 0x41 /* 'A' */ :
		case 0x42 /* 'B' */ :
		case 0x43 /* 'C' */ :
		case 0x44 /* 'D' */ :
		case 0x45 /* 'E' */ :
		case 0x46 /* 'F' */ :
		case 0x47 /* 'G' */ :
		case 0x48 /* 'H' */ :
		case 0x49 /* 'I' */ :
		case 0x4a /* 'J' */ :
		case 0x4b /* 'K' */ :
		case 0x4c /* 'L' */ :
		case 0x4d /* 'M' */ :
		case 0x4e /* 'N' */ :
		case 0x4f /* 'O' */ :
		case 0x50 /* 'P' */ :
		case 0x51 /* 'Q' */ :
		case 0x52 /* 'R' */ :
		case 0x53 /* 'S' */ :
		case 0x54 /* 'T' */ :
		case 0x55 /* 'U' */ :
		case 0x56 /* 'V' */ :
		case 0x57 /* 'W' */ :
		case 0x58 /* 'X' */ :
		case 0x59 /* 'Y' */ :
		case 0x5a /* 'Z' */ :
		case 0x5f /* '_' */ :
		case 0x61 /* 'a' */ :
		case 0x62 /* 'b' */ :
		case 0x63 /* 'c' */ :
		case 0x64 /* 'd' */ :
		case 0x65 /* 'e' */ :
		case 0x66 /* 'f' */ :
		case 0x67 /* 'g' */ :
		case 0x68 /* 'h' */ :
		case 0x69 /* 'i' */ :
		case 0x6a /* 'j' */ :
		case 0x6b /* 'k' */ :
		case 0x6c /* 'l' */ :
		case 0x6d /* 'm' */ :
		case 0x6e /* 'n' */ :
		case 0x6f /* 'o' */ :
		case 0x70 /* 'p' */ :
		case 0x71 /* 'q' */ :
		case 0x72 /* 'r' */ :
		case 0x73 /* 's' */ :
		case 0x74 /* 't' */ :
		case 0x75 /* 'u' */ :
		case 0x76 /* 'v' */ :
		case 0x77 /* 'w' */ :
		case 0x78 /* 'x' */ :
		case 0x79 /* 'y' */ :
		case 0x7a /* 'z' */ :
		{
			mALPHA(false);
			break;
		}
		case 0x30 /* '0' */ :
		case 0x31 /* '1' */ :
		case 0x32 /* '2' */ :
		case 0x33 /* '3' */ :
		case 0x34 /* '4' */ :
		case 0x35 /* '5' */ :
		case 0x36 /* '6' */ :
		case 0x37 /* '7' */ :
		case 0x38 /* '8' */ :
		case 0x39 /* '9' */ :
		{
			mDIGIT(false);
			break;
		}
		case 0x24 /* '$' */ :
		{
			match('$' /* charlit */ );
			break;
		}
		default:
		{
			goto _loop72;
		}
		}
	}
	_loop72:;
	} // ( ... )*
	_ttype = testLiteralsTable(_ttype);
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void CslLexer::mESCAPED_IDENTIFIER(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = ESCAPED_IDENTIFIER;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
#line 661 "csl.lexer.g"
	char c = 0xFF;
#line 2043 "CslLexer.cpp"
	
	_saveIndex = text.length();
	match('\\' /* charlit */ );
	text.erase(_saveIndex);
	if ( inputState->guessing==0 ) {
#line 662 "csl.lexer.g"
		text += c;
#line 2051 "CslLexer.cpp"
	}
	{ // ( ... )+
	int _cnt76=0;
	for (;;) {
		if ((_tokenSet_1.member(LA(1)))) {
			{
			match(_tokenSet_1);
			}
		}
		else if ((LA(1) == 0x2e /* '.' */ )) {
			_saveIndex = text.length();
			match('.' /* charlit */ );
			text.erase(_saveIndex);
			if ( inputState->guessing==0 ) {
#line 664 "csl.lexer.g"
				text += c;
#line 2068 "CslLexer.cpp"
			}
		}
		else {
			if ( _cnt76>=1 ) { goto _loop76; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltForCharException(LA(1), getFilename(), getLine(), getColumn());}
		}
		
		_cnt76++;
	}
	_loop76:;
	}  // ( ... )+
	{
	switch ( LA(1)) {
	case 0x20 /* ' ' */ :
	{
		_saveIndex = text.length();
		match(' ' /* charlit */ );
		text.erase(_saveIndex);
		break;
	}
	case 0x9 /* '\t' */ :
	{
		_saveIndex = text.length();
		match('\t' /* charlit */ );
		text.erase(_saveIndex);
		break;
	}
	case 0x8 /* '\10' */ :
	{
		_saveIndex = text.length();
		match('\10' /* charlit */ );
		text.erase(_saveIndex);
		break;
	}
	case 0xc /* '\14' */ :
	{
		_saveIndex = text.length();
		match('\14' /* charlit */ );
		text.erase(_saveIndex);
		break;
	}
	case 0xa /* '\n' */ :
	case 0xd /* '\r' */ :
	{
		_saveIndex = text.length();
		mEND_OF_LINE(false);
		text.erase(_saveIndex);
		break;
	}
	default:
		{
		}
	}
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void CslLexer::mSTRING(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = STRING;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	_saveIndex = text.length();
	match('\"' /* charlit */ );
	text.erase(_saveIndex);
	{ // ( ... )*
	for (;;) {
		if ((LA(1) == 0x5c /* '\\' */ )) {
			{
			match('\\' /* charlit */ );
			{
			match(_tokenSet_2);
			}
			}
		}
		else if ((_tokenSet_3.member(LA(1)))) {
			{
			match(_tokenSet_3);
			}
		}
		else {
			goto _loop83;
		}
		
	}
	_loop83:;
	} // ( ... )*
	_saveIndex = text.length();
	match('\"' /* charlit */ );
	text.erase(_saveIndex);
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void CslLexer::mUNSIGNED_NUMBER(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = UNSIGNED_NUMBER;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	{
	mDIGIT(false);
	}
	{ // ( ... )*
	for (;;) {
		switch ( LA(1)) {
		case 0x30 /* '0' */ :
		case 0x31 /* '1' */ :
		case 0x32 /* '2' */ :
		case 0x33 /* '3' */ :
		case 0x34 /* '4' */ :
		case 0x35 /* '5' */ :
		case 0x36 /* '6' */ :
		case 0x37 /* '7' */ :
		case 0x38 /* '8' */ :
		case 0x39 /* '9' */ :
		{
			mDIGIT(false);
			break;
		}
		case 0x5f /* '_' */ :
		{
			match('_' /* charlit */ );
			break;
		}
		default:
		{
			goto _loop87;
		}
		}
	}
	_loop87:;
	} // ( ... )*
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void CslLexer::mNZ_UNSIGNED_NUMBER(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = NZ_UNSIGNED_NUMBER;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	{
	mNZ_DIGIT(false);
	}
	{ // ( ... )*
	for (;;) {
		switch ( LA(1)) {
		case 0x30 /* '0' */ :
		case 0x31 /* '1' */ :
		case 0x32 /* '2' */ :
		case 0x33 /* '3' */ :
		case 0x34 /* '4' */ :
		case 0x35 /* '5' */ :
		case 0x36 /* '6' */ :
		case 0x37 /* '7' */ :
		case 0x38 /* '8' */ :
		case 0x39 /* '9' */ :
		{
			mDIGIT(false);
			break;
		}
		case 0x5f /* '_' */ :
		{
			match('_' /* charlit */ );
			break;
		}
		default:
		{
			goto _loop91;
		}
		}
	}
	_loop91:;
	} // ( ... )*
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void CslLexer::mREAL_NUMBER(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = REAL_NUMBER;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	mUNSIGNED_NUMBER(false);
	match('.' /* charlit */ );
	mUNSIGNED_NUMBER(false);
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void CslLexer::mREAL_NUMBER_EXP(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = REAL_NUMBER_EXP;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	mUNSIGNED_NUMBER(false);
	{
	switch ( LA(1)) {
	case 0x2e /* '.' */ :
	{
		match('.' /* charlit */ );
		mUNSIGNED_NUMBER(false);
		break;
	}
	case 0x45 /* 'E' */ :
	case 0x65 /* 'e' */ :
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltForCharException(LA(1), getFilename(), getLine(), getColumn());
	}
	}
	}
	mEXP(false);
	{
	switch ( LA(1)) {
	case 0x2b /* '+' */ :
	case 0x2d /* '-' */ :
	{
		mSIGN(false);
		break;
	}
	case 0x30 /* '0' */ :
	case 0x31 /* '1' */ :
	case 0x32 /* '2' */ :
	case 0x33 /* '3' */ :
	case 0x34 /* '4' */ :
	case 0x35 /* '5' */ :
	case 0x36 /* '6' */ :
	case 0x37 /* '7' */ :
	case 0x38 /* '8' */ :
	case 0x39 /* '9' */ :
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltForCharException(LA(1), getFilename(), getLine(), getColumn());
	}
	}
	}
	mUNSIGNED_NUMBER(false);
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void CslLexer::mEXP(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = EXP;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	switch ( LA(1)) {
	case 0x65 /* 'e' */ :
	{
		match('e' /* charlit */ );
		break;
	}
	case 0x45 /* 'E' */ :
	{
		match('E' /* charlit */ );
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltForCharException(LA(1), getFilename(), getLine(), getColumn());
	}
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void CslLexer::mSIGN(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = SIGN;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	switch ( LA(1)) {
	case 0x2b /* '+' */ :
	{
		match('+' /* charlit */ );
		break;
	}
	case 0x2d /* '-' */ :
	{
		match('-' /* charlit */ );
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltForCharException(LA(1), getFilename(), getLine(), getColumn());
	}
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void CslLexer::mXZ_NUMBER(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = XZ_NUMBER;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	mXZ_DIGIT(false);
	{ // ( ... )*
	for (;;) {
		if ((LA(1) == 0x5f /* '_' */ )) {
			match('_' /* charlit */ );
		}
		else {
			goto _loop100;
		}
		
	}
	_loop100:;
	} // ( ... )*
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

 bool  CslLexer::mBIN_NUMBER(bool _createToken) {
#line 710 "csl.lexer.g"
	 bool hasXZ ;
#line 2428 "CslLexer.cpp"
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = BIN_NUMBER;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
#line 710 "csl.lexer.g"
	hasXZ = false;
#line 2434 "CslLexer.cpp"
	
	{
	switch ( LA(1)) {
	case 0x30 /* '0' */ :
	case 0x31 /* '1' */ :
	{
		mBIN_DIGIT(false);
		break;
	}
	case 0x3f /* '?' */ :
	case 0x58 /* 'X' */ :
	case 0x5a /* 'Z' */ :
	case 0x78 /* 'x' */ :
	case 0x7a /* 'z' */ :
	{
		mXZ_DIGIT(false);
		if ( inputState->guessing==0 ) {
#line 712 "csl.lexer.g"
			hasXZ = true;
#line 2454 "CslLexer.cpp"
		}
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltForCharException(LA(1), getFilename(), getLine(), getColumn());
	}
	}
	}
	{ // ( ... )*
	for (;;) {
		switch ( LA(1)) {
		case 0x30 /* '0' */ :
		case 0x31 /* '1' */ :
		{
			mBIN_DIGIT(false);
			break;
		}
		case 0x3f /* '?' */ :
		case 0x58 /* 'X' */ :
		case 0x5a /* 'Z' */ :
		case 0x78 /* 'x' */ :
		case 0x7a /* 'z' */ :
		{
			mXZ_DIGIT(false);
			if ( inputState->guessing==0 ) {
#line 712 "csl.lexer.g"
				hasXZ = true;
#line 2483 "CslLexer.cpp"
			}
			break;
		}
		case 0x5f /* '_' */ :
		{
			match('_' /* charlit */ );
			break;
		}
		default:
		{
			goto _loop104;
		}
		}
	}
	_loop104:;
	} // ( ... )*
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
	return hasXZ ;
}

 bool  CslLexer::mOCT_NUMBER(bool _createToken) {
#line 715 "csl.lexer.g"
	 bool hasXZ ;
#line 2512 "CslLexer.cpp"
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = OCT_NUMBER;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
#line 715 "csl.lexer.g"
	hasXZ = false;
#line 2518 "CslLexer.cpp"
	
	{
	switch ( LA(1)) {
	case 0x30 /* '0' */ :
	case 0x31 /* '1' */ :
	case 0x32 /* '2' */ :
	case 0x33 /* '3' */ :
	case 0x34 /* '4' */ :
	case 0x35 /* '5' */ :
	case 0x36 /* '6' */ :
	case 0x37 /* '7' */ :
	{
		mOCT_DIGIT(false);
		break;
	}
	case 0x3f /* '?' */ :
	case 0x58 /* 'X' */ :
	case 0x5a /* 'Z' */ :
	case 0x78 /* 'x' */ :
	case 0x7a /* 'z' */ :
	{
		mXZ_DIGIT(false);
		if ( inputState->guessing==0 ) {
#line 717 "csl.lexer.g"
			hasXZ = true;
#line 2544 "CslLexer.cpp"
		}
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltForCharException(LA(1), getFilename(), getLine(), getColumn());
	}
	}
	}
	{ // ( ... )*
	for (;;) {
		switch ( LA(1)) {
		case 0x30 /* '0' */ :
		case 0x31 /* '1' */ :
		case 0x32 /* '2' */ :
		case 0x33 /* '3' */ :
		case 0x34 /* '4' */ :
		case 0x35 /* '5' */ :
		case 0x36 /* '6' */ :
		case 0x37 /* '7' */ :
		{
			mOCT_DIGIT(false);
			break;
		}
		case 0x3f /* '?' */ :
		case 0x58 /* 'X' */ :
		case 0x5a /* 'Z' */ :
		case 0x78 /* 'x' */ :
		case 0x7a /* 'z' */ :
		{
			mXZ_DIGIT(false);
			if ( inputState->guessing==0 ) {
#line 717 "csl.lexer.g"
				hasXZ = true;
#line 2579 "CslLexer.cpp"
			}
			break;
		}
		case 0x5f /* '_' */ :
		{
			match('_' /* charlit */ );
			break;
		}
		default:
		{
			goto _loop108;
		}
		}
	}
	_loop108:;
	} // ( ... )*
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
	return hasXZ ;
}

 bool  CslLexer::mHEX_NUMBER(bool _createToken) {
#line 720 "csl.lexer.g"
	 bool hasXZ ;
#line 2608 "CslLexer.cpp"
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = HEX_NUMBER;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
#line 720 "csl.lexer.g"
	hasXZ = false;
#line 2614 "CslLexer.cpp"
	
	{
	switch ( LA(1)) {
	case 0x30 /* '0' */ :
	case 0x31 /* '1' */ :
	case 0x32 /* '2' */ :
	case 0x33 /* '3' */ :
	case 0x34 /* '4' */ :
	case 0x35 /* '5' */ :
	case 0x36 /* '6' */ :
	case 0x37 /* '7' */ :
	case 0x38 /* '8' */ :
	case 0x39 /* '9' */ :
	case 0x41 /* 'A' */ :
	case 0x42 /* 'B' */ :
	case 0x43 /* 'C' */ :
	case 0x44 /* 'D' */ :
	case 0x45 /* 'E' */ :
	case 0x46 /* 'F' */ :
	case 0x61 /* 'a' */ :
	case 0x62 /* 'b' */ :
	case 0x63 /* 'c' */ :
	case 0x64 /* 'd' */ :
	case 0x65 /* 'e' */ :
	case 0x66 /* 'f' */ :
	{
		mHEX_DIGIT(false);
		break;
	}
	case 0x3f /* '?' */ :
	case 0x58 /* 'X' */ :
	case 0x5a /* 'Z' */ :
	case 0x78 /* 'x' */ :
	case 0x7a /* 'z' */ :
	{
		mXZ_DIGIT(false);
		if ( inputState->guessing==0 ) {
#line 722 "csl.lexer.g"
			hasXZ = true;
#line 2654 "CslLexer.cpp"
		}
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltForCharException(LA(1), getFilename(), getLine(), getColumn());
	}
	}
	}
	{ // ( ... )*
	for (;;) {
		switch ( LA(1)) {
		case 0x30 /* '0' */ :
		case 0x31 /* '1' */ :
		case 0x32 /* '2' */ :
		case 0x33 /* '3' */ :
		case 0x34 /* '4' */ :
		case 0x35 /* '5' */ :
		case 0x36 /* '6' */ :
		case 0x37 /* '7' */ :
		case 0x38 /* '8' */ :
		case 0x39 /* '9' */ :
		case 0x41 /* 'A' */ :
		case 0x42 /* 'B' */ :
		case 0x43 /* 'C' */ :
		case 0x44 /* 'D' */ :
		case 0x45 /* 'E' */ :
		case 0x46 /* 'F' */ :
		case 0x61 /* 'a' */ :
		case 0x62 /* 'b' */ :
		case 0x63 /* 'c' */ :
		case 0x64 /* 'd' */ :
		case 0x65 /* 'e' */ :
		case 0x66 /* 'f' */ :
		{
			mHEX_DIGIT(false);
			break;
		}
		case 0x3f /* '?' */ :
		case 0x58 /* 'X' */ :
		case 0x5a /* 'Z' */ :
		case 0x78 /* 'x' */ :
		case 0x7a /* 'z' */ :
		{
			mXZ_DIGIT(false);
			if ( inputState->guessing==0 ) {
#line 722 "csl.lexer.g"
				hasXZ = true;
#line 2703 "CslLexer.cpp"
			}
			break;
		}
		case 0x5f /* '_' */ :
		{
			match('_' /* charlit */ );
			break;
		}
		default:
		{
			goto _loop112;
		}
		}
	}
	_loop112:;
	} // ( ... )*
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
	return hasXZ ;
}

void CslLexer::mNUMBER(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = NUMBER;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	ANTLR_USE_NAMESPACE(antlr)RefToken r_exp;
	ANTLR_USE_NAMESPACE(antlr)RefToken r;
	ANTLR_USE_NAMESPACE(antlr)RefToken u;
#line 724 "csl.lexer.g"
	RefCslNumber vn;
#line 2738 "CslLexer.cpp"
	
	try {      // for error handling
		{
		bool synPredMatched117 = false;
		if ((((LA(1) >= 0x30 /* '0' */  && LA(1) <= 0x39 /* '9' */ )) && (_tokenSet_4.member(LA(2))) && (_tokenSet_5.member(LA(3))))) {
			int _m117 = mark();
			synPredMatched117 = true;
			inputState->guessing++;
			try {
				{
				mUNSIGNED_NUMBER(false);
				{
				switch ( LA(1)) {
				case 0x2e /* '.' */ :
				{
					match('.' /* charlit */ );
					mUNSIGNED_NUMBER(false);
					break;
				}
				case 0x45 /* 'E' */ :
				case 0x65 /* 'e' */ :
				{
					break;
				}
				default:
				{
					throw ANTLR_USE_NAMESPACE(antlr)NoViableAltForCharException(LA(1), getFilename(), getLine(), getColumn());
				}
				}
				}
				mEXP(false);
				}
			}
			catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& pe) {
				synPredMatched117 = false;
			}
			rewind(_m117);
			inputState->guessing--;
		}
		if ( synPredMatched117 ) {
			mREAL_NUMBER_EXP(true);
			r_exp=_returnToken;
			if ( inputState->guessing==0 ) {
#line 730 "csl.lexer.g"
				
				_token = makeNumberToken(REAL_NUMBER, CslNumber::build(_RS(r_exp->getText()), CslNumber::NUM_REAL) ) ;
				
#line 2786 "CslLexer.cpp"
			}
		}
		else {
			bool synPredMatched119 = false;
			if ((((LA(1) >= 0x30 /* '0' */  && LA(1) <= 0x39 /* '9' */ )) && (_tokenSet_6.member(LA(2))) && (_tokenSet_6.member(LA(3))))) {
				int _m119 = mark();
				synPredMatched119 = true;
				inputState->guessing++;
				try {
					{
					mUNSIGNED_NUMBER(false);
					match('.' /* charlit */ );
					}
				}
				catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& pe) {
					synPredMatched119 = false;
				}
				rewind(_m119);
				inputState->guessing--;
			}
			if ( synPredMatched119 ) {
				mREAL_NUMBER(true);
				r=_returnToken;
				if ( inputState->guessing==0 ) {
#line 734 "csl.lexer.g"
					
					_token = makeNumberToken(REAL_NUMBER, CslNumber::build(_RS(r->getText()), CslNumber::NUM_REAL) ) ;
					
#line 2815 "CslLexer.cpp"
				}
			}
			else if ((LA(1) == 0x27 /* '\'' */ )) {
				vn=mBASED_NUMBER(false,CslNumber::NOT_SIZED);
				if ( inputState->guessing==0 ) {
#line 726 "csl.lexer.g"
					
					_token = makeNumberToken(BASED_NUMBER, vn);
					
#line 2825 "CslLexer.cpp"
				}
			}
			else if (((LA(1) >= 0x30 /* '0' */  && LA(1) <= 0x39 /* '9' */ )) && (true) && (true)) {
				mUNSIGNED_NUMBER(true);
				u=_returnToken;
				if ( inputState->guessing==0 ) {
#line 738 "csl.lexer.g"
					
					_token = makeNumberToken(UNSIGNED_NUMBER, CslNumber::build(_RS(u->getText()), CslNumber::NUM_BASED) ) ;
					
#line 2836 "CslLexer.cpp"
				}
			}
		else {
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltForCharException(LA(1), getFilename(), getLine(), getColumn());
		}
		}
		}
		if ( inputState->guessing==0 ) {
#line 742 "csl.lexer.g"
			
			assert(_token.get());
			_token->setText(text.substr(_begin, text.length()-_begin));
			
#line 2850 "CslLexer.cpp"
		}
	}
	catch (NoViableAltForCharException& e) {
		if (inputState->guessing==0) {
#line 748 "csl.lexer.g"
			
			//  DCERR("Lexer NVAFCE" << e.toString());
			// this catch ovverides the default lexer catch for this kind of exception that prints unwanted messages
			// if the consume() from the end of the block is removed then this exception will be thrown over and over again
			// - 1 : this exception can't be caught by parser, and thus it is caught by main which just prints it = unwanted behaviour,
			//        so it is caught here and ignored
			// - 2 : a similar exception is caught by parser and a error is printed = wanted behaviour
			// so nothing is lost
			consume();
			
#line 2866 "CslLexer.cpp"
		} else {
			throw;
		}
	}
	catch (ANTLRException& e) {
		if (inputState->guessing==0) {
#line 758 "csl.lexer.g"
			
			//  throw e;
			//  DCERR(getFilename());
			//  throw RecognitionException(e.getMessage(), e.getFilename(), e.getLine(), e.getColumn());
			//  DCERR("Lexer ANTLRE:" << e.toString());
			//consume();
			
#line 2881 "CslLexer.cpp"
		} else {
			throw;
		}
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

RefCslNumber  CslLexer::mBASED_NUMBER(bool _createToken,
	TInt size
) {
#line 775 "csl.lexer.g"
	RefCslNumber vn;
#line 2899 "CslLexer.cpp"
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = BASED_NUMBER;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	ANTLR_USE_NAMESPACE(antlr)RefToken xz;
#line 775 "csl.lexer.g"
	TBool isSigned; TBool hasXZ;
#line 2906 "CslLexer.cpp"
	
	bool synPredMatched126 = false;
	if (((LA(1) == 0x27 /* '\'' */ ) && (_tokenSet_7.member(LA(2))) && (_tokenSet_8.member(LA(3))))) {
		int _m126 = mark();
		synPredMatched126 = true;
		inputState->guessing++;
		try {
			{
			mBASED_NUMBER_HEADER(false);
			{
			switch ( LA(1)) {
			case 0x64 /* 'd' */ :
			{
				match('d' /* charlit */ );
				break;
			}
			case 0x44 /* 'D' */ :
			{
				match('D' /* charlit */ );
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltForCharException(LA(1), getFilename(), getLine(), getColumn());
			}
			}
			}
			}
		}
		catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& pe) {
			synPredMatched126 = false;
		}
		rewind(_m126);
		inputState->guessing--;
	}
	if ( synPredMatched126 ) {
		isSigned=mBASED_NUMBER_HEADER(false);
		{
		switch ( LA(1)) {
		case 0x64 /* 'd' */ :
		{
			match('d' /* charlit */ );
			break;
		}
		case 0x44 /* 'D' */ :
		{
			match('D' /* charlit */ );
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltForCharException(LA(1), getFilename(), getLine(), getColumn());
		}
		}
		}
		{ // ( ... )*
		for (;;) {
			switch ( LA(1)) {
			case 0x20 /* ' ' */ :
			{
				match(' ' /* charlit */ );
				break;
			}
			case 0x9 /* '\t' */ :
			{
				match('\t' /* charlit */ );
				break;
			}
			default:
			{
				goto _loop129;
			}
			}
		}
		_loop129:;
		} // ( ... )*
		{
		switch ( LA(1)) {
		case 0x30 /* '0' */ :
		case 0x31 /* '1' */ :
		case 0x32 /* '2' */ :
		case 0x33 /* '3' */ :
		case 0x34 /* '4' */ :
		case 0x35 /* '5' */ :
		case 0x36 /* '6' */ :
		case 0x37 /* '7' */ :
		case 0x38 /* '8' */ :
		case 0x39 /* '9' */ :
		{
			mUNSIGNED_NUMBER(false);
			if ( inputState->guessing==0 ) {
#line 778 "csl.lexer.g"
				
				vn = CslNumber::build( _RS(getText()), CslNumber::NUM_BASED, isSigned, CslNumber::BASE_DEC, size, false );
				
#line 3002 "CslLexer.cpp"
			}
			break;
		}
		case 0x3f /* '?' */ :
		case 0x58 /* 'X' */ :
		case 0x5a /* 'Z' */ :
		case 0x78 /* 'x' */ :
		case 0x7a /* 'z' */ :
		{
			mXZ_NUMBER(true);
			xz=_returnToken;
			if ( inputState->guessing==0 ) {
#line 782 "csl.lexer.g"
				
				vn = CslNumber::build( _RS(getText()), CslNumber::NUM_BASED, isSigned, CslNumber::BASE_DEC, size, true );
				
#line 3019 "CslLexer.cpp"
			}
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltForCharException(LA(1), getFilename(), getLine(), getColumn());
		}
		}
		}
	}
	else {
		bool synPredMatched133 = false;
		if (((LA(1) == 0x27 /* '\'' */ ) && (_tokenSet_9.member(LA(2))) && (_tokenSet_10.member(LA(3))))) {
			int _m133 = mark();
			synPredMatched133 = true;
			inputState->guessing++;
			try {
				{
				mBASED_NUMBER_HEADER(false);
				{
				switch ( LA(1)) {
				case 0x62 /* 'b' */ :
				{
					match('b' /* charlit */ );
					break;
				}
				case 0x42 /* 'B' */ :
				{
					match('B' /* charlit */ );
					break;
				}
				default:
				{
					throw ANTLR_USE_NAMESPACE(antlr)NoViableAltForCharException(LA(1), getFilename(), getLine(), getColumn());
				}
				}
				}
				}
			}
			catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& pe) {
				synPredMatched133 = false;
			}
			rewind(_m133);
			inputState->guessing--;
		}
		if ( synPredMatched133 ) {
			isSigned=mBASED_NUMBER_HEADER(false);
			{
			switch ( LA(1)) {
			case 0x62 /* 'b' */ :
			{
				match('b' /* charlit */ );
				break;
			}
			case 0x42 /* 'B' */ :
			{
				match('B' /* charlit */ );
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltForCharException(LA(1), getFilename(), getLine(), getColumn());
			}
			}
			}
			{ // ( ... )*
			for (;;) {
				switch ( LA(1)) {
				case 0x20 /* ' ' */ :
				{
					match(' ' /* charlit */ );
					break;
				}
				case 0x9 /* '\t' */ :
				{
					match('\t' /* charlit */ );
					break;
				}
				default:
				{
					goto _loop136;
				}
				}
			}
			_loop136:;
			} // ( ... )*
			hasXZ=mBIN_NUMBER(false);
			if ( inputState->guessing==0 ) {
#line 787 "csl.lexer.g"
				
				vn = CslNumber::build( _RS(getText()), CslNumber::NUM_BASED, isSigned, CslNumber::BASE_BIN, size, hasXZ );
				
#line 3112 "CslLexer.cpp"
			}
		}
		else {
			bool synPredMatched139 = false;
			if (((LA(1) == 0x27 /* '\'' */ ) && (_tokenSet_11.member(LA(2))) && (_tokenSet_12.member(LA(3))))) {
				int _m139 = mark();
				synPredMatched139 = true;
				inputState->guessing++;
				try {
					{
					mBASED_NUMBER_HEADER(false);
					{
					switch ( LA(1)) {
					case 0x6f /* 'o' */ :
					{
						match('o' /* charlit */ );
						break;
					}
					case 0x4f /* 'O' */ :
					{
						match('O' /* charlit */ );
						break;
					}
					default:
					{
						throw ANTLR_USE_NAMESPACE(antlr)NoViableAltForCharException(LA(1), getFilename(), getLine(), getColumn());
					}
					}
					}
					}
				}
				catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& pe) {
					synPredMatched139 = false;
				}
				rewind(_m139);
				inputState->guessing--;
			}
			if ( synPredMatched139 ) {
				isSigned=mBASED_NUMBER_HEADER(false);
				{
				switch ( LA(1)) {
				case 0x6f /* 'o' */ :
				{
					match('o' /* charlit */ );
					break;
				}
				case 0x4f /* 'O' */ :
				{
					match('O' /* charlit */ );
					break;
				}
				default:
				{
					throw ANTLR_USE_NAMESPACE(antlr)NoViableAltForCharException(LA(1), getFilename(), getLine(), getColumn());
				}
				}
				}
				{ // ( ... )*
				for (;;) {
					switch ( LA(1)) {
					case 0x20 /* ' ' */ :
					{
						match(' ' /* charlit */ );
						break;
					}
					case 0x9 /* '\t' */ :
					{
						match('\t' /* charlit */ );
						break;
					}
					default:
					{
						goto _loop142;
					}
					}
				}
				_loop142:;
				} // ( ... )*
				hasXZ=mOCT_NUMBER(false);
				if ( inputState->guessing==0 ) {
#line 791 "csl.lexer.g"
					
					vn = CslNumber::build( _RS(getText()), CslNumber::NUM_BASED, isSigned, CslNumber::BASE_OCT, size, hasXZ );
					
#line 3197 "CslLexer.cpp"
				}
			}
			else {
				bool synPredMatched145 = false;
				if (((LA(1) == 0x27 /* '\'' */ ) && (_tokenSet_13.member(LA(2))) && (_tokenSet_14.member(LA(3))))) {
					int _m145 = mark();
					synPredMatched145 = true;
					inputState->guessing++;
					try {
						{
						mBASED_NUMBER_HEADER(false);
						{
						switch ( LA(1)) {
						case 0x68 /* 'h' */ :
						{
							match('h' /* charlit */ );
							break;
						}
						case 0x48 /* 'H' */ :
						{
							match('H' /* charlit */ );
							break;
						}
						default:
						{
							throw ANTLR_USE_NAMESPACE(antlr)NoViableAltForCharException(LA(1), getFilename(), getLine(), getColumn());
						}
						}
						}
						}
					}
					catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& pe) {
						synPredMatched145 = false;
					}
					rewind(_m145);
					inputState->guessing--;
				}
				if ( synPredMatched145 ) {
					isSigned=mBASED_NUMBER_HEADER(false);
					{
					switch ( LA(1)) {
					case 0x68 /* 'h' */ :
					{
						match('h' /* charlit */ );
						break;
					}
					case 0x48 /* 'H' */ :
					{
						match('H' /* charlit */ );
						break;
					}
					default:
					{
						throw ANTLR_USE_NAMESPACE(antlr)NoViableAltForCharException(LA(1), getFilename(), getLine(), getColumn());
					}
					}
					}
					{ // ( ... )*
					for (;;) {
						switch ( LA(1)) {
						case 0x20 /* ' ' */ :
						{
							match(' ' /* charlit */ );
							break;
						}
						case 0x9 /* '\t' */ :
						{
							match('\t' /* charlit */ );
							break;
						}
						default:
						{
							goto _loop148;
						}
						}
					}
					_loop148:;
					} // ( ... )*
					hasXZ=mHEX_NUMBER(false);
					if ( inputState->guessing==0 ) {
#line 795 "csl.lexer.g"
						
						vn = CslNumber::build( _RS(getText()), CslNumber::NUM_BASED, isSigned, CslNumber::BASE_HEX, size, hasXZ);
						
#line 3282 "CslLexer.cpp"
					}
				}
	else {
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltForCharException(LA(1), getFilename(), getLine(), getColumn());
	}
	}}}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
	return vn;
}

TBool  CslLexer::mBASED_NUMBER_HEADER(bool _createToken) {
#line 768 "csl.lexer.g"
	TBool s;
#line 3301 "CslLexer.cpp"
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = BASED_NUMBER_HEADER;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	if ( inputState->guessing==0 ) {
#line 769 "csl.lexer.g"
		s = FALSE;
#line 3309 "CslLexer.cpp"
	}
	match('\'' /* charlit */ );
	{
	switch ( LA(1)) {
	case 0x53 /* 'S' */ :
	case 0x73 /* 's' */ :
	{
		{
		switch ( LA(1)) {
		case 0x73 /* 's' */ :
		{
			match('s' /* charlit */ );
			break;
		}
		case 0x53 /* 'S' */ :
		{
			match('S' /* charlit */ );
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltForCharException(LA(1), getFilename(), getLine(), getColumn());
		}
		}
		}
		if ( inputState->guessing==0 ) {
#line 771 "csl.lexer.g"
			s = TRUE;
#line 3338 "CslLexer.cpp"
		}
		break;
	}
	case 0x42 /* 'B' */ :
	case 0x44 /* 'D' */ :
	case 0x48 /* 'H' */ :
	case 0x4f /* 'O' */ :
	case 0x62 /* 'b' */ :
	case 0x64 /* 'd' */ :
	case 0x68 /* 'h' */ :
	case 0x6f /* 'o' */ :
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltForCharException(LA(1), getFilename(), getLine(), getColumn());
	}
	}
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
	return s;
}

void CslLexer::mSYSTEM_TASK_NAME(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = SYSTEM_TASK_NAME;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match('$' /* charlit */ );
	{ // ( ... )+
	int _cnt151=0;
	for (;;) {
		switch ( LA(1)) {
		case 0x41 /* 'A' */ :
		case 0x42 /* 'B' */ :
		case 0x43 /* 'C' */ :
		case 0x44 /* 'D' */ :
		case 0x45 /* 'E' */ :
		case 0x46 /* 'F' */ :
		case 0x47 /* 'G' */ :
		case 0x48 /* 'H' */ :
		case 0x49 /* 'I' */ :
		case 0x4a /* 'J' */ :
		case 0x4b /* 'K' */ :
		case 0x4c /* 'L' */ :
		case 0x4d /* 'M' */ :
		case 0x4e /* 'N' */ :
		case 0x4f /* 'O' */ :
		case 0x50 /* 'P' */ :
		case 0x51 /* 'Q' */ :
		case 0x52 /* 'R' */ :
		case 0x53 /* 'S' */ :
		case 0x54 /* 'T' */ :
		case 0x55 /* 'U' */ :
		case 0x56 /* 'V' */ :
		case 0x57 /* 'W' */ :
		case 0x58 /* 'X' */ :
		case 0x59 /* 'Y' */ :
		case 0x5a /* 'Z' */ :
		case 0x5f /* '_' */ :
		case 0x61 /* 'a' */ :
		case 0x62 /* 'b' */ :
		case 0x63 /* 'c' */ :
		case 0x64 /* 'd' */ :
		case 0x65 /* 'e' */ :
		case 0x66 /* 'f' */ :
		case 0x67 /* 'g' */ :
		case 0x68 /* 'h' */ :
		case 0x69 /* 'i' */ :
		case 0x6a /* 'j' */ :
		case 0x6b /* 'k' */ :
		case 0x6c /* 'l' */ :
		case 0x6d /* 'm' */ :
		case 0x6e /* 'n' */ :
		case 0x6f /* 'o' */ :
		case 0x70 /* 'p' */ :
		case 0x71 /* 'q' */ :
		case 0x72 /* 'r' */ :
		case 0x73 /* 's' */ :
		case 0x74 /* 't' */ :
		case 0x75 /* 'u' */ :
		case 0x76 /* 'v' */ :
		case 0x77 /* 'w' */ :
		case 0x78 /* 'x' */ :
		case 0x79 /* 'y' */ :
		case 0x7a /* 'z' */ :
		{
			mALPHA(false);
			break;
		}
		case 0x30 /* '0' */ :
		case 0x31 /* '1' */ :
		case 0x32 /* '2' */ :
		case 0x33 /* '3' */ :
		case 0x34 /* '4' */ :
		case 0x35 /* '5' */ :
		case 0x36 /* '6' */ :
		case 0x37 /* '7' */ :
		case 0x38 /* '8' */ :
		case 0x39 /* '9' */ :
		{
			mDIGIT(false);
			break;
		}
		case 0x24 /* '$' */ :
		{
			match('$' /* charlit */ );
			break;
		}
		default:
		{
			if ( _cnt151>=1 ) { goto _loop151; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltForCharException(LA(1), getFilename(), getLine(), getColumn());}
		}
		}
		_cnt151++;
	}
	_loop151:;
	}  // ( ... )+
	_ttype = testLiteralsTable(_ttype);
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void CslLexer::mFILENAME(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = FILENAME;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	{ // ( ... )*
	for (;;) {
		if ((_tokenSet_15.member(LA(1)))) {
			matchNot('\"' /* charlit */ );
		}
		else {
			goto _loop154;
		}
		
	}
	_loop154:;
	} // ( ... )*
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void CslLexer::mDIRECTIVE(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = DIRECTIVE;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	ANTLR_USE_NAMESPACE(antlr)RefToken i;
	
	_saveIndex = text.length();
	match('`' /* charlit */ );
	text.erase(_saveIndex);
	{
	mIDENTIFIER(true);
	i=_returnToken;
	{
	if ((_tokenSet_16.member(LA(1)))) {
		{ // ( ... )+
		int _cnt159=0;
		for (;;) {
			if ((_tokenSet_16.member(LA(1)))) {
				mW(false);
			}
			else {
				if ( _cnt159>=1 ) { goto _loop159; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltForCharException(LA(1), getFilename(), getLine(), getColumn());}
			}
			
			_cnt159++;
		}
		_loop159:;
		}  // ( ... )+
		{
		{
		match(_tokenSet_17);
		}
		}
		{ // ( ... )*
		for (;;) {
			if ((_tokenSet_2.member(LA(1)))) {
				{
				match(_tokenSet_2);
				}
			}
			else {
				goto _loop164;
			}
			
		}
		_loop164:;
		} // ( ... )*
	}
	else {
	}
	
	}
	}
	{
	if ((LA(1) == 0xa /* '\n' */  || LA(1) == 0xd /* '\r' */ )) {
		_saveIndex = text.length();
		mEND_OF_LINE(false);
		text.erase(_saveIndex);
	}
	else {
	}
	
	}
	if ( inputState->guessing==0 ) {
#line 821 "csl.lexer.g"
		
		cout << "WARNING: Directives are ignored" << endl;
		_ttype = Token::SKIP;
		
#line 3566 "CslLexer.cpp"
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void CslLexer::mWS(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = WS;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	{
	switch ( LA(1)) {
	case 0x8 /* '\10' */ :
	case 0x9 /* '\t' */ :
	case 0xc /* '\14' */ :
	case 0x20 /* ' ' */ :
	{
		mW(false);
		break;
	}
	case 0xa /* '\n' */ :
	case 0xd /* '\r' */ :
	{
		mEND_OF_LINE(false);
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltForCharException(LA(1), getFilename(), getLine(), getColumn());
	}
	}
	}
	if ( inputState->guessing==0 ) {
#line 832 "csl.lexer.g"
		_ttype = Token::SKIP;
#line 3606 "CslLexer.cpp"
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void CslLexer::mSL_COMMENT(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = SL_COMMENT;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match("//");
	{ // ( ... )*
	for (;;) {
		if ((_tokenSet_2.member(LA(1)))) {
			{
			match(_tokenSet_2);
			}
		}
		else {
			goto _loop171;
		}
		
	}
	_loop171:;
	} // ( ... )*
	{
	if ((LA(1) == 0xa /* '\n' */  || LA(1) == 0xd /* '\r' */ )) {
		mEND_OF_LINE(false);
	}
	else {
	}
	
	}
	if ( inputState->guessing==0 ) {
#line 837 "csl.lexer.g"
		_ttype = Token::SKIP;
#line 3647 "CslLexer.cpp"
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void CslLexer::mML_COMMENT(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = ML_COMMENT;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	match("/*");
	{ // ( ... )*
	for (;;) {
		if (((LA(1) == 0x2a /* '*' */ ) && ((LA(2) >= 0x3 /* '\3' */  && LA(2) <= 0xff)) && ((LA(3) >= 0x3 /* '\3' */  && LA(3) <= 0xff)))&&( LA(2) != '/' )) {
			match('*' /* charlit */ );
		}
		else if ((LA(1) == 0xa /* '\n' */  || LA(1) == 0xd /* '\r' */ )) {
			mEND_OF_LINE(false);
		}
		else if ((_tokenSet_18.member(LA(1)))) {
			{
			match(_tokenSet_18);
			}
		}
		else {
			goto _loop176;
		}
		
	}
	_loop176:;
	} // ( ... )*
	match("*/");
	if ( inputState->guessing==0 ) {
#line 847 "csl.lexer.g"
		_ttype = Token::SKIP;
#line 3687 "CslLexer.cpp"
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}


const unsigned long CslLexer::_tokenSet_0_data_[] = { 0UL, 0UL, 2281701374UL, 134217726UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// A B C D E F G H I J K L M N O P Q R S T U V W X Y Z _ a b c d e f g 
// h i j k l m n o p q r s t u v w x y z 
const ANTLR_USE_NAMESPACE(antlr)BitSet CslLexer::_tokenSet_0(_tokenSet_0_data_,10);
const unsigned long CslLexer::_tokenSet_1_data_[] = { 4294953208UL, 4294950910UL, 4294967295UL, 4294967295UL, 4294967295UL, 4294967295UL, 4294967295UL, 4294967295UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// 0x3 0x4 0x5 0x6 0x7 0xb 0xe 0xf 0x10 0x11 0x12 0x13 0x14 0x15 0x16 0x17 
// 0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x1e 0x1f ! \" # $ % & \' ( ) * + , - 
// / 0 1 2 3 4 5 6 7 8 9 : ; < = > ? @ A B C D E F G H I J K L M N O P 
// Q R S T U V W X Y Z [ 0x5c ] ^ _ ` a b c d e f g h i j k l m n o p q 
// r s t u v w x y z { | } ~ 0x7f 0x80 0x81 0x82 0x83 0x84 0x85 0x86 0x87 
// 0x88 0x89 0x8a 0x8b 0x8c 0x8d 0x8e 0x8f 0x90 0x91 0x92 0x93 0x94 0x95 
// 0x96 0x97 0x98 0x99 0x9a 0x9b 0x9c 0x9d 0x9e 0x9f 0xa0 0xa1 0xa2 0xa3 
// 0xa4 0xa5 0xa6 0xa7 0xa8 0xa9 0xaa 0xab 0xac 0xad 0xae 0xaf 0xb0 0xb1 
// 0xb2 0xb3 0xb4 0xb5 0xb6 0xb7 0xb8 0xb9 0xba 0xbb 0xbc 0xbd 0xbe 0xbf 
// 0xc0 0xc1 0xc2 0xc3 0xc4 0xc5 0xc6 0xc7 0xc8 0xc9 0xca 0xcb 0xcc 0xcd 
// 0xce 0xcf 0xd0 0xd1 0xd2 0xd3 0xd4 0xd5 0xd6 0xd7 0xd8 0xd9 0xda 0xdb 
// 0xdc 0xdd 0xde 0xdf 0xe0 0xe1 0xe2 0xe3 0xe4 0xe5 0xe6 0xe7 0xe8 0xe9 
// 0xea 0xeb 0xec 0xed 0xee 0xef 0xf0 0xf1 0xf2 0xf3 0xf4 0xf5 0xf6 0xf7 
// 0xf8 0xf9 0xfa 0xfb 0xfc 0xfd 0xfe 0xff 
const ANTLR_USE_NAMESPACE(antlr)BitSet CslLexer::_tokenSet_1(_tokenSet_1_data_,16);
const unsigned long CslLexer::_tokenSet_2_data_[] = { 4294958072UL, 4294967295UL, 4294967295UL, 4294967295UL, 4294967295UL, 4294967295UL, 4294967295UL, 4294967295UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// 0x3 0x4 0x5 0x6 0x7 0x8 0x9 0xb 0xc 0xe 0xf 0x10 0x11 0x12 0x13 0x14 
// 0x15 0x16 0x17 0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x1e 0x1f   ! \" # $ % 
// & \' ( ) * + , - . / 0 1 2 3 4 5 6 7 8 9 : ; < = > ? @ A B C D E F G 
// H I J K L M N O P Q R S T U V W X Y Z [ 0x5c ] ^ _ ` a b c d e f g h 
// i j k l m n o p q r s t u v w x y z { | } ~ 0x7f 0x80 0x81 0x82 0x83 
// 0x84 0x85 0x86 0x87 0x88 0x89 0x8a 0x8b 0x8c 0x8d 0x8e 0x8f 0x90 0x91 
// 0x92 0x93 0x94 0x95 0x96 0x97 0x98 0x99 0x9a 0x9b 0x9c 0x9d 0x9e 0x9f 
// 0xa0 0xa1 0xa2 0xa3 0xa4 0xa5 0xa6 0xa7 0xa8 0xa9 0xaa 0xab 0xac 0xad 
// 0xae 0xaf 0xb0 0xb1 0xb2 0xb3 0xb4 0xb5 0xb6 0xb7 0xb8 0xb9 0xba 0xbb 
// 0xbc 0xbd 0xbe 0xbf 0xc0 0xc1 0xc2 0xc3 0xc4 0xc5 0xc6 0xc7 0xc8 0xc9 
// 0xca 0xcb 0xcc 0xcd 0xce 0xcf 0xd0 0xd1 0xd2 0xd3 0xd4 0xd5 0xd6 0xd7 
// 0xd8 0xd9 0xda 0xdb 0xdc 0xdd 0xde 0xdf 0xe0 0xe1 0xe2 0xe3 0xe4 0xe5 
// 0xe6 0xe7 0xe8 0xe9 0xea 0xeb 0xec 0xed 0xee 0xef 0xf0 0xf1 0xf2 0xf3 
// 0xf4 0xf5 0xf6 0xf7 0xf8 0xf9 0xfa 0xfb 0xfc 0xfd 0xfe 0xff 
const ANTLR_USE_NAMESPACE(antlr)BitSet CslLexer::_tokenSet_2(_tokenSet_2_data_,16);
const unsigned long CslLexer::_tokenSet_3_data_[] = { 4294958072UL, 4294967291UL, 4026531839UL, 4294967295UL, 4294967295UL, 4294967295UL, 4294967295UL, 4294967295UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// 0x3 0x4 0x5 0x6 0x7 0x8 0x9 0xb 0xc 0xe 0xf 0x10 0x11 0x12 0x13 0x14 
// 0x15 0x16 0x17 0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x1e 0x1f   ! # $ % & \' 
// ( ) * + , - . / 0 1 2 3 4 5 6 7 8 9 : ; < = > ? @ A B C D E F G H I 
// J K L M N O P Q R S T U V W X Y Z [ ] ^ _ ` a b c d e f g h i j k l 
// m n o p q r s t u v w x y z { | } ~ 0x7f 0x80 0x81 0x82 0x83 0x84 0x85 
// 0x86 0x87 0x88 0x89 0x8a 0x8b 0x8c 0x8d 0x8e 0x8f 0x90 0x91 0x92 0x93 
// 0x94 0x95 0x96 0x97 0x98 0x99 0x9a 0x9b 0x9c 0x9d 0x9e 0x9f 0xa0 0xa1 
// 0xa2 0xa3 0xa4 0xa5 0xa6 0xa7 0xa8 0xa9 0xaa 0xab 0xac 0xad 0xae 0xaf 
// 0xb0 0xb1 0xb2 0xb3 0xb4 0xb5 0xb6 0xb7 0xb8 0xb9 0xba 0xbb 0xbc 0xbd 
// 0xbe 0xbf 0xc0 0xc1 0xc2 0xc3 0xc4 0xc5 0xc6 0xc7 0xc8 0xc9 0xca 0xcb 
// 0xcc 0xcd 0xce 0xcf 0xd0 0xd1 0xd2 0xd3 0xd4 0xd5 0xd6 0xd7 0xd8 0xd9 
// 0xda 0xdb 0xdc 0xdd 0xde 0xdf 0xe0 0xe1 0xe2 0xe3 0xe4 0xe5 0xe6 0xe7 
// 0xe8 0xe9 0xea 0xeb 0xec 0xed 0xee 0xef 0xf0 0xf1 0xf2 0xf3 0xf4 0xf5 
// 0xf6 0xf7 0xf8 0xf9 0xfa 0xfb 0xfc 0xfd 0xfe 0xff 
const ANTLR_USE_NAMESPACE(antlr)BitSet CslLexer::_tokenSet_3(_tokenSet_3_data_,16);
const unsigned long CslLexer::_tokenSet_4_data_[] = { 0UL, 67059712UL, 2147483680UL, 32UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// . 0 1 2 3 4 5 6 7 8 9 E _ e 
const ANTLR_USE_NAMESPACE(antlr)BitSet CslLexer::_tokenSet_4(_tokenSet_4_data_,10);
const unsigned long CslLexer::_tokenSet_5_data_[] = { 0UL, 67069952UL, 2147483680UL, 32UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// + - . 0 1 2 3 4 5 6 7 8 9 E _ e 
const ANTLR_USE_NAMESPACE(antlr)BitSet CslLexer::_tokenSet_5(_tokenSet_5_data_,10);
const unsigned long CslLexer::_tokenSet_6_data_[] = { 0UL, 67059712UL, 2147483648UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// . 0 1 2 3 4 5 6 7 8 9 _ 
const ANTLR_USE_NAMESPACE(antlr)BitSet CslLexer::_tokenSet_6(_tokenSet_6_data_,10);
const unsigned long CslLexer::_tokenSet_7_data_[] = { 0UL, 0UL, 524304UL, 524304UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// D S d s 
const ANTLR_USE_NAMESPACE(antlr)BitSet CslLexer::_tokenSet_7(_tokenSet_7_data_,10);
const unsigned long CslLexer::_tokenSet_8_data_[] = { 512UL, 2214526977UL, 83886096UL, 83886096UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// 0x9   0 1 2 3 4 5 6 7 8 9 ? D X Z d x z 
const ANTLR_USE_NAMESPACE(antlr)BitSet CslLexer::_tokenSet_8(_tokenSet_8_data_,10);
const unsigned long CslLexer::_tokenSet_9_data_[] = { 0UL, 0UL, 524292UL, 524292UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// B S b s 
const ANTLR_USE_NAMESPACE(antlr)BitSet CslLexer::_tokenSet_9(_tokenSet_9_data_,10);
const unsigned long CslLexer::_tokenSet_10_data_[] = { 512UL, 2147680257UL, 83886084UL, 83886084UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// 0x9   0 1 ? B X Z b x z 
const ANTLR_USE_NAMESPACE(antlr)BitSet CslLexer::_tokenSet_10(_tokenSet_10_data_,10);
const unsigned long CslLexer::_tokenSet_11_data_[] = { 0UL, 0UL, 557056UL, 557056UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// O S o s 
const ANTLR_USE_NAMESPACE(antlr)BitSet CslLexer::_tokenSet_11(_tokenSet_11_data_,10);
const unsigned long CslLexer::_tokenSet_12_data_[] = { 512UL, 2164195329UL, 83918848UL, 83918848UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// 0x9   0 1 2 3 4 5 6 7 ? O X Z o x z 
const ANTLR_USE_NAMESPACE(antlr)BitSet CslLexer::_tokenSet_12(_tokenSet_12_data_,10);
const unsigned long CslLexer::_tokenSet_13_data_[] = { 0UL, 0UL, 524544UL, 524544UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// H S h s 
const ANTLR_USE_NAMESPACE(antlr)BitSet CslLexer::_tokenSet_13(_tokenSet_13_data_,10);
const unsigned long CslLexer::_tokenSet_14_data_[] = { 512UL, 2214526977UL, 83886462UL, 83886462UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// 0x9   0 1 2 3 4 5 6 7 8 9 ? A B C D E F H X Z a b c d e f h x z 
const ANTLR_USE_NAMESPACE(antlr)BitSet CslLexer::_tokenSet_14(_tokenSet_14_data_,10);
const unsigned long CslLexer::_tokenSet_15_data_[] = { 4294967288UL, 4294967291UL, 4294967295UL, 4294967295UL, 4294967295UL, 4294967295UL, 4294967295UL, 4294967295UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// 0x3 0x4 0x5 0x6 0x7 0x8 0x9 0xa 0xb 0xc 0xd 0xe 0xf 0x10 0x11 0x12 0x13 
// 0x14 0x15 0x16 0x17 0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x1e 0x1f   ! # $ 
// % & \' ( ) * + , - . / 0 1 2 3 4 5 6 7 8 9 : ; < = > ? @ A B C D E F 
// G H I J K L M N O P Q R S T U V W X Y Z [ 0x5c ] ^ _ ` a b c d e f g 
// h i j k l m n o p q r s t u v w x y z { | } ~ 0x7f 0x80 0x81 0x82 0x83 
// 0x84 0x85 0x86 0x87 0x88 0x89 0x8a 0x8b 0x8c 0x8d 0x8e 0x8f 0x90 0x91 
// 0x92 0x93 0x94 0x95 0x96 0x97 0x98 0x99 0x9a 0x9b 0x9c 0x9d 0x9e 0x9f 
// 0xa0 0xa1 0xa2 0xa3 0xa4 0xa5 0xa6 0xa7 0xa8 0xa9 0xaa 0xab 0xac 0xad 
// 0xae 0xaf 0xb0 0xb1 0xb2 0xb3 0xb4 0xb5 0xb6 0xb7 0xb8 0xb9 0xba 0xbb 
// 0xbc 0xbd 0xbe 0xbf 0xc0 0xc1 0xc2 0xc3 0xc4 0xc5 0xc6 0xc7 0xc8 0xc9 
// 0xca 0xcb 0xcc 0xcd 0xce 0xcf 0xd0 0xd1 0xd2 0xd3 0xd4 0xd5 0xd6 0xd7 
// 0xd8 0xd9 0xda 0xdb 0xdc 0xdd 0xde 0xdf 0xe0 0xe1 0xe2 0xe3 0xe4 0xe5 
// 0xe6 0xe7 0xe8 0xe9 0xea 0xeb 0xec 0xed 0xee 0xef 0xf0 0xf1 0xf2 0xf3 
// 0xf4 0xf5 0xf6 0xf7 0xf8 0xf9 0xfa 0xfb 0xfc 0xfd 0xfe 0xff 
const ANTLR_USE_NAMESPACE(antlr)BitSet CslLexer::_tokenSet_15(_tokenSet_15_data_,16);
const unsigned long CslLexer::_tokenSet_16_data_[] = { 4864UL, 1UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// 0x8 0x9 0xc   
const ANTLR_USE_NAMESPACE(antlr)BitSet CslLexer::_tokenSet_16(_tokenSet_16_data_,10);
const unsigned long CslLexer::_tokenSet_17_data_[] = { 4294953208UL, 4294967294UL, 4294967295UL, 4294967295UL, 4294967295UL, 4294967295UL, 4294967295UL, 4294967295UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// 0x3 0x4 0x5 0x6 0x7 0xb 0xe 0xf 0x10 0x11 0x12 0x13 0x14 0x15 0x16 0x17 
// 0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x1e 0x1f ! \" # $ % & \' ( ) * + , - 
// . / 0 1 2 3 4 5 6 7 8 9 : ; < = > ? @ A B C D E F G H I J K L M N O 
// P Q R S T U V W X Y Z [ 0x5c ] ^ _ ` a b c d e f g h i j k l m n o p 
// q r s t u v w x y z { | } ~ 0x7f 0x80 0x81 0x82 0x83 0x84 0x85 0x86 
// 0x87 0x88 0x89 0x8a 0x8b 0x8c 0x8d 0x8e 0x8f 0x90 0x91 0x92 0x93 0x94 
// 0x95 0x96 0x97 0x98 0x99 0x9a 0x9b 0x9c 0x9d 0x9e 0x9f 0xa0 0xa1 0xa2 
// 0xa3 0xa4 0xa5 0xa6 0xa7 0xa8 0xa9 0xaa 0xab 0xac 0xad 0xae 0xaf 0xb0 
// 0xb1 0xb2 0xb3 0xb4 0xb5 0xb6 0xb7 0xb8 0xb9 0xba 0xbb 0xbc 0xbd 0xbe 
// 0xbf 0xc0 0xc1 0xc2 0xc3 0xc4 0xc5 0xc6 0xc7 0xc8 0xc9 0xca 0xcb 0xcc 
// 0xcd 0xce 0xcf 0xd0 0xd1 0xd2 0xd3 0xd4 0xd5 0xd6 0xd7 0xd8 0xd9 0xda 
// 0xdb 0xdc 0xdd 0xde 0xdf 0xe0 0xe1 0xe2 0xe3 0xe4 0xe5 0xe6 0xe7 0xe8 
// 0xe9 0xea 0xeb 0xec 0xed 0xee 0xef 0xf0 0xf1 0xf2 0xf3 0xf4 0xf5 0xf6 
// 0xf7 0xf8 0xf9 0xfa 0xfb 0xfc 0xfd 0xfe 0xff 
const ANTLR_USE_NAMESPACE(antlr)BitSet CslLexer::_tokenSet_17(_tokenSet_17_data_,16);
const unsigned long CslLexer::_tokenSet_18_data_[] = { 4294958072UL, 4294966271UL, 4294967295UL, 4294967295UL, 4294967295UL, 4294967295UL, 4294967295UL, 4294967295UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// 0x3 0x4 0x5 0x6 0x7 0x8 0x9 0xb 0xc 0xe 0xf 0x10 0x11 0x12 0x13 0x14 
// 0x15 0x16 0x17 0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x1e 0x1f   ! \" # $ % 
// & \' ( ) + , - . / 0 1 2 3 4 5 6 7 8 9 : ; < = > ? @ A B C D E F G H 
// I J K L M N O P Q R S T U V W X Y Z [ 0x5c ] ^ _ ` a b c d e f g h i 
// j k l m n o p q r s t u v w x y z { | } ~ 0x7f 0x80 0x81 0x82 0x83 0x84 
// 0x85 0x86 0x87 0x88 0x89 0x8a 0x8b 0x8c 0x8d 0x8e 0x8f 0x90 0x91 0x92 
// 0x93 0x94 0x95 0x96 0x97 0x98 0x99 0x9a 0x9b 0x9c 0x9d 0x9e 0x9f 0xa0 
// 0xa1 0xa2 0xa3 0xa4 0xa5 0xa6 0xa7 0xa8 0xa9 0xaa 0xab 0xac 0xad 0xae 
// 0xaf 0xb0 0xb1 0xb2 0xb3 0xb4 0xb5 0xb6 0xb7 0xb8 0xb9 0xba 0xbb 0xbc 
// 0xbd 0xbe 0xbf 0xc0 0xc1 0xc2 0xc3 0xc4 0xc5 0xc6 0xc7 0xc8 0xc9 0xca 
// 0xcb 0xcc 0xcd 0xce 0xcf 0xd0 0xd1 0xd2 0xd3 0xd4 0xd5 0xd6 0xd7 0xd8 
// 0xd9 0xda 0xdb 0xdc 0xdd 0xde 0xdf 0xe0 0xe1 0xe2 0xe3 0xe4 0xe5 0xe6 
// 0xe7 0xe8 0xe9 0xea 0xeb 0xec 0xed 0xee 0xef 0xf0 0xf1 0xf2 0xf3 0xf4 
// 0xf5 0xf6 0xf7 0xf8 0xf9 0xfa 0xfb 0xfc 0xfd 0xfe 0xff 
const ANTLR_USE_NAMESPACE(antlr)BitSet CslLexer::_tokenSet_18(_tokenSet_18_data_,16);

