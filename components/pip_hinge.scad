
module hinge(
	d,
	l, 
	tol, 
	max_angle_1=45, 
	max_angle_2=45, 
	angle=0
) {
	// all values besides the angle must be positive
	assert(d > 0, "Diameter must be positive");
	assert(l > 0, "Length must be positive");
	assert(tol >= 0, "Tolerance must be non-negative");
	assert(max_angle_1 >= 0, "Max angle 1 must be non-negative");
	assert(max_angle_2 >= 0, "Max angle 2 must be non-negative");
	// max angles must be 15 <= angle <= 180
	assert(max_angle_1 <= 180, "Max angle 1 must be <= 180");
	assert(max_angle_1 >= 15, "Max angle 1 must be >= 15");
	assert(max_angle_2 <= 180, "Max angle 2 must be <= 180");
	assert(max_angle_2 >= 15, "Max angle 2 must be >= 15");
	// single width is determined via the calc in "notes/Width calc.pdf"
	single_width = (16/25)*d;
	segments = floor(l / single_width);  // how many units fit in l
	width = l/segments; // the ideal single width (will need to pad to fit)
	pad_width = width-single_width;
	r = d/2;
	// function to create the interface cone
	module interface_cone(cone_tol=0) {
		// make it 45 degrees
		rise=single_width/2;
		r1 = (4/5)*r;
		r2 = r1-rise;
		// scale factor will be to get the desired tolerance
		scale_factor = (r1 + cone_tol) / r1;
		scale([scale_factor, scale_factor, scale_factor])
			cylinder(
				h=rise, 
				r1=r1, 
				r2=r2
			);
	}
	
	// function to create the "barrel" of the hinge (option to not have the 
	// male or female features)
	module barrel(suppress_female=false, suppress_male=false) {
		barrel_height = suppress_male ? width : width - tol;
		difference() {
			cylinder(h=barrel_height, r=r);
			if (!suppress_female) {
				translate([0, 0, -0.01])
					interface_cone(cone_tol=tol);
			}
		}
		if (!suppress_male) {
		        translate([0, 0, (barrel_height)-0.01])
				interface_cone();
		}
		difference() {
			translate([0, -d/2, 0])
				resize([2*d, d, barrel_height])
					cube();
			translate([0, 0, -0.01])
				cylinder(h=barrel_height+0.02, r=r-tol);
		}
	}
	// function to create the flange body
	module flange_body() {
		module flange_cutout() {
			barrel_cutout_d = d + 2*tol;
			cutout_l = l + 0.02;
			cylinder(h=cutout_l, r=barrel_cutout_d/2);
			// cutout for hinge body at first angle
			rotate([0, 0, max_angle_1])
				translate([0, -barrel_cutout_d/2, 0])
					resize([barrel_cutout_d*2, barrel_cutout_d, cutout_l])
						cube();
			// cutout for hinge body at second angle
			rotate([0, 0, -max_angle_2])
				translate([0, -barrel_cutout_d/2, 0])
					resize([barrel_cutout_d*2, barrel_cutout_d, cutout_l])
						cube();
		}
		difference() {
			translate([0, -d/2, 0])
				resize([d*2, d, l])
					cube();
			translate([0, 0, -0.01])
				flange_cutout();
		}
	}
	// function to create one side of the hinge
	module hinge_side(odd=false) {
		flange_body();
		for (i = [0 : segments-1]) {
			// if odd, skip odd iterations
			translate([0, 0, i*width])
			// skip if odd and even iteration
			// or if not odd and odd iteration
			if (
				(odd && (i % 2 == 1)) ||
				(!odd && (i % 2 == 0))
			) {
				if (i == segments-1)
					barrel(suppress_male=true);
				else if (i == 0)
					barrel(suppress_female=true);
				else
					barrel();
			}
		}
	}
	hinge_side(odd=false);
	rotate([0, 0, angle])
		mirror([1, 0, 0])
			hinge_side(odd=true);
}

module full_close_hinge(d,l, tol, max_open_angle=90, angle=0) {
	intersection() {
		union() {
			translate([-2*d, -d/2, 0])
				resize([4*d, d/2, l])
					cube();
			cylinder(h=l, r=d/2);
		}
		hinge(
			d=d, 
			l=l, 
			tol=tol, 
			max_angle_1=90,
			max_angle_2=max_open_angle, 
			angle=angle
		);
	}
}

