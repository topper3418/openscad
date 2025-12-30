// res config
$fa = 1;
$fs = 0.05;

// helpers
function inches(x) = x * 25.4;

// parameterization
// body
OD=inches(5);
ID=inches(0.55);
base_height=inches(0.25);
mound_height=inches(0.25);
total_height=base_height+mound_height;
tol=0.5;
// screws
thread_od=inches(1/4);
head_od=inches(1/2);

// screw holes
module anchor_void() {
    translate([0,0,-0.01])
        cylinder(h=base_height+0.02, r=thread_od/2);
    translate([0,0,base_height])
        cylinder(h=20, r=head_od/2);
}
module circular_pattern(r, instances) {
    for(i = [0 : instances-1]) {
        angle = i * 360 / instances;
        rotate([0, 0, angle])
            translate([r, 0, 0])
                children(0);
    }
}

// base body
module body() {
    difference() {
        union() {
            cylinder(
                h=base_height+0.001, 
                r=OD/2
            );
            translate([0,0,base_height])
                resize([OD, OD, mound_height*2])
                    sphere();
        }
        union() {
            circular_pattern(r=inches(1.5), instances=3)
                anchor_void();
            translate([0,0,-0.01])
                cylinder(h=base_height+mound_height+0.02, r=ID/2);
        }
    }
}

// subtraction feature
module subtractor(tolerance=0) {
    width = OD/2;
    union() {
        // bottom part
        translate([-(width + tolerance),-OD/2,-0.01])
            resize([width, OD, (base_height*0.66)+0.01 - tolerance])
                cube();
        // top part
        translate([-(width + tolerance)/2, 0, (total_height/2)-0.01])
            resize([(OD/2) + 0.01, ID - tolerance, total_height+0.02])
                cube(center=true);
    }
}

// components
module top_plate() {
    difference() {
        body();
        subtractor();
    }
}

module bottom_plate() {
    intersection() {
        body();
        subtractor(tolerance=tol);
    }
}

module main() {
    * top_plate();
    bottom_plate();
}

main();
