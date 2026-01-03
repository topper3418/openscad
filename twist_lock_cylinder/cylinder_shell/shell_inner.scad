module shell_inner(
    radius,
    wall_thickness,
    shell_height
) {
    translate([0, 0, wall_thickness])
    cylinder(
        h=shell_height-wall_thickness+0.01,
        r=radius-wall_thickness
    );
}
