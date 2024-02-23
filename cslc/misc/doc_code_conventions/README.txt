Drawing schematics/block diagrams

1. Use top down design. Start with the top level schematic

2. Draw the level and intermediate level blocks and signals.

3. Use connnect by name instead of connecting long signals that change direction

4. When drawing a pipeline connect the blocks using horizontal lines

5. Line up the bottom of the signal names with the input or output line

6. line up everything.

7. Make it look neat.

8. Use the same size arrow heads for pointing

9. Do not use arrowheads for signal lines

10. Line up modules/blocks vertically so that the pipelines are self evident

11. Make sure that the interfaces are complete

12. If you have a set of signals which are repeated (inputs and outputs of a pipeline)
     make a concat and show it in the bottom of the page and use the concat name
     in the diagram to make it easy to read and maintain.

    Example: bus = {data<32>, addr<21>, cmd<4>, be<4>}
    Now the from/to and pipestage prefixes and suffixes can be added to the bus.
    See below.

13. Use abreviations. Example: be = byte enable, cmd = command, addr = address

14. Use the name of the block as the file name so it is easy to follow the design top down

15. Use landscape mode for complex logic paths or many pipestages shown on the same page.

16. Use lower case.

17. Control signals are vertical.

18. Inputs are on the left side of the block, outpus on the write side of the bloc.

19. Divide control and data path vertically.

20. Line up pipeline registers.

21. Small logic blocks show the pins and logic.

22. Use dot to show source of signals in congested areas with crossing signals.

Writing RTL code
1. Use CSL to develop the interconnect and the testbenches

2. Use the Verilog component library for random logic to instantiate flip flops and counters
   Where is this library in the SVN repo?

3. Use the module names and signal names from the schematics in the RTL code.

4. We need a set of RTL coding guidelines.
   The decoder class notes from last week are a start.
   The blue book contains another set of guidelines.
   Understand the difference between non-blocking and blocking code and when to
   use the appropriate coding style

5. Do not use numbers in the code except 0 for the lower index of a bit range.
   Use constants and parameters instead.

6. use a naming convention for signals sent from one module to another module

7. choose a 2 or 3 letter code for the cluster name
   For example queue manager is "qm".

8. The top level schematics/RTL and lower level schematics/RTL should use the
following naming convention for signals:
<from>_<to>_<signal_name>_<pipestage_number>

from: the two letter code name for the sending unit
to: the two letter code name for the receiver unit
signal_name: the name of the signal
pipestage_number: the pipestage number

9. Label the signals in the combinational logic paths with the pipestage number
   The pipestage number

10. Combinational logic name use "_ps" suffix

11. Do not start coding until you know what you are designing

12. Use emacs in verilog mode to expand sesitivity lists.


Example:
queue manager|->foo->|in fifo
pipestage 10                    pipestage 11

qm_if_foo_ps11 (combinational logic belongs to the next flip flop or state element)
