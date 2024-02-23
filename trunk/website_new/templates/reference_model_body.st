<div class="colmask threecol">
  <div class="colmid">
    <div class="colleft">
      <div class="col1">
		<!-- Column 1 start -->
		Design teams build their implemenation of the design using
		RTL. The RTL design must be verified using an alternate
		model. Typically design teams choose bus functional models and
		other drivers such as reference models written in C++ or SystemC
		to verify their designs. Reference models execute the same
		binaries or process the same input stream as the RTL
		models. Reference models generate stimulus and exected results at
		interfaces which are shared with the RTL design. The stimulus
		vectors are applied by a testbench to a RTL design unit and the
		output of the unit is compared against the reference model
		expected results. In addition reference model state can be
		compared to RTL design state.
		
		<img  class="g1515" src="../imagesfpl/soc_tlm.png"  alt="soc" />
		<br/>
		The reference model is an alternate model of the
		architecture. The reference model may not define all fo the
		interfaces in the RTL design. The reference model is an
		alternate implementation from the RTL design and may find
		ambiguities in the specification that are subject ot
		interpretation by the individual engineer.

		The RTL design and the reference model share the same
		interfaces where the stimulus and expected vectors and state 
		are defined. As a result any interface changes in the micro 
		architecture or RTL design must also be made in the reference
		model. Otherwise simulation mismatches will
		occur. 

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

