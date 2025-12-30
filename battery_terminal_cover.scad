// res config
$fa = 1;
$fs = 0.01;

// users params
terminal_width = 4;
terminal_length = 15;
terminal_height = 20;
detent_center_height = 10;
detent_diameter = 2.5;
thickness = 3;
detent_gap = 1.5;


module detent() {
    translate([terminal_width/2 + detent_gap/2, 0, detent_center_height])
        resize([(terminal_width), detent_diameter*2, detent_diameter*2])
            sphere();
}

terminal_resize = [terminal_width + 0.1, terminal_length, terminal_height];
outer_shell_resize = [
    terminal_width + 2*thickness,
    terminal_length + 2*thickness,
    terminal_height + thickness
];

detent();
mirror([1,0,0])
    detent();
translate([ -outer_shell_resize[0]/2, -outer_shell_resize[1]/2, 0])
    difference() {
        resize(outer_shell_resize)
            cube();
        translate([thickness, thickness, -0.1])
            resize(terminal_resize)
                cube();
    }
