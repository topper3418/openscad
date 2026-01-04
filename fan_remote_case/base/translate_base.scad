include <../params.scad>
include <base_params.scad>

module translate_base() {
  translate([base_width / 2, -base_plate_offset_y, 0])
    children();
}
