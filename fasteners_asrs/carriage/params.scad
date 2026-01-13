include <../params.scad>

carriage_base_thickness = 2.5;
carriage_wall_thickness = 1.5;

solenoid_solenoid_spacing = 2;

// based on https://www.amazon.com/dp/B098KVBH4L/?coliid=ISKANO6BTI5H2&colid=MUOI8GUHHOY3&psc=1&ref_=list_c_wl_lv_ov_lig_dp_it
solenoid_body_length = 21;
solenoid_body_width = 10;
solenoid_body_height = 11;
solenoid_back_stroke = 7;
solenoid_stroke = 4;
solenoid_shaft_length = 1.5 + solenoid_back_stroke + solenoid_body_length;
solenoid_shaft_diameter = 3;
// based on https://www.amazon.com/dp/B0831HYGND/?coliid=I37IDJ4KO44FXI&colid=MUOI8GUHHOY3&ref_=list_c_wl_lv_ov_lig_dp_it&th=1
carriage_motor_body_length = 25.1 + 11.55 + 2.1;
carriage_motor_body_width = 20.4;
carriage_motor_body_height = 15.4;
carriage_motor_shaft_length = 11.55 - 1.6;
carriage_motor_shaft_diameter = 3;
carriage_motor_overall_length = carriage_motor_body_length + carriage_motor_shaft_length;
