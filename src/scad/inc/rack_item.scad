$fn=60;
/**
 * "*" It will not be shown, nor computed, not even appear in the "compiled" final shape
 * "!" prefix will show only the given part (it hides all the others parts of the design)
 * "%" is also very useful. It shows the shape as half transparent like with the hash sign, but, in addition, the part will not be included in the final shape (F6, STL).
 */
d1=0.1; d2=0.2; d4=0.4;

// rod holes
threadedRodHoleD=4.4; // 4.8; // rod hole diameter
threadedRodNutD=7.7; // m5: 8.5, m4: 7.7
threadedRodHoleOuterDiameter=6;

module disk() {
	cube([101.6,146,26.1]);
}
module psu120w() {
	cube([160,100,41]);
}

module part(drive=true, board=false, power=false, left=true) {
	union() {
		sl=210; // side length
		h=26;
		h1=16.5; // hole 1
		hh=2.6; // hole height
		h2=77; // hole 2
		h3=118.0; // hole 3
		
		bh1=h1+10; // bottom hole
		bh2=153.7;
		bh3=105;
		bh4=190.7;
		bh4_po=205; // power or odroid
		bhw=11; // bottom hole width
		bhd=7;
		
		sh=5; // side height
		
		th=3;
		sd=7.0; // spacer depth
		side_height = 40; // sh+h+th+8;
		echo(side_height,side_height);
		pd=4; // pilar depth
		pcs=9.5; //pilar cube size
		
		ethCableD=6; // ethernet cable diameter
		powerCableD=7; // power cable diameter
		cableLockH=5; // cable lock height
		
		rodOffset=2.5;
		wallOffset=4.0;
					
