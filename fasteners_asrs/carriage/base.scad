include <params.scad>

module carriage_base() {
  cube(
    [
      container_dimensions.x,
      container_dimensions.y,
      carriage_base_thickness,
    ]
  );
}
