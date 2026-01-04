use <../../components/ring.scad>

screw_hole_standoff_height = 7 - 1.5;
screw_hole_standoff_outer_radius = 4 / 2;
screw_hole_standoff_inner_radius = 2 / 2;
array_width = 43;
array_height = 34;
screw_hole_standoff_offset_y = 33;
base_thickness = 1;

module base_plug() {
  cylinder(
    h=base_thickness,
    r=screw_hole_standoff_outer_radius
  );
}

module screw_hole_standoff(height = screw_hole_standoff_height) {
  ring(
    ring_height=height,
    outer_radius=screw_hole_standoff_outer_radius,
    inner_radius=screw_hole_standoff_inner_radius
  );
  base_plug();
}

module pattern_for_screw_hole_array() {
  translate([-array_width / 2, 0, 0])
    union() {
      children();
      translate([array_width, 0, 0])
        children();
      translate([0, array_height, 0])
        children();
      // top was chewed, but we still want the support so we will actually
      // just move it down a bit
      translate([array_width, array_height - 10, 0])
        children();
    }
}

module screw_hole_standoff_array() {
  pattern_for_screw_hole_array()
    screw_hole_standoff();
}

module screw_hole_cutout_array() {
  module blank() cylinder(
      h=screw_hole_standoff_height,
      r=screw_hole_standoff_outer_radius - 0.1
    );
  translate([0, 0, -0.1])
    pattern_for_screw_hole_array()
      blank();
}

module offset_screw_hole_standoff_array() {
  translate([0, screw_hole_standoff_offset_y, 0])
    children();
}
