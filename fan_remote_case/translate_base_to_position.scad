include <params.scad>

module translate_base_to_position() {
  translate(
    [
      case_thickness,
      case_thickness,
      base_assembly_offset_z,
    ]
  )
    children();
}
