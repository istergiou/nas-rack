include <inc/rack_item.scad>

translate([0,12*0,0]) connector_lock();
translate([0,12*1,0]) connector_lock();
translate([0,12*2,0]) connector_lock();

translate([0,12*3,0]) connector_lock(bw=53+1.5-2*6);
translate([0,12*4,0]) connector_lock(bw=53+1.5-2*6);
translate([0,12*5,0]) connector_lock(bw=53+1.5-2*6);
