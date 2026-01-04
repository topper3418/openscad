include <../params.scad>
use <../base/screw_hole_standoff.scad>
use <../base/pass_through.scad>
include <../translate_base_to_position.scad>
include <../base/translate_base.scad>

angle1 = 78;
angle2 = 88;
angle_3 = 80;
side_offset = 4;
peak_offset_y = case_length * 0.5;

arb_height = 500;

module joined_rectangles() {
  module fb_rectangle() {
    translate([0, 0, -arb_height])
      resize([case_width + 0.2, arb_height, arb_height])
        cube();
  }
  translate([-0.1, 0, 0])
    union() {
      rotate([angle1, 0, 0])
        fb_rectangle();
      mirror([0, 1, 0])
        rotate([angle2, 0, 0])
          fb_rectangle();
    }
}

module side_rectangles() {
  module side_rectangle() {
    translate([-side_offset, -0.1, 0])
      rotate([0, angle_3, 0])
        translate([0, 0, -arb_height])
          rotate([0, -90, 0])
            resize([arb_height, case_length + 0.2, arb_height])
              cube();
  }
  side_rectangle();
  mirror([1, 0, 0])
    side_rectangle();
}

module cutting_hat() {
  translate([0, peak_offset_y, case_top_height])
    joined_rectangles();
  translate([case_width / 2, 0, case_top_height])
    side_rectangles();
}

module top_shell_outer() {
  difference() {
    resize([case_width, case_length + case_case_tolerance, case_top_height])
      cube();
    cutting_hat();
  }
}

module clicker_cutout() {
  translate([case_width / 2, clicker_offset_y, 0])
    cylinder(h=case_top_height + 0.2, r=clicker_diameter / 2);
}

module top_shell() {
  $fn = 100;
  $fa = 1;
  union() {
    difference() {
      top_shell_outer();
      translate([case_thickness, case_thickness, -0.1])
        resize([case_width - 2 * case_thickness, case_length - 2 * case_thickness, case_top_height - case_thickness + 0.1])
          top_shell_outer();
      clicker_cutout();
    }
    difference() {
      translate([case_thickness, case_thickness, 0])
        translate_base()
          pattern_for_pass_through_array()
            translate([0, 0, case_top_height])
              mirror([0, 0, 1])
                screw_hole_standoff(case_top_height);
      cutting_hat();
    }
  }
}
