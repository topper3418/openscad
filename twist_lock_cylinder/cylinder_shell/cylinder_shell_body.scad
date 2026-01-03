use <shell_inner.scad>
use <shell_outer.scad>
use <chamfer.scad>
use <knurling.scad>

module cylinder_shell(
    shell_height,
    wall_thickness,
    chamfer_ratio,
    knurling_height,
    diameter
) {
    chamfer_side_length = wall_thickness*chamfer_ratio;
    radius = diameter/2;
    // each knurl will have width of approx. knurling height * 2
    // therefore it takes up 2knurling_height/(pi*radius^2) radians of
    // the outer shell
    knurl_width = knurling_height * 2;           // from your comment
    circumference = PI * diameter;               // or 2 * PI * radius
    angle_degrees = (knurl_width / circumference) * 360;
    knurl_instances = floor(180/angle_degrees);
    knurl_degrees = 360/knurl_instances;

    // body
    difference() {
        union() {
            shell_outer(
                radius,
                shell_height
            );
            translate([0, 0, chamfer_side_length])
            knurling(
                radius,
                wall_thickness,
                knurling_height,
                knurl_instances,
                knurl_degrees,
                chamfer_side_length
            );
        }
        shell_inner(
            radius,
            wall_thickness,
            shell_height
        );
        chamfer(
            radius,
            chamfer_side_length,
            knurling_height
        );
    }
}
