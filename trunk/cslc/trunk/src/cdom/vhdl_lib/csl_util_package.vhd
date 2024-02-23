library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

package csl_util_package is

  -----------------------------------------------------------------------------
  -- types
  -----------------------------------------------------------------------------
  constant csl_size_of_integer  : natural := 32;
  constant csl_size_of_unsigned : natural := 64;

  subtype csl_bit        is std_logic;
  subtype csl_bit_vector is std_logic_vector;
  subtype csl_integer    is integer;
  subtype csl_unsigned   is ieee.numeric_std.unsigned(csl_size_of_unsigned - 1 downto 0);
  subtype csl_real       is real;
  subtype csl_string     is string;

  type csl_matrix_2D     is array (natural range <>, natural range<>) of csl_bit;
  type csl_matrix_3D     is array (natural range <>, natural range<>, natural range<>) of csl_bit;
  type csl_matrix_4D     is array (natural range <>, natural range<>, natural range<>, natural range<>) of csl_bit;
  type csl_matrix_5D     is array (natural range <>, natural range<>, natural range<>, natural range<>, natural range<>) of csl_bit;
  type csl_matrix_6D     is array (natural range <>, natural range<>, natural range<>, natural range<>, natural range<>, natural range<>) of csl_bit;

  -----------------------------------------------------------------------------
  -- cast functions
  -----------------------------------------------------------------------------
  function cast_boolean_to_bit         (expr : boolean)                     return csl_bit;
  function cast_boolean_to_integer     (expr : boolean)                     return csl_integer;
  function cast_boolean_to_unsigned    (expr : boolean)                     return csl_unsigned;
  function cast_boolean_to_real        (expr : boolean)                     return csl_real;
  function cast_boolean_to_bit_vector  (size: natural; expr : boolean)      return csl_bit_vector;
  function cast_bit_to_boolean         (expr : csl_bit)                     return boolean;
  function cast_bit_to_integer         (expr : csl_bit)                     return csl_integer;
  function cast_bit_to_unsigned        (expr : csl_bit)                     return csl_unsigned;
  function cast_bit_to_real            (expr : csl_bit)                     return csl_real;
  function cast_bit_to_bit_vector      (size: natural; expr : csl_bit)      return csl_bit_vector;
  function cast_bit_vector_to_boolean  (expr : csl_bit_vector)              return boolean;
  function cast_bit_vector_to_bit      (expr : csl_bit_vector)              return csl_bit;
  function cast_bit_vector_to_integer  (expr : csl_bit_vector)              return csl_integer;
  function cast_bit_vector_to_unsigned (expr : csl_bit_vector)              return csl_unsigned;
  function cast_bit_vector_to_real     (expr : csl_bit_vector)              return csl_real;
  function cast_integer_to_boolean     (expr : csl_integer)                 return boolean;
  function cast_integer_to_bit         (expr : csl_integer)                 return csl_bit;
  function cast_integer_to_unsigned    (expr : csl_integer)                 return csl_unsigned;
  function cast_integer_to_real        (expr : csl_integer)                 return csl_real;
  function cast_integer_to_bit_vector  (size: natural; expr : csl_integer)  return csl_bit_vector;
  function cast_unsigned_to_boolean    (expr : csl_unsigned)                return boolean;
  function cast_unsigned_to_bit        (expr : csl_unsigned)                return csl_bit;
  function cast_unsigned_to_integer    (expr : csl_unsigned)                return csl_integer;
  function cast_unsigned_to_real       (expr : csl_unsigned)                return csl_real;
  function cast_unsigned_to_bit_vector (size: natural; expr : csl_unsigned) return csl_bit_vector;
  function cast_real_to_boolean        (expr : csl_real)                    return boolean;
  function cast_real_to_bit            (expr : csl_real)                    return csl_bit;
  function cast_real_to_integer        (expr : csl_real)                    return csl_integer;
  function cast_real_to_unsigned       (expr : csl_real)                    return csl_unsigned;
  function cast_real_to_bit_vector     (size: natural; expr : csl_real)     return csl_bit_vector;

  -----------------------------------------------------------------------------
  -- unary reduction 'and'
  -----------------------------------------------------------------------------
  function unary_reduction_and (expr : csl_bit)                        return csl_bit;
  function unary_reduction_and (expr : csl_bit_vector)                 return csl_bit;
  function unary_reduction_and (expr : csl_integer)                    return csl_bit;
  function unary_reduction_and (expr : csl_unsigned)                   return csl_bit;
  function unary_reduction_and (expr : csl_real)                       return csl_bit;

  -----------------------------------------------------------------------------
  -- unary reduction 'nand'
  -----------------------------------------------------------------------------
  function unary_reduction_nand (expr : csl_bit)                        return csl_bit;
  function unary_reduction_nand (expr : csl_bit_vector)                 return csl_bit;
  function unary_reduction_nand (expr : csl_integer)                    return csl_bit;
  function unary_reduction_nand (expr : csl_unsigned)                   return csl_bit;
  function unary_reduction_nand (expr : csl_real)                       return csl_bit;

  -----------------------------------------------------------------------------
  -- unary reduction 'or'
  -----------------------------------------------------------------------------
  function unary_reduction_or (expr : csl_bit)                        return csl_bit;
  function unary_reduction_or (expr : csl_bit_vector)                 return csl_bit;
  function unary_reduction_or (expr : csl_integer)                    return csl_bit;
  function unary_reduction_or (expr : csl_unsigned)                   return csl_bit;
  function unary_reduction_or (expr : csl_real)                       return csl_bit;

  -----------------------------------------------------------------------------
  -- unary reduction 'nor'
  -----------------------------------------------------------------------------
  function unary_reduction_nor (expr : csl_bit)                        return csl_bit;
  function unary_reduction_nor (expr : csl_bit_vector)                 return csl_bit;
  function unary_reduction_nor (expr : csl_integer)                    return csl_bit;
  function unary_reduction_nor (expr : csl_unsigned)                   return csl_bit;
  function unary_reduction_nor (expr : csl_real)                       return csl_bit;

  -----------------------------------------------------------------------------
  -- unary reduction 'xor'
  -----------------------------------------------------------------------------
  function unary_reduction_xor (expr : csl_bit)                        return csl_bit;
  function unary_reduction_xor (expr : csl_bit_vector)                 return csl_bit;
  function unary_reduction_xor (expr : csl_integer)                    return csl_bit;
  function unary_reduction_xor (expr : csl_unsigned)                   return csl_bit;
  function unary_reduction_xor (expr : csl_real)                       return csl_bit;

  -----------------------------------------------------------------------------
  -- unary reduction 'xnor'
  -----------------------------------------------------------------------------
  function unary_reduction_xnor (expr : csl_bit)                        return csl_bit;
  function unary_reduction_xnor (expr : csl_bit_vector)                 return csl_bit;
  function unary_reduction_xnor (expr : csl_integer)                    return csl_bit;
  function unary_reduction_xnor (expr : csl_unsigned)                   return csl_bit;
  function unary_reduction_xnor (expr : csl_real)                       return csl_bit;

  -----------------------------------------------------------------------------
  -- logical 'not'
  -----------------------------------------------------------------------------
  function logical_not (expr : boolean)        return boolean;
  function logical_not (expr : csl_bit)        return boolean;
  function logical_not (expr : csl_bit_vector) return boolean;
  function logical_not (expr : csl_integer)    return boolean;
  function logical_not (expr : csl_unsigned)   return boolean;
  function logical_not (expr : csl_real)       return boolean;

  -----------------------------------------------------------------------------
  -- logical 'and'
  -----------------------------------------------------------------------------
  function logical_and (first_expr : boolean;        second_expr : boolean)        return boolean;
  function logical_and (first_expr : csl_bit;        second_expr : csl_bit)        return boolean;
  function logical_and (first_expr : csl_bit_vector; second_expr : csl_bit_vector) return boolean;
  function logical_and (first_expr : csl_integer;    second_expr : csl_integer)    return boolean;
  function logical_and (first_expr : csl_unsigned;   second_expr : csl_unsigned)   return boolean;
  function logical_and (first_expr : csl_real;       second_expr : csl_real)       return boolean;

  -----------------------------------------------------------------------------
  -- logical 'or'
  -----------------------------------------------------------------------------
  function logical_or (first_expr : boolean;        second_expr : boolean)        return boolean;
  function logical_or (first_expr : csl_bit;        second_expr : csl_bit)        return boolean;
  function logical_or (first_expr : csl_bit_vector; second_expr : csl_bit_vector) return boolean;
  function logical_or (first_expr : csl_integer;    second_expr : csl_integer)    return boolean;
  function logical_or (first_expr : csl_unsigned;   second_expr : csl_unsigned)   return boolean;
  function logical_or (first_expr : csl_real;       second_expr : csl_real)       return boolean;

  -----------------------------------------------------------------------------
  -- logical left shift 'sll'
  -----------------------------------------------------------------------------
  function "sll" (first_expr : csl_integer; second_expr : csl_integer) return csl_integer;

  -----------------------------------------------------------------------------
  -- logical left shift 'sll'
  -----------------------------------------------------------------------------
  function "srl" (first_expr : csl_integer; second_expr : csl_integer) return csl_integer;

  -----------------------------------------------------------------------------
  -- ternary condition operator '<cond> ? <exp_then> : <exp_else>'
  -----------------------------------------------------------------------------
  function ternary_condition_operator (cond : boolean; expr_then : csl_bit;        expr_else : csl_bit)        return csl_bit;
  function ternary_condition_operator (cond : boolean; expr_then : csl_bit_vector; expr_else : csl_bit_vector) return csl_bit_vector;
  function ternary_condition_operator (cond : boolean; expr_then : csl_integer;    expr_else : csl_integer)    return csl_integer;
  function ternary_condition_operator (cond : boolean; expr_then : csl_unsigned;   expr_else : csl_unsigned)   return csl_unsigned;
  function ternary_condition_operator (cond : boolean; expr_then : csl_real;       expr_else : csl_real)       return csl_real;

  -----------------------------------------------------------------------------
  -- replication operator '&'
  -----------------------------------------------------------------------------
  function "&" (first_expr  : csl_integer; second_expr : csl_integer) return csl_bit_vector;

  -----------------------------------------------------------------------------
  -- replication operator '{<num>{<expr>}}'
  -----------------------------------------------------------------------------
  function replication_operator (num : natural; expr : csl_integer)    return csl_bit_vector;
  function replication_operator (num : natural; expr : csl_bit)        return csl_bit_vector;
  function replication_operator (num : natural; expr : csl_bit_vector) return csl_bit_vector;

  -----------------------------------------------------------------------------
  -- log2
  -----------------------------------------------------------------------------
  function log2 (num : csl_integer) return csl_integer;

