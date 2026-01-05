use <../../components/open_top_shell.scad>
use <../base/pass_through.scad>
use <../base/translate_base.scad>
use <../translate_base_to_position.scad>
include <../params.scad>
use <top_wall_knockout.scad>
use <base_cutout.scad>
use <battery_cover.scad>
use <sliding_shell.scad>
use <../base/base_plate_features.scad>
use <../chamfers.scad>

module bottom_shell_1() {
  difference() {
    sliding_shell(bottom_shell_1_length);
    translate([case_width / 2, 0, 0])
      battery_cover_cutout();
    translate_base_plate_features()
      pass_through_cutout_array_bottom_shell();
  }
}

module bottom_shell_2() {
  difference() {
    translate(
      [
        case_width,
        bottom_shell_2_length + bottom_shell_1_length + case_case_tolerance,
        0,
      ]
    )
      rotate([0, 0, 180])
        sliding_shell(bottom_shell_2_length);
    translate_base_plate_features()
      pass_through_cutout_array_bottom_shell();
  }
}

// shell for when the case is printed as a single piece
module bottom_shell() {
  outer_dimensions = [case_width, case_length, case_base_height];
  difference() {
    open_top_shell(
      case_thickness,
      outer_dimensions
    )
      cut_off_chamfers(case_base_height)
        cube(outer_dimensions);
    translate_base_plate_features()
      pass_through_cutout_array_bottom_shell();
  }
}
