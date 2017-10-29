include <inc/rack_item_new.scad>
include <inc/rack_item.scad>

union() {
//	both_parts(drive=true, power=false, board=false);
	color("red")  
		translate([-120,3,20]) 
			//side_wall();
			both_sides();
}