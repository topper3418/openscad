
module flange_body(
  d,
  l,
  tol,
  max_angle_1,
  max_angle_2
) {
  module flange_cutout() {
    barrel_cutout_d = d + 2 * tol;
    cutout_l = l + 0.02;
    cylinder(h=cutout_l, r=barrel_cutout_d / 2);
    // cutout for hinge body at first angle
    rotate([0, 0, max_angle_1])
      translate([0, -barrel_cutout_d / 2, 0])
        resize([barrel_cutout_d * 2, barrel_cutout_d, cutout_l])
          cube();
    // cutout for hinge body at second angle
    rotate([0, 0, -max_angle_2])
      translate([0, -barrel_cutout_d / 2, 0])
        resize([barrel_cutout_d * 2, barrel_cutout_d, cutout_l])
          cube();
  }
  difference() {
    translate([0, -d / 2, 0])
      resize([d * 2, d, l])
        cube();
    translate([0, 0, -0.01])
      flange_cutout();
  }
}
