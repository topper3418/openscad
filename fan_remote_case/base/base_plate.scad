use <screw_hole_standoff.scad>
use <pass_through.scad>
use <battery_case.scad>

include <base_params.scad>
include <../params.scad>

radio_pass_through_offset_x = -11;
radio_pass_through_offset_y = -8;
radio_pass_through_diameter = 12;

dip_switch_pass_through_width = 13;
dip_switch_pass_through_height = 10;
dip_switch_pass_through_offset_x = 9;
dip_switch_pass_through_offset_y = -7;

module side_rail() {
  translate([base_width / 2, 0, 0])
    translate([-base_thickness / 2, 0, base_thickness / 2])
      resize([base_thickness, base_length, base_thickness])
        rotate([0, 45, 0])
          cube();
}

module radio_pass_through_cutout() {
  translate(
    [
      radio_pass_through_offset_x,
      radio_pass_through_offset_y,
      -0.1,
    ]
  )
    cylinder(
      h=base_thickness + 0.2,
      r=radio_pass_through_diameter / 2 + 0.1
    );
}

module dip_switch_cutout() {
  translate(
    [
      dip_switch_pass_through_offset_x - dip_switch_pass_through_width / 2,
      dip_switch_pass_through_offset_y - dip_switch_pass_through_height / 2,
      -0.1,
    ]
  )
    cube(
      [
        dip_switch_pass_through_width + 0.2,
        dip_switch_pass_through_height + 0.2,
        base_thickness + 0.2,
      ]
    );
}

module base_plate() {
  difference() {
    // main base plate
    translate([-base_width / 2, base_plate_offset_y, 0])
      cube([base_width, base_length, base_thickness]);

    // cutouts for pass throughs
    pass_through_cutout_array();

    // cutouts for screw hole standoffs
    offset_screw_hole_standoff_array()
      screw_hole_cutout_array();

    // cutouts for the battery case
    offset_battery_case()
      battery_case_cutout();

    // cutout for the radio pass through
    radio_pass_through_cutout();

    // cutout for the dip switch pass through
    dip_switch_cutout();
  }
  // rails for sliding into case
  translate([0, base_plate_offset_y, 0])
    union() {
      side_rail();
      mirror([1, 0, 0])
        side_rail();
    }
}
