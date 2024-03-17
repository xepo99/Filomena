
//Phone Microscope Adapter Body

module triangle_support(){
linear_extrude(height=2)polygon([[0,0],[10,0],[0,10]]);
}

//Body of Adapter
rotate([180,0,0])translate([0,0,-15])union(){

	//Center Connector
		linear_extrude(height=15)translate([-12/2,-6,0])square([20.5,12]);

	//Horizontal arms
		difference(){
			translate([0,0,10])linear_extrude(height=5)difference(){
				translate([-6,-43,0])square([12,109]);
				union(){
					translate([0,-23.5,-.5])square([3.5,31], center=true);
					translate([0,35,-.5])square([3.5,55], center=true);
				}
			}
			translate([0,0,9])linear_extrude(height=3){
				union(){
					translate([0,-23,-.5])square([8,36], center=true);
					translate([0,34.5,-.5])square([8,59.5], center=true);
				}
			}
		}
}

//Horizontal arm triangular supports
	translate([6,6,5])rotate([0,270,0])triangle_support();
	translate([-4,6,5])rotate([0,270,0])triangle_support();
	translate([4,-6,5])rotate([0,270,180])triangle_support();
	translate([-6,-6,5])rotate([0,270,180])triangle_support();

//Vertical arm
	rotate([180,0,0])union(){

	//Vertical arm triangular supports
		translate([-1,-2,-10])rotate([0,0,270]){
			translate([4,-5,5])rotate([0,90,180])triangle_support();
			translate([-6,-5,5])rotate([0,90,180])triangle_support();
		}

	translate([0,0,-15]){
		translate([-1,0,0])rotate([0,0,90])difference(){
			translate([0,0,10])linear_extrude(height=5)difference(){
				translate([-6,4,0])square([12,95.5]);
				translate([0,51.5,-.5])square([3.5,89], center=true);
			}
			translate([0,0,9])linear_extrude(height=3){
				translate([0,46.25,-.5])square([8,103], center=true);
			}
		}
	}

}