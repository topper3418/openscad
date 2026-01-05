include <params.scad>

module chamfer_block(cutting = false) {
  z = cutting ? case_base_height + 0.2 : case_thickness + 0.1;
}

module chamfer(size, height) {
  difference() {
    resize([size, size, height])
      cube();
    translate([0, size, -0.1])
      rotate([0, 0, -45])
        resize([size * 2, size * 2, height + 0.2])
          cube();
  }
}

module cut_off_chamfers(height) {
  difference() {
    children();
    translate([0, 0, -0.1])
      union() {
        translate([-0.1, -0.1, 0])
          chamfer(bottom_chamfer_size, height + 0.2);
        translate([-0.1, case_length + 0.1, 0])
          rotate([0, 0, -90])
            chamfer(top_chamfer_size, height + 0.2);
        translate([case_width + 0.1, -0.1, 0])
          rotate([0, 0, 90])
            chamfer(bottom_chamfer_size, height + 0.2);
        translate([case_width + 0.1, case_length + 0.1, 0])
          rotate([0, 0, 180])
            chamfer(top_chamfer_size, height + 0.2);
      }
  }
}
