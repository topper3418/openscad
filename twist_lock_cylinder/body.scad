use <../helpers/units.scad>
use <../components/ring.scad>
use <cylinder_shell/cylinder_shell_body.scad>
use <conical_band.scad>
use <bottom/bottom_body.scad>
use <top/top_body.scad>

module twist_lock_cylinder(
  diameter = 50,
  height = 35,
  wall_thickness = 3,
  split_ratio = 0.5,
  tolerance = 0.2,
  num_lugs = 4,
  chamfer_ratio = 0.2,
  knurling_height = 1.5,
  top_only = false,
  bottom_only = false
) {
  // chamfer ratio cannot be above 0.5 or below 0
  assert(chamfer_ratio <= 0.5, "chamfer radius cannot be above 0.5");
  assert(chamfer_ratio >= 0, "chamfer radius cannot be below 0");
  $fn = 500;
  $fa = .1;
  radius = diameter / 2;
  interface_height = wall_thickness * 4;

  module top_body_wrapper() {
    top(
      height,
      diameter,
      wall_thickness,
      chamfer_ratio,
      knurling_height,
      split_ratio,
      interface_height,
      num_lugs,
      tolerance
    );
  }

  if (!top_only) {
    bottom(
      height,
      diameter,
      wall_thickness,
      chamfer_ratio,
      knurling_height,
      split_ratio,
      interface_height,
      num_lugs,
      tolerance
    );
  }
  if (!bottom_only) {
    if (!top_only) {
      translate([diameter * 1.125, 0, 0])
        top_body_wrapper();
    } else {
      top_body_wrapper();
    }
  }
}

//twist_lock_cylinder(
//  diameter=inches(4.5),
//  height=inches(8)
//);
//twist_lock_cylinder(
//    diameter=inches(1.5),
//    height=inches(1.5)
//);
