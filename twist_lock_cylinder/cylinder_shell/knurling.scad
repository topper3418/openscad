use <chamfer.scad>

module knurling(
    radius,
    wall_thickness,
    knurling_height,
    knurl_instances,
    knurl_degrees,
    chamfer_side_length
) {
    knurl_z = wall_thickness*2;
    module knurl() {
        // grip
        translate([0, -knurling_height, 0]) // center on Z axis
        resize([
            knurling_height*2, 
            knurling_height*2, 
            knurl_z
        ])  // resize to be the knurling height/2
        rotate([0, 0, 45])  // rotate 45 to put the pointy end out
        cube();
        // add a cube body
        translate([
            -knurling_height,
            -knurling_height*2,
            0
        ])
        resize([
            knurling_height*2, 
            knurling_height*2, 
            knurl_z
        ])  // resize to be the knurling height/2
        cube();
    }
    // knurl_chamfer_translation
    kct = [0, 0, -knurl_z/2];
    difference() {
        union() {
            for (i = [0 : knurl_instances-1 ]) {
                rotate([0, 0, i*knurl_degrees])
                translate([0, radius, 0])
                knurl();
            }
        }
        // translate back
        translate(-kct)
        // mirror
        mirror([0,0,1])
        //translate down to mirror
        translate(kct)
        chamfer(
            radius,
            chamfer_side_length,
            knurling_height
        );
    }
}
