
	/******************************************************/
	/*** function: rootof2 ********************************/
	/******************************************************/

	// input:
	//      n - integer number
	//
	// output:
	//      rootof2 - a real number

	function real rootof2;

		input n;

		integer n, i;
		real power;

		begin
			power = 0.82629586;
			power = power / 10000000.0;
			power = power + 1.0;
			i = -23;

			if (n >= 1) begin
				power = 2.0;
				i = 0;
			end

			for (i=i ; i<n; i=i+1) begin
				power = power * power;
			end

			rootof2 = power;
		end

	endfunction

	/******************************************************/
	/*** function: log ************************************/
	/******************************************************/

	// input:
	//      x - real number
	//
	// output:
	//      log - a real number, the natural logarithm of x (log = ln(x))

	function real log;

		input x;

		real x, re, log2;
		integer i;

		begin
			if (x <= 0.0) begin
				$display($realtime," ERROR: log illegal argument:",x);
				$finish;
			end

			else begin
				if (x<1.0)
					re = 1.0/x;
				else
					re = x;

				log2 = 0.0;

				for (i=7; i>=-23; i=i-1) begin
					if (re > rootof2(i)) begin
						re = re/rootof2(i);
						log2 = 2.0*log2 + 1.0;
					end

					else begin
						log2 = log2*2;
					end
				end

				if (x < 1.0)
					log = -log2/12102203.16;
				else
					log = log2/12102203.16;
			end
		end

	endfunction

	/******************************************************/
	/*** function: rnd_uniform_real ***********************/
	/******************************************************/

	// input:
	//      max - the maximum value this function can return (real number)
	//
	// output:
	//      rnd_uniform_real - a random real number, uniformly distributed
	//            between 0 (including) and max (not including), range [0, max)

	function real rnd_uniform_real;

		input max;

		reg [31:0] ti;
		real tr, max;

		begin
			ti = {$random(`seed)} % `RESOLUTION;	// integer [0..(RESOLUTION-1)]
			tr = ti;				// convert: integer -> real
			rnd_uniform_real = tr/`RESOLUTION*max;	// real [0,max)
		end
	endfunction

	/******************************************************/
	/*** function: rnd_uniform_int ************************/
	/******************************************************/

	// inputs:
	//      min - the minimum value this function can return (integer number)
	//      max - the maximum value this function can return (integer number)
	//
	// output:
	//      rnd_uniform_int - a random integer number, uniformly distributed
	//            between min and max (including both edges, range [min, max])

	function integer rnd_uniform_int;

		input min, max;

		integer min, max;

		begin
			rnd_uniform_int = ({$random(`seed)} % (max-min+1)) + min;
		end

	endfunction

	/******************************************************/
	/*** function: rnd_exp ********************************/
	/******************************************************/

	// input:
	//      avrg - the average of the exponential distribution (real number)
	//
	// output:
	//      rnd_exp - a random real number, exponentially distributed
	//            with parameter lambda = (1/avrg), and average = avrg

	function real rnd_exp;

		input avrg;

		real avrg, u;

		begin
			u = rnd_uniform_real(1.0);
			rnd_exp = -avrg*log(1-u);
		end

	endfunction


