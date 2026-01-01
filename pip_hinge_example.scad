use <components/pip_hinge.scad>


module hinge_example() {
	hinge(
		d=15, 
		l=70, 
		tol=0.25, 
		max_angle_1=90,
		angle=90
	);
}


hinge_example();
