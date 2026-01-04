use <../../components/cube_shell.scad>
use <../base/pass_through.scad>
use <../base/translate_base.scad>
use <../translate_base_to_position.scad>
include <../params.scad>
include <top_wall_knockout.scad>
include <base_cutout.scad>
include <battery_cover.scad>

module sliding_shell(length) {
  difference() {
    cube_shell(
      [
        case_width,
        length,
        case_base_height,
      ], case_thickness
    );
    top_wall_knockout(length);
    base_cutout(second_side=false, length=length);
    base_cutout(second_side=true, length=length);
  }
}
