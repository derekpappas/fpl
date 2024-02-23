`ifndef INC_GUARD_ISA
`define INC_GUARD_ISA

`define IF_F_OPCODE_UPPER_INDEX  (6-1)
`define IF_F_OPCODE_LOWER_INDEX (0)
`define IF_F_OPCODE_WIDTH (6)
`define IF_F_OPCODE_RANGE `IF_F_OPCODE_UPPER_INDEX:`IF_F_OPCODE_LOWER_INDEX

`define IF_F_FIELD_UPPER_INDEX  (6-1)
`define IF_F_FIELD_LOWER_INDEX (0)
`define IF_F_FIELD_WIDTH (6)
`define IF_F_FIELD_RANGE `IF_F_FIELD_UPPER_INDEX:`IF_F_FIELD_LOWER_INDEX

`define IF_F_IMM_UPPER_INDEX  (1-1)
`define IF_F_IMM_LOWER_INDEX (0)
`define IF_F_IMM_WIDTH (1)
`define IF_F_IMM_RANGE `IF_F_IMM_UPPER_INDEX:`IF_F_IMM_LOWER_INDEX

`define IE_RISC_ISA_UPPER_INDEX (32-1)
`define IE_RISC_ISA_LOWER_INDEX (0)
`define IE_RISC_ISA_WIDTH (32)
`define IE_RISC_ISA_RANGE `IE_RISC_ISA_UPPER_INDEX:`IE_RISC_ISA_LOWER_INDEX
`define IE_BASE_FORMAT_UPPER_INDEX (32-1)
`define IE_BASE_FORMAT_LOWER_INDEX (0)
`define IE_BASE_FORMAT_WIDTH (32)
`define IE_BASE_FORMAT_RANGE `IE_BASE_FORMAT_UPPER_INDEX:`IE_BASE_FORMAT_LOWER_INDEX
`define IE_BASE_FORMAT_IF_F_OPCODE_UPPER_INDEX  (5)
`define IE_BASE_FORMAT_IF_F_OPCODE_LOWER_INDEX (0)
`define IE_BASE_FORMAT_IF_F_OPCODE_RANGE `IE_BASE_FORMAT_IF_F_OPCODE_UPPER_INDEX:`IE_BASE_FORMAT_IF_F_OPCODE_LOWER_INDEX

`define IE_BASE_FORMAT_IF_OPERAND1_UPPER_INDEX  (5)
`define IE_BASE_FORMAT_IF_OPERAND1_LOWER_INDEX (0)
`define IE_BASE_FORMAT_IF_OPERAND1_RANGE `IE_BASE_FORMAT_IF_OPERAND1_UPPER_INDEX:`IE_BASE_FORMAT_IF_OPERAND1_LOWER_INDEX

`define IE_FORMAT1_UPPER_INDEX (32-1)
`define IE_FORMAT1_LOWER_INDEX (0)
`define IE_FORMAT1_WIDTH (32)
`define IE_FORMAT1_RANGE `IE_FORMAT1_UPPER_INDEX:`IE_FORMAT1_LOWER_INDEX
`define IE_FORMAT1_IF_F_OPCODE_UPPER_INDEX  (5)
`define IE_FORMAT1_IF_F_OPCODE_LOWER_INDEX (0)
`define IE_FORMAT1_IF_F_OPCODE_RANGE `IE_FORMAT1_IF_F_OPCODE_UPPER_INDEX:`IE_FORMAT1_IF_F_OPCODE_LOWER_INDEX

`define IE_FORMAT1_IF_OPERAND1_UPPER_INDEX  (5)
`define IE_FORMAT1_IF_OPERAND1_LOWER_INDEX (0)
`define IE_FORMAT1_IF_OPERAND1_RANGE `IE_FORMAT1_IF_OPERAND1_UPPER_INDEX:`IE_FORMAT1_IF_OPERAND1_LOWER_INDEX

`define IE_FORMAT1_IF_F1_OPERAND2_UPPER_INDEX  (1-1)
`define IE_FORMAT1_IF_F1_OPERAND2_LOWER_INDEX (0)
`define IE_FORMAT1_IF_F1_OPERAND2_WIDTH (1)
`define IE_FORMAT1_IF_F1_OPERAND2_RANGE `IE_FORMAT1_IF_F1_OPERAND2_UPPER_INDEX:`IE_FORMAT1_IF_F1_OPERAND2_LOWER_INDEX

`define IE_FORMAT1_IF_F1_REZ_UPPER_INDEX  (13-1)
`define IE_FORMAT1_IF_F1_REZ_LOWER_INDEX (0)
`define IE_FORMAT1_IF_F1_REZ_WIDTH (13)
`define IE_FORMAT1_IF_F1_REZ_RANGE `IE_FORMAT1_IF_F1_REZ_UPPER_INDEX:`IE_FORMAT1_IF_F1_REZ_LOWER_INDEX

`define IE_FORMAT2_UPPER_INDEX (32-1)
`define IE_FORMAT2_LOWER_INDEX (0)
`define IE_FORMAT2_WIDTH (32)
`define IE_FORMAT2_RANGE `IE_FORMAT2_UPPER_INDEX:`IE_FORMAT2_LOWER_INDEX
`define IE_FORMAT2_IF_F_OPCODE_UPPER_INDEX  (5)
`define IE_FORMAT2_IF_F_OPCODE_LOWER_INDEX (0)
`define IE_FORMAT2_IF_F_OPCODE_RANGE `IE_FORMAT2_IF_F_OPCODE_UPPER_INDEX:`IE_FORMAT2_IF_F_OPCODE_LOWER_INDEX

`define IE_FORMAT2_IF_OPERAND1_UPPER_INDEX  (5)
`define IE_FORMAT2_IF_OPERAND1_LOWER_INDEX (0)
`define IE_FORMAT2_IF_OPERAND1_RANGE `IE_FORMAT2_IF_OPERAND1_UPPER_INDEX:`IE_FORMAT2_IF_OPERAND1_LOWER_INDEX

`define IE_FORMAT2_IF_F2_OPERAND2_UPPER_INDEX  (5)
`define IE_FORMAT2_IF_F2_OPERAND2_LOWER_INDEX (0)
`define IE_FORMAT2_IF_F2_OPERAND2_RANGE `IE_FORMAT2_IF_F2_OPERAND2_UPPER_INDEX:`IE_FORMAT2_IF_F2_OPERAND2_LOWER_INDEX

`define IE_FORMAT2_IF_F2_IMM_UPPER_INDEX  (0)
`define IE_FORMAT2_IF_F2_IMM_LOWER_INDEX (0)
`define IE_FORMAT2_IF_F2_IMM_RANGE `IE_FORMAT2_IF_F2_IMM_UPPER_INDEX:`IE_FORMAT2_IF_F2_IMM_LOWER_INDEX

`define IE_FORMAT2_IF_F2_OPERAND_UPPER_INDEX  (12-1)
`define IE_FORMAT2_IF_F2_OPERAND_LOWER_INDEX (0)
`define IE_FORMAT2_IF_F2_OPERAND_WIDTH (12)
`define IE_FORMAT2_IF_F2_OPERAND_RANGE `IE_FORMAT2_IF_F2_OPERAND_UPPER_INDEX:`IE_FORMAT2_IF_F2_OPERAND_LOWER_INDEX

`define IE_FORMAT3_UPPER_INDEX (32-1)
`define IE_FORMAT3_LOWER_INDEX (0)
`define IE_FORMAT3_WIDTH (32)
`define IE_FORMAT3_RANGE `IE_FORMAT3_UPPER_INDEX:`IE_FORMAT3_LOWER_INDEX
`define IE_FORMAT3_IF_F_OPCODE_UPPER_INDEX  (5)
`define IE_FORMAT3_IF_F_OPCODE_LOWER_INDEX (0)
`define IE_FORMAT3_IF_F_OPCODE_RANGE `IE_FORMAT3_IF_F_OPCODE_UPPER_INDEX:`IE_FORMAT3_IF_F_OPCODE_LOWER_INDEX

`define IE_FORMAT3_IF_OPERAND1_UPPER_INDEX  (5)
`define IE_FORMAT3_IF_OPERAND1_LOWER_INDEX (0)
`define IE_FORMAT3_IF_OPERAND1_RANGE `IE_FORMAT3_IF_OPERAND1_UPPER_INDEX:`IE_FORMAT3_IF_OPERAND1_LOWER_INDEX

`define IE_FORMAT3_IF_F3_OPERAND2_UPPER_INDEX  (5)
`define IE_FORMAT3_IF_F3_OPERAND2_LOWER_INDEX (0)
`define IE_FORMAT3_IF_F3_OPERAND2_RANGE `IE_FORMAT3_IF_F3_OPERAND2_UPPER_INDEX:`IE_FORMAT3_IF_F3_OPERAND2_LOWER_INDEX

`define IE_FORMAT3_IF_F3_IMM_UPPER_INDEX  (0)
`define IE_FORMAT3_IF_F3_IMM_LOWER_INDEX (0)
`define IE_FORMAT3_IF_F3_IMM_RANGE `IE_FORMAT3_IF_F3_IMM_UPPER_INDEX:`IE_FORMAT3_IF_F3_IMM_LOWER_INDEX

