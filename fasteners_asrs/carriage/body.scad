include <params.scad>
use <actuators/solenoid.scad>
use <actuators/carriage_motor.scad>
use <base.scad>

module carriage() {
  module mirror_about_base_x() {
    translate([container_dimensions.x / 2, 0, 0])
      mirror([1, 0, 0])
        translate([-container_dimensions.x / 2, 0, 0])
          children();
  }
  module mirror_about_base_y() {
    translate([0, container_dimensions.y / 2, 0])
      mirror([0, 1, 0])
        translate([0, -container_dimensions.y / 2, 0])
          children();
  }
  carriage_base();
  mirror_about_base_y()
    mirror_about_base_x()
      base_translate_solenoid()
        solenoid(actuated=true);
  base_translate_solenoid()
    solenoid(actuated=true);
  carriage_motor_base_translation = [
    carriage_motor_overall_length,
    (container_dimensions.y - carriage_motor_body_width) / 2,
    0,
  ];
  mirror_about_base_x()
    base_translate_carriage_motor()
      carriage_motor();
  base_translate_carriage_motor()
    carriage_motor();
}
