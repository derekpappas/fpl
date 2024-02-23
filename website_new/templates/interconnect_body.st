<div class="colmask threecol">
  <div class="colmid">
    <div class="colleft">
      <div class="col1">
		<!-- Column 1 start -->
	    <h2>Interconnect</h2>
		The design hierarchy and interconect are at the heart of every chip design. Generating and maintaining the design hierarchy and interconnect during the life of a project is a time consuming activity for the entire project. When viewed from the point of view of the RTL design team design hierarchy and interconnect generation and maintenance is not seen as a hot button. However, from the standpoint of the verification and functional simulation teams maintaining a design hierarchy and interconect that remains in sync with the rest of the design is constant battle. Parallel bookkeeping in the verification (e.g. functional simulator design hierarchy and interconnect, testbenches, vectors, state data, and transaction level modeling) is not a productive use of engineers time. The generation of functional simulator design hierarchy and interconnect, testbenches, vectors, state data, and transaction level modeling components can be automated and generated from the sam source as the RTL design hierarchy and interconnect. 
		<br/>

	    <h2>SoC example</h2>
	    <p>SoC designs are typically proliferated which requires modifications to the interconnect to add new modules or delete existing modules.
	      </p>
	    <img class="g1515" src="../imagesfpl/soc_interconnect.png"  alt="soc"/>
	    <p> Interconnect is built by design and verification teams during chip design projects. The interconnect uses interfaces to connect modules to one another in the verification simulator, the test benches, and the RTL design. A change in the RTL design must be reflected in the corresponding verification components and the functional simulator. Changes between modules in the RTL or functional simulator must be maintained by two or more RTL design engineers or functional simulator writers.
</p>  
	    <h2>SoC Design Hierarchy and Interconnect</h2>
	    <p>SoC designs are constructed using a design hierarchy and interconnect. The design is verified at specific points (interfaces) using simulation models, bus functional models, and assertions. These interfaces change during the course of the project, creating significant consistency issues between the RTL, verification, and simulation domains. 
		</p>
		<br/>
		Moreover, there are networks in the design which need to be configured
		and maintained by the various teams on a design project. The
		SoC communication network consists of interconnect and
		components for sending information from one module to another
		module. Examples are -
		<ul>
		  <li>Testability network for controlling and reporting the
			results of the various testability units on the chip
			(e.g. MBIST, loopback testing,...</li>
		  <li>Clock tree network including clock gates, phase delays,
			loopback controllers</li>
		  <li>Register configuration, status, control, query network (PSCQN)</li>
		  <li>SoC data and control communication</li>
		  <li>Broadcast and reply networks</li>
		</ul>

	    <h3>Interconnect Constructs</h3>
	    <ul>
	      <li>unit</li>
	      <li>parameter</li>
	      <li>signal</li>
	      <li>signal group</li>
	      <li>port</li>
	      <li>interface</li>
	      <li>formal to actual name mappings with bit ranges</li>
	      <li>connection statements using hierarchical identifiers</li>
	    </ul>

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