`define IE_FORMAT3_IF_F3_SPARE_UPPER_INDEX  (7-1)
`define IE_FORMAT3_IF_F3_SPARE_LOWER_INDEX (0)
`define IE_FORMAT3_IF_F3_SPARE_WIDTH (7)
`define IE_FORMAT3_IF_F3_SPARE_RANGE `IE_FORMAT3_IF_F3_SPARE_UPPER_INDEX:`IE_FORMAT3_IF_F3_SPARE_LOWER_INDEX

`define IE_FORMAT3_IF_F3_RX_UPPER_INDEX  (5-1)
`define IE_FORMAT3_IF_F3_RX_LOWER_INDEX (0)
`define IE_FORMAT3_IF_F3_RX_WIDTH (5)
`define IE_FORMAT3_IF_F3_RX_RANGE `IE_FORMAT3_IF_F3_RX_UPPER_INDEX:`IE_FORMAT3_IF_F3_RX_LOWER_INDEX

`define IE_I_ADD_UPPER_INDEX (32-1)
`define IE_I_ADD_LOWER_INDEX (0)
`define IE_I_ADD_WIDTH (32)
`define IE_I_ADD_RANGE `IE_I_ADD_UPPER_INDEX:`IE_I_ADD_LOWER_INDEX
`define IE_I_ADD_IF_F_OPCODE_UPPER_INDEX  (5)
`define IE_I_ADD_IF_F_OPCODE_LOWER_INDEX (0)
`define IE_I_ADD_IF_F_OPCODE_RANGE `IE_I_ADD_IF_F_OPCODE_UPPER_INDEX:`IE_I_ADD_IF_F_OPCODE_LOWER_INDEX

`define IE_I_ADD_IF_OPERAND1_UPPER_INDEX  (5)
`define IE_I_ADD_IF_OPERAND1_LOWER_INDEX (0)
`define IE_I_ADD_IF_OPERAND1_RANGE `IE_I_ADD_IF_OPERAND1_UPPER_INDEX:`IE_I_ADD_IF_OPERAND1_LOWER_INDEX

`define IE_I_ADD_IF_F3_OPERAND2_UPPER_INDEX  (5)
`define IE_I_ADD_IF_F3_OPERAND2_LOWER_INDEX (0)
`define IE_I_ADD_IF_F3_OPERAND2_RANGE `IE_I_ADD_IF_F3_OPERAND2_UPPER_INDEX:`IE_I_ADD_IF_F3_OPERAND2_LOWER_INDEX

`define IE_I_ADD_IF_F3_IMM_UPPER_INDEX  (0)
`define IE_I_ADD_IF_F3_IMM_LOWER_INDEX (0)
`define IE_I_ADD_IF_F3_IMM_RANGE `IE_I_ADD_IF_F3_IMM_UPPER_INDEX:`IE_I_ADD_IF_F3_IMM_LOWER_INDEX

`define IE_I_ADD_IF_F3_SPARE_UPPER_INDEX  (6)
`define IE_I_ADD_IF_F3_SPARE_LOWER_INDEX (0)
`define IE_I_ADD_IF_F3_SPARE_RANGE `IE_I_ADD_IF_F3_SPARE_UPPER_INDEX:`IE_I_ADD_IF_F3_SPARE_LOWER_INDEX

`define IE_I_ADD_IF_F3_RX_UPPER_INDEX  (4)
`define IE_I_ADD_IF_F3_RX_LOWER_INDEX (0)
`define IE_I_ADD_IF_F3_RX_RANGE `IE_I_ADD_IF_F3_RX_UPPER_INDEX:`IE_I_ADD_IF_F3_RX_LOWER_INDEX

`define IE_I_ADDC_UPPER_INDEX (32-1)
`define IE_I_ADDC_LOWER_INDEX (0)
`define IE_I_ADDC_WIDTH (32)
`define IE_I_ADDC_RANGE `IE_I_ADDC_UPPER_INDEX:`IE_I_ADDC_LOWER_INDEX
`define IE_I_ADDC_IF_F_OPCODE_UPPER_INDEX  (5)
`define IE_I_ADDC_IF_F_OPCODE_LOWER_INDEX (0)
`define IE_I_ADDC_IF_F_OPCODE_RANGE `IE_I_ADDC_IF_F_OPCODE_UPPER_INDEX:`IE_I_ADDC_IF_F_OPCODE_LOWER_INDEX

`define IE_I_ADDC_IF_OPERAND1_UPPER_INDEX  (5)
`define IE_I_ADDC_IF_OPERAND1_LOWER_INDEX (0)
`define IE_I_ADDC_IF_OPERAND1_RANGE `IE_I_ADDC_IF_OPERAND1_UPPER_INDEX:`IE_I_ADDC_IF_OPERAND1_LOWER_INDEX

`define IE_I_ADDC_IF_F3_OPERAND2_UPPER_INDEX  (5)
`define IE_I_ADDC_IF_F3_OPERAND2_LOWER_INDEX (0)
`define IE_I_ADDC_IF_F3_OPERAND2_RANGE `IE_I_ADDC_IF_F3_OPERAND2_UPPER_INDEX:`IE_I_ADDC_IF_F3_OPERAND2_LOWER_INDEX

`define IE_I_ADDC_IF_F3_IMM_UPPER_INDEX  (0)
`define IE_I_ADDC_IF_F3_IMM_LOWER_INDEX (0)
`define IE_I_ADDC_IF_F3_IMM_RANGE `IE_I_ADDC_IF_F3_IMM_UPPER_INDEX:`IE_I_ADDC_IF_F3_IMM_LOWER_INDEX

`define IE_I_ADDC_IF_F3_SPARE_UPPER_INDEX  (6)
`define IE_I_ADDC_IF_F3_SPARE_LOWER_INDEX (0)
`define IE_I_ADDC_IF_F3_SPARE_RANGE `IE_I_ADDC_IF_F3_SPARE_UPPER_INDEX:`IE_I_ADDC_IF_F3_SPARE_LOWER_INDEX

`define IE_I_ADDC_IF_F3_RX_UPPER_INDEX  (4)
`define IE_I_ADDC_IF_F3_RX_LOWER_INDEX (0)
`define IE_I_ADDC_IF_F3_RX_RANGE `IE_I_ADDC_IF_F3_RX_UPPER_INDEX:`IE_I_ADDC_IF_F3_RX_LOWER_INDEX

`define IE_I_AND_UPPER_INDEX (32-1)
`define IE_I_AND_LOWER_INDEX (0)
`define IE_I_AND_WIDTH (32)
`define IE_I_AND_RANGE `IE_I_AND_UPPER_INDEX:`IE_I_AND_LOWER_INDEX
`define IE_I_AND_IF_F_OPCODE_UPPER_INDEX  (5)
`define IE_I_AND_IF_F_OPCODE_LOWER_INDEX (0)
`define IE_I_AND_IF_F_OPCODE_RANGE `IE_I_AND_IF_F_OPCODE_UPPER_INDEX:`IE_I_AND_IF_F_OPCODE_LOWER_INDEX

`define IE_I_AND_IF_OPERAND1_UPPER_INDEX  (5)
`define IE_I_AND_IF_OPERAND1_LOWER_INDEX (0)
`define IE_I_AND_IF_OPERAND1_RANGE `IE_I_AND_IF_OPERAND1_UPPER_INDEX:`IE_I_AND_IF_OPERAND1_LOWER_INDEX

`define IE_I_AND_IF_F3_OPERAND2_UPPER_INDEX  (5)
`define IE_I_AND_IF_F3_OPERAND2_LOWER_INDEX (0)
`define IE_I_AND_IF_F3_OPERAND2_RANGE `IE_I_AND_IF_F3_OPERAND2_UPPER_INDEX:`IE_I_AND_IF_F3_OPERAND2_LOWER_INDEX

`define IE_I_AND_IF_F3_IMM_UPPER_INDEX  (0)
`define IE_I_AND_IF_F3_IMM_LOWER_INDEX (0)
`define IE_I_AND_IF_F3_IMM_RANGE `IE_I_AND_IF_F3_IMM_UPPER_INDEX:`IE_I_AND_IF_F3_IMM_LOWER_INDEX

`define IE_I_AND_IF_F3_SPARE_UPPER_INDEX  (6)
`define IE_I_AND_IF_F3_SPARE_LOWER_INDEX (0)
`define IE_I_AND_IF_F3_SPARE_RANGE `IE_I_AND_IF_F3_SPARE_UPPER_INDEX:`IE_I_AND_IF_F3_SPARE_LOWER_INDEX

`define IE_I_AND_IF_F3_RX_UPPER_INDEX  (4)
`define IE_I_AND_IF_F3_RX_LOWER_INDEX (0)
`define IE_I_AND_IF_F3_RX_RANGE `IE_I_AND_IF_F3_RX_UPPER_INDEX:`IE_I_AND_IF_F3_RX_LOWER_INDEX

