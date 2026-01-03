module lid_blank(
    lid_length,
    lid_width,
    blank_only,
    lid_height, 
    slide_tolerance
) {
    resize([
      lid_length,
      lid_width,
      blank_only ? lid_height * 2 : lid_height * 1.75 - slide_tolerance
    ])
    cube();
}
