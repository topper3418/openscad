use <components/image_mold.scad>;

image_mold(
  // image
  image_name="OnePiece.svg",
  image_width=134,
  image_length=227,
  image_depth=2.5,
  image_offset_x=2,
  image_offset_y=2,
  // frame
  frame_width=2.5,
  // base
  base_thickness=1.5,
  // config
  negative_mold=false
);
