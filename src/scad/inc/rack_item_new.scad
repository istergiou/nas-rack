
module mount_unions(
  pos=[0,0,0], h=3
) {
	echo(pos,pos);
	#translate(pos) cylinder(d=7,h=h);
}
module mount_differences(
  pos=[0,0,0]
) {
	translate(pos) cylinder(d=3,h=10,$fn=5);
}

module both_sides(
	mount1_pos=[80,13+35,0], mount2_pos=[80+22.5,13+35,0],
	mount3_pos=[7+7/2+4.5,75,0],mount4_pos=[7+7/2+4.5+79.5,75,0],
	mount5_pos=[95,153,0],
) {
	difference() {
		union() {
			side_wall();
			translate([124,0,0]) mirror([1,0,0]) side_wall();
			mount_unions(pos=mount1_pos);	
			mount_unions(pos=mount2_pos);
			mount_unions(pos=mount3_pos);	
			mount_unions(pos=mount4_pos);
			mount_unions(pos=mount5_pos);
		}
		mount_differences(pos=mount1_pos);
		mount_differences(pos=mount2_pos);
		mount_differences(pos=mount3_pos);
		mount_differences(pos=mount4_pos);
		mount_differences(pos=mount5_pos);
	}
}

module side_wall (
	front=[70,3,20],
	rear=[70,3,20],
	side=[7,207,20], // sl,sd,side_height
	pillar1_pos=[7,8,0], pillar1_dim=[4,11,20],
	pillar2_pos=[7,68.5,0], pillar2_dim=[4,11,20],
	pillar3_pos=[7,109.5,0], pillar3_dim=[4,11,20],
	rod1_pos=[5/2+1.0,23.5,0], 
	rod2_pos=[5/2+1.0,102,0], 
	rod3_pos=[5/2+1.0,202.8,0], 
	rod_d=4.8, rod_h=41,
	bridge1_pos=[7,43,0], bridge1_dim=[70,11,3],
	bridge2_pos=[0,68.5,0], bridge2_dim=[70,11,3],
	//bridge3_pos=[0,109.5,0], bridge3_dim=[70,11,3],
	bridge4_pos=[0,147,0], bridge4_dim=[70,11,3],
	bridge5_pos=[0,181,0], bridge5_dim=[70,4,3],
) {
	difference() {
		union() {
			cube(side);
			translate([0,-front[1],0]) cube(front);
			translate([0,side[1],0]) {
				cube(rear);
			}
			translate(pillar1_pos) cube(pillar1_dim);
			translate(pillar2_pos) cube(pillar2_dim);
			translate(pillar3_pos) cube(pillar3_dim);

			#translate(bridge1_pos) cube(bridge1_dim);
			translate(bridge2_pos) cube(bridge2_dim);
			//translate(bridge3_pos) cube(bridge3_dim);
			translate(bridge4_pos) cube(bridge4_dim);
			translate(bridge5_pos) cube(bridge5_dim);
		}
		// rods
		translate(rod1_pos) cylinder(d=rod_d, h=rod_h);
		translate(rod2_pos) cylinder(d=rod_d, h=rod_h);
		translate(rod3_pos) cylinder(d=rod_d, h=rod_h);
	}
}

