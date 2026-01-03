use <lid_pull_tab.scad>
use <lid_slider.scad>
use <lid_blank.scad>

module lid_body(
   blank_only=false,
   wall_thickness=3,
   slide_tolerance=0.5,
   width=100,
   length=100
) {
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
    difference() {
        union() {
            lid_blank(
                lid_length,
                lid_width,
                blank_only,
                lid_height, 
                slide_tolerance
            );
            translate([lid_length, 0, 0])
                slider(
                    lid_height,
                    lid_width
                );
            slider(
                lid_height,
                lid_width
            );
        }
        if (!blank_only)
            pull_tab(
                length,
                wall_thickness,
                lid_length,
                lid_height,
                slide_tolerance
            );

    }
}