`define IE_I_CONST_ADD_UPPER_INDEX (32-1)
`define IE_I_CONST_ADD_LOWER_INDEX (0)
`define IE_I_CONST_ADD_WIDTH (32)
`define IE_I_CONST_ADD_RANGE `IE_I_CONST_ADD_UPPER_INDEX:`IE_I_CONST_ADD_LOWER_INDEX
`define IE_I_CONST_ADD_IF_F_OPCODE_UPPER_INDEX  (5)
`define IE_I_CONST_ADD_IF_F_OPCODE_LOWER_INDEX (0)
`define IE_I_CONST_ADD_IF_F_OPCODE_RANGE `IE_I_CONST_ADD_IF_F_OPCODE_UPPER_INDEX:`IE_I_CONST_ADD_IF_F_OPCODE_LOWER_INDEX

`define IE_I_CONST_ADD_IF_OPERAND1_UPPER_INDEX  (5)
`define IE_I_CONST_ADD_IF_OPERAND1_LOWER_INDEX (0)
`define IE_I_CONST_ADD_IF_OPERAND1_RANGE `IE_I_CONST_ADD_IF_OPERAND1_UPPER_INDEX:`IE_I_CONST_ADD_IF_OPERAND1_LOWER_INDEX

`define IE_I_CONST_ADD_IF_F1_OPERAND2_UPPER_INDEX  (0)
`define IE_I_CONST_ADD_IF_F1_OPERAND2_LOWER_INDEX (0)
`define IE_I_CONST_ADD_IF_F1_OPERAND2_RANGE `IE_I_CONST_ADD_IF_F1_OPERAND2_UPPER_INDEX:`IE_I_CONST_ADD_IF_F1_OPERAND2_LOWER_INDEX

`define IE_I_CONST_ADD_IF_F1_REZ_UPPER_INDEX  (12)
`define IE_I_CONST_ADD_IF_F1_REZ_LOWER_INDEX (0)
`define IE_I_CONST_ADD_IF_F1_REZ_RANGE `IE_I_CONST_ADD_IF_F1_REZ_UPPER_INDEX:`IE_I_CONST_ADD_IF_F1_REZ_LOWER_INDEX

`define IE_I_CONST_SUB_UPPER_INDEX (32-1)
`define IE_I_CONST_SUB_LOWER_INDEX (0)
`define IE_I_CONST_SUB_WIDTH (32)
`define IE_I_CONST_SUB_RANGE `IE_I_CONST_SUB_UPPER_INDEX:`IE_I_CONST_SUB_LOWER_INDEX
`define IE_I_CONST_SUB_IF_F_OPCODE_UPPER_INDEX  (5)
`define IE_I_CONST_SUB_IF_F_OPCODE_LOWER_INDEX (0)
`define IE_I_CONST_SUB_IF_F_OPCODE_RANGE `IE_I_CONST_SUB_IF_F_OPCODE_UPPER_INDEX:`IE_I_CONST_SUB_IF_F_OPCODE_LOWER_INDEX

`define IE_I_CONST_SUB_IF_OPERAND1_UPPER_INDEX  (5)
`define IE_I_CONST_SUB_IF_OPERAND1_LOWER_INDEX (0)
`define IE_I_CONST_SUB_IF_OPERAND1_RANGE `IE_I_CONST_SUB_IF_OPERAND1_UPPER_INDEX:`IE_I_CONST_SUB_IF_OPERAND1_LOWER_INDEX

`define IE_I_CONST_SUB_IF_F1_OPERAND2_UPPER_INDEX  (0)
`define IE_I_CONST_SUB_IF_F1_OPERAND2_LOWER_INDEX (0)
`define IE_I_CONST_SUB_IF_F1_OPERAND2_RANGE `IE_I_CONST_SUB_IF_F1_OPERAND2_UPPER_INDEX:`IE_I_CONST_SUB_IF_F1_OPERAND2_LOWER_INDEX

`define IE_I_CONST_SUB_IF_F1_REZ_UPPER_INDEX  (12)
`define IE_I_CONST_SUB_IF_F1_REZ_LOWER_INDEX (0)
`define IE_I_CONST_SUB_IF_F1_REZ_RANGE `IE_I_CONST_SUB_IF_F1_REZ_UPPER_INDEX:`IE_I_CONST_SUB_IF_F1_REZ_LOWER_INDEX

`define IE_I_CONST_H_UPPER_INDEX (32-1)
`define IE_I_CONST_H_LOWER_INDEX (0)
`define IE_I_CONST_H_WIDTH (32)
`define IE_I_CONST_H_RANGE `IE_I_CONST_H_UPPER_INDEX:`IE_I_CONST_H_LOWER_INDEX
`define IE_I_CONST_H_IF_F_OPCODE_UPPER_INDEX  (5)
`define IE_I_CONST_H_IF_F_OPCODE_LOWER_INDEX (0)
`define IE_I_CONST_H_IF_F_OPCODE_RANGE `IE_I_CONST_H_IF_F_OPCODE_UPPER_INDEX:`IE_I_CONST_H_IF_F_OPCODE_LOWER_INDEX

`define IE_I_CONST_H_IF_OPERAND1_UPPER_INDEX  (5)
`define IE_I_CONST_H_IF_OPERAND1_LOWER_INDEX (0)
`define IE_I_CONST_H_IF_OPERAND1_RANGE `IE_I_CONST_H_IF_OPERAND1_UPPER_INDEX:`IE_I_CONST_H_IF_OPERAND1_LOWER_INDEX

`define IE_I_CONST_H_IF_F1_OPERAND2_UPPER_INDEX  (0)
`define IE_I_CONST_H_IF_F1_OPERAND2_LOWER_INDEX (0)
`define IE_I_CONST_H_IF_F1_OPERAND2_RANGE `IE_I_CONST_H_IF_F1_OPERAND2_UPPER_INDEX:`IE_I_CONST_H_IF_F1_OPERAND2_LOWER_INDEX

`define IE_I_CONST_H_IF_F1_REZ_UPPER_INDEX  (12)
`define IE_I_CONST_H_IF_F1_REZ_LOWER_INDEX (0)
`define IE_I_CONST_H_IF_F1_REZ_RANGE `IE_I_CONST_H_IF_F1_REZ_UPPER_INDEX:`IE_I_CONST_H_IF_F1_REZ_LOWER_INDEX

`define IE_I_OR_UPPER_INDEX (32-1)
`define IE_I_OR_LOWER_INDEX (0)
`define IE_I_OR_WIDTH (32)
`define IE_I_OR_RANGE `IE_I_OR_UPPER_INDEX:`IE_I_OR_LOWER_INDEX
`define IE_I_OR_IF_F_OPCODE_UPPER_INDEX  (5)
`define IE_I_OR_IF_F_OPCODE_LOWER_INDEX (0)
`define IE_I_OR_IF_F_OPCODE_RANGE `IE_I_OR_IF_F_OPCODE_UPPER_INDEX:`IE_I_OR_IF_F_OPCODE_LOWER_INDEX

`define IE_I_OR_IF_OPERAND1_UPPER_INDEX  (5)
`define IE_I_OR_IF_OPERAND1_LOWER_INDEX (0)
`define IE_I_OR_IF_OPERAND1_RANGE `IE_I_OR_IF_OPERAND1_UPPER_INDEX:`IE_I_OR_IF_OPERAND1_LOWER_INDEX

`define IE_I_OR_IF_F3_OPERAND2_UPPER_INDEX  (5)
`define IE_I_OR_IF_F3_OPERAND2_LOWER_INDEX (0)
`define IE_I_OR_IF_F3_OPERAND2_RANGE `IE_I_OR_IF_F3_OPERAND2_UPPER_INDEX:`IE_I_OR_IF_F3_OPERAND2_LOWER_INDEX

`define IE_I_OR_IF_F3_IMM_UPPER_INDEX  (0)
`define IE_I_OR_IF_F3_IMM_LOWER_INDEX (0)
`define IE_I_OR_IF_F3_IMM_RANGE `IE_I_OR_IF_F3_IMM_UPPER_INDEX:`IE_I_OR_IF_F3_IMM_LOWER_INDEX

`define IE_I_OR_IF_F3_SPARE_UPPER_INDEX  (6)
`define IE_I_OR_IF_F3_SPARE_LOWER_INDEX (0)
`define IE_I_OR_IF_F3_SPARE_RANGE `IE_I_OR_IF_F3_SPARE_UPPER_INDEX:`IE_I_OR_IF_F3_SPARE_LOWER_INDEX

`define IE_I_OR_IF_F3_RX_UPPER_INDEX  (4)
`define IE_I_OR_IF_F3_RX_LOWER_INDEX (0)
`define IE_I_OR_IF_F3_RX_RANGE `IE_I_OR_IF_F3_RX_UPPER_INDEX:`IE_I_OR_IF_F3_RX_LOWER_INDEX

`define IE_I_ROTL_UPPER_INDEX (32-1)
`define IE_I_ROTL_LOWER_INDEX (0)
`define IE_I_ROTL_WIDTH (32)
`define IE_I_ROTL_RANGE `IE_I_ROTL_UPPER_INDEX:`IE_I_ROTL_LOWER_INDEX
`define IE_I_ROTL_IF_F_OPCODE_UPPER_INDEX  (5)
`define IE_I_ROTL_IF_F_OPCODE_LOWER_INDEX (0)
`define IE_I_ROTL_IF_F_OPCODE_RANGE `IE_I_ROTL_IF_F_OPCODE_UPPER_INDEX:`IE_I_ROTL_IF_F_OPCODE_LOWER_INDEX

`define IE_I_ROTL_IF_OPERAND1_UPPER_INDEX  (5)
`define IE_I_ROTL_IF_OPERAND1_LOWER_INDEX (0)
`define IE_I_ROTL_IF_OPERAND1_RANGE `IE_I_ROTL_IF_OPERAND1_UPPER_INDEX:`IE_I_ROTL_IF_OPERAND1_LOWER_INDEX

