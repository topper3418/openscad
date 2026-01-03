use <interface_cone.scad>
use <barrel.scad>
use <flange_body.scad>

module hinge(
  d,
  l,
  tol,
  max_angle_1 = 45,
  max_angle_2 = 45,
  angle = 0
) {
  // all values besides the angle must be positive
  assert(d > 0, "Diameter must be positive");
  assert(l > 0, "Length must be positive");
  assert(tol >= 0, "Tolerance must be non-negative");
  assert(max_angle_1 >= 0, "Max angle 1 must be non-negative");
  assert(max_angle_2 >= 0, "Max angle 2 must be non-negative");
  // max angles must be 15 <= angle <= 180
  assert(max_angle_1 <= 180, "Max angle 1 must be <= 180");
  assert(max_angle_1 >= 15, "Max angle 1 must be >= 15");
  assert(max_angle_2 <= 180, "Max angle 2 must be <= 180");
  assert(max_angle_2 >= 15, "Max angle 2 must be >= 15");
  // single width is determined via the calc in "notes/Width calc.pdf"
  single_width = (16 / 25) * d;
  segments = floor(l / single_width); // how many units fit in l
  width = l / segments; // the ideal single width (will need to pad to fit)
  pad_width = width - single_width;
  r = d / 2;
  // function to create the "barrel" of the hinge (option to not have the 
  // male or female features)
  // function to create the flange body
  // function to create one side of the hinge
  module hinge_side(odd = false) {
    flange_body(
      d,
      l,
      tol,
      max_angle_1,
      max_angle_2
    );
    for (i = [0:segments - 1]) {
      // if odd, skip odd iterations
      translate([0, 0, i * width])
      // skip if odd and even iteration
      // or if not odd and odd iteration
      if (
        (odd && (i % 2 == 1)) || (!odd && (i % 2 == 0))
      ) {
        if (i == segments - 1)
          barrel(
            suppress_male=true,
            suppress_female=false,
            width=width,
            tol=tol,
            single_width=single_width,
            r=r
          );
        else if (i == 0)
          barrel(
            suppress_female=true,
            suppress_male=false,
            width=width,
            tol=tol,
            single_width=single_width,
            r=r
          );
        else
          barrel(
            suppress_female=false,
            suppress_male=false,
            width=width,
            tol=tol,
            single_width=single_width,
            r=r
          );
      }
    }
  }
  hinge_side(odd=false);
  rotate([0, 0, angle])
    mirror([1, 0, 0])
      hinge_side(odd=true);
}

module full_close_hinge(d, l, tol, max_open_angle = 90, angle = 0) {
  intersection() {
    union() {
      translate([-2 * d, -d / 2, 0])
        resize([4 * d, d / 2, l])
          cube();
      cylinder(h=l, r=d / 2);
    }
    hinge(
      d=d,
      l=l,
      tol=tol,
      max_angle_1=90,
      max_angle_2=max_open_angle,
      angle=angle
    );
  }
}
