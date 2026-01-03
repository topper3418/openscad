use <../conical_band.scad>

module lug(
    bottom_interface_radius,
    wall_thickness
) {
    // two cones joined by a cylinder and cut by a smaller 
    // cylinder to make a ring, then cut the majority of 
    // it away to make a tiny cylindrical wedge
    lug_outer_radius = bottom_interface_radius + wall_thickness/3;
    intersection() {
        // lug intersection cut
        conical_band(
            lug_outer_radius, 
            bottom_interface_radius,
            wall_thickness
        );
        translate([0, 0, -wall_thickness/2])
        resize([
            lug_outer_radius+wall_thickness/2, 
            lug_outer_radius+wall_thickness/2, 
            wall_thickness
        ])
        rotate([0, 0, -45])
        cube();
    }
}
