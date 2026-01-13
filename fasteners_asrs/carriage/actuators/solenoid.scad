include <params.scad>

module solenoid(actuated = false) {
  solenoid_base_x_translation = -solenoid_back_stroke;
  solenoid_x_translation = actuated ? solenoid_base_x_translation + solenoid_stroke : solenoid_base_x_translation;
  module shaft() {
    translate(
      [
        solenoid_x_translation,
        solenoid_body_width / 2,
        solenoid_body_height / 2,
      ]
    )
      rotate([0, 90, 0])
        cylinder(h=solenoid_shaft_length, r=solenoid_shaft_diameter / 2);
  }
  shaft();
  cube([solenoid_body_length, solenoid_body_width, solenoid_body_height]);
}

module base_translate_solenoid() {
  translate(
    [
      container_dimensions.x * (1 / 3),
      carriage_wall_thickness,
      0,
    ]
  )
    children();
}
