use <base/body.scad>
use <top_shell/body.scad>
use <bottom_shell/body.scad>
use <bottom_shell/battery_cover.scad>
use <chamfers.scad>
use <wall_mount/body.scad>

include <params.scad>
use <translate_base_to_position.scad>

module full_bottom_case() {
  cut_off_chamfers(height=case_base_height)
    difference() {
      union() {
        bottom_shell();
        translate_base_to_position()
          remote_base();
      }
      translate([case_width / 2, 0, 0])
        battery_cover_cutout();
    }
}

module assembled_case(for_printing = false) {
  if (single_piece_base) {
    //chamfer_and_add_walls(case_base_height)
    full_bottom_case();
  } else {
    translate_base_to_position()
      remote_base();
    bottom_shell_1();
    bottom_shell_2();
  }
  if (single_piece_base)
    cut_off_chamfers(height=case_base_height)
      translate([case_width / 2, 0, 0])
        battery_cover();
  translate([0, 0, case_base_height + case_case_tolerance])
    top_shell();
}

module mounted_case() {
  wall_mount_offset = wall_mount_thickness + wall_mount_tolerance;

  translate(
    [
      wall_mount_offset,
      wall_mount_offset,
      wall_mount_offset,
    ]
  )
    assembled_case();
  !wall_mount();
}

//assembled_case(for_printing=false);
mounted_case();
