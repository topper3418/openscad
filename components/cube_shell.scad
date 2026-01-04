module cube_shell(
  size = [10, 10, 10],
  wall_thickness = 1
) {
  !difference() {
    resize(size)
      cube();
    translate([wall_thickness, wall_thickness, wall_thickness])
      resize(
        [
          size[0] - 2 * wall_thickness,
          size[1] - 2 * wall_thickness,
          size[2],
        ]
      )
        cube();
  }
}
