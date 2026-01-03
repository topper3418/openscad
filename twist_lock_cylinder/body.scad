use <../helpers/units.scad>
use <../components/ring.scad>
use <cylinder_shell/cylinder_shell_body.scad>
use <conical_band.scad>
use <bottom/bottom_body.scad>
use <top/top_body.scad>

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


    bottom(
        height,
        diameter,
        wall_thickness,
        chamfer_ratio,
        knurling_height,
        split_ratio,
        interface_height,
        num_lugs,
        tolerance
    );
    translate([diameter*1.125, 0, 0])
        top(
            height,
            diameter,
            wall_thickness,
            chamfer_ratio,
            knurling_height,
            split_ratio,
            interface_height,
            num_lugs,
            tolerance
        );

}

//twist_lock_cylinder(
//    diameter=inches(4.5),
//    height=inches(8)
//);
twist_lock_cylinder(
    diameter=inches(1.5),
    height=inches(1.5)
);