`define IE_I_ROTL_IF_F3_OPERAND2_UPPER_INDEX  (5)
`define IE_I_ROTL_IF_F3_OPERAND2_LOWER_INDEX (0)
`define IE_I_ROTL_IF_F3_OPERAND2_RANGE `IE_I_ROTL_IF_F3_OPERAND2_UPPER_INDEX:`IE_I_ROTL_IF_F3_OPERAND2_LOWER_INDEX

`define IE_I_ROTL_IF_F3_IMM_UPPER_INDEX  (0)
`define IE_I_ROTL_IF_F3_IMM_LOWER_INDEX (0)
`define IE_I_ROTL_IF_F3_IMM_RANGE `IE_I_ROTL_IF_F3_IMM_UPPER_INDEX:`IE_I_ROTL_IF_F3_IMM_LOWER_INDEX

`define IE_I_ROTL_IF_F3_SPARE_UPPER_INDEX  (6)
`define IE_I_ROTL_IF_F3_SPARE_LOWER_INDEX (0)
`define IE_I_ROTL_IF_F3_SPARE_RANGE `IE_I_ROTL_IF_F3_SPARE_UPPER_INDEX:`IE_I_ROTL_IF_F3_SPARE_LOWER_INDEX

`define IE_I_ROTL_IF_F3_RX_UPPER_INDEX  (4)
`define IE_I_ROTL_IF_F3_RX_LOWER_INDEX (0)
`define IE_I_ROTL_IF_F3_RX_RANGE `IE_I_ROTL_IF_F3_RX_UPPER_INDEX:`IE_I_ROTL_IF_F3_RX_LOWER_INDEX

`define IE_I_SLL_UPPER_INDEX (32-1)
`define IE_I_SLL_LOWER_INDEX (0)
`define IE_I_SLL_WIDTH (32)
`define IE_I_SLL_RANGE `IE_I_SLL_UPPER_INDEX:`IE_I_SLL_LOWER_INDEX
`define IE_I_SLL_IF_F_OPCODE_UPPER_INDEX  (5)
`define IE_I_SLL_IF_F_OPCODE_LOWER_INDEX (0)
`define IE_I_SLL_IF_F_OPCODE_RANGE `IE_I_SLL_IF_F_OPCODE_UPPER_INDEX:`IE_I_SLL_IF_F_OPCODE_LOWER_INDEX

`define IE_I_SLL_IF_OPERAND1_UPPER_INDEX  (5)
`define IE_I_SLL_IF_OPERAND1_LOWER_INDEX (0)
`define IE_I_SLL_IF_OPERAND1_RANGE `IE_I_SLL_IF_OPERAND1_UPPER_INDEX:`IE_I_SLL_IF_OPERAND1_LOWER_INDEX

`define IE_I_SLL_IF_F3_OPERAND2_UPPER_INDEX  (5)
`define IE_I_SLL_IF_F3_OPERAND2_LOWER_INDEX (0)
`define IE_I_SLL_IF_F3_OPERAND2_RANGE `IE_I_SLL_IF_F3_OPERAND2_UPPER_INDEX:`IE_I_SLL_IF_F3_OPERAND2_LOWER_INDEX

`define IE_I_SLL_IF_F3_IMM_UPPER_INDEX  (0)
`define IE_I_SLL_IF_F3_IMM_LOWER_INDEX (0)
`define IE_I_SLL_IF_F3_IMM_RANGE `IE_I_SLL_IF_F3_IMM_UPPER_INDEX:`IE_I_SLL_IF_F3_IMM_LOWER_INDEX

`define IE_I_SLL_IF_F3_SPARE_UPPER_INDEX  (6)
`define IE_I_SLL_IF_F3_SPARE_LOWER_INDEX (0)
`define IE_I_SLL_IF_F3_SPARE_RANGE `IE_I_SLL_IF_F3_SPARE_UPPER_INDEX:`IE_I_SLL_IF_F3_SPARE_LOWER_INDEX

`define IE_I_SLL_IF_F3_RX_UPPER_INDEX  (4)
`define IE_I_SLL_IF_F3_RX_LOWER_INDEX (0)
`define IE_I_SLL_IF_F3_RX_RANGE `IE_I_SLL_IF_F3_RX_UPPER_INDEX:`IE_I_SLL_IF_F3_RX_LOWER_INDEX

`define IE_I_SRA_UPPER_INDEX (32-1)
`define IE_I_SRA_LOWER_INDEX (0)
`define IE_I_SRA_WIDTH (32)
`define IE_I_SRA_RANGE `IE_I_SRA_UPPER_INDEX:`IE_I_SRA_LOWER_INDEX
`define IE_I_SRA_IF_F_OPCODE_UPPER_INDEX  (5)
`define IE_I_SRA_IF_F_OPCODE_LOWER_INDEX (0)
`define IE_I_SRA_IF_F_OPCODE_RANGE `IE_I_SRA_IF_F_OPCODE_UPPER_INDEX:`IE_I_SRA_IF_F_OPCODE_LOWER_INDEX

`define IE_I_SRA_IF_OPERAND1_UPPER_INDEX  (5)
`define IE_I_SRA_IF_OPERAND1_LOWER_INDEX (0)
`define IE_I_SRA_IF_OPERAND1_RANGE `IE_I_SRA_IF_OPERAND1_UPPER_INDEX:`IE_I_SRA_IF_OPERAND1_LOWER_INDEX

`define IE_I_SRA_IF_F3_OPERAND2_UPPER_INDEX  (5)
`define IE_I_SRA_IF_F3_OPERAND2_LOWER_INDEX (0)
`define IE_I_SRA_IF_F3_OPERAND2_RANGE `IE_I_SRA_IF_F3_OPERAND2_UPPER_INDEX:`IE_I_SRA_IF_F3_OPERAND2_LOWER_INDEX

`define IE_I_SRA_IF_F3_IMM_UPPER_INDEX  (0)
`define IE_I_SRA_IF_F3_IMM_LOWER_INDEX (0)
`define IE_I_SRA_IF_F3_IMM_RANGE `IE_I_SRA_IF_F3_IMM_UPPER_INDEX:`IE_I_SRA_IF_F3_IMM_LOWER_INDEX

`define IE_I_SRA_IF_F3_SPARE_UPPER_INDEX  (6)
`define IE_I_SRA_IF_F3_SPARE_LOWER_INDEX (0)
`define IE_I_SRA_IF_F3_SPARE_RANGE `IE_I_SRA_IF_F3_SPARE_UPPER_INDEX:`IE_I_SRA_IF_F3_SPARE_LOWER_INDEX

`define IE_I_SRA_IF_F3_RX_UPPER_INDEX  (4)
`define IE_I_SRA_IF_F3_RX_LOWER_INDEX (0)
`define IE_I_SRA_IF_F3_RX_RANGE `IE_I_SRA_IF_F3_RX_UPPER_INDEX:`IE_I_SRA_IF_F3_RX_LOWER_INDEX

`define IE_I_SRL_UPPER_INDEX (32-1)
`define IE_I_SRL_LOWER_INDEX (0)
`define IE_I_SRL_WIDTH (32)
`define IE_I_SRL_RANGE `IE_I_SRL_UPPER_INDEX:`IE_I_SRL_LOWER_INDEX
`define IE_I_SRL_IF_F_OPCODE_UPPER_INDEX  (5)
`define IE_I_SRL_IF_F_OPCODE_LOWER_INDEX (0)
`define IE_I_SRL_IF_F_OPCODE_RANGE `IE_I_SRL_IF_F_OPCODE_UPPER_INDEX:`IE_I_SRL_IF_F_OPCODE_LOWER_INDEX

`define IE_I_SRL_IF_OPERAND1_UPPER_INDEX  (5)
`define IE_I_SRL_IF_OPERAND1_LOWER_INDEX (0)
`define IE_I_SRL_IF_OPERAND1_RANGE `IE_I_SRL_IF_OPERAND1_UPPER_INDEX:`IE_I_SRL_IF_OPERAND1_LOWER_INDEX

`define IE_I_SRL_IF_F3_OPERAND2_UPPER_INDEX  (5)
`define IE_I_SRL_IF_F3_OPERAND2_LOWER_INDEX (0)
`define IE_I_SRL_IF_F3_OPERAND2_RANGE `IE_I_SRL_IF_F3_OPERAND2_UPPER_INDEX:`IE_I_SRL_IF_F3_OPERAND2_LOWER_INDEX

`define IE_I_SRL_IF_F3_IMM_UPPER_INDEX  (0)
`define IE_I_SRL_IF_F3_IMM_LOWER_INDEX (0)
`define IE_I_SRL_IF_F3_IMM_RANGE `IE_I_SRL_IF_F3_IMM_UPPER_INDEX:`IE_I_SRL_IF_F3_IMM_LOWER_INDEX