end package csl_util_package;

package body csl_util_package is

  -----------------------------------------------------------------------------
  -- cast functions
  -----------------------------------------------------------------------------
  -- boolean
  function cast_boolean_to_bit (expr : boolean) return csl_bit is
  begin
    if expr then
      return '1';
    else
      return '0';
    end if;
  end function cast_boolean_to_bit;

  function cast_boolean_to_integer (expr : boolean) return csl_integer is
  begin
    if expr then
      return 1;
    else
      return 0;
    end if;
  end function cast_boolean_to_integer;

  function cast_boolean_to_unsigned (expr : boolean) return csl_unsigned is
  begin
    if expr then
      return X"0000_0000_0000_0001";
    else
      return X"0000_0000_0000_0000";
    end if;
  end function cast_boolean_to_unsigned;

  function cast_boolean_to_real (expr : boolean) return csl_real is
  begin
    if expr then
      return 1.0;
    else
      return 0.0;
    end if;
  end function cast_boolean_to_real;

  function cast_boolean_to_bit_vector (size: natural; expr : boolean) return csl_bit_vector is
  begin
    if expr then
      return conv_std_logic_vector(1, size);
    else
      return conv_std_logic_vector(0, size);
    end if;
  end function cast_boolean_to_bit_vector;

  -- csl_bit
  function cast_bit_to_boolean (expr : csl_bit) return boolean is
  begin
    if (expr = '1') then
      return true;
    else
      return false;
    end if;
  end function cast_bit_to_boolean;

  function cast_bit_to_integer (expr : csl_bit) return csl_integer is
  begin
    if (expr = '1') then
      return 1;
    else
      return 0;
    end if;
  end function cast_bit_to_integer;

  function cast_bit_to_unsigned (expr : csl_bit) return csl_unsigned is
  begin
    if (expr = '1') then
      return X"0000_0000_0000_0001";
    else
      return X"0000_0000_0000_0000";
    end if;
  end function cast_bit_to_unsigned;

  function cast_bit_to_real (expr : csl_bit) return csl_real is
  begin
    if (expr = '1') then
      return 1.0;
    else
      return 0.0;
    end if;
  end function cast_bit_to_real;

  function cast_bit_to_bit_vector (size: natural; expr : csl_bit) return csl_bit_vector is
  begin
    if (expr = '1') then
      return conv_std_logic_vector(1, size);
    else
      return conv_std_logic_vector(0, size);
    end if;
  end function cast_bit_to_bit_vector;

  -- csl_bit_vector
  function cast_bit_vector_to_boolean (expr : csl_bit_vector) return boolean is
  begin
    if (unary_reduction_and(expr) = '1') then
      return true;
    else
      return false;
    end if;
  end function cast_bit_vector_to_boolean;

  function cast_bit_vector_to_bit (expr : csl_bit_vector) return csl_bit is
  begin
    if (unary_reduction_and(expr) = '1') then
      return '1';
    else
      return '0';
    end if;
  end function cast_bit_vector_to_bit;

  function cast_bit_vector_to_integer (expr : csl_bit_vector) return csl_integer is
  begin
    return conv_integer(expr);
  end function cast_bit_vector_to_integer;

  function cast_bit_vector_to_unsigned (expr : csl_bit_vector) return csl_unsigned is
  begin
  end function cast_bit_vector_to_unsigned;

  function cast_bit_vector_to_real (expr : csl_bit_vector) return csl_real is
  begin
    -- TODO
  end function cast_bit_vector_to_real;

  -- csl_integer
  function cast_integer_to_boolean (expr : csl_integer) return boolean is
  begin
    if (expr /= 0) then
      return true;
    else
      return false;
    end if;
  end function cast_integer_to_boolean;

  function cast_integer_to_bit (expr : csl_integer) return csl_bit is
  begin
    if (expr /= 0) then
      return '1';
    else
      return '0';
    end if;
  end function cast_integer_to_bit;

  function cast_integer_to_unsigned (expr : csl_integer) return csl_unsigned is
    variable result : csl_unsigned := (others => '0');
    variable temp_expr : csl_bit_vector(csl_size_of_integer - 1 downto 0) := conv_std_logic_vector(expr, csl_size_of_integer);
  begin
    for index in temp_expr'reverse_range loop
      result(index) := temp_expr(index);
    end loop;
  end function cast_integer_to_unsigned;

  function cast_integer_to_real (expr : csl_integer) return csl_real is
  begin
    -- TODO
  end function cast_integer_to_real;

  function cast_integer_to_bit_vector (size: natural; expr : csl_integer) return csl_bit_vector is
  begin
    return conv_std_logic_vector(expr, size);
  end function cast_integer_to_bit_vector;

  -- csl_unsigned
  function cast_unsigned_to_boolean (expr : csl_unsigned) return boolean is
  begin
    if (expr /= X"0000_0000_0000_0000") then
      return true;
    else
      return false;
    end if;
  end function cast_unsigned_to_boolean;

  function cast_unsigned_to_bit (expr : csl_unsigned) return csl_bit is
  begin
    if (expr /= X"0000_0000_0000_0000") then
      return '1';
    else
      return '0';
    end if;
  end function cast_unsigned_to_bit;

  function cast_unsigned_to_integer (expr : csl_unsigned) return csl_integer is
    variable temp_expr : csl_bit_vector(csl_size_of_unsigned - 1 downto 0) := (others => '0');
  begin
    for index in expr'reverse_range loop
      temp_expr(index) := expr(index);
    end loop;
    return conv_integer(temp_expr);
  end function cast_unsigned_to_integer;

  function cast_unsigned_to_real (expr : csl_unsigned) return csl_real is
  begin
    -- TODO
  end function cast_unsigned_to_real;

  function cast_unsigned_to_bit_vector (size: natural; expr : csl_unsigned) return csl_bit_vector is
    variable result : csl_bit_vector(size - 1 downto 0) := (others => '0');
  begin
    for index in expr'reverse_range loop
      result(index) := expr(index);
    end loop;
    return result;
  end function cast_unsigned_to_bit_vector;

  -- csl_real
  function cast_real_to_boolean (expr : csl_real) return boolean is
  begin
    if (expr /= 0.0) then
      return true;
    else
      return false;
    end if;
  end function cast_real_to_boolean;

  function cast_real_to_bit (expr : csl_real) return csl_bit is
  begin
    if (expr /= 0.0) then
      return '1';
    else
      return '0';
    end if;
  end function cast_real_to_bit;

  function cast_real_to_integer (expr : csl_real) return csl_integer is
  begin
    -- TODO
  end function cast_real_to_integer;

  function cast_real_to_unsigned (expr : csl_real) return csl_unsigned is
  begin
    -- TODO
  end function cast_real_to_unsigned;

  function cast_real_to_bit_vector (size: natural; expr : csl_real) return csl_bit_vector is
  begin
    -- TODO
  end function cast_real_to_bit_vector;


  -----------------------------------------------------------------------------
  -- unary reduction 'and'
  -----------------------------------------------------------------------------
  -- csl_bit
  function unary_reduction_and (expr : csl_bit) return csl_bit is
  begin
    return expr;
  end function unary_reduction_and;

  -- csl_bit_vector
  function unary_reduction_and (expr : csl_bit_vector) return csl_bit is
    variable result : csl_bit;
  begin
    result := expr(0);
    for index in expr'range loop
      result := expr(index) and result;
    end loop;  -- index
    return result;
  end function unary_reduction_and;

  -- csl_integer
  function unary_reduction_and (expr : csl_integer) return csl_bit is
    variable result : csl_bit;
    variable expr_vec : csl_bit_vector(csl_size_of_integer - 1 downto 0);
  begin
    expr_vec := conv_std_logic_vector(expr, csl_size_of_integer);
    result := expr_vec(0);
    for index in expr_vec'range loop
      result := expr_vec(index) and result;
    end loop;  -- index
    return result;
  end function unary_reduction_and;

  -- csl_unsigned
  function unary_reduction_and (expr : csl_unsigned) return csl_bit is
    variable result : csl_bit;
  begin
    result := expr(0);
    for index in expr'range loop
      result := expr(index) and result;
    end loop;  -- index
    return result;
  end function unary_reduction_and;

  -- csl_real
  function unary_reduction_and (expr : csl_real) return csl_bit is
  begin
    return '0';
  end function unary_reduction_and;


  -----------------------------------------------------------------------------
  -- unary reduction 'nand'
  -----------------------------------------------------------------------------
  -- csl_bit
  function unary_reduction_nand (expr : csl_bit) return csl_bit is
  begin
    return expr;
  end function unary_reduction_nand;

  -- csl_bit_vector
  function unary_reduction_nand (expr : csl_bit_vector) return csl_bit is
    variable result : csl_bit;
  begin
    result := expr(0);
    for index in expr'range loop
      result := expr(index) nand result;
    end loop;  -- index
    return result;
  end function unary_reduction_nand;

  -- csl_integer
  function unary_reduction_nand (expr : csl_integer) return csl_bit is
    variable result : csl_bit;
    variable expr_vec : csl_bit_vector(csl_size_of_integer - 1 downto 0);
  begin
    expr_vec := conv_std_logic_vector(expr, csl_size_of_integer);
    result := expr_vec(0);
    for index in expr_vec'range loop
      result := expr_vec(index) nand result;
    end loop;  -- index
    return result;
  end function unary_reduction_nand;

  -- csl_unsigned
  function unary_reduction_nand (expr : csl_unsigned) return csl_bit is
    variable result : csl_bit;
  begin
    result := expr(0);
    for index in expr'range loop
      result := expr(index) nand result;
    end loop;  -- index
    return result;
  end function unary_reduction_nand;

  -- csl_real
  function unary_reduction_nand (expr : csl_real) return csl_bit is
  begin
    return '0';
  end function unary_reduction_nand;


  -----------------------------------------------------------------------------
  -- unary reduction 'or'
  -----------------------------------------------------------------------------
  -- csl_bit
  function unary_reduction_or (expr : csl_bit) return csl_bit is
  begin
    return expr;
  end function unary_reduction_or;

  -- csl_bit_vector
  function unary_reduction_or (expr : csl_bit_vector) return csl_bit is
    variable result : csl_bit;
  begin
    result := expr(0);
    for index in expr'range loop
      result := expr(index) or result;
    end loop;  -- index
    return result;
  end function unary_reduction_or;

  -- csl_integer
  function unary_reduction_or (expr : csl_integer) return csl_bit is
    variable result : csl_bit;
    variable expr_vec : csl_bit_vector(csl_size_of_integer - 1 downto 0);
  begin
    expr_vec := conv_std_logic_vector(expr, csl_size_of_integer);
    result := expr_vec(0);
    for index in expr_vec'range loop
      result := expr_vec(index) or result;
    end loop;  -- index
    return result;
  end function unary_reduction_or;

  -- csl_unsigned
  function unary_reduction_or (expr : csl_unsigned) return csl_bit is
    variable result : csl_bit;
  begin
    result := expr(0);
    for index in expr'range loop
      result := expr(index) or result;
    end loop;  -- index
    return result;
  end function unary_reduction_or;

  -- csl_real
  function unary_reduction_or (expr : csl_real) return csl_bit is
  begin
    return '0';
  end function unary_reduction_or;


  -----------------------------------------------------------------------------
  -- unary reduction 'nor'
  -----------------------------------------------------------------------------
  -- csl_bit
  function unary_reduction_nor (expr : csl_bit) return csl_bit is
  begin
    return expr;
  end function unary_reduction_nor;

  -- csl_bit_vector
  function unary_reduction_nor (expr : csl_bit_vector) return csl_bit  is
    variable result : csl_bit;
  begin
    result := expr(0);
    for index in expr'range loop
      result := expr(index) nor result;
    end loop;  -- index
    return result;
  end function unary_reduction_nor;

  -- csl_integer
  function unary_reduction_nor (expr : csl_integer) return csl_bit is
    variable result : csl_bit;
    variable expr_vec : csl_bit_vector(csl_size_of_integer - 1 downto 0);
  begin
    expr_vec := conv_std_logic_vector(expr, csl_size_of_integer);
    result := expr_vec(0);
    for index in expr_vec'range loop
      result := expr_vec(index) nor result;
    end loop;  -- index
    return result;
  end function unary_reduction_nor;

  -- csl_unsigned
  function unary_reduction_nor (expr : csl_unsigned) return csl_bit is
    variable result : csl_bit;
  begin
    result := expr(0);
    for index in expr'range loop
      result := expr(index) nor result;
    end loop;  -- index
    return result;
  end function unary_reduction_nor;

  -- csl_real
  function unary_reduction_nor (expr : csl_real) return csl_bit is
  begin
    return '0';
  end function unary_reduction_nor;


  -----------------------------------------------------------------------------
  -- unary reduction 'xor'
  -----------------------------------------------------------------------------
  -- csl_bit
  function unary_reduction_xor (expr : csl_bit) return csl_bit is
  begin
    return expr;
  end function unary_reduction_xor;

  -- csl_bit_vector
  function unary_reduction_xor (expr : csl_bit_vector) return csl_bit is
    variable result : csl_bit;
  begin
    result := expr(0);
    for index in expr'range loop
      result := expr(index) xor result;
    end loop;  -- index
    return result;
  end function unary_reduction_xor;

  -- csl_integer
  function unary_reduction_xor (expr : csl_integer) return csl_bit is
    variable result : csl_bit;
    variable expr_vec : csl_bit_vector(csl_size_of_integer - 1 downto 0);
  begin
    expr_vec := conv_std_logic_vector(expr, csl_size_of_integer);
    result := expr_vec(0);
    for index in expr_vec'range loop
      result := expr_vec(index) xor result;
    end loop;  -- index
    return result;
  end function unary_reduction_xor;

  -- csl_unsigned
  function unary_reduction_xor (expr : csl_unsigned) return csl_bit is
    variable result : csl_bit;
  begin
    result := expr(0);
    for index in expr'range loop
      result := expr(index) xor result;
    end loop;  -- index
    return result;
  end function unary_reduction_xor;

  -- csl_real
  function unary_reduction_xor (expr : csl_real) return csl_bit is
  begin
    return '0';
  end function unary_reduction_xor;


  -----------------------------------------------------------------------------
  -- unary reduction 'xnor'
  -----------------------------------------------------------------------------
  -- csl_bit
  function unary_reduction_xnor (expr : csl_bit) return csl_bit is
  begin
    return expr;
  end function unary_reduction_xnor;

  -- csl_bit_vector
  function unary_reduction_xnor (expr : csl_bit_vector) return csl_bit is
    variable result : csl_bit;
  begin
    result := expr(0);
    for index in expr'range loop
      result := expr(index) xnor result;
    end loop;  -- index
    return result;
  end function unary_reduction_xnor;

  -- csl_integer
  function unary_reduction_xnor (expr : csl_integer) return csl_bit is
    variable result : csl_bit;
    variable expr_vec : csl_bit_vector(csl_size_of_integer - 1 downto 0);
  begin
    expr_vec := conv_std_logic_vector(expr, csl_size_of_integer);
    result := expr_vec(0);
    for index in expr_vec'range loop
      result := expr_vec(index) xnor result;
    end loop;  -- index
    return result;
  end function unary_reduction_xnor;

  -- csl_unsigned
  function unary_reduction_xnor (expr : csl_unsigned) return csl_bit is
    variable result : csl_bit;
  begin
    result := expr(0);
    for index in expr'range loop
      result := expr(index) xnor result;
    end loop;  -- index
    return result;
  end function unary_reduction_xnor;

  -- csl_real
  function unary_reduction_xnor (expr : csl_real) return csl_bit is
  begin
    return '0';
  end function unary_reduction_xnor;


  -----------------------------------------------------------------------------
  -- logical 'not'
  -----------------------------------------------------------------------------
  -- boolean
  function logical_not (expr : boolean) return boolean is
  begin
    return not expr;
  end function logical_not;

  -- csl_bit
  function logical_not (expr : csl_bit) return boolean is
  begin
    return not (expr /= '0');
  end function logical_not;

  -- csl_bit_vector
  function logical_not (expr : csl_bit_vector) return boolean is
    variable temp_expr : csl_bit_vector(expr'right - 1 downto 0) := (others => '0');
  begin
    return not (expr /= temp_expr);
  end function logical_not;

  -- csl_integer
  function logical_not (expr : csl_integer) return boolean is
  begin
    return not (expr /= 0);
  end function logical_not;

  -- csl_unsigned
  function logical_not (expr : csl_unsigned) return boolean is
  begin
    return not (expr /= X"0000_0000_0000_0000");
  end function logical_not;

  -- csl_real
  function logical_not (expr : csl_real) return boolean is
  begin
    return not (expr /= 0.0);
  end function logical_not;


  -----------------------------------------------------------------------------
  -- logical 'and'
  -----------------------------------------------------------------------------
  -- boolean
  function logical_and (first_expr : boolean; second_expr : boolean) return boolean is
  begin
    return (first_expr and second_expr);
  end function logical_and;

  -- csl_bit
  function logical_and (first_expr : csl_bit; second_expr : csl_bit) return boolean is
  begin
    return ((unary_reduction_and(first_expr) and unary_reduction_and(second_expr)) = '1');
  end function logical_and;

  -- csl_bit_vector
  function logical_and (first_expr : csl_bit_vector; second_expr : csl_bit_vector) return boolean is
  begin
    return ((unary_reduction_and(first_expr) and unary_reduction_and(second_expr)) = '1');
  end function logical_and;

  -- csl_integer
  function logical_and (first_expr : csl_integer; second_expr : csl_integer) return boolean is
  begin
    return ((unary_reduction_and(first_expr) and unary_reduction_and(second_expr)) = '1');
  end function logical_and;

  -- csl_unsigned
  function logical_and (first_expr : csl_unsigned; second_expr : csl_unsigned) return boolean is
  begin
    return ((unary_reduction_and(first_expr) and unary_reduction_and(second_expr)) = '1');
  end function logical_and;

  -- csl_real
  function logical_and (first_expr : csl_real; second_expr : csl_real) return boolean is
  begin
    return ((unary_reduction_and(first_expr) and unary_reduction_and(second_expr)) = '1');
  end function logical_and;


  -----------------------------------------------------------------------------
  -- logical 'or'
  -----------------------------------------------------------------------------
  -- boolean
  function logical_or (first_expr : boolean; second_expr : boolean) return boolean is
  begin
    return (first_expr or second_expr);
  end function logical_or;

  -- csl_bit
  function logical_or (first_expr : csl_bit; second_expr : csl_bit) return boolean is
  begin
    return ((unary_reduction_or(first_expr) or unary_reduction_or(second_expr)) = '1');
  end function logical_or;

  -- csl_bit_vector
  function logical_or (first_expr : csl_bit_vector; second_expr : csl_bit_vector) return boolean is
  begin
    return ((unary_reduction_or(first_expr) or unary_reduction_or(second_expr)) = '1');
  end function logical_or;

  -- csl_integer
  function logical_or (first_expr : csl_integer; second_expr : csl_integer) return boolean is
  begin
    return ((unary_reduction_or(first_expr) or unary_reduction_or(second_expr)) = '1');
  end function logical_or;

  -- csl_unsigned
  function logical_or (first_expr : csl_unsigned; second_expr : csl_unsigned) return boolean is
  begin
    return ((unary_reduction_or(first_expr) or unary_reduction_or(second_expr)) = '1');
  end function logical_or;

  -- csl_real
  function logical_or (first_expr : csl_real; second_expr : csl_real) return boolean is
  begin
    return ((unary_reduction_or(first_expr) or unary_reduction_or(second_expr)) = '1');
  end function logical_or;


  -----------------------------------------------------------------------------
  -- logical left shift 'sll'
  -----------------------------------------------------------------------------
  function "sll" (first_expr : csl_integer; second_expr : csl_integer) return csl_integer is
    variable temp_expr : csl_bit_vector(csl_size_of_integer - 1 downto 0) := cast_integer_to_bit_vector(csl_size_of_integer, first_expr);
    variable result: csl_bit_vector(csl_size_of_integer - 1 downto 0) := (others => '0');
  begin
    if ((0 <= second_expr) and (second_expr < csl_size_of_integer)) then
      result(csl_size_of_integer downto second_expr) := temp_expr(csl_size_of_integer - second_expr downto 0);
    end if;
    return cast_bit_vector_to_integer(result);
  end function "sll";


  -----------------------------------------------------------------------------
  -- logical left shift 'srl'
  -----------------------------------------------------------------------------
  function "srl" (first_expr : csl_integer; second_expr : csl_integer) return csl_integer is
    variable temp_expr : csl_bit_vector(csl_size_of_integer - 1 downto 0) := cast_integer_to_bit_vector(csl_size_of_integer, first_expr);
    variable result: csl_bit_vector(csl_size_of_integer - 1 downto 0) := (others => '0');
  begin
    if ((0 <= second_expr) and (second_expr < csl_size_of_integer)) then
      result(csl_size_of_integer - second_expr downto 0) := temp_expr(csl_size_of_integer downto second_expr);
    end if;
    return cast_bit_vector_to_integer(result);
  end function "srl";


  -----------------------------------------------------------------------------
  -- ternary condition operator '<cond> ? <exp_then> : <exp_else>'
  -----------------------------------------------------------------------------
  -- csl_bit
  function ternary_condition_operator (cond : boolean; expr_then : csl_bit; expr_else : csl_bit) return csl_bit is
  begin
    if (cond) then
      return expr_then;
    else
      return expr_else;
    end if;
  end function ternary_condition_operator;

  -- csl_bit_vector
  function ternary_condition_operator (cond : boolean; expr_then : csl_bit_vector; expr_else : csl_bit_vector) return csl_bit_vector is
  begin
    if (cond) then
      return expr_then;
    else
      return expr_else;
    end if;
  end function ternary_condition_operator;

  -- csl_integer
  function ternary_condition_operator (cond : boolean; expr_then : csl_integer; expr_else : csl_integer) return csl_integer is
  begin
    if (cond) then
      return expr_then;
    else
      return expr_else;
    end if;
  end function ternary_condition_operator;

  -- csl_unsigned
  function ternary_condition_operator (cond : boolean; expr_then : csl_unsigned; expr_else : csl_unsigned) return csl_unsigned is
  begin
    if (cond) then
      return expr_then;
    else
      return expr_else;
    end if;
  end function ternary_condition_operator;

  -- csl_real
  function ternary_condition_operator (cond : boolean; expr_then : csl_real; expr_else : csl_real) return csl_real is
  begin
    if (cond) then
      return expr_then;
    else
      return expr_else;
    end if;
  end function ternary_condition_operator;


  -----------------------------------------------------------------------------
  -- concatenation operator '&'
  -----------------------------------------------------------------------------
  function "&" (first_expr  : csl_integer; second_expr : csl_integer) return csl_bit_vector is
    variable temp_first_len : natural := 0;
    variable temp_second_len : natural := 0;
  begin
  end function "&";


  -----------------------------------------------------------------------------
  -- replication operator '{<num>{<expr>}}'
  -----------------------------------------------------------------------------
  function replication_operator (num : natural; expr : csl_integer) return csl_bit_vector is
  begin
  end function replication_operator;

  function replication_operator (num : natural; expr : csl_bit) return csl_bit_vector is
    variable result : csl_bit_vector(num - 1 downto 0) := (others => expr);
  begin
    return result;
  end function replication_operator;

  function replication_operator (num : natural; expr : csl_bit_vector) return csl_bit_vector is
    variable result : csl_bit_vector(num * expr'high - 1 downto 0) := (others => '0');
  begin
    for index1 in num - 1 downto 0 loop
      for index2 in expr'range loop
        result(index1 * index2) := expr(index2);
      end loop;
    end loop;
    return result;
  end function replication_operator;

  -----------------------------------------------------------------------------
  -- log2
  -----------------------------------------------------------------------------
  function log2 (num : csl_integer) return csl_integer is
  begin
    if num < 2 then
      return 1;
    else
      return 1 + log2(num / 2);
    end if;
  end function log2;
end package body csl_util_package;
