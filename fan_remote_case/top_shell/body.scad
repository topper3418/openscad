include <../params.scad>
use <../base/screw_hole_standoff.scad>
use <../base/pass_through.scad>
include <../translate_base_to_position.scad>
include <../base/translate_base.scad>
use <../base/base_plate_features.scad>
use <../chamfers.scad>

angle_1 = 79;
angle_2 = 88;
angle_3 = 76;
angle_4 = 55;
side_offset = 4;
peak_offset_y = case_length * 0.5 + 3 + 1;

filler_offset_z = 10;
filler_offset_y = 27.5;

arb_height = 500;

module joined_rectangles() {
  module fb_rectangle() {
    translate([0, 0, -arb_height])
      resize([case_width + 0.2, arb_height, arb_height])
        cube();
  }
  translate([-0.1, 0, 0])
    union() {
      rotate([angle_1, 0, 0])
        fb_rectangle();
      mirror([0, 1, 0])
        rotate([angle_2, 0, 0])
          fb_rectangle();
    }
}

module side_rectangles(angle = angle_3, manual_offset = side_offset) {
  module side_rectangle() {
    translate([-manual_offset, -0.1, 0])
      rotate([0, angle, 0])
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
  translate([0, 0, case_top_height])
    outer_cube();
  translate([0, peak_offset_y, case_top_height])
    joined_rectangles();
  translate([case_width / 2, 0, case_top_height])
    side_rectangles();
  translate([case_width / 2, 0, case_top_height - 3])
    side_rectangles(angle_4, 21);
  translate([0, 0, 12])
    rotate([15, 0, 0])
      outer_cube();
}

module outer_cube() {
  resize([case_width, case_length + case_case_tolerance, case_top_height])
    cube();
}

module top_shell_outer() {
  if (single_piece_base)
    cut_off_chamfers(height=case_top_height)
      difference() {
        outer_cube();
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
      union() {
        difference() {
          top_shell_outer();
          translate([case_thickness, case_thickness, -0.1])
            resize([case_width - 2 * case_thickness, case_length - 2 * case_thickness, case_top_height - case_thickness + 0.1])
              top_shell_outer();
        }
        difference() {
          translate([0, filler_offset_y, filler_offset_z])
            outer_cube();
          cutting_hat();
        }
      }
      clicker_cutout();
    }
    difference() {
      translate([case_thickness, case_thickness, 0])
        translate_base_plate_features()
          translate_base()
            pattern_for_pass_through_array()
              translate([0, 0, case_top_height])
                mirror([0, 0, 1])
                  screw_hole_standoff(case_top_height);
      cutting_hat();
    }
  }
}
