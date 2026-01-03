module slider(
    lid_height,
    lid_width,
) {
    // triangle thing is going to have a diagonal of wall_thickness, 
    // so wall thickness needs to be sqrt(2)*side_length
    side_length = lid_height / sqrt(2);
    translate([
        -lid_height/2,
        0,
        lid_height/2,
    ])
    rotate([0,45,0])
    resize([
      side_length,
      lid_width,
      side_length
    ])
    cube();
}
