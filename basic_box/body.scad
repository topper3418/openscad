use <../helpers/units.scad>
// this will be a basic box with a sliding lid
module basic_box(
    length=100,
    width=50,
    height=50,
    wall_thickness=3,
    slide_tolerance=0.5,
    print_mode=false,
) {
   module lid_body(blank_only=false) {
        lid_height = blank_only ? 
            wall_thickness+2*slide_tolerance : 
            wall_thickness;
        lid_width = blank_only ? 
            width-wall_thickness/2 : 
            width - slide_tolerance - wall_thickness;
        lid_length = blank_only ? 
            length - 2*wall_thickness : 
            length - 2*(wall_thickness + slide_tolerance);
        // lid slides in the positive y direction to close
        module lid_blank() {
            resize([
              lid_length,
              lid_width,
              blank_only ? lid_height * 2 : lid_height * 1.75 - slide_tolerance
            ])
            cube();
        }
        module triangle_thing() {
            // triangle thing is going to have a diagonal of wall_thickness, 
            // so wall thickness needs to be sqrt(2)*side_length
            side_length = lid_height / sqrt(2);
            translate([
                -lid_height/2,
                0,
                lid_height/2,
            ])
            rotate([0,45,0])
            resize([
              side_length,
              lid_width,
              side_length
            ])
            cube();
        }
        module pull_tab() {
            tab_length = length/2;
            tab_width = wall_thickness * 2;
            translate([
                lid_length/2 - tab_length/2,
                wall_thickness,
                lid_height * 1.75 - slide_tolerance + 0.01,
            ])
            mirror([0, 0, 1])
            union() {
                resize([
                    tab_length,
                    tab_width,
                    wall_thickness,
                ])
                    cube();
                translate([
                    0,
                    tab_width,
                    wall_thickness
                ])
                    rotate([30 + 180, 0, 0])
                        resize([
                            tab_length,
                            wall_thickness,
                            wall_thickness * 1.5,
                        ])
                            cube();
            }
        }
        difference() {
            union() {
                lid_blank();
                translate([lid_length, 0, 0])
                    triangle_thing();
                triangle_thing();
                triangle_thing();
            }
            if (!blank_only)
                pull_tab();

        }
   }

    module box_body() {
       module outer_blank() resize([length, width, height]) cube();
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
               lid_body(true);
       }
    }
    module translate_lid_to_slot() {
        // move up into the lid slot
        translate([
            wall_thickness + slide_tolerance, 
            0, 
            height - wall_thickness*1.75 + slide_tolerance
        ])
        children();
    }

    module translate_lid_for_print() {
        translate([0, -width*1.125, 0])
        children();
    }
    
    box_body();
    if (print_mode)
        translate_lid_for_print()
            lid_body();
    else
        translate_lid_to_slot()
            lid_body();
}

basic_box(
    length=inches(7.5),
    width=inches(3.5),
    height=inches(2.5),
    wall_thickness=2,
    slide_tolerance=0.15,
    print_mode=true
);