		difference () {
			union() {
				// rail side
				translate([0,-wallOffset,0]) cube([sl,sd,side_height]);
				// bottom mount
				if (drive==true || board==true) {
					translate([bh1-bhw/2,sd-wallOffset,0]) cube([bhw,bhd,sh]);
					translate([bh2-bhw/2,sd-wallOffset,0]) cube([bhw,bhd,sh]);
					translate([bh3-bhw/2,sd-wallOffset,0]) cube([bhw,bhd,sh]);
					translate([77-bhw/2,sd-wallOffset,0]) cube([bhw,bhd,sh]);
				}
				if (power==true) {
					bhd=20;
					translate([bh1-bhw/2,sd-wallOffset,0]) cube([bhw,bhd,sh]);
					translate([bh2-bhw/2,sd-wallOffset,0]) cube([bhw,bhd,sh]);
					translate([bh3-bhw/2,sd-wallOffset,0]) cube([bhw,bhd,sh]);
					translate([77-bhw/2,sd-wallOffset,0]) cube([bhw,bhd,sh]);
				}
				if (drive==true) {
					//translate([bh4-bhw/2,sd,0]) cube([bhw,bhd,3]);					
				}
				// bottom rail
				translate([bh1-bhw/2,sd-wallOffset,0]) cube([bhw,58,3]);
				translate([bh2-bhw/2,sd-wallOffset,0]) cube([bhw,58,3]);
				translate([bh3-bhw/2,sd-wallOffset,0]) cube([bhw,58,3]);
				if (drive==true)  translate([bh4-bhw/2,sd-wallOffset,0]) cube([3,58,3]);
				if (power==true || board==true) translate([bh4_po-bhw/2,sd-wallOffset,0]) cube([bhw,15,3]);
				// pilar 
				translate([h1-bhw/2,sd-wallOffset,0]) cube([bhw,pd,side_height]);
				translate([h2-bhw/2,sd-wallOffset,0]) cube([bhw,pd,side_height]);
				translate([h3-bhw/2,sd-wallOffset,0]) cube([bhw,pd,side_height]);
//
//				if (power==true) { 
//					pd=10;
//					translate([h1-bhw/2,sd-wallOffset,0]) cube([bhw,pd,side_height]);
//					translate([h2-bhw/2,sd-wallOffset,0]) cube([bhw,pd,side_height]);
//					translate([h3-bhw/2,sd-wallOffset,0]) cube([bhw,pd,side_height]);
//				};
				
				// rod 1
				translate([bh1,-threadedRodHoleOuterDiameter/2+rodOffset,0]) cylinder(d=threadedRodHoleOuterDiameter,h=side_height);
				// rod 2
				//translate([bh2,-threadedRodHoleOuterDiameter/2+rodOffset,0]) cylinder(d=threadedRodHoleOuterDiameter,h=sh+h+th);
				// rod 3
				translate([bh3,-threadedRodHoleOuterDiameter/2+rodOffset,0]) cylinder(d=threadedRodHoleOuterDiameter,h=side_height);
				// rod 4
				translate([bh4+15,-threadedRodHoleOuterDiameter/2+rodOffset,0]) cylinder(d=threadedRodHoleOuterDiameter,h=side_height);
				// front mount
				translate([0,-wallOffset,0]) cube([3,sd+pd,side_height]);
				// back mount
				translate([sl,-wallOffset,0]) cube([3,sd+pd+36/2,side_height]);
				// electronics mount
				if (drive==true && left==true) {
					translate([148.2,64.6,0]) rotate([0,0,-90]) difference() {
						usb2sataCase(zOffset=4.0);
						translate([0,-d1,d1]) usb2sata(zOffset=4.0);
					}
					
				}
				if(board==true) {
					// add ETH cable lock
					translate([sl-10/2,5+th,0]) rotate([0,0,90]) difference() { cylinder(d=10,h=cableLockH); }
					translate([sl-10/2,5+th+ethCableD,0]) rotate([0,0,90]) difference() { cylinder(d=10,h=cableLockH); }
				}	
				if(power==true) {
					// add power cable lock
					translate([sl-10/2,5+th,0]) rotate([0,0,90]) { cylinder(d=10,h=cableLockH); }
					translate([sl-10/2,5+th+powerCableD,0]) rotate([0,0,90]) { cylinder(d=10,h=cableLockH); }
				}				
			}
			// side holes
			union() {
				translate([h1-pcs/2,-wallOffset-d2,sh+hh+sd/2-pcs/2]) cube([pcs,sd,pcs]);
				translate([h1,-wallOffset-d2,sh+hh+sd/2]) rotate([-90,0,0])	cylinder(d=3,h=8+7);
				translate([h2-pcs/2,-wallOffset-d2,sh+hh+sd/2-pcs/2]) cube([pcs,sd,pcs]);
				translate([h2,-wallOffset-d2,sh+hh+sd/2]) rotate([-90,0,0])	cylinder(d=3,h=8+7);
				translate([h3-pcs/2,-wallOffset-d2,sh+hh+sd/2-pcs/2]) cube([pcs,sd,pcs]);
				translate([h3,-wallOffset-d2,sh+hh+sd/2]) rotate([-90,0,0])	cylinder(d=3,h=8+7);
			}
			// bottom holes
			// rod 1 hole
			translate([bh1,-threadedRodHoleOuterDiameter/2+rodOffset,0]) cylinder(d=threadedRodHoleD,h=side_height);
			// rod 2 hole
			//translate([bh2,-threadedRodHoleOuterDiameter/2+rodOffset,0]) cylinder(d=threadedRodHoleD,h=sh+h+th);
			// rod 3 hole 
			translate([bh3,-threadedRodHoleOuterDiameter/2+rodOffset,0]) cylinder(d=threadedRodHoleD,h=side_height);
			// rod 4 hole 
			translate([bh4+15,-threadedRodHoleOuterDiameter/2+rodOffset,0]) cylinder(d=threadedRodHoleD,h=side_height);
			
			// rear fan hole bottom
			translate([-1,2,4.6]) rotate([0,90,0]) cylinder(d=3,h=22);
			// rear fan hole top
			translate([-9,2,40-4.6]) rotate([0,90,0]) cylinder(d=3,h=22);
	
			// fan hole bottom
			translate([sl-d1-5,22,4.6]) rotate([0,90,0]) cylinder(d=3,h=10);
			// fan hole top
			translate([sl-d1-5,22,40-4.6]) rotate([0,90,0]) cylinder(d=3,h=10);
			if(board==true) {
				// add ETH cable lock
				translate([sl-10/2,5+th,0]) rotate([0,0,90]) { cylinder(d=3,h=cableLockH+d2, $fn=5);}
				translate([sl-10/2,5+th+ethCableD,0]) rotate([0,0,90]) { cylinder(d=3,h=cableLockH+d2, $fn=5);}
			}
			if(power==true) {
				// add power cable lock
				translate([sl-10/2,5+th,0]) rotate([0,0,90]) { cylinder(d=3,h=cableLockH+d2, $fn=5);}
				translate([sl-10/2,5+th+powerCableD,0]) rotate([0,0,90]) { cylinder(d=3,h=cableLockH+d2, $fn=5);}
			}
		}	
	}
}
// https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/The_OpenSCAD_Language
module usb2sataCase(zOffset=0) {
	c=1;
	h=9-1;
	bw=53+1.5;
	tw=9;
	t1=bw / 2 - tw / 2;//22
	t2=bw / 2 + tw / 2;//31
	echo(t1, t1);
	echo(t2, t2);
	points=[
		[  -c, 0, 0 ],  //0
		[ bw+c, 0,  0 ],  //1
		[ t2+c, 40,  0], //2
		[ t1-c,  40,  0 ], //3
		[  -c,  0,  h+zOffset ],  //4
		[ bw+c,  0,  h+zOffset ],  //5
		[ t2+c,  40,  h+zOffset ], //6
		[ t1-c,  40,  h+zOffset ]  // 7
	];
	faces = [
	  [0,1,2,3],  // bottom
	  [4,5,1,0],  // front
	  [7,6,5,4],  // top
	  [5,6,2,1],  // right
	  [6,7,3,2],  // back
	  [7,4,0,3]]; // left
  polyhedron( points, faces );
  // cable support
  //translate([24-c,40,1+zOffset]) cube([6.9+c*2,2+c,h-1]);
  // top cable support screw
  supportsCable=false;
  if (supportsCable==true) {
	  translate([bw/2-c-4/2-1,40+c+10/2,0]) rotate([0,0,90]) difference() { cylinder(d=12,h=h/2+zOffset); cylinder(d=3,h=h+d2+zOffset, $fn=5);}
	  translate([bw/2+c+4/2,40+c+10/2,0]) rotate([0,0,90]) difference() { cylinder(d=12,h=h/2+zOffset); cylinder(d=3,h=h+d2+zOffset, $fn=5);}
	  translate([bw/2-8/2,40-1,0]) { cube([8,2,h/2+zOffset]);}
  }
  // bottom support screw
  sc=10;
  translate([-c,sc/2,0]) rotate([0,0,90]) difference(){ cylinder(d=sc,h=h+zOffset); cylinder(d=3,h=h+c+d1+zOffset, $fn=5);}
  translate([bw+c,sc/2,0]) rotate([0,0,90]) difference(){ cylinder(d=sc,h=h+zOffset); cylinder(d=3,h=h+c+d1+zOffset, $fn=5);}
  // top support screw
  translate([-c+6,  sc+sc/2+2,0]) rotate([0,0,90]) difference(){ cylinder(d=sc,h=h+zOffset); cylinder(d=3,h=h+c+d1+zOffset, $fn=5);}
  translate([bw+c-6,sc+sc/2+2,0]) rotate([0,0,90]) difference(){ cylinder(d=sc,h=h+zOffset); cylinder(d=3,h=h+c+d1+zOffset, $fn=5);}
}
module usb2sata(zOffset=0) {
	h=9;
	bw=53+1.5;
	tw=9;
	t1=bw / 2 - tw / 2;//22
	t2=bw / 2 + tw / 2;//31
	points=[
		[  0,  0,  zOffset ],  //0
		[ bw,  0,  zOffset ],  //1
		[ t2,  40,  zOffset ], //2
		[ t1,  40,  zOffset ], //3
		[  0,  0,  h+zOffset ],  //4
		[ bw,  0,  h+zOffset ],  //5
		[ t2,  40,  h+zOffset ], //6
		[ t1,  40,  h+zOffset ]  // 7
	];
	faces = [
	  [0,1,2,3],  // bottom
	  [4,5,1,0],  // front
	  [7,6,5,4],  // top
	  [5,6,2,1],  // right
	  [6,7,3,2],  // back
	  [7,4,0,3]]; // left
  polyhedron( points, faces );
  // cable support
  //translate([24,40,1+zOffset]) cube([6.9,2,7]);
  // cable (cylinder)
  //translate([24+6.9/2,40+2,1+7/2+zOffset]) rotate([-90,0,0]) cylinder(d=4, h=3);
  // cable (cube)
  translate([24+6.9/2-4/2,40,1+7/2-4/2+zOffset]) cube([4,3+2,9-7/2+1]);
  // power jack
  //translate([40,24.5,9/2+zOffset]) rotate([-90,0,-60]) cylinder(d=9, h=20);
  translate([39,26,9/2+zOffset]) rotate([-90,0,-60]) cylinder(d=9, h=20);
}
module connector_lock(bw=53+1.5) {
	c=1;
	tw=9;
	h=5;
  // left support screw
  sc=10;
  difference() {
  	union() {
	  translate([0,0,0]) cube([bw,sc,h]);
	  translate([-c,sc/2,0]) rotate([0,0,90]) cylinder(d=sc,h=h); 
  	  translate([bw+c,sc/2,0]) rotate([0,0,90]) cylinder(d=sc,h=h);
  	}
  	// center stripe
  	o=sc/2+2;
  	translate([o,sc/2-0.75,0]) cube([bw-2*o,1.5,h]);
  	// screw holes
	translate([-c,sc/2,0]) rotate([0,0,90]) cylinder(d=3,h=h+c+d1, $fn=5);
	translate([bw+c,sc/2,0]) rotate([0,0,90]) cylinder(d=3,h=h+c+d1, $fn=5);
  }
}

