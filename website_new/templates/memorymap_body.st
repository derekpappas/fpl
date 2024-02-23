<div class="colmask threecol">
  <div class="colmid">
    <div class="colleft">
      <div class="col1">
	<!-- Column 1 start -->
	    <h2>SoC Address maps</h2>
	    <p>
		  SoC's designs contain an address map which is used to
	      write and read the addressable objects in the SoC
	      design. The memory map must be implmented in both the
	      functional simulator and the RTL design. The address map changes during the
	      development of the project. Maintenance of the consistency
	      between these interfaces is  address map between the
	      simulaiton and RTL designs is a consistency problem.
		  SoC designs are typically controlled via a set of addressable objects
		  located in a memory map. 
		<br/>
		  The objects are distributed over a design
		  hierarchy and are typically read and written via a network or bus.
		  Thus there is a relationship between the design hierarchy/interconnect
		  and the address map in the units. Moreover, each unit has some
		  sort of functional block which recognizes transactions addressed
		  to the unit. The address decoder outputs combined with the inputs
		  of the bus/network control a transaction processing unit whih
		  issues commands to the unit. The commands typically are read a
		  register or write a register. Writing a reigster can be used to
		  control the configuration of the unit or activate a
		  command. Unit configuration controls the data oath and control
		  units in a unit as well as blocks such as performance counters and
		  status registers. Commands include send a reply to the requesting
		  unit, start a process,...
		  <br/>
		  This requires addressing modes which are consistent in all domains, as
		  well as data framers to encapsulate the data that is being
		  transmitted from one point to another in the design. The
		  configuration of the address space and the associated ddressable
		  objects (e.g. registers, SRAM's, register files,...) requires a
		  memory map generation syste that is tied to the addressable
		  objects, the data framers, and the interconnect.
		</p>

	<!-- Column 1 end -->
      </div>
      <div class="col2">
	<!-- Column 2 start -->

	<!-- Column 2 end -->
      </div>
      <div class="col3">
	<!-- Column 3 start -->
	<!-- Column 3 end -->
      </div>
    </div>
  </div>
</div>

