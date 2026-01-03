offset_x = -22;
offset_y = -31;
outside_width = 38;
outside_height = 15;
outside_depth = 15;
wall_thickness = 1.2;
cone_spring_rectangle_width = 10;
cone_spring_rectangle_height = 8;
cone_spring_slot_width = 1.5;
cone_spring_slot_offset_x = 1.5;
cone_spring_rectangle_offset_y = 3;
second_spring_slot_offset_x = 34;

module battery_case() {
	module inner() {
		translate([wall_thickness, wall_thickness, -0.1])
		resize([
			outside_width - 2*wall_thickness,
			outside_height - 2*wall_thickness,
			outside_depth - wall_thickness + 0.1
		])
			cube();
	}

	module cone_spring_slot() {
		translate([
			cone_spring_slot_offset_x, 
			cone_spring_rectangle_offset_y,
			-0.1
		])
			resize([
				wall_thickness,
				outside_height - wall_thickness + 0.1,
				outside_depth + 0.2
			])
				cube();
	}

	module cone_spring_rectangle() {
		translate([
		    cone_spring_slot_offset_x,
			cone_spring_rectangle_offset_y,
			-0.1
		])
		resize([
			cone_spring_rectangle_width,
			cone_spring_rectangle_height,
			outside_depth+0.2
		])
		cube();
	}

	module outer() {
		resize([
			outside_width,
			outside_height,
			outside_depth
		])
			cube();
	}
	difference() {
		outer();
		inner();
		cone_spring_slot();
		cone_spring_rectangle();
		translate([second_spring_slot_offset_x, 0, 0])
		cone_spring_slot();
	}
}

module offset_battery_case() {
	translate([offset_x, offset_y, 0])
		children();
}

module battery_case_cutout() {
	translate([wall_thickness, wall_thickness, -0.1])
	resize([
		outside_width - 2*wall_thickness,
		outside_height - 2*wall_thickness,
		outside_depth + 0.2
	])
	cube();
}
