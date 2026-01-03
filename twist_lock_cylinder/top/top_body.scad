use <../cylinder_shell/cylinder_shell_body.scad>
use <../conical_band.scad>
use <../../components/ring.scad>
use <slot.scad>

module top(
  height,
  diameter,
  wall_thickness,
  chamfer_ratio,
  knurling_height,
  split_ratio,
  interface_height,
  num_lugs,
  tolerance
) {
  radius = diameter / 2;
  top_height = height * (1 - split_ratio) + wall_thickness;
  top_interface_radius = radius - wall_thickness * (2 / 3);
  rotate_angle = 180 / num_lugs;

  rotate([0, 0, -rotate_angle / 2])
    difference() {
      cylinder_shell(
        top_height,
        wall_thickness,
        chamfer_ratio,
        knurling_height,
        diameter
      );
      translate([0, 0, top_height - interface_height])
        ring(
          interface_height + 0.01,
          top_interface_radius,
          radius - wall_thickness - 0.01
        );
      translate([0, 0, top_height - interface_height / 2])for (i = [0:num_lugs - 1]) {
        rotate([0, 0, i * 360 / num_lugs])
          render() slot(
              height,
              diameter,
              wall_thickness,
              chamfer_ratio,
              knurling_height,
              split_ratio,
              interface_height,
              num_lugs,
              tolerance,
              radius,
              top_height,
              top_interface_radius,
              rotate_angle
            );
      }
    }
}
