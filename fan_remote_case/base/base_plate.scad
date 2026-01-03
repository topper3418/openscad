use <screw_hole_standoff.scad>
use <pass_through.scad>
use <battery_case.scad>

base_thickness = 2;
base_width = 65;
base_height = 125;
base_plate_offset_y = -45;

radio_pass_through_offset_x = -12;
radio_pass_through_offset_y = -5;
radio_pass_through_diameter = 10;

dip_switch_pass_through_width = 21;
dip_switch_pass_through_height = 9;
dip_switch_pass_through_offset_x = 7;
dip_switch_pass_through_offset_y = -5;

module radio_pass_through_cutout() {
  translate([radio_pass_through_offset_x, radio_pass_through_offset_y, -0.1])
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
      cube([base_width, base_height, base_thickness]);

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
