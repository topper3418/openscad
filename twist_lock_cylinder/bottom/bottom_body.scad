use <../cylinder_shell/cylinder_shell_body.scad>
use <../../components/ring.scad>
use <lug.scad>

module bottom(
    height,
    diameter,
    wall_thickness,
    chamfer_ratio,
    knurling_height,
    split_ratio,
    interface_height,
    num_lugs,
    tolerance
) {
    radius = diameter / 2;
    bottom_height = height*split_ratio + wall_thickness - tolerance;
    bottom_interface_radius = radius - wall_thickness*(2/3) - tolerance;
    // main body
    difference() {
        cylinder_shell(
            bottom_height,
            wall_thickness,
            chamfer_ratio,
            knurling_height,
            diameter
        );
        translate([0, 0, bottom_height - interface_height - tolerance])
        ring(
            interface_height + tolerance + 0.01,
            radius+0.1,
            bottom_interface_radius
        );
    }
    // lugs for locking
    translate([0, 0, bottom_height - interface_height/2 - tolerance])
    union() {
        for (i = [0 : num_lugs - 1]) {
            rotate([0, 0, i * 360 / num_lugs])
            lug(
                bottom_interface_radius,
                wall_thickness
            );
        }
    }
}
