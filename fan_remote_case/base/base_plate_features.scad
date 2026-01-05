use <pass_through.scad>
use <screw_hole_standoff.scad>
use <base_plate.scad>
use <battery_case.scad>
use <translate_base.scad>

include <../params.scad>
include <base_params.scad>

radio_pass_through_offset_x = -10;
radio_pass_through_offset_y = -6;
radio_pass_through_diameter = 10;

dip_switch_pass_through_width = 13;
dip_switch_pass_through_height = 10;
dip_switch_pass_through_offset_x = 9;
dip_switch_pass_through_offset_y = -5;

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

module translate_base_plate_features() {
  translate([01.68, 1.5, 0])
    children();
}

module base_plate_cutouts() {
  translate_base_plate_features()
    union() {
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
}

module base_plate_features() {
  translate_base_plate_features()
    union() {
      pass_through_array();
      offset_screw_hole_standoff_array()
        screw_hole_standoff_array();
      offset_battery_case()
        battery_case();
    }
}
