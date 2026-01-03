module pull_tab(
    length,
    wall_thickness,
    lid_length,
    lid_height,
    slide_tolerance
) {
    tab_length = length/2;
    tab_width = wall_thickness * 2;
    translate([
        lid_length/2 - tab_length/2,
        wall_thickness,
        lid_height * 1.75 - slide_tolerance + 0.01,
    ])
    mirror([0, 0, 1])
    union() {
        resize([
            tab_length,
            tab_width,
            wall_thickness,
        ])
            cube();
        translate([
            0,
            tab_width,
            wall_thickness
        ])
            rotate([30 + 180, 0, 0])
                resize([
                    tab_length,
                    wall_thickness,
                    wall_thickness * 1.5,
                ])
                    cube();
    }
}
