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
			translate([0, 8,0]) cube([101,10,th]);
			// 2nd
			translate([0,53,0]) cube([101,10,th]);
			// 3rd
			translate([0,106,0]) cube([101,10,th]);
			//
			for (y=[10:100:100]) {
				translate([th+3.5+5,3.5+y,0]) {
					// rpi: 49,58
					// odroid: 52,76
					translate([ 0, 0,0]) cylinder(d=7,h=th+ra);
					translate([22.5, 0,0]) cylinder(d=7,h=th+ra);		
					translate([ 22.5+7.5, 0,0]) cylinder(d=7,h=th+ra);
					translate([22.5+7.5+22.5, 0,0]) cylinder(d=7,h=th+ra);		
				}
			}
			// https://www.raspberrypi.org/blog/introducing-raspberry-pi-model-b-plus/
			// http://www.hardkernel.com/main/products/prdt_info.php?g_code=G143452239825&tab_idx=2
			for (y=[55:100:100]) {
				translate([th+3.5+5,3.5+y,0]) {
					// rpi: 49,58
					// odroid: 52,76
					translate([ 0, 0,0]) cylinder(d=7,h=th+ra);
					translate([76, 0,0]) cylinder(d=7,h=th+ra);		
					translate([76,52,0]) cylinder(d=7,h=th+ra);
					translate([ 0,52,0]) cylinder(d=7,h=th+ra);		
				}
			}
		}
		//		
		#for (y=[10:100:100]) {
			translate([th+3.5+5,3.5+y,0]) {
				translate([ 0, 0,0]) cylinder(d=3,h=th+ra,$fn=5);
				translate([22.5, 0,0]) cylinder(d=3,h=th+ra,$fn=5);		
				translate([ 22.5+7.5, 0,0]) cylinder(d=3,h=th+ra,$fn=5);
				translate([22.5+7.5+22.5, 0,0]) cylinder(d=3,h=th+ra,$fn=5);		
			}
		}
		//		
		for (y=[55:100:100]) {
			translate([th+3.5+5,3.5+y,0]) {
				translate([ 0, 0,0]) cylinder(d=3,h=th+ra,$fn=5);
				translate([76, 0,0]) cylinder(d=3,h=th+ra,$fn=5);		
				translate([76,52,0]) cylinder(d=3,h=th+ra,$fn=5);
				translate([ 0,52,0]) cylinder(d=3,h=th+ra,$fn=5);		
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