module connector(zOffset=10) {
	difference() {
		usb2sataCase(zOffset=zOffset);
		translate([0,-d1,d1]) usb2sata(zOffset=zOffset);
	}
}
module connector_test(){
	connector(zOffset=1);
	sc=10;
	translate([0,-sc-2,0]) connector_lock();	
	translate([0,-sc*2-4,0]) connector_lock(bw=53+1.5-2*6);	
}
module both_parts(drive=true, power=false, board=false) {
	%if(drive==true)translate([-109,0,5]) disk();
	rotate([0,0,90]) 
	difference() {
		union() {
			part(drive=drive, power=power, board=board);
			translate([0,118.8-2.8,0]) mirror([0,1,0]) part(drive=drive, power=power, board=board, left=false);
		}
		//
		//if(power==true)translate([10,9,0]) psu120w();		
	}
}
module floor_part(with_inbody_screws=true) {
	sd=7.0; // spacer depth
	sl=210;
		h1=16.5; // hole 1		
		bh1=h1+10; // bottom hole
		bh2=153.7;
		bh3=105;
		bh4=190.7;
		bh4_po=205; // power or odroid
	side_height=10;
	
	rodOffset=2.5;
		
	//part(drive=true, board=false, power=false, left=true);
	difference() {
		union() { 
			translate([ 0,-4,-7]) cube([sl+3,7,7]);
			translate([0,-4,-7]) cube([sl+3,70,2]);
			translate([0,-4,-7]) cube([3,70,7]);
			translate([sl,-4,-7]) cube([3,70,7]);
			if (with_inbody_screws==true) {
				translate([bh1,-threadedRodHoleOuterDiameter/2+rodOffset,-7-d1]) cylinder(d=threadedRodNutD+2,h=7);
				translate([bh3,-threadedRodHoleOuterDiameter/2+rodOffset,-7-d1]) cylinder(d=threadedRodNutD+2,h=7);
				translate([bh4+15,-threadedRodHoleOuterDiameter/2+rodOffset,-7-d1]) cylinder(d=threadedRodNutD+2,h=7);
			}
		}
		// rod 1
		//translate([bh1,-threadedRodHoleOuterDiameter/2+rodOffset,0]) cylinder(d=threadedRodHoleD,h=side_height);
		
		translate([bh1,-threadedRodHoleOuterDiameter/2+rodOffset,-10-d1]) cylinder(d=threadedRodHoleD,h=side_height+d2);
		if (with_inbody_screws==true) translate([bh1,-threadedRodHoleOuterDiameter/2+rodOffset,-7-d1]) cylinder(d=threadedRodNutD,h=4+d2,$fn=6);		
		// rod 2
		//translate([bh2,-8/2+2,-10]) cylinder(d=threadedRodHoleD,h=sh+h+th);
		// rod 3
		translate([bh3,-threadedRodHoleOuterDiameter/2+rodOffset,-10-d1]) cylinder(d=threadedRodHoleD,h=side_height+d2);
		if (with_inbody_screws==true) translate([bh3,-threadedRodHoleOuterDiameter/2+rodOffset,-7-d1]) cylinder(d=threadedRodNutD,h=4+d2,$fn=6);		
		// rod 4
		translate([bh4+15,-threadedRodHoleOuterDiameter/2+rodOffset,-10-d1]) cylinder(d=threadedRodHoleD,h=side_height+d2);
		if (with_inbody_screws==true) translate([bh4+15,-threadedRodHoleOuterDiameter/2+rodOffset,-7-d1]) cylinder(d=threadedRodNutD,h=4+d2,$fn=6);		
	}
}
module floor(with_inbody_screws=true) {
	//both_parts(drive=true, power=false, board=false);
	rotate([0,0,90]) 
	union() {
		floor_part(with_inbody_screws);
		translate([0,118.8-2.5,0]) mirror([0,1,0]) floor_part(with_inbody_screws);
	}
}
module top() {
	//floor(with_inbody_screws=false);
	translate([20,0,0]) mirror([1,0,0]) floor(with_inbody_screws=false);
}

module cableTie(
	h=10,
	w=4
) {
  difference() {
	  union(){ 
		translate([-w/2-1,0,0]) rotate([0,0,90]) difference() { cylinder(d=10,h=h/2); cylinder(d=3,h=h+d2, $fn=5);}
	  	translate([+w/2+1,0,0]) rotate([0,0,90]) difference() { cylinder(d=10,h=h/2); cylinder(d=3,h=h+d2, $fn=5);}
	  }
      #translate([0,10,0]) rotate([90,0,0]) { cylinder(d=w+0.1,h=20); }
  }
}