`define IE_I_SRL_IF_F3_SPARE_UPPER_INDEX  (6)
`define IE_I_SRL_IF_F3_SPARE_LOWER_INDEX (0)
`define IE_I_SRL_IF_F3_SPARE_RANGE `IE_I_SRL_IF_F3_SPARE_UPPER_INDEX:`IE_I_SRL_IF_F3_SPARE_LOWER_INDEX

`define IE_I_SRL_IF_F3_RX_UPPER_INDEX  (4)
`define IE_I_SRL_IF_F3_RX_LOWER_INDEX (0)
`define IE_I_SRL_IF_F3_RX_RANGE `IE_I_SRL_IF_F3_RX_UPPER_INDEX:`IE_I_SRL_IF_F3_RX_LOWER_INDEX

`define IE_I_SUB_UPPER_INDEX (32-1)
`define IE_I_SUB_LOWER_INDEX (0)
`define IE_I_SUB_WIDTH (32)
`define IE_I_SUB_RANGE `IE_I_SUB_UPPER_INDEX:`IE_I_SUB_LOWER_INDEX
`define IE_I_SUB_IF_F_OPCODE_UPPER_INDEX  (5)
`define IE_I_SUB_IF_F_OPCODE_LOWER_INDEX (0)
`define IE_I_SUB_IF_F_OPCODE_RANGE `IE_I_SUB_IF_F_OPCODE_UPPER_INDEX:`IE_I_SUB_IF_F_OPCODE_LOWER_INDEX

`define IE_I_SUB_IF_OPERAND1_UPPER_INDEX  (5)
`define IE_I_SUB_IF_OPERAND1_LOWER_INDEX (0)
`define IE_I_SUB_IF_OPERAND1_RANGE `IE_I_SUB_IF_OPERAND1_UPPER_INDEX:`IE_I_SUB_IF_OPERAND1_LOWER_INDEX

`define IE_I_SUB_IF_F3_OPERAND2_UPPER_INDEX  (5)
`define IE_I_SUB_IF_F3_OPERAND2_LOWER_INDEX (0)
`define IE_I_SUB_IF_F3_OPERAND2_RANGE `IE_I_SUB_IF_F3_OPERAND2_UPPER_INDEX:`IE_I_SUB_IF_F3_OPERAND2_LOWER_INDEX

`define IE_I_SUB_IF_F3_IMM_UPPER_INDEX  (0)
`define IE_I_SUB_IF_F3_IMM_LOWER_INDEX (0)
`define IE_I_SUB_IF_F3_IMM_RANGE `IE_I_SUB_IF_F3_IMM_UPPER_INDEX:`IE_I_SUB_IF_F3_IMM_LOWER_INDEX

`define IE_I_SUB_IF_F3_SPARE_UPPER_INDEX  (6)
`define IE_I_SUB_IF_F3_SPARE_LOWER_INDEX (0)
`define IE_I_SUB_IF_F3_SPARE_RANGE `IE_I_SUB_IF_F3_SPARE_UPPER_INDEX:`IE_I_SUB_IF_F3_SPARE_LOWER_INDEX

`define IE_I_SUB_IF_F3_RX_UPPER_INDEX  (4)
`define IE_I_SUB_IF_F3_RX_LOWER_INDEX (0)
`define IE_I_SUB_IF_F3_RX_RANGE `IE_I_SUB_IF_F3_RX_UPPER_INDEX:`IE_I_SUB_IF_F3_RX_LOWER_INDEX

`define IE_I_SUBC_UPPER_INDEX (32-1)
`define IE_I_SUBC_LOWER_INDEX (0)
`define IE_I_SUBC_WIDTH (32)
`define IE_I_SUBC_RANGE `IE_I_SUBC_UPPER_INDEX:`IE_I_SUBC_LOWER_INDEX
`define IE_I_SUBC_IF_F_OPCODE_UPPER_INDEX  (5)
`define IE_I_SUBC_IF_F_OPCODE_LOWER_INDEX (0)
`define IE_I_SUBC_IF_F_OPCODE_RANGE `IE_I_SUBC_IF_F_OPCODE_UPPER_INDEX:`IE_I_SUBC_IF_F_OPCODE_LOWER_INDEX

`define IE_I_SUBC_IF_OPERAND1_UPPER_INDEX  (5)
`define IE_I_SUBC_IF_OPERAND1_LOWER_INDEX (0)
`define IE_I_SUBC_IF_OPERAND1_RANGE `IE_I_SUBC_IF_OPERAND1_UPPER_INDEX:`IE_I_SUBC_IF_OPERAND1_LOWER_INDEX

`define IE_I_SUBC_IF_F3_OPERAND2_UPPER_INDEX  (5)
`define IE_I_SUBC_IF_F3_OPERAND2_LOWER_INDEX (0)
`define IE_I_SUBC_IF_F3_OPERAND2_RANGE `IE_I_SUBC_IF_F3_OPERAND2_UPPER_INDEX:`IE_I_SUBC_IF_F3_OPERAND2_LOWER_INDEX

`define IE_I_SUBC_IF_F3_IMM_UPPER_INDEX  (0)
`define IE_I_SUBC_IF_F3_IMM_LOWER_INDEX (0)
`define IE_I_SUBC_IF_F3_IMM_RANGE `IE_I_SUBC_IF_F3_IMM_UPPER_INDEX:`IE_I_SUBC_IF_F3_IMM_LOWER_INDEX

`define IE_I_SUBC_IF_F3_SPARE_UPPER_INDEX  (6)
`define IE_I_SUBC_IF_F3_SPARE_LOWER_INDEX (0)
`define IE_I_SUBC_IF_F3_SPARE_RANGE `IE_I_SUBC_IF_F3_SPARE_UPPER_INDEX:`IE_I_SUBC_IF_F3_SPARE_LOWER_INDEX

`define IE_I_SUBC_IF_F3_RX_UPPER_INDEX  (4)
`define IE_I_SUBC_IF_F3_RX_LOWER_INDEX (0)
`define IE_I_SUBC_IF_F3_RX_RANGE `IE_I_SUBC_IF_F3_RX_UPPER_INDEX:`IE_I_SUBC_IF_F3_RX_LOWER_INDEX

`define IE_I_SUBR_UPPER_INDEX (32-1)
`define IE_I_SUBR_LOWER_INDEX (0)
`define IE_I_SUBR_WIDTH (32)
`define IE_I_SUBR_RANGE `IE_I_SUBR_UPPER_INDEX:`IE_I_SUBR_LOWER_INDEX
`define IE_I_SUBR_IF_F_OPCODE_UPPER_INDEX  (5)
`define IE_I_SUBR_IF_F_OPCODE_LOWER_INDEX (0)
`define IE_I_SUBR_IF_F_OPCODE_RANGE `IE_I_SUBR_IF_F_OPCODE_UPPER_INDEX:`IE_I_SUBR_IF_F_OPCODE_LOWER_INDEX

`define IE_I_SUBR_IF_OPERAND1_UPPER_INDEX  (5)
`define IE_I_SUBR_IF_OPERAND1_LOWER_INDEX (0)
`define IE_I_SUBR_IF_OPERAND1_RANGE `IE_I_SUBR_IF_OPERAND1_UPPER_INDEX:`IE_I_SUBR_IF_OPERAND1_LOWER_INDEX

`define IE_I_SUBR_IF_F3_OPERAND2_UPPER_INDEX  (5)
`define IE_I_SUBR_IF_F3_OPERAND2_LOWER_INDEX (0)
`define IE_I_SUBR_IF_F3_OPERAND2_RANGE `IE_I_SUBR_IF_F3_OPERAND2_UPPER_INDEX:`IE_I_SUBR_IF_F3_OPERAND2_LOWER_INDEX

`define IE_I_SUBR_IF_F3_IMM_UPPER_INDEX  (0)
`define IE_I_SUBR_IF_F3_IMM_LOWER_INDEX (0)
`define IE_I_SUBR_IF_F3_IMM_RANGE `IE_I_SUBR_IF_F3_IMM_UPPER_INDEX:`IE_I_SUBR_IF_F3_IMM_LOWER_INDEX

`define IE_I_SUBR_IF_F3_SPARE_UPPER_INDEX  (6)
`define IE_I_SUBR_IF_F3_SPARE_LOWER_INDEX (0)
`define IE_I_SUBR_IF_F3_SPARE_RANGE `IE_I_SUBR_IF_F3_SPARE_UPPER_INDEX:`IE_I_SUBR_IF_F3_SPARE_LOWER_INDEX

`define IE_I_SUBR_IF_F3_RX_UPPER_INDEX  (4)
`define IE_I_SUBR_IF_F3_RX_LOWER_INDEX (0)
`define IE_I_SUBR_IF_F3_RX_RANGE `IE_I_SUBR_IF_F3_RX_UPPER_INDEX:`IE_I_SUBR_IF_F3_RX_LOWER_INDEX

`define IE_I_SUBRC_UPPER_INDEX (32-1)
`define IE_I_SUBRC_LOWER_INDEX (0)
`define IE_I_SUBRC_WIDTH (32)
`define IE_I_SUBRC_RANGE `IE_I_SUBRC_UPPER_INDEX:`IE_I_SUBRC_LOWER_INDEX
`define IE_I_SUBRC_IF_F_OPCODE_UPPER_INDEX  (5)
`define IE_I_SUBRC_IF_F_OPCODE_LOWER_INDEX (0)
`define IE_I_SUBRC_IF_F_OPCODE_RANGE `IE_I_SUBRC_IF_F_OPCODE_UPPER_INDEX:`IE_I_SUBRC_IF_F_OPCODE_LOWER_INDEX

`define IE_I_SUBRC_IF_OPERAND1_UPPER_INDEX  (5)
`define IE_I_SUBRC_IF_OPERAND1_LOWER_INDEX (0)
`define IE_I_SUBRC_IF_OPERAND1_RANGE `IE_I_SUBRC_IF_OPERAND1_UPPER_INDEX:`IE_I_SUBRC_IF_OPERAND1_LOWER_INDEX

