include <params.scad>

module x_rail() {
  translate([0, -container_depth / 4, 0])
    cube([x_rail_length, container_depth / 2, x_rail_height]);
}

module translate_second_x_rail() {
  translate([0, 0, y_rail_length - x_rail_height])
    children();
}

module x_rails() {
  x_rail();
  translate_second_x_rail()
    x_rail();
}

module y_rail() {
  translate([0, -container_depth / 4, 0])
    cube([y_rail_width, container_depth / 2, y_rail_length]);
}
