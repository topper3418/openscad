include <../params.scad>
include <../top_shell/body.scad>
include <../bottom_shell/body.scad>

shell_width = case_width + 2 * wall_mount_thickness + 2 * wall_mount_tolerance;
shell_length = case_length + 2 * wall_mount_thickness + 2 * wall_mount_tolerance;
shell_height = case_height + 2 * wall_mount_thickness + 2 * wall_mount_tolerance;

module case_blank() {
  union() {
    translate([0, 0, case_base_height - 0.01])
      top_shell_outer();
    bottom_shell_blank();
  }
}

module case_shell() {
  cutout_offset = 2 * wall_mount_tolerance;
  shell_offset = cutout_offset + 2 * wall_mount_thickness;
  difference() {
    resize(
      [
        shell_width,
        shell_length,
        shell_height,
      ]
    )
      case_blank();
    translate(
      [
        wall_mount_thickness,
        wall_mount_thickness,
        wall_mount_thickness,
      ]
    )
      resize(
        [
          case_width + cutout_offset,
          case_length + cutout_offset,
          case_height + cutout_offset,
        ]
      )
        case_blank();
  }
}

module wall_mount_blank() {
  cutout_width = 15;
  cutout_base_height = 45;
  cutout_height = case_height + 2 * (wall_mount_thickness + 0.02);
  module mirror_cutout() {
    mirror([1, 0, 0])
      translate(
        [
          -shell_width - 0.02,
          0,
          0,
        ]
      )
        children();
  }
  module side_cutout(mirrored = false) {

    translate([-0.01, -0.01, -0.01])
      cube([cutout_width, cutout_base_height, cutout_height]);
    translate([-0.01, cutout_base_height - 0.02, -0.1])
      difference() {
        cube([cutout_width, cutout_width, cutout_height]);
        translate([0, cutout_width, -0.1])
          rotate([0, 0, -45])
            cube([cutout_width * 2, cutout_width, cutout_height + 0.2]);
      }
  }
  difference() {
    cube(
      [
        shell_width,
        shell_length * (7 / 10),
        shell_height,
      ]
    );
    translate(
      [
        case_width / 2 + wall_mount_thickness + wall_mount_tolerance,
        clicker_offset_y + wall_mount_thickness + wall_mount_tolerance,
        case_height / 2,
      ]
    )
      cylinder(h=case_top_height + wall_mount_thickness + wall_mount_tolerance, r=clicker_diameter / 2 + 5);
    side_cutout();
    mirror_cutout()
      side_cutout();
  }
}

module wall_mount() {
  intersection() {
    wall_mount_blank();
    case_shell();
  }
}
