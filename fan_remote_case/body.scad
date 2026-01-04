use <base/body.scad>
use <top_shell/body.scad>
use <bottom_shell/body.scad>
use <bottom_shell/battery_cover.scad>

include <params.scad>
use <translate_base_to_position.scad>

module assembled_case(for_printing = false) {
  translate_base_to_position()
    remote_base();
  bottom_shell_1();
  bottom_shell_2();
  translate([case_width / 2, 0, 0])
    battery_cover();
  translate([0, 0, case_base_height + case_case_tolerance])
    top_shell();
}
assembled_case(for_printing=false);