`define IE_I_SUBRC_IF_F3_OPERAND2_UPPER_INDEX  (5)
`define IE_I_SUBRC_IF_F3_OPERAND2_LOWER_INDEX (0)
`define IE_I_SUBRC_IF_F3_OPERAND2_RANGE `IE_I_SUBRC_IF_F3_OPERAND2_UPPER_INDEX:`IE_I_SUBRC_IF_F3_OPERAND2_LOWER_INDEX

`define IE_I_SUBRC_IF_F3_IMM_UPPER_INDEX  (0)
`define IE_I_SUBRC_IF_F3_IMM_LOWER_INDEX (0)
`define IE_I_SUBRC_IF_F3_IMM_RANGE `IE_I_SUBRC_IF_F3_IMM_UPPER_INDEX:`IE_I_SUBRC_IF_F3_IMM_LOWER_INDEX

`define IE_I_SUBRC_IF_F3_SPARE_UPPER_INDEX  (6)
`define IE_I_SUBRC_IF_F3_SPARE_LOWER_INDEX (0)
`define IE_I_SUBRC_IF_F3_SPARE_RANGE `IE_I_SUBRC_IF_F3_SPARE_UPPER_INDEX:`IE_I_SUBRC_IF_F3_SPARE_LOWER_INDEX

`define IE_I_SUBRC_IF_F3_RX_UPPER_INDEX  (4)
`define IE_I_SUBRC_IF_F3_RX_LOWER_INDEX (0)
`define IE_I_SUBRC_IF_F3_RX_RANGE `IE_I_SUBRC_IF_F3_RX_UPPER_INDEX:`IE_I_SUBRC_IF_F3_RX_LOWER_INDEX

`define IE_I_XOR_UPPER_INDEX (32-1)
`define IE_I_XOR_LOWER_INDEX (0)
`define IE_I_XOR_WIDTH (32)
`define IE_I_XOR_RANGE `IE_I_XOR_UPPER_INDEX:`IE_I_XOR_LOWER_INDEX
`define IE_I_XOR_IF_F_OPCODE_UPPER_INDEX  (5)
`define IE_I_XOR_IF_F_OPCODE_LOWER_INDEX (0)
`define IE_I_XOR_IF_F_OPCODE_RANGE `IE_I_XOR_IF_F_OPCODE_UPPER_INDEX:`IE_I_XOR_IF_F_OPCODE_LOWER_INDEX

`define IE_I_XOR_IF_OPERAND1_UPPER_INDEX  (5)
`define IE_I_XOR_IF_OPERAND1_LOWER_INDEX (0)
`define IE_I_XOR_IF_OPERAND1_RANGE `IE_I_XOR_IF_OPERAND1_UPPER_INDEX:`IE_I_XOR_IF_OPERAND1_LOWER_INDEX

`define IE_I_XOR_IF_F3_OPERAND2_UPPER_INDEX  (5)
`define IE_I_XOR_IF_F3_OPERAND2_LOWER_INDEX (0)
`define IE_I_XOR_IF_F3_OPERAND2_RANGE `IE_I_XOR_IF_F3_OPERAND2_UPPER_INDEX:`IE_I_XOR_IF_F3_OPERAND2_LOWER_INDEX

`define IE_I_XOR_IF_F3_IMM_UPPER_INDEX  (0)
`define IE_I_XOR_IF_F3_IMM_LOWER_INDEX (0)
`define IE_I_XOR_IF_F3_IMM_RANGE `IE_I_XOR_IF_F3_IMM_UPPER_INDEX:`IE_I_XOR_IF_F3_IMM_LOWER_INDEX

`define IE_I_XOR_IF_F3_SPARE_UPPER_INDEX  (6)
`define IE_I_XOR_IF_F3_SPARE_LOWER_INDEX (0)
`define IE_I_XOR_IF_F3_SPARE_RANGE `IE_I_XOR_IF_F3_SPARE_UPPER_INDEX:`IE_I_XOR_IF_F3_SPARE_LOWER_INDEX

`define IE_I_XOR_IF_F3_RX_UPPER_INDEX  (4)
`define IE_I_XOR_IF_F3_RX_LOWER_INDEX (0)
`define IE_I_XOR_IF_F3_RX_RANGE `IE_I_XOR_IF_F3_RX_UPPER_INDEX:`IE_I_XOR_IF_F3_RX_LOWER_INDEX

`define IE_I_LP_UPPER_INDEX (32-1)
`define IE_I_LP_LOWER_INDEX (0)
`define IE_I_LP_WIDTH (32)
`define IE_I_LP_RANGE `IE_I_LP_UPPER_INDEX:`IE_I_LP_LOWER_INDEX
`define IE_I_LP_IF_F_OPCODE_UPPER_INDEX  (5)
`define IE_I_LP_IF_F_OPCODE_LOWER_INDEX (0)
`define IE_I_LP_IF_F_OPCODE_RANGE `IE_I_LP_IF_F_OPCODE_UPPER_INDEX:`IE_I_LP_IF_F_OPCODE_LOWER_INDEX

`define IE_I_LP_IF_OPERAND1_UPPER_INDEX  (5)
`define IE_I_LP_IF_OPERAND1_LOWER_INDEX (0)
`define IE_I_LP_IF_OPERAND1_RANGE `IE_I_LP_IF_OPERAND1_UPPER_INDEX:`IE_I_LP_IF_OPERAND1_LOWER_INDEX

`define IE_I_LP_IF_F2_OPERAND2_UPPER_INDEX  (5)
`define IE_I_LP_IF_F2_OPERAND2_LOWER_INDEX (0)
`define IE_I_LP_IF_F2_OPERAND2_RANGE `IE_I_LP_IF_F2_OPERAND2_UPPER_INDEX:`IE_I_LP_IF_F2_OPERAND2_LOWER_INDEX

`define IE_I_LP_IF_F2_IMM_UPPER_INDEX  (0)
`define IE_I_LP_IF_F2_IMM_LOWER_INDEX (0)
`define IE_I_LP_IF_F2_IMM_RANGE `IE_I_LP_IF_F2_IMM_UPPER_INDEX:`IE_I_LP_IF_F2_IMM_LOWER_INDEX

`define IE_I_LP_IF_F2_OPERAND_UPPER_INDEX  (11)
`define IE_I_LP_IF_F2_OPERAND_LOWER_INDEX (0)
`define IE_I_LP_IF_F2_OPERAND_RANGE `IE_I_LP_IF_F2_OPERAND_UPPER_INDEX:`IE_I_LP_IF_F2_OPERAND_LOWER_INDEX

`define IE_I_SQ_UPPER_INDEX (32-1)
`define IE_I_SQ_LOWER_INDEX (0)
`define IE_I_SQ_WIDTH (32)
`define IE_I_SQ_RANGE `IE_I_SQ_UPPER_INDEX:`IE_I_SQ_LOWER_INDEX
`define IE_I_SQ_IF_F_OPCODE_UPPER_INDEX  (5)
`define IE_I_SQ_IF_F_OPCODE_LOWER_INDEX (0)
`define IE_I_SQ_IF_F_OPCODE_RANGE `IE_I_SQ_IF_F_OPCODE_UPPER_INDEX:`IE_I_SQ_IF_F_OPCODE_LOWER_INDEX

`define IE_I_SQ_IF_OPERAND1_UPPER_INDEX  (5)
`define IE_I_SQ_IF_OPERAND1_LOWER_INDEX (0)
`define IE_I_SQ_IF_OPERAND1_RANGE `IE_I_SQ_IF_OPERAND1_UPPER_INDEX:`IE_I_SQ_IF_OPERAND1_LOWER_INDEX

`define IE_I_SQ_IF_F3_OPERAND2_UPPER_INDEX  (5)
`define IE_I_SQ_IF_F3_OPERAND2_LOWER_INDEX (0)
`define IE_I_SQ_IF_F3_OPERAND2_RANGE `IE_I_SQ_IF_F3_OPERAND2_UPPER_INDEX:`IE_I_SQ_IF_F3_OPERAND2_LOWER_INDEX

`define IE_I_SQ_IF_F3_IMM_UPPER_INDEX  (0)
`define IE_I_SQ_IF_F3_IMM_LOWER_INDEX (0)
`define IE_I_SQ_IF_F3_IMM_RANGE `IE_I_SQ_IF_F3_IMM_UPPER_INDEX:`IE_I_SQ_IF_F3_IMM_LOWER_INDEX

`define IE_I_SQ_IF_F3_SPARE_UPPER_INDEX  (6)
`define IE_I_SQ_IF_F3_SPARE_LOWER_INDEX (0)
`define IE_I_SQ_IF_F3_SPARE_RANGE `IE_I_SQ_IF_F3_SPARE_UPPER_INDEX:`IE_I_SQ_IF_F3_SPARE_LOWER_INDEX

