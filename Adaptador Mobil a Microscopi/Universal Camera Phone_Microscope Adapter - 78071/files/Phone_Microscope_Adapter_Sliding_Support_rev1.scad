//Sliding Supports

union(){
	rotate([0,180,0])translate([0,0,-20]){
		union(){
		difference(){
			linear_extrude(height=20){
				union(){
					square([25,7], center=true);
					difference(){
						translate([25/2,3.5,0])circle(7, center=true);
						translate([0,3.5,0])square([20,10]);
					}
					difference(){
						translate([-25/2,3.5,0])circle(7, center=true);
						translate([-23,3.5,0])square([20,10]);
					}
				}
			}
			union(){
				translate([0,0,2])cube([12.4,8,4], center=true);
				translate([20,0,2])cube([15,10,6], center=true);
				translate([-20,0,2])cube([15,10,6], center=true);
			}
			cylinder(20,1.75,1.75);
		}
		}
	}
	rotate([0,270,0])translate([0,3.5,-19.5])linear_extrude(height=39)polygon([[0,0],[0,5],[5,0]]);
}