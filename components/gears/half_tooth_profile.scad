// gear_tooth_profile.scad
// Generates a 2D half-tooth profile (right side, from root to tip)
// Suitable for mirror() to make full tooth, then circular array for full gear

use <params.scad>; // provides get_params()

module half_tooth_profile(params, steps = 50) {
  m = get_value(params, "m");
  z = get_value(params, "z");
  alpha = get_value(params, "alpha");
  x = get_value(params, "x");
  ha_coeff = get_value(params, "ha_coeff");
  c_coeff = get_value(params, "c_coeff");
  d = get_value(params, "d");
  db = get_value(params, "db");
  ha = get_value(params, "ha");
  hf = get_value(params, "hf");
  da = get_value(params, "da");
  df = get_value(params, "df");
  ht = get_value(params, "ht");
  p = get_value(params, "p");
  s0 = get_value(params, "s0");
  alpha_rad = get_value(params, "alpha_rad");
  inv_alpha = get_value(params, "inv_alpha");

  rb = db / 2;
  rp = d / 2;
  ra = da / 2;
  rf = df / 2;

  alpha_a = acos(rb / ra);
  alpha_a_rad = alpha_a * PI / 180;
  phi_a = tan(alpha_a) - alpha_a_rad; // roll at tip, rad

  // Determine start roll for root
  phi_f =
    rf > rb ? let (
        alpha_f = acos(rb / rf),
        alpha_f_rad = alpha_f * PI / 180,
        phi = tan(alpha_f) - alpha_f_rad
      ) phi
    : 0;

  // Half angular at pitch, rad
  theta_half_rad = (s0 / 2) / rp; // = s0 / d

  beta_deg = theta_half_rad * 180 / PI; // positive

  // Involute points (basic curve, then rotate)
  involute_pts = [
    for (i = [0:steps]) let (
      phi = phi_f + (phi_a - phi_f) * i / steps, // rad
      phi_deg = phi * 180 / PI,
      x = rb * (cos(phi_deg) + phi * sin(phi_deg)),
      y_raw = rb * (sin(phi_deg) - phi * cos(phi_deg)),
      y = -y_raw, // flip for right flank positive y
      // Rotate by -beta_deg around origin
      x_rot = x * cos(-beta_deg) - y * sin(-beta_deg),
      y_rot = x * sin(-beta_deg) + y * cos(-beta_deg)
    ) [x_rot, y_rot],
  ];

  // Points: add root line if undercut (phi_f == 0 and rf < rb)
  points =
    phi_f > 0 ? involute_pts
    : concat(
      [[rf, 0]], // start at symmetry on root circle
      involute_pts
    );

  polygon(points);
}

// Example usage (uncomment to test)
// p = get_params(m=1, z=20, alpha=20, x=0);
// half_tooth_profile(p);
