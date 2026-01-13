// overlap to ensure proper union
ovl = 0.01;

// module
module image_mold(
  // USER PARAMETERS

  // image
  image_name = "../assets/OnePiece.svg",
  image_width = 134,
  image_length = 227,
  image_depth = 2.5,
  image_offset_x = 2,
  image_offset_y = 2,
  // frame
  frame_width = 2.5,
  // base
  base_thickness = 1.5,
  // config
  negative_mold = false
) {

  // BUILDING BLOCKS

  // calculated dimensions
  base_width = image_width + 2 * frame_width;
  base_length = image_length + 2 * frame_width;
  base_dims = [base_width, base_length, base_thickness];

  // translations
  module to_top_of_base() {
    translate([0, 0, base_thickness])
      children();
  }
  module bump_for_overlap(reversed = false) {
    translate([0, 0, reversed ? ovl : -ovl])
      children();
  }
  module translate_for_frame() {
    translate([frame_width, frame_width, 0])
      children();
  }
  module translate_for_image() {
    translate([image_offset_x, image_offset_y, 0])
      children();
  }

  // base
  module base() {
    cube(base_dims);
  }

  // frame
  module frame() {
    module outer_frame() {
      frame_outer_dims = [base_dims.x, base_dims.y, image_depth];
      cube(frame_outer_dims);
    }
    module inner_frame() {
      frame_inner_dims = [image_width, image_length, image_depth + 2 * ovl];
      cube(frame_inner_dims);
    }
    difference() {
      outer_frame();
      bump_for_overlap()
        translate_for_frame()
          inner_frame();
    }
  }

  // image
  module image() {
    image_path = str("../assets/", image_name);
    linear_extrude(height=image_depth + ovl)
      import(image_path);
  }

  // ASSEMBLY

  if (!negative_mold) {
    // framed model
    bump_for_overlap()
      to_top_of_base()
        frame();
    base();
    bump_for_overlap()
      to_top_of_base()
        translate_for_frame()
          translate_for_image()
            image();
  } else {
    // negative mold
    difference() {
      union() {
        base();
        bump_for_overlap()
          to_top_of_base()
            base();
      }
      bump_for_overlap(reversed=true)
        to_top_of_base()
          translate_for_frame()
            translate_for_image()
              image();
    }
  }
}
