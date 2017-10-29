//include <fan_grille.scad>
include <inc/rack_item.scad>


module cover(h=120){
  difference() {
    union() {
    	cube([65,h,2.8]);

    	translate([-10,0,2.8]) cube([13,h,2.8]);
    	translate([-11.5,0,  0]) cube([2.2,h,2.8]);

    	translate([66-5,0,2.8]) cube([13,h,2.8]);
    	translate([65+10-1.8,0,0]) cube([2.2,h,2.8]);

	    translate([-5+1,5,0]) cylinder(d=3.5,h=2.8);
	    translate([65+5-1,5,0]) cylinder(d=3.5,h=2.8);
	    translate([-5+1,120-5,0]) cylinder(d=3.5,h=2.8);
	    translate([65+5-1,120-5,0]) cylinder(d=3.5,h=2.8);

    }
    translate([-5+1,5,0]) cylinder(d=3,h=10);
    translate([65+5-1,5,0]) cylinder(d=3,h=10);
    translate([-5+1,120-5,0]) cylinder(d=3,h=10);
    translate([65+5-1,120-5,0]) cylinder(d=3,h=10);
  }
}

//translate([0,0, 0]) both_parts(drive=true, power=false, board=false);
//translate([0,0,40]) both_parts(drive=true, power=false, board=false);
//translate([0,0,80]) both_parts(drive=true, power=false, board=false);
//translate([-90.5,212,0]) rotate([90,0,0])
  cover();