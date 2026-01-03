use <../conical_band.scad>

module slot(
    height,
    diameter,
    wall_thickness,
    chamfer_ratio,
    knurling_height,
    split_ratio,
    interface_height,
    num_lugs,
    tolerance,
    radius,
    top_height,
    top_interface_radius,
    rotate_angle,
) {
    slot_outer_radius = top_interface_radius + wall_thickness/3 + tolerance;
    // reusable helper for groove limits
    module groove_intersection_half() {
        rotate([0, 0, rotate_angle/2])
        translate([0, 0, -wall_thickness/2])
        cube([slot_outer_radius, slot_outer_radius, wall_thickness]);
    }
    // reusable helper for groove blank
    module groove_blank(groove_height) {
        rotate([0, 0, rotate_angle/2])
        resize([
            slot_outer_radius+wall_thickness/2 + tolerance, 
            slot_outer_radius+wall_thickness/2 + tolerance, 
            groove_height
        ])
        rotate([0, 0, 45])
        cube();
    }
    // groove cutout
    intersection() {
        conical_band(
            slot_outer_radius, 
            top_interface_radius,
            wall_thickness
        );
        groove_intersection_half();
        mirror([1, 0, 0])
        groove_intersection_half();
    }
    // slot cutout
    translate([0, 0, -wall_thickness/2])
    intersection() {
        // outer cylinder
        cylinder(
            h=interface_height,
            r=slot_outer_radius
        );
        // slot for linear insert
        difference() {
            // actual groove
            groove_blank(interface_height);
            difference() {
                // start with a shorter groove blank
                groove_blank(wall_thickness/2);
                // cut out the band
                translate([0, 0, wall_thickness/2])
                conical_band(
                    slot_outer_radius, 
                    top_interface_radius,
                    wall_thickness
                );
                // cut out the cylinder in the middle
                translate([0, 0, -0.01])
                cylinder(h=wall_thickness/2 + 0.02, r=top_interface_radius);
            }
        }
    }
}
