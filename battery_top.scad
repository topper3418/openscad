// helpers
function inches(x) = x * 25.4;

// battery dimensions
battery_length = inches(12.76);
battery_width = inches(8.86);
large_bump_length = inches(12);
large_bump_width = inches(4.25);
small_bump_length = inches(7.5);
small_bump_width = inches(3);
cap_height = inches(1);
terminal_offset_x = inches(1.5);
terminal_offset_y = inches(2);
terminal_dim_x = inches(0.3);
terminal_dim_y = inches(1);

// config dimensions
thickness = 5; // wall thickness

// calc dimensions
large_bump_widthwise_offset = battery_width - large_bump_width - inches(0.5);
small_bump_widthwise_offset = large_bump_widthwise_offset - small_bump_width;
outer_dimensions = [
  battery_length + 2 * thickness,
  battery_width + 2 * thickness,
  cap_height + thickness,
];

module base_plate() {
  resize([battery_length, battery_width, cap_height])
    cube();
}

module large_bump() {
  lengthwise_offset = (battery_length - large_bump_length) / 2;
  translate([lengthwise_offset, large_bump_widthwise_offset, cap_height - 0.01])
    resize([large_bump_length, large_bump_width, cap_height + 0.01])
      cube();
}

module small_bump() {
  lengthwise_offset = (battery_length - small_bump_length) / 2;
  translate([lengthwise_offset, small_bump_widthwise_offset, cap_height - 0.01])
    resize([small_bump_length, small_bump_width, cap_height + 0.01])
      cube();
}

module battery_cap_blank() {
  base_plate();
  large_bump();
  small_bump();
}

module terminal_blank() {
  resize([terminal_dim_x, terminal_dim_y, cap_height * 2])
    cube();
}

module battery_cap() {
  right_terminal_translation = battery_length + 2 * thickness - terminal_offset_x - terminal_dim_x;
  translate([-outer_dimensions[0] / 2, -outer_dimensions[1] / 2, 0])
    difference() {
      resize(outer_dimensions) battery_cap_blank();
      union() {
        translate([thickness, thickness, -0.01])
          resize([battery_length, battery_width, cap_height + 0.01])
            battery_cap_blank();
        translate([terminal_offset_x, terminal_offset_y, 0])
          terminal_blank();
        translate([right_terminal_translation, terminal_offset_y, 0])
          terminal_blank();
      }
    }
}

module halving_blank() {
  translate([0, -outer_dimensions[1] / 2 - 1, -1])
    resize([battery_length + 3 * thickness, battery_width + 3 * thickness, cap_height + 2 * thickness])
      cube();
}

module battery_cap_left() {
  difference() {
    battery_cap();
    halving_blank();
  }
}

module battery_cap_right() {
  difference() {
    battery_cap();
    mirror([1, 0, 0])
      halving_blank();
  }
}

battery_cap_left();
*battery_cap_right();