`define IE_I_SQ_IF_F3_RX_UPPER_INDEX  (4)
`define IE_I_SQ_IF_F3_RX_LOWER_INDEX (0)
`define IE_I_SQ_IF_F3_RX_RANGE `IE_I_SQ_IF_F3_RX_UPPER_INDEX:`IE_I_SQ_IF_F3_RX_LOWER_INDEX

`define IE_I_BCC_UPPER_INDEX (32-1)
`define IE_I_BCC_LOWER_INDEX (0)
`define IE_I_BCC_WIDTH (32)
`define IE_I_BCC_RANGE `IE_I_BCC_UPPER_INDEX:`IE_I_BCC_LOWER_INDEX
`define IE_I_BCC_IF_F_OPCODE_UPPER_INDEX  (5)
`define IE_I_BCC_IF_F_OPCODE_LOWER_INDEX (0)
`define IE_I_BCC_IF_F_OPCODE_RANGE `IE_I_BCC_IF_F_OPCODE_UPPER_INDEX:`IE_I_BCC_IF_F_OPCODE_LOWER_INDEX

`define IE_I_BCC_IF_OPERAND1_UPPER_INDEX  (5)
`define IE_I_BCC_IF_OPERAND1_LOWER_INDEX (0)
`define IE_I_BCC_IF_OPERAND1_RANGE `IE_I_BCC_IF_OPERAND1_UPPER_INDEX:`IE_I_BCC_IF_OPERAND1_LOWER_INDEX

`define IE_I_BCC_IF_F1_OPERAND2_UPPER_INDEX  (0)
`define IE_I_BCC_IF_F1_OPERAND2_LOWER_INDEX (0)
`define IE_I_BCC_IF_F1_OPERAND2_RANGE `IE_I_BCC_IF_F1_OPERAND2_UPPER_INDEX:`IE_I_BCC_IF_F1_OPERAND2_LOWER_INDEX

`define IE_I_BCC_IF_F1_REZ_UPPER_INDEX  (12)
`define IE_I_BCC_IF_F1_REZ_LOWER_INDEX (0)
`define IE_I_BCC_IF_F1_REZ_RANGE `IE_I_BCC_IF_F1_REZ_UPPER_INDEX:`IE_I_BCC_IF_F1_REZ_LOWER_INDEX

`define IE_I_CALLM_UPPER_INDEX (32-1)
`define IE_I_CALLM_LOWER_INDEX (0)
`define IE_I_CALLM_WIDTH (32)
`define IE_I_CALLM_RANGE `IE_I_CALLM_UPPER_INDEX:`IE_I_CALLM_LOWER_INDEX
`define IE_I_CALLM_IF_F_OPCODE_UPPER_INDEX  (5)
`define IE_I_CALLM_IF_F_OPCODE_LOWER_INDEX (0)
`define IE_I_CALLM_IF_F_OPCODE_RANGE `IE_I_CALLM_IF_F_OPCODE_UPPER_INDEX:`IE_I_CALLM_IF_F_OPCODE_LOWER_INDEX

`define IE_I_CALLM_IF_OPERAND1_UPPER_INDEX  (5)
`define IE_I_CALLM_IF_OPERAND1_LOWER_INDEX (0)
`define IE_I_CALLM_IF_OPERAND1_RANGE `IE_I_CALLM_IF_OPERAND1_UPPER_INDEX:`IE_I_CALLM_IF_OPERAND1_LOWER_INDEX

`define IE_I_CALLM_IF_F1_OPERAND2_UPPER_INDEX  (0)
`define IE_I_CALLM_IF_F1_OPERAND2_LOWER_INDEX (0)
`define IE_I_CALLM_IF_F1_OPERAND2_RANGE `IE_I_CALLM_IF_F1_OPERAND2_UPPER_INDEX:`IE_I_CALLM_IF_F1_OPERAND2_LOWER_INDEX

`define IE_I_CALLM_IF_F1_REZ_UPPER_INDEX  (12)
`define IE_I_CALLM_IF_F1_REZ_LOWER_INDEX (0)
`define IE_I_CALLM_IF_F1_REZ_RANGE `IE_I_CALLM_IF_F1_REZ_UPPER_INDEX:`IE_I_CALLM_IF_F1_REZ_LOWER_INDEX

`define IE_I_CALLRY_UPPER_INDEX (32-1)
`define IE_I_CALLRY_LOWER_INDEX (0)
`define IE_I_CALLRY_WIDTH (32)
`define IE_I_CALLRY_RANGE `IE_I_CALLRY_UPPER_INDEX:`IE_I_CALLRY_LOWER_INDEX
`define IE_I_CALLRY_IF_F_OPCODE_UPPER_INDEX  (5)
`define IE_I_CALLRY_IF_F_OPCODE_LOWER_INDEX (0)
`define IE_I_CALLRY_IF_F_OPCODE_RANGE `IE_I_CALLRY_IF_F_OPCODE_UPPER_INDEX:`IE_I_CALLRY_IF_F_OPCODE_LOWER_INDEX

`define IE_I_CALLRY_IF_OPERAND1_UPPER_INDEX  (5)
`define IE_I_CALLRY_IF_OPERAND1_LOWER_INDEX (0)
`define IE_I_CALLRY_IF_OPERAND1_RANGE `IE_I_CALLRY_IF_OPERAND1_UPPER_INDEX:`IE_I_CALLRY_IF_OPERAND1_LOWER_INDEX

`define IE_I_CALLRY_IF_F1_OPERAND2_UPPER_INDEX  (0)
`define IE_I_CALLRY_IF_F1_OPERAND2_LOWER_INDEX (0)
`define IE_I_CALLRY_IF_F1_OPERAND2_RANGE `IE_I_CALLRY_IF_F1_OPERAND2_UPPER_INDEX:`IE_I_CALLRY_IF_F1_OPERAND2_LOWER_INDEX

`define IE_I_CALLRY_IF_F1_REZ_UPPER_INDEX  (12)
`define IE_I_CALLRY_IF_F1_REZ_LOWER_INDEX (0)
`define IE_I_CALLRY_IF_F1_REZ_RANGE `IE_I_CALLRY_IF_F1_REZ_UPPER_INDEX:`IE_I_CALLRY_IF_F1_REZ_LOWER_INDEX

`define IE_I_JMPM_UPPER_INDEX (32-1)
`define IE_I_JMPM_LOWER_INDEX (0)
`define IE_I_JMPM_WIDTH (32)
`define IE_I_JMPM_RANGE `IE_I_JMPM_UPPER_INDEX:`IE_I_JMPM_LOWER_INDEX
`define IE_I_JMPM_IF_F_OPCODE_UPPER_INDEX  (5)
`define IE_I_JMPM_IF_F_OPCODE_LOWER_INDEX (0)
`define IE_I_JMPM_IF_F_OPCODE_RANGE `IE_I_JMPM_IF_F_OPCODE_UPPER_INDEX:`IE_I_JMPM_IF_F_OPCODE_LOWER_INDEX

`define IE_I_JMPM_IF_OPERAND1_UPPER_INDEX  (5)
`define IE_I_JMPM_IF_OPERAND1_LOWER_INDEX (0)
`define IE_I_JMPM_IF_OPERAND1_RANGE `IE_I_JMPM_IF_OPERAND1_UPPER_INDEX:`IE_I_JMPM_IF_OPERAND1_LOWER_INDEX

`define IE_I_JMPM_IF_F1_OPERAND2_UPPER_INDEX  (0)
`define IE_I_JMPM_IF_F1_OPERAND2_LOWER_INDEX (0)
`define IE_I_JMPM_IF_F1_OPERAND2_RANGE `IE_I_JMPM_IF_F1_OPERAND2_UPPER_INDEX:`IE_I_JMPM_IF_F1_OPERAND2_LOWER_INDEX

`define IE_I_JMPM_IF_F1_REZ_UPPER_INDEX  (12)
`define IE_I_JMPM_IF_F1_REZ_LOWER_INDEX (0)
`define IE_I_JMPM_IF_F1_REZ_RANGE `IE_I_JMPM_IF_F1_REZ_UPPER_INDEX:`IE_I_JMPM_IF_F1_REZ_LOWER_INDEX

`define IE_I_JMPRY_UPPER_INDEX (32-1)
`define IE_I_JMPRY_LOWER_INDEX (0)
`define IE_I_JMPRY_WIDTH (32)
`define IE_I_JMPRY_RANGE `IE_I_JMPRY_UPPER_INDEX:`IE_I_JMPRY_LOWER_INDEX
`define IE_I_JMPRY_IF_F_OPCODE_UPPER_INDEX  (5)
`define IE_I_JMPRY_IF_F_OPCODE_LOWER_INDEX (0)
`define IE_I_JMPRY_IF_F_OPCODE_RANGE `IE_I_JMPRY_IF_F_OPCODE_UPPER_INDEX:`IE_I_JMPRY_IF_F_OPCODE_LOWER_INDEX

