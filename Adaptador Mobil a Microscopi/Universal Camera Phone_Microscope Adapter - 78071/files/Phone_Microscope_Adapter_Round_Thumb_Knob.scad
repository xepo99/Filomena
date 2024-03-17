
//Round Thumb Knob
translate([0,0,5])rotate([180,0,0]){
	difference(){
		linear_extrude(height=5)circle(7);
		linear_extrude(height=3)circle(3.4);
		cylinder(10,1.75,1.75);
	}
}