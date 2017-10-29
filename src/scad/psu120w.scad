//include <fan_grille.scad>
include <inc/rack_item.scad>

module psu() {
	%cube([97,160,30]);
	translate([0,20,6]) rotate([0,270,0]) cylinder(d=3, h=15);
	translate([0,20,24]) rotate([0,270,0]) cylinder(d=3, h=15);
	translate([0,137,15]) rotate([0,270,0]) cylinder(d=3, h=15);

	translate([36,57,0]) rotate([180,0,0]) cylinder(d=3, h=15);
	translate([36,135,0]) rotate([180,0,0]) cylinder(d=3, h=15);
}

difference() {
	both_parts(drive=false, power=true, board=false);
    #translate([-109,0,5]) psu(); 
}
