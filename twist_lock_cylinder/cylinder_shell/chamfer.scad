module chamfer(
    radius,
    chamfer_side_length,
    knurling_height
) {
    // chamfer
    translate([0, 0, -0.01])
    difference () {
        cylinder(
            h=chamfer_side_length+knurling_height, 
            r=radius+knurling_height+0.01
        );
        translate([0, 0, -0.01])
        cylinder(
            h=chamfer_side_length + knurling_height + 0.02, 
            r1=radius-chamfer_side_length, 
            r2=radius+knurling_height+0.01
        );
    }
}
