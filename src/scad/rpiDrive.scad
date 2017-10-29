th=3; // thickness
ra=4; // raiser
d1=0.01;d2=2*d1;

//translate([140,-40,0]) import("inc/Pi_Drive.stl");
translate([0,-20,0]) {
	difference() {
		union() {
			// side mount
			cube([th,140,10]);
			translate([102-3,0,0]) cube([th,140,10]);
			//
			//cube([th+5,140,th]);
			//
			//#translate([th+3.5+49,22,0]) cube([th,100,3]);
			// 1st
			translate([0,32,0]) cube([101,10,th]);
			// 2nd
			translate([0,100-10,0]) cube([101,10,th]);
			// 3rd
			translate([0,135-10,0]) cube([101,3,th]);
			// https://www.raspberrypi.org/blog/introducing-raspberry-pi-model-b-plus/
			for (y=[33:100:100]) {
				translate([th+3.5+2,3.5+y,0]) {
					translate([ 0, 0,0]) cylinder(d=7,h=th+ra);
					translate([49, 0,0]) cylinder(d=7,h=th+ra);		
					translate([49,58,0]) cylinder(d=7,h=th+ra);
					translate([ 0,58,0]) cylinder(d=7,h=th+ra);		
				}
			}
		}
		//		
		for (y=[33:100:100]) {
			translate([th+3.5+2,3.5+y,0]) {
				translate([ 0, 0,0]) cylinder(d=3,h=th+ra,$fn=5);
				translate([49, 0,0]) cylinder(d=3,h=th+ra,$fn=5);		
				translate([49,58,0]) cylinder(d=3,h=th+ra,$fn=5);
				translate([ 0,58,0]) cylinder(d=3,h=th+ra,$fn=5);		
			}
		}
		//
		translate([-d1,25,6.3]) rotate([0,90,0]) cylinder(d=3,h=th+d2,$fn=5);
		translate([-d1,66.5,6.3]) rotate([0,90,0]) cylinder(d=3,h=th+d2,$fn=5);
		translate([-d1,126.6,6.3]) rotate([0,90,0]) cylinder(d=3,h=th+d2,$fn=5);
		//
		translate([102-3-d1,25,6.3]) rotate([0,90,0]) cylinder(d=3,h=th+d2,$fn=5);
		translate([102-3-d1,66.5,6.3]) rotate([0,90,0]) cylinder(d=3,h=th+d2,$fn=5);
		translate([102-3-d1,126.6,6.3]) rotate([0,90,0]) cylinder(d=3,h=th+d2,$fn=5);
	}
}