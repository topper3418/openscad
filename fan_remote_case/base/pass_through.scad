
use <../../components/ring.scad>

pass_through_height = 5;
pass_through_outer_radius = 7.5/2;
pass_through_inner_radius = 3/2;
array_width = 44;
array_height = 42;
inset_depth = 2.5;
inset_radius = 5/2;

module inset() {
	cylinder(
		h=inset_depth + 0.1,
		r=inset_radius
	);
}

module pass_through() {
	difference() {
		ring(
			ring_height=pass_through_height,
			outer_radius=pass_through_outer_radius,
			inner_radius=pass_through_inner_radius
		);
		translate([0, 0, -0.01])
		inset();
	}
}

module pattern_for_pass_through_array() {
    translate([-array_width/2, 0, 0])
	union() {
			children();
			translate([array_width, 0, 0])
				children();
			translate([0, array_height, 0])
				children();
			translate([array_width, array_height, 0])
				children();
	}
}

module pass_through_array() {
	pattern_for_pass_through_array() 
	    pass_through();
}

module pass_through_cutout_array() {
	module blank() cylinder(
	    h=pass_through_height, 
	    r=pass_through_outer_radius - 0.1
	);
    translate([0, 0, -0.1])
    pattern_for_pass_through_array() 
	    blank();
}
