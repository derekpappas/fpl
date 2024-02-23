/**************************************************************************
 * $test_invoke_options example -- Verilog test bench source code
 *
 * Verilog test bench to test the $test_invoke_options PLI application.
 *
 * NOTE: This test uses two supplemental files: invoke_options_test1.f and
 * invoke_options_test1.f.  This test is designed to be invoked as follows:
 *
 *   <simulator_name> +a +b -f invoke_options_test1.f +c
 *
 * For the book, "The Verilog PLI Handbook" by Stuart Sutherland
 *  Book copyright 1999, Kluwer Academic Publishers, Norwell, MA, USA
 *   Contact: www.wkap.il
 *  Example copyright 1998, Sutherland HDL Inc, Portland, Oregon, USA
 *   Contact: www.sutherland.com or (503) 692-0898
 *************************************************************************/
`timescale 1ns / 1ns
module test;
  reg option_exists;
  initial
    begin
      option_exists = $test_invoke_options("+test1");
      if (option_exists)
        $display("\nSimulation WAS invoked with a +test1 option\n");
      else
        $display("\nSimulation was NOT invoked with a +test1 option\n");

      if ($test_invoke_options("+test2"))
        $display("\nSimulation WAS invoked with a +test2 option\n");
      else
        $display("\nSimulation was NOT invoked with a +test2 option\n");

      #1 $finish;
    end

endmodule
