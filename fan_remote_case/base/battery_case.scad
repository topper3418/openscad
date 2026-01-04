include <base_params.scad>

offset_x = -22 - 0.75;
outside_depth = 13;
wall_thickness = 1;
outside_height = 11.5 + 2 * wall_thickness + 1.5;
offset_y = base_plate_offset_y;

cone_spring_rectangle_width = 10;
cone_spring_rectangle_height = 8;
cone_spring_slot_width = 1.5;
cone_spring_slot_offset_x = 1.5;
cone_spring_rectangle_offset_y = 3;
second_spring_slot_offset_x = 35;
outside_width = second_spring_slot_offset_x + cone_spring_slot_width + wall_thickness + cone_spring_slot_width;

module battery_case() {

  module outer() {
    resize(
      [
        outside_width,
        outside_height,
        outside_depth,
      ]
    )
      cube();
  }

  module inner() {
    translate([wall_thickness, wall_thickness, -0.1])
      resize(
        [
          outside_width - 2 * wall_thickness,
          outside_height - 2 * wall_thickness,
          outside_depth - wall_thickness + 0.1,
        ]
      )
        cube();
  }

  module cone_spring_slot() {
    translate(
      [
        cone_spring_slot_offset_x,
        cone_spring_rectangle_offset_y,
        -0.1,
      ]
    )
      resize(
        [
          wall_thickness,
          outside_height - wall_thickness + 0.1,
          outside_depth + 0.2,
        ]
      )
        cube();
  }

  module cone_spring_rectangle() {
    translate(
      [
        cone_spring_slot_offset_x,
        cone_spring_rectangle_offset_y,
        -0.1,
      ]
    )
      resize(
        [
          cone_spring_rectangle_width,
          cone_spring_rectangle_height,
          outside_depth + 0.2,
        ]
      )
        cube();
  }
  // put the top of it at x=0
  translate([0, -outside_height, 0])
    difference() {
      outer();
      inner();
      cone_spring_slot();
      cone_spring_rectangle();
      translate([second_spring_slot_offset_x, 0, 0])
        cone_spring_slot();
    }
}

module offset_battery_case() {
  translate([offset_x, offset_y + outside_height, 0])
    children();
}

module battery_case_cutout() {
  translate([0, -outside_height, 0])
    translate([wall_thickness, wall_thickness, -0.1])
      resize(
        [
          outside_width - 2 * wall_thickness,
          outside_height - 2 * wall_thickness,
          outside_depth + 0.2,
        ]
      )
        cube();
}
