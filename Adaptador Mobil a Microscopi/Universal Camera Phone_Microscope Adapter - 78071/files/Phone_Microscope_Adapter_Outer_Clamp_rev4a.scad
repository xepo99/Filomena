
//Phone Microscope Adapter Outside Clamp
difference(){

	translate([30,0,0])linear_extrude(height=40){
		difference(){
			translate([-15,0,0])square([30,60], center=true);
			circle(21, $fn=100);
			square([10,60], center=true);
		}
	}

	union(){
		translate([-10,-25,20])rotate([0,90,0])cylinder(40,1.75,1.75);
		translate([-10,25,20])rotate([0,90,0])cylinder(40,1.75,1.75);
	}

}


