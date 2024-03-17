
//Phone Microscope Adapter Inside Clamp
difference(){
	translate([30,0,0])linear_extrude(height=40){
		difference(){
			translate([-15,0,0])square([30,60], center=true);
			circle(21, $fn=100);
			square([10,60], center=true);
		}
	}
	union(){
		translate([0,-6,0])cube([2,12,15]);
		translate([-10,-25,20])rotate([0,90,0])cylinder(40,1.75,1.75);
		translate([-10,25,20])rotate([0,90,0])cylinder(40,1.75,1.75);
		translate([-.1,25,20])rotate([0,90,0])translate([-4.42,0,0])linear_extrude(height=4)polygon([[0,0],[2.21,-3.9],[6.63,-3.9],[8.84,0],[6.63,3.9],[2.21,3.9]]);
		translate([-.1,-25,20])rotate([0,90,0])translate([-4.42,0,0])linear_extrude(height=4)polygon([[0,0],[2.21,-3.9],[6.63,-3.9],[8.84,0],[6.63,3.9],[2.21,3.9]]);
	}

}

