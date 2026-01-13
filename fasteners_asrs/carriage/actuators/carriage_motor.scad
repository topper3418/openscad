include <params.scad>

module carriage_motor() {
  module shaft() {
    translate(
      [
        carriage_motor_body_width / 2,
        carriage_motor_body_length - 0.01,
        carriage_motor_body_height / 2,
      ]
    )
      rotate([-90, 0, 0])
        cylinder(h=carriage_motor_shaft_length, r=carriage_motor_shaft_diameter / 2);
  }
  shaft();
  cube(
    [
      carriage_motor_body_width,
      carriage_motor_body_length,
      carriage_motor_body_height,
    ]
  );
}

module base_translate_carriage_motor() {
  translate(
    [
      carriage_motor_overall_length,
      (container_dimensions.y - carriage_motor_body_width) / 2,
      0,
    ]
  )
    rotate([0, 0, 90])
      children();
}
