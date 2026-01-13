// USER PARAMETERS

// containers
container_height = 50;
container_width = 150;
container_depth = 50;

// warehouse dimensions
units_high = 10;
units_wide = 5;
units_deep = 3;
container_lift_height = 5;
pillar_width = 4;

// crane dimensions
x_rail_height = 15;
y_rail_width = 15;

// CALC PARAMETERS
x_rail_length = units_wide * (container_width + pillar_width) + (y_rail_width + pillar_width) * 2;
y_rail_length = units_high * (container_height + container_lift_height) + x_rail_height * 2;

container_dimensions = [
  container_width,
  container_depth,
  container_height,
];
container_translate_widthwise = container_width + pillar_width;
container_translate_heightwise = container_height + container_lift_height;
container_translate_depthwise = container_depth + pillar_width;
