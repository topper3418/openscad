use <hinge_and_lid.scad>

// res config
$fa = 1;
$fs = 0.05;

module box(
    length=100, 
    width=100, 
    height=100,
    wall_thickness=5,
    lid_angle=45, // 180 being open, 0 being closed
    hinge_angle=45,
    tolerance=0.3
) {

    lid_length = length-2*(wall_thickness + tolerance);
    lid_width = width-2*wall_thickness -2*tolerance;
    
   module box_body() {
       module outer_blank() resize([length, width, height]) cube();
       module inner_blank() cube([
           length - 2*wall_thickness, 
           width - 2*wall_thickness, 
           height - wall_thickness+0.01
       ]);
       module hinge_cutout() {
            module hinge_side_attacher() {
                translate([-tolerance/2, -0.1, -0.1])
                    translate([-lid_length/2-tolerance, 0, 0])
                        resize([3*tolerance, wall_thickness+0.2, wall_thickness+0.1])
                            cube();
            }
            module hinge_side_attachers() {
            translate([lid_length/2+tolerance, 0.1, 0])
                    union() {
                        hinge_side_attacher();
                        mirror([1,0,0])
                            hinge_side_attacher();
                    }

            }
            translate([wall_thickness, -0.1, height-2*wall_thickness])
                difference() {
                    resize([
                        length -2*wall_thickness, 
                        wall_thickness+0.2, 
                        2*wall_thickness+0.1
                    ])
                    cube();
                    hinge_side_attachers();
                }
       }
       difference() {
           outer_blank();
           union() {
               hinge_cutout();
               translate([wall_thickness, wall_thickness, wall_thickness+0.01])
                   inner_blank();
           }
       }
   }

   box_body();
   // move up into the hinge cutout
   translate([wall_thickness+tolerance, wall_thickness/2, height - (wall_thickness/2)])
   lid(
       length=length, 
       width=width, 
       wall_thickness=wall_thickness,
       lid_angle=lid_angle
   );
}

box(
    height=30, 
    length=60, 
    width=40, 
    wall_thickness=3, 
    lid_angle=180
);
