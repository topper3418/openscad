include <../params.scad>

module top_wall_knockout(length) {
  translate(
    [
      case_thickness,
      length - case_thickness - 0.1,
      case_thickness,
    ]
  )
    resize(
      [
        base_width,
        case_thickness + 0.2,
        case_base_height,
      ]
    )
      cube();
}
