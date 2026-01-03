// this will have screw holes for the motherboard to screw into
// this will have pass throughs for the screws that put the case together
// this will have a chamber for the battery to sit in

// first screw hole will be located at 0,0
// big holes will be called pass_throughs
// needs a hole for the radio to pass through
// needs a hole for the dip switches
use <pass_through.scad>
use <screw_hole_standoff.scad>
use <base_plate.scad>
use <battery_case.scad>

$fn=50;
$fa=0.1;

module remote_base() {
    union() {
	base_plate();
	pass_through_array();
	offset_screw_hole_standoff_array()
		screw_hole_standoff_array();
	offset_battery_case()
		battery_case();
	}
}

remote_base();
