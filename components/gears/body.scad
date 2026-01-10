module gear(
  m, // module
  z, // number of teeth
  h, // height of gear
  alpha = 20, // pressure angle in degrees
  tip_tolerance = 0.3, // tip tolerance
  backlash = 0.1, // backlash
  tooth_steps = 20,
  twist = 0
) {
  d = m * z; // Pitch diameter
  db = d * cos(alpha); // Base diameter
  da = d + 2 * m; // Tip diameter
  // a string is tied to the base circle. 
  // it will be wrapped around 90 degrees of it
  l_string = PI * db / 4;
  tooth_half_angle = 360 / (4 * z);
  // max angle will be what it takes to get to the tip diameter
  // da/2 is the sqrt((db/2)^2 + translation_down^2)
  // ((da-tip_tolerance)/2)^2 - d^2/4 = translation_down^2
  // translation_down = sqrt(da^2 - d^2)/2
  // (angle/360) * PI * d = sqrt((da-tip_tolerance)^2 - d^2)/2
  // (angle/360) * PI * d = sqrt((da-tip_tolerance)^2 - d^2)/
  // angle = sqrt((da-tip_tolerance)^2 - d^2) * 180 / (PI * d)
  max_angle = sqrt((da - tip_tolerance) * (da - tip_tolerance) - db * db) * 180 / (PI * d);
  // contact angle is the angle where the tooth crosses the pitch circle
  contact_angle = sqrt(d * d - (db - tip_tolerance) * (db - tip_tolerance)) * 180 / (PI * d);
  // backlash angle is the angle to reduce the tooth thickness by the backlash amount
  backlash_angle = (backlash / (PI * d)) * 360;
  // at a given angle, it will extend tangentially from that angle
  // to the circle point. 
  // so translate the point out to the reference circle
  // then down by the amount left on the string
  function get_translation_down(angle) =
    (angle / 360) * PI * db;
  // finally rotate it to the angle
  function rotate_point(point, angle) =
    [
      point[0] * cos(angle) - point[1] * sin(angle),
      point[0] * sin(angle) + point[1] * cos(angle),
    ];
  // full function
  function point_on_involute(angle) =
    rotate_point(
      [
        (db - tip_tolerance) / 2,
        -get_translation_down(angle),
      ],
      angle
    );
  contact_point = point_on_involute(contact_angle);
  global_contact_angle = atan2(contact_point[1], contact_point[0]);
  function rotate_to_position(point) =
    rotate_point(
      point,
      -tooth_half_angle - global_contact_angle + backlash_angle / 2
    );
  angle_step = max_angle / tooth_steps;
  function point_on_involute_wrapper(i) =
    let (
      angle = i * angle_step
    ) point_on_involute(angle);
  function mirror_y(point) =
    [point[0], -point[1]];
  // starting point for the tip arc
  arc_starting_point = rotate_to_position(point_on_involute(max_angle));
  // angle of that point
  next_point_angle = -atan2(arc_starting_point[1], arc_starting_point[0]);
  // angle step for the arc
  arc_angle = next_point_angle * 2 / tooth_steps;
  points = concat(
    // we will rotate the points on the first curve to be at the contact angle
    [for (i = [0:tooth_steps]) rotate_to_position(point_on_involute_wrapper(i))],
    // then we do an arc to the next point
    [
      for (j = [0:tooth_steps]) rotate_point(
        arc_starting_point,
        j * arc_angle
      ),
    ],
    // next we will mirror the points down on the negative side
    [for (i = [tooth_steps:-1:0]) mirror_y(rotate_to_position(point_on_involute_wrapper(i)))]
    // finally we go back to that first point to close the shape
    //[rotate_to_position(point_on_involute_wrapper(0))]
  );
  // now the tooth half angle is from center tooth to the contact point. 
  // so 360 / (2 * z)
  // lets translate the contact angle (that's the angle of the construction line)
  // to the global angle
  // so we are going to rotate the polygon by the contact angle to have that on the 
  // axis, then rotate it further to the half tooth angle
  // then we can mirror that full polygon to get teh full tooth profile
  module tooth_profile() {
    polygon(points);
  }
  module teeth() {
    for (i = [0:z - 1]) {
      rotate(i * 360 / z)
        tooth_profile();
    }
  }
  linear_extrude(height=h, twist=twist)
    union() {
      circle(d=db, $fn=500, $fa=1);
      teeth();
    }
}

z1 = 20;
z2 = 30;
m = 3;
dist = (z1 + z2) * m / 2;

gear_rotation = $t * 60;

rotate([0, 0, gear_rotation])
  gear(
    m=3,
    z=20,
    h=10,
    twist=10
  );
translate([dist, 0, 0])
  rotate([0, 0, -gear_rotation * (z1 / z2)])
    rotate([0, 0, 360 / ( (2 * z2) )])
      gear(
        m=3,
        z=30,
        h=10,
        twist=-10 * (z1 / z2)
      );
