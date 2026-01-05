
module open_top_shell(thickness, child_dimensions) {
  difference() {
    children();
    translate([thickness, thickness, thickness + 0.01])
      resize(
        [
          child_dimensions[0] - 2 * thickness,
          child_dimensions[1] - 2 * thickness,
          child_dimensions[2],
        ]
      )
        children();
  }
}
