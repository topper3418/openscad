
// basically a cylinder shell
module ring(ring_height, outer_radius, inner_radius) {
	// outer radius must be greater than inner
	assert(outer_radius > inner_radius, "outer_radius must be greater than inner_radius");
	difference () {
	    cylinder(
		h=ring_height,
		r=outer_radius
	    );
	    translate([0,0,-0.01])
	    cylinder(
		h=ring_height + 0.02,
		r=inner_radius
	    );
	}
}
