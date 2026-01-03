use <interface_cone.scad>
module barrel(
  suppress_female,
  suppress_male,
  width,
  tol,
  single_width,
  r,
) {
  d = 2 * r;
  barrel_height = suppress_male ? width : width - tol;
  difference() {
    cylinder(h=barrel_height, r=r);
    if (!suppress_female) {
      translate([0, 0, -0.01])
        interface_cone(cone_tol=tol, single_width=single_width, r=r);
    }
  }
  if (!suppress_male) {
    translate([0, 0, (barrel_height) - 0.01])
      interface_cone(cone_tol=0, single_width=single_width, r=r);
  }
  difference() {
    translate([0, -d / 2, 0])
      resize([2 * d, d, barrel_height])
        cube();
    translate([0, 0, -0.01])
      cylinder(h=barrel_height + 0.02, r=r - tol);
  }
}
