include <../params.scad>

module base_cutout(second_side, length) {
  base_cutout_width = base_thickness + case_base_tolerance * 2;
  translate(
    [
      second_side ? base_width + case_thickness : case_thickness,
      case_thickness,
      case_thickness,
    ]
  )
    resize(
      [
        base_cutout_width,
        length,
        base_cutout_width,
      ]
    )
      rotate([0, 45 - 90, 0])
        cube();
}
