module conical_band(
    outer_radius, 
    inner_radius,
    wall_thickness
) {
    difference() {
        union() {
            // top cone
            cylinder(
                h=wall_thickness/2,
                r1=outer_radius,
                r2=inner_radius-0.01
            );
            // bottom cone
            mirror([0,0,1])
            cylinder(
                h=wall_thickness/2,
                r1=outer_radius,
                r2=inner_radius-0.01
            );
            // joining cylinder
            cylinder(
                h=0.02,
                r=outer_radius,
                center=true
            );
        }
        // cutting cylinder
        cylinder(
            h=wall_thickness + 0.02,
            r=inner_radius-0.01,
            center=true
        );
    }
}
