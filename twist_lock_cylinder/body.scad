use <../helpers/units.scad>
use <../components/ring.scad>
use <cylinder_shell/cylinder_shell_body.scad>
use <conical_band.scad>

module twist_lock_cylinder(
    diameter=50,
    height=35,
    wall_thickness=3,
    split_ratio=0.5,
    tolerance=0.2,
    num_lugs=4,
    chamfer_ratio=0.2,
    knurling_height=1.5
) {
    // chamfer ratio cannot be above 0.5 or below 0
    assert(chamfer_ratio <= 0.5, "chamfer radius cannot be above 0.5");
    assert(chamfer_ratio >= 0, "chamfer radius cannot be below 0");
    $fn=100;
    $fa=.1;
    radius = diameter/2;
    interface_height = wall_thickness*4;


    module bottom() {
        bottom_height = height*split_ratio + wall_thickness - tolerance;
        bottom_interface_radius = radius - wall_thickness*(2/3) - tolerance;
        module nub() {
            // two cones joined by a cylinder and cut by a smaller 
            // cylinder to make a ring, then cut the majority of 
            // it away to make a tiny cylindrical wedge
            nub_outer_radius = bottom_interface_radius + wall_thickness/3;
            intersection() {
                // nub intersection cut
                conical_band(
                    nub_outer_radius, 
                    bottom_interface_radius,
                    wall_thickness
                );
                translate([0, 0, -wall_thickness/2])
                resize([
                    nub_outer_radius+wall_thickness/2, 
                    nub_outer_radius+wall_thickness/2, 
                    wall_thickness
                ])
                rotate([0, 0, -45])
                cube();
            }
        }
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
        // nubes for locking
        translate([0, 0, bottom_height - interface_height/2 - tolerance])
        union() {
            for (i = [0 : num_lugs - 1]) {
                rotate([0, 0, i * 360 / num_lugs])
                nub();
            }
        }
    }
    module top() {
        top_height = height*(1 - split_ratio) + wall_thickness;
        top_interface_radius = radius - wall_thickness*(2/3);
        rotate_angle = 180 / num_lugs;
        module slot() {
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
        rotate([0, 0, -rotate_angle/2])
        difference() {
            cylinder_shell(
                top_height,
                wall_thickness,
                chamfer_ratio,
                knurling_height,
                diameter
            );
            translate([0, 0, top_height - interface_height])
            ring(
                interface_height + 0.01,
                top_interface_radius,
                radius - wall_thickness - 0.01
            );
            translate([0, 0, top_height - interface_height/2])
            for (i = [0 : num_lugs - 1]) {
                rotate([0, 0, i * 360 / num_lugs])
                render() slot();
            }
        }
    }

    bottom();
    translate([diameter*1.125, 0, 0])
        top();

}

twist_lock_cylinder(
    diameter=inches(4.5),
    height=inches(8)
);
//twist_lock_cylinder(
//    diameter=inches(1.5),
//    height=inches(1.5)
//);
