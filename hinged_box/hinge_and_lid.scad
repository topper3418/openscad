use <../components/pip_hinge.scad>

module lid(
    length=100, 
    width=100, 
    wall_thickness=5,
    lid_angle=45, // 180 being open, 0 being closed
    hinge_angle=45,
    tolerance=0.2
) {

    lid_length = length-2*(wall_thickness + tolerance);
    lid_width = width-2*wall_thickness -2*tolerance;

    // 0 angle is straight up, 90 is full open, -90 is full closed, on the hinge. 
    // we want 0 angle to be closed lid, and 180 angle to be open lid
    function hinge_angle_to_hinge_module_angle(lid_angle) = (lid_angle - 90);
    

    // for the lid body, we want it to be fully synchronized with the hinge. 
    // 90 is straight up, 0 is closed and 180 is fully open on the lid.



   module lid_body() {

     resize([lid_length, lid_width, wall_thickness])
       cube();
   }

   module integral_hinge() {
        rotate([0, 90, 0])
        hinge(
             d=wall_thickness,
             l=lid_length,
             tol=tolerance,
             max_angle_1=90,
             max_angle_2=90,
             angle=hinge_angle_to_hinge_module_angle(lid_angle)
         );
   }

     // chamfer to snip off the far corner
     module chamfer() {
         translate([-5, lid_width, wall_thickness / 2])
         rotate([45+180, 0, 0])
         resize([lid_length + 10, 20, wall_thickness])
            cube();
     }
     // rotate about the x axis to synchronize with the hinge
     rotate([lid_angle, 0, 0])
     // move to intersect with the hinge but not interfere with the hinge    
     translate([0, wall_thickness/2 + tolerance, -wall_thickness/2])
     difference() {
       lid_body();

       chamfer();

       // thumb hole in the center of the lid
         translate([lid_length/2, lid_width/2, -1])
             cylinder(h=wall_thickness + 2, r=lid_width/8);

     }
       integral_hinge();
}

lid(
    length=120, 
    width=80, 
    wall_thickness=4, 
    lid_angle=0
);
