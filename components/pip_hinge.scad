// res config
$fa = 1;
$fs = 0.01;

module hinge(d,l, tol, max_angle_1=45, max_angle_2=45, angle=0) {
	// single width is determined such that there are equal parts
	// in the width of the male and female solid parts. 
	// since the interference cone is a 45 degree angle, that 
	// means that 
	single_width = (16/25)*d;
	segments = floor(l / single_width);  // how many units fit in l
	width = l/segments; // the ideal single width (pad to fit)
	pad_width = width-single_width;
	r = d/2;
	
	module interface_cone(cone_tol=0) {
		// make it 45 degrees
		rise=single_width/2;
		r1 = (4/5)*r;
		r2 = r1-rise;
		// scale factor will be to get the desired tolerance
		scale_factor = (r1 + cone_tol) / r1;
		translate([0, 0, single_width/4])
			scale([scale_factor, scale_factor, scale_factor])
				cylinder(
					h=rise, 
					r1=r1, 
					r2=r2
				);
	}
	
	module male_hinge_instance() {

		module male_hinge_cutout() {
			adjusted_d = (d+2*tol);
			cutout_w = (3/4)*single_width + tol + pad_width;
			translation_w = single_width/4;
			// cutout for barrel
			translate([0, 0, translation_w])
				cylinder(h=cutout_w, r=r+tol);
			// cutout for hinge body at first angle
			rotate([0, 0, max_angle_1])
				translate([0, -adjusted_d/2, translation_w])
					resize([adjusted_d*2, adjusted_d, cutout_w])
						cube();
			// cutout for hinge body at second angle
			rotate([0, 0, -max_angle_2])
				translate([0, -adjusted_d/2, translation_w])
					resize([adjusted_d*2, adjusted_d, cutout_w])
						cube();
		}
		
		union() {
			// hinge body
			difference() {
				translate([0, -d/2, 0])
					resize([2*d, d, width])
						cube();
				// subtract a cutout
				male_hinge_cutout();
			}
			// hinge barrel
			cylinder(h=single_width/4, r=r);
			// interface with female
			interface_cone();
		}
	}
	
	module female_hinge_instance() {
		
		module female_hinge_cutout() {
			adjusted_d = (d+2*tol);
			cutout_w = single_width/4 + tol;
			// cutout for barrel
			translate([0, 0, -tol])
				cylinder(h=cutout_w+(2*tol), r=adjusted_d/2);
			// cutout for hinge body at first angle
			rotate([0, 0, 180+max_angle_2])
				translate([0, -adjusted_d/2, -tol])
					resize([adjusted_d*2, adjusted_d, cutout_w+2*tol])
						cube();
			// cutout for hinge body at second angle
			rotate([0, 0, 180-max_angle_1])
				translate([0, -adjusted_d/2, -tol])
					resize([adjusted_d*2, adjusted_d, cutout_w+2*tol])
						cube();
		}
		
		difference() {
			union() {
				// hinge barrel
				translate([0, 0, single_width/4 + tol])
					cylinder(h=single_width*(3/4) + pad_width - tol, r=r);
				// hinge body
				translate([-2*d, -d/2, 0])
					resize([2*d, d, width])
						cube();
			}
			union() {
				interface_cone(cone_tol = tol);
				female_hinge_cutout();
			}
		}
	}
	
	module full_left_hinge() {
		for (i = [0 : segments-1]) {
			translate([0, 0, i*width])
				if (i % 2 == 0) 
					male_hinge_instance();
				else
					mirror([1, 0, 0])
						female_hinge_instance();
		}
	}
	
	module full_right_hinge() {
		for (i = [0 : segments-1]) {
			translate([0, 0, i*width])
				if (i % 2 == 0) 
					female_hinge_instance();
				else
					mirror([1, 0, 0])
						male_hinge_instance();
		}
	}
	
	rotate([0, 0, angle/2])
		full_left_hinge();
	rotate([0, 0, -angle/2])
		full_right_hinge();
}

module main() {
	hinge(
		d=10, 
		l=100, 
		tol=0.375, 
		max_angle_1=15,
		max_angle_2=120, 
		angle=0
	);
}


main();