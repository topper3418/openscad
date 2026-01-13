include <params.scad>
use <container.scad>

module array_widthwise() {
  for (i = [0:units_wide - 1]) {
    translate([i * container_translate_widthwise, 0, 0])
      children();
  }
}

module array_heightwise() {
  for (j = [0:units_high - 1]) {
    translate([0, 0, j * container_translate_heightwise])
      children();
  }
}

module array_depthwise() {
  for (k = [0:units_deep - 1]) {
    translate([0, k * container_translate_depthwise, 0])
      children();
  }
}

module asrs_module() {
  array_widthwise()
    array_depthwise()
      array_heightwise()
        container();
}

module translate_asrs_module() {
  translate(
    [
      y_rail_width + pillar_width,
      pillar_width + container_depth / 2,
      x_rail_height,
    ]
  )
    children();
}

module warehouse() {
  translate_asrs_module()
    asrs_module();
  mirror([0, 1, 0])
    translate_asrs_module()
      asrs_module();
}
