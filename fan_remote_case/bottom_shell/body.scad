use <../../components/cube_shell.scad>
use <../base/pass_through.scad>
use <../base/translate_base.scad>
use <../translate_base_to_position.scad>
include <../params.scad>
use <top_wall_knockout.scad>
use <base_cutout.scad>
use <battery_cover.scad>
use <sliding_shell.scad>

module bottom_shell_1() {
  difference() {
    sliding_shell(bottom_shell_1_length);
    translate([case_width / 2, 0, 0])
      battery_cover_cutout();
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
    pass_through_cutout_array_bottom_shell();
  }
}
