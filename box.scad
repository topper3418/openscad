use <components/pip_hinge.scad>

module box(
    length=100, 
    width=100, 
    height=100,
    wall_thickness=5,
    lid_angle=45, // 180 being open, 0 being closed
    hinge_angle=45,
    tolerance=0.2
) {

    lid_length = length-2*wall_thickness -2*tolerance;
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

   module lid_body() {
     resize([lid_length, lid_width, wall_thickness])
       cube();
   }

   module integral_hinge() {
        translate([0, wall_thickness/2, 0])
        rotate([0, 90, 0])
        hinge(
             d=wall_thickness,
             l=lid_length,
             tol=tolerance,
             max_angle_1=lid_angle,
             max_angle_2=hinge_angle,
             angle=lid_angle+90
         );
   }

   box_body();
   *translate([wall_thickness,wall_thickness,height - wall_thickness + tolerance])
       lid_body();
   translate([wall_thickness+tolerance, 0, height-wall_thickness/2])
       integral_hinge();
}

box(height=60, length=120, width=80, wall_thickness=4, lid_angle=180);
