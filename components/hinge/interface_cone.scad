
// function to create the interface cone
module interface_cone(
  cone_tol,
  single_width,
  r
) {
  // make it 45 degrees
  rise = single_width / 2;
  r1 = (4 / 5) * r;
  r2 = r1 - rise;
  // scale factor will be to get the desired tolerance
  scale_factor = (r1 + cone_tol) / r1;
  scale([scale_factor, scale_factor, scale_factor])
    cylinder(
      h=rise,
      r1=r1,
      r2=r2
    );
}
