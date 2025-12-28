use <components/pip_hinge.scad>


module hinge_example() {
	full_close_hinge(
		d=15, 
		l=70, 
		tol=0.375, 
		max_open_angle=90,
		angle=0
	);
}


hinge_example();
