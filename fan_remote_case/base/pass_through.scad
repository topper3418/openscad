use <../../components/ring.scad>
include <../params.scad>
include <../translate_base_to_position.scad>
include <translate_base.scad>

pass_through_height = case_base_height - (case_thickness + case_base_tolerance);
pass_through_outer_radius = 7.5 / 2;
pass_through_inner_radius = 3 / 2;
array_width = 44;
array_height = 42;
inset_depth = pass_through_height - 1.5;
inset_radius = 5 / 2;

module inset() {
  cylinder(
    h=inset_depth + 0.1,
    r=inset_radius
  );
}

module pass_through(height = pass_through_inner_radius) {
  difference() {
    ring(
      ring_height=pass_through_height,
      outer_radius=pass_through_outer_radius,
      inner_radius=height
    );
    translate([0, 0, -0.01])
      inset();
  }
}

module pattern_for_pass_through_array() {
  translate([-array_width / 2, 0, 0])
    union() {
      children();
      translate([array_width - 4.5 + 1.5, 0, 0])
        children();
      translate([0, array_height + 1.16 - 1.5, 0])
        children();
      translate([array_width, array_height - 1, 0])
        children();
    }
}

module pass_through_array() {
  pattern_for_pass_through_array()
    pass_through();
}

module pass_through_cutout_array() {
  $fn = 100;
  $fa = 1;
  module blank() cylinder(
      h=pass_through_height,
      r=inset_radius
    );
  translate([0, 0, -0.1])
    pattern_for_pass_through_array()
      blank();
}

module pass_through_cutout_array_bottom_shell() {
  translate([0, 0, -base_assembly_offset_z - 0.01])
    translate_base_to_position()
      translate_base()
        pass_through_cutout_array();
}
