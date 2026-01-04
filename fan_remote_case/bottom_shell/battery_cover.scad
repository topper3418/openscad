include <../params.scad>
include <../base/pass_through.scad>

width = base_width - 2 * case_thickness;
base_length = 33;

module battery_cover_blank(tolerance = 0) {
  thickness = case_thickness + tolerance * 2;
  length = tolerance > 0 ? base_length + tolerance + 0.01 : base_length;
  module rail() {
    translate([thickness / 2, 0, thickness / 2])
      resize(
        [
          thickness,
          length,
          thickness,
        ]
      )
        rotate([0, -135, 0])
          cube();
  }
  translate([-width / 2, 0, 0])
    union() {
      rail();
      translate([width, 0, 0])
        rail();
      resize([width, length, thickness])
        cube();
    }
}

module cutout_pattern() {
  cutout_width = 3;
  cutout_length = 15;
  cutout_depth = 0.5;
  module rectangular_cutout() {
    translate([-cutout_length / 2, 0, -0.01])
      resize(
        [
          cutout_length,
          cutout_width,
          cutout_depth,
        ]
      )
        cube();
  }

  instances = 4;
  for (i = [0:instances - 1]) {
    translate([0, i * (cutout_width + 2), 0])
      rectangular_cutout();
  }
}

module battery_cover() {
  difference() {
    battery_cover_blank();

    //translate([-case_width / 2, 0, 0])
    //  pass_through_cutout_array_bottom_shell();
    translate([0, 2, 0])
      cutout_pattern();
  }
}

module battery_cover_cutout() {
  translate([0, -0.01, -battery_cover_tolerance])
    battery_cover_blank(tolerance=battery_cover_tolerance);
}