`define IE_I_JMPRY_IF_OPERAND1_UPPER_INDEX  (5)
`define IE_I_JMPRY_IF_OPERAND1_LOWER_INDEX (0)
`define IE_I_JMPRY_IF_OPERAND1_RANGE `IE_I_JMPRY_IF_OPERAND1_UPPER_INDEX:`IE_I_JMPRY_IF_OPERAND1_LOWER_INDEX

`define IE_I_JMPRY_IF_F1_OPERAND2_UPPER_INDEX  (0)
`define IE_I_JMPRY_IF_F1_OPERAND2_LOWER_INDEX (0)
`define IE_I_JMPRY_IF_F1_OPERAND2_RANGE `IE_I_JMPRY_IF_F1_OPERAND2_UPPER_INDEX:`IE_I_JMPRY_IF_F1_OPERAND2_LOWER_INDEX

`define IE_I_JMPRY_IF_F1_REZ_UPPER_INDEX  (12)
`define IE_I_JMPRY_IF_F1_REZ_LOWER_INDEX (0)
`define IE_I_JMPRY_IF_F1_REZ_RANGE `IE_I_JMPRY_IF_F1_REZ_UPPER_INDEX:`IE_I_JMPRY_IF_F1_REZ_LOWER_INDEX

`define IE_I_HALT_UPPER_INDEX (32-1)
`define IE_I_HALT_LOWER_INDEX (0)
`define IE_I_HALT_WIDTH (32)
`define IE_I_HALT_RANGE `IE_I_HALT_UPPER_INDEX:`IE_I_HALT_LOWER_INDEX
`define IE_I_HALT_IF_F_OPCODE_UPPER_INDEX  (5)
`define IE_I_HALT_IF_F_OPCODE_LOWER_INDEX (0)
`define IE_I_HALT_IF_F_OPCODE_RANGE `IE_I_HALT_IF_F_OPCODE_UPPER_INDEX:`IE_I_HALT_IF_F_OPCODE_LOWER_INDEX

`define IE_I_HALT_IF_OPERAND1_UPPER_INDEX  (5)
`define IE_I_HALT_IF_OPERAND1_LOWER_INDEX (0)
`define IE_I_HALT_IF_OPERAND1_RANGE `IE_I_HALT_IF_OPERAND1_UPPER_INDEX:`IE_I_HALT_IF_OPERAND1_LOWER_INDEX

`define IE_I_HALT_IF_F1_OPERAND2_UPPER_INDEX  (0)
`define IE_I_HALT_IF_F1_OPERAND2_LOWER_INDEX (0)
`define IE_I_HALT_IF_F1_OPERAND2_RANGE `IE_I_HALT_IF_F1_OPERAND2_UPPER_INDEX:`IE_I_HALT_IF_F1_OPERAND2_LOWER_INDEX

`define IE_I_HALT_IF_F1_REZ_UPPER_INDEX  (12)
`define IE_I_HALT_IF_F1_REZ_LOWER_INDEX (0)
`define IE_I_HALT_IF_F1_REZ_RANGE `IE_I_HALT_IF_F1_REZ_UPPER_INDEX:`IE_I_HALT_IF_F1_REZ_LOWER_INDEX

`define IE_I_NOP_UPPER_INDEX (32-1)
`define IE_I_NOP_LOWER_INDEX (0)
`define IE_I_NOP_WIDTH (32)
`define IE_I_NOP_RANGE `IE_I_NOP_UPPER_INDEX:`IE_I_NOP_LOWER_INDEX
`define IE_I_NOP_IF_F_OPCODE_UPPER_INDEX  (5)
`define IE_I_NOP_IF_F_OPCODE_LOWER_INDEX (0)
`define IE_I_NOP_IF_F_OPCODE_RANGE `IE_I_NOP_IF_F_OPCODE_UPPER_INDEX:`IE_I_NOP_IF_F_OPCODE_LOWER_INDEX

`define IE_I_NOP_IF_OPERAND1_UPPER_INDEX  (5)
`define IE_I_NOP_IF_OPERAND1_LOWER_INDEX (0)
`define IE_I_NOP_IF_OPERAND1_RANGE `IE_I_NOP_IF_OPERAND1_UPPER_INDEX:`IE_I_NOP_IF_OPERAND1_LOWER_INDEX

`define IE_I_NOP_IF_F1_OPERAND2_UPPER_INDEX  (0)
`define IE_I_NOP_IF_F1_OPERAND2_LOWER_INDEX (0)
`define IE_I_NOP_IF_F1_OPERAND2_RANGE `IE_I_NOP_IF_F1_OPERAND2_UPPER_INDEX:`IE_I_NOP_IF_F1_OPERAND2_LOWER_INDEX

`define IE_I_NOP_IF_F1_REZ_UPPER_INDEX  (12)
`define IE_I_NOP_IF_F1_REZ_LOWER_INDEX (0)
`define IE_I_NOP_IF_F1_REZ_RANGE `IE_I_NOP_IF_F1_REZ_UPPER_INDEX:`IE_I_NOP_IF_F1_REZ_LOWER_INDEX

`define IE_I_RETI_UPPER_INDEX (32-1)
`define IE_I_RETI_LOWER_INDEX (0)
`define IE_I_RETI_WIDTH (32)
`define IE_I_RETI_RANGE `IE_I_RETI_UPPER_INDEX:`IE_I_RETI_LOWER_INDEX
`define IE_I_RETI_IF_F_OPCODE_UPPER_INDEX  (5)
`define IE_I_RETI_IF_F_OPCODE_LOWER_INDEX (0)
`define IE_I_RETI_IF_F_OPCODE_RANGE `IE_I_RETI_IF_F_OPCODE_UPPER_INDEX:`IE_I_RETI_IF_F_OPCODE_LOWER_INDEX

`define IE_I_RETI_IF_OPERAND1_UPPER_INDEX  (5)
`define IE_I_RETI_IF_OPERAND1_LOWER_INDEX (0)
`define IE_I_RETI_IF_OPERAND1_RANGE `IE_I_RETI_IF_OPERAND1_UPPER_INDEX:`IE_I_RETI_IF_OPERAND1_LOWER_INDEX

`define IE_I_RETI_IF_F1_OPERAND2_UPPER_INDEX  (0)
`define IE_I_RETI_IF_F1_OPERAND2_LOWER_INDEX (0)
`define IE_I_RETI_IF_F1_OPERAND2_RANGE `IE_I_RETI_IF_F1_OPERAND2_UPPER_INDEX:`IE_I_RETI_IF_F1_OPERAND2_LOWER_INDEX

`define IE_I_RETI_IF_F1_REZ_UPPER_INDEX  (12)
`define IE_I_RETI_IF_F1_REZ_LOWER_INDEX (0)
`define IE_I_RETI_IF_F1_REZ_RANGE `IE_I_RETI_IF_F1_REZ_UPPER_INDEX:`IE_I_RETI_IF_F1_REZ_LOWER_INDEX

`define IE_I_TRAP_UPPER_INDEX (32-1)
`define IE_I_TRAP_LOWER_INDEX (0)
`define IE_I_TRAP_WIDTH (32)
`define IE_I_TRAP_RANGE `IE_I_TRAP_UPPER_INDEX:`IE_I_TRAP_LOWER_INDEX
`define IE_I_TRAP_IF_F_OPCODE_UPPER_INDEX  (5)
`define IE_I_TRAP_IF_F_OPCODE_LOWER_INDEX (0)
`define IE_I_TRAP_IF_F_OPCODE_RANGE `IE_I_TRAP_IF_F_OPCODE_UPPER_INDEX:`IE_I_TRAP_IF_F_OPCODE_LOWER_INDEX

`define IE_I_TRAP_IF_OPERAND1_UPPER_INDEX  (5)
`define IE_I_TRAP_IF_OPERAND1_LOWER_INDEX (0)
`define IE_I_TRAP_IF_OPERAND1_RANGE `IE_I_TRAP_IF_OPERAND1_UPPER_INDEX:`IE_I_TRAP_IF_OPERAND1_LOWER_INDEX

`define IE_I_TRAP_IF_F3_OPERAND2_UPPER_INDEX  (5)
`define IE_I_TRAP_IF_F3_OPERAND2_LOWER_INDEX (0)
`define IE_I_TRAP_IF_F3_OPERAND2_RANGE `IE_I_TRAP_IF_F3_OPERAND2_UPPER_INDEX:`IE_I_TRAP_IF_F3_OPERAND2_LOWER_INDEX

`define IE_I_TRAP_IF_F3_IMM_UPPER_INDEX  (0)
`define IE_I_TRAP_IF_F3_IMM_LOWER_INDEX (0)
`define IE_I_TRAP_IF_F3_IMM_RANGE `IE_I_TRAP_IF_F3_IMM_UPPER_INDEX:`IE_I_TRAP_IF_F3_IMM_LOWER_INDEX

`define IE_I_TRAP_IF_F3_SPARE_UPPER_INDEX  (6)
`define IE_I_TRAP_IF_F3_SPARE_LOWER_INDEX (0)
`define IE_I_TRAP_IF_F3_SPARE_RANGE `IE_I_TRAP_IF_F3_SPARE_UPPER_INDEX:`IE_I_TRAP_IF_F3_SPARE_LOWER_INDEX

`define IE_I_TRAP_IF_F3_RX_UPPER_INDEX  (4)
`define IE_I_TRAP_IF_F3_RX_LOWER_INDEX (0)
`define IE_I_TRAP_IF_F3_RX_RANGE `IE_I_TRAP_IF_F3_RX_UPPER_INDEX:`IE_I_TRAP_IF_F3_RX_LOWER_INDEX


`endif