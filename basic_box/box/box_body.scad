use <../lid/lid_body.scad>

module box_body(
    length,
    width,
    height, 
    wall_thickness,
    slide_tolerance
) {

   module outer_blank() resize(
       [length, width, height]
   ) cube();

   module inner_blank() cube([
       length - 2*wall_thickness, 
       width - 2*wall_thickness, 
       height - wall_thickness+0.01
   ]);

    difference() {
       outer_blank();
       translate([wall_thickness, wall_thickness, wall_thickness+0.01])
           inner_blank();
       translate([wall_thickness, -wall_thickness/2, height - 1.75*wall_thickness])
           lid_body(
               blank_only=true,
               wall_thickness=wall_thickness,
               slide_tolerance=slide_tolerance,
               width=width,
               length=length
           );
   }
}
