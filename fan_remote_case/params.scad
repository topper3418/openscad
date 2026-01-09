single_piece_base = true;
base_thickness = 1.5;
base_width = 55;
base_length = 115 - 7 + 2;

case_thickness = 2.4;
case_base_height = 6;
case_top_height = 17;
case_height = case_base_height + case_top_height;

case_base_tolerance =
  single_piece_base ? -0.1
  : 0.15;
case_case_tolerance =
  single_piece_base ? -0.1
  : 0.2;
battery_cover_tolerance = 0.2;

case_width = base_width + 2 * case_thickness;
case_length = base_length + 2 * case_thickness;

bottom_shell_1_length = 40;
bottom_shell_2_length = (base_length + 2 * case_thickness) - bottom_shell_1_length;

clicker_diameter = 44;
clicker_offset_y = 83.5;

base_assembly_offset_z = let (
  tolerance_value = case_base_tolerance < 0 ? -0.1 : case_base_tolerance
) case_thickness + tolerance_value;

top_chamfer_size = 10;
bottom_chamfer_size = 8;

wall_mount_thickness = 3.5;
wall_mount_tolerance = 1;
