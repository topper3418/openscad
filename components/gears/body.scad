use <params.scad>
use <half_tooth_profile.scad>

module gear(
  m,
  z,
  alpha = 20,
  x = 0,
  ha_coeff = 1,
  c_coeff = 0.25,
  tooth_steps = 50
) {
  params = get_params(
    m=m,
    z=z,
    alpha=alpha,
    x=x,
    ha_coeff=ha_coeff,
    c_coeff=c_coeff
  );
  half_tooth_profile(params=params, steps=tooth_steps);
}

gear(
  m=2,
  z=20
);
