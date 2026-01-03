use <../helpers/units.scad>
use <lid/lid_body.scad>
use <box/box_body.scad>

// this will be a basic box with a sliding lid
module basic_box(
    length=100,
    width=50,
    height=50,
    wall_thickness=3,
    slide_tolerance=0.5,
    print_mode=false,
) {

    module translate_lid_to_slot() {
        // move up into the lid slot
        translate([
            wall_thickness + slide_tolerance, 
            0, 
            height - wall_thickness*1.75 + slide_tolerance
        ])
        children();
    }

    module translate_lid_for_print_widthwise() {
        translate([0, -width, 0])
        children();
    }

    module translate_lid_for_print_lengthwise() {
        translate([-length+10, 0, 0])
        children();
    }
    
    box_body(
        length,
        width,
        height, 
        wall_thickness,
        slide_tolerance
    );

    if (print_mode)
        if (width < length)
            translate_lid_for_print_widthwise()
               lid_body(
                   blank_only=false,
                   wall_thickness=wall_thickness,
                   slide_tolerance=slide_tolerance,
                   width=width,
                   length=length
               );
        else
            translate_lid_for_print_lengthwise()
               lid_body(
                   blank_only=false,
                   wall_thickness=wall_thickness,
                   slide_tolerance=slide_tolerance,
                   width=width,
                   length=length
               );
    else
        translate_lid_to_slot()
           lid_body(
               blank_only=false,
               wall_thickness=wall_thickness,
               slide_tolerance=slide_tolerance,
               width=width,
               length=length
           );
}

