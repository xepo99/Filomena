x=25.4; //Diameter of the Lens
y=10;   //Lens holder Thickness
z=3;     //Lens Holder Lip Size
X=25; //Base Diameter
Y=25;  //Base Height
a=3.35; //Set Screw Diameter
b=7.88; //Set Screw Nut Daimeter
c=2.82; //Set Screw Nut Thickness
d=8; //Guide Rod Diameter
e=20; //Guide Rod Length
f=3;    // Thumb Screw Head Height
g=7.8;   //Thumb Screw Head Diameter
i=3.3;    //Thumb Screw Diameter
j=3;    //PL Board Hole Diameter
thumbscrew();

module thumbscrew(){
difference(){
cylinder(f+2,(g+6)/2, (g+6)/2);
translate([0,0,2])cylinder(5,(g+1)/2, (g+1)/2);
cylinder(5,(i+1)/2, (i+1)/2);
}
difference(){
	for ( i = [0 :8] ){
					rotate( i * 360 / 8, [0, 0, 1])
					translate([(g+6)/2,0,0])
					cylinder(5,3,3);
		}	
translate([0,0,2])cylinder(5,(g+1)/2, (g+1)/2);
}
}

module mount(){
difference(){
cylinder((2/5)*Y,X/2,X/2);
translate([0,0,(1/5)*Y])cylinder(Y,(d+1)/2,(d+1)/2);
}
difference(){
translate([0,0,(2/5)*Y])cylinder((2/5)*Y,X/2,(d+6)/2);
cylinder(Y,(d+1)/2,(d+1)/2);

}
difference(){
translate([0,0,(4/5)*Y])cylinder((1/5)*Y,(d+6)/2,(d+6)/2);
cylinder(Y,(d+1)/2,(d+1)/2);

}
difference(){
translate([0,(X/2)+3,0])cylinder(5,(j+6)/2, (j+6)/2);
translate([0,(X/2)+3,0])cylinder(5,(j+1)/2, (j+1)/2);
}
difference(){
translate([0,(X/2)-2,5/2])cube([j+6,j+6,5],center = true);
translate([0,(X/2)+3,0])cylinder(5,(j+1)/2, (j+1)/2);
}
}

module lens_holder(){
difference(){
cylinder(y/2,(x+10)/2,(x+10)/2);
cylinder((y+2)/2,(x-3)/2,(x-3)/2);
translate([0,0,1.5])cylinder((y+2)/2,(x+1)/2,(x+1)/2);
translate([0,(x+10)/2+5,(b+3)/2])rotate([90,0,0])cylinder(10,(a+1)/2,(a+1)/2);
translate([0,(x+8)/2,(b+3)/2])nuttrap();
translate([(x+15)/2,e/2,(d+6)/2])rotate([90,0,0])cylinder(e,(d+6)/2, (d+6)/2);
}
difference(){
translate([0,0,y/2])cylinder((y)/2,(x+5)/2,(x+5)/2);
cylinder((y)*2,(x+1)/2,(x+1)/2);
translate([0,(x+10)/2+5,(b+3)/2])rotate([90,0,0])cylinder(25,(b+3)/2,(b+3)/2);
translate([0,(x+8)/2,(b+3)/2])nuttrap();
}
difference(){
translate([0,(x+8)/2,0])set_screw((b+3)/2);
cylinder((y+2),(x+1)/2,(x+1)/2);
}
difference(){
translate([(x+15)/2,0,0])guide_rod();
rotate([0,0,90]){
#translate([0,((x+7)/-2)-((d)),(d+6)/2])rotate([90,0,0])cylinder(50,(a+1)/2,(a+1)/2);
translate([((x+7.5)/2)+((d+6)),0,0])rotate([0,0,90])set_screw1((d+6)/2);
}
}
translate([((x+7.5)/2)+((d+6)),0,0])rotate([0,0,90])set_screw((d+6)/2);
}

module guide_rod(){
difference(){
translate([0,e/2,(d+6)/2])rotate([90,0,0])cylinder(e,(d+6)/2, (d+6)/2);
translate([0,(e/2)+1,(d+6)/2])rotate([90,0,0])cylinder(e+2,(d+1)/2, (d+1)/2);
}
difference(){
translate([0,0,(d+6)/4])cube([(d+6),e,(d+6)/2], center = true);
translate([0,(e/2)+1,(d+6)/2])rotate([90,0,0])cylinder(e+2,(d+1)/2, (d+1)/2);
}
}

module set_screw(h){
difference(){
translate([0,5,h])rotate([90,0,0])cylinder(10,(b+3)/2, (b+3)/2);
#translate([0,10,h])rotate([90,0,0])cylinder(200,(a+1)/2, (a+1)/2);
translate([0,0,h])nuttrap();
}
difference(){
translate([0,0,h/2])cube([(b+3),10,h], center = true);
translate([0,6,h])rotate([90,0,0])cylinder(12,(a+1)/2, (a+1)/2);
translate([0,0,h])nuttrap();
}
}
module set_screw1(h){
translate([0,5,h])rotate([90,0,0])cylinder(10,(b+3)/2, (b+3)/2);
translate([0,0,h/2])cube([(b+3),10,h], center = true);

}



module nuttrap(){
translate([0,(c+1)/2,0])rotate([90,0,0])hexagon(c+1,(b+1)/2);
translate([0,0,(b*3)/2])cube([b+1,c+1,b*3],center = true);
}

module reg_polygon(sides,radius)
{
  function dia(r) = sqrt(pow(r*2,2)/2);  //sqrt((r*2^2)/2) if only we had an exponention op
  if(sides<2) square([radius,0]);
  if(sides==3) triangle(radius);
  if(sides==4) square([dia(radius),dia(radius)],center=true);
  if(sides>4) circle(r=radius,$fn=sides);
}

module hexagonf(radius)
{
  reg_polygon(6,radius);
}

module hexagon(height,radius) 
{
  linear_extrude(height=height) hexagonf(radius);
}
