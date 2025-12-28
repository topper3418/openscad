// res config
$fa = 1;
$fs = 0.01;

// parameters
outside_diameter = 10;
inside_diameter = 5;
total_depth = 5;
hole_depth = 3;

difference() {
	cylinder(h=total_depth, r=outside_diameter/2);
	translate([0, 0, -0.01])
		cylinder(h=hole_depth+0.01, r=inside_diameter/2);
}