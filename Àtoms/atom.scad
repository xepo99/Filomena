use <write_scad/write.scad>

ELECTRON_D = 6;
OUTER_ELECTRON_H = 7;
INNER_ELECTRON_H = 7;
DISC_H = 2.5;
TOLERANCE = 0.7;

SOCKET_W = 2.5;
SOCKET_OPENING_W = ELECTRON_D - TOLERANCE;
CORE_RADIUS = 5;
SHELL_DISTANCE = 10;
RING_W = 2;
RING_H = 3.5;
ASSEMBLY_CONNECTOR_DEPTH = 10;
OVERLAP_FIX = 0.3;
LONG_BOND_LENGTH = 80;

electron_offset = ELECTRON_D/2 + SOCKET_W + TOLERANCE / 2;
socket_outer_d = ELECTRON_D + 2 * SOCKET_W;
bond_w = electron_offset + ELECTRON_D/2 + socket_outer_d;
socket_electron_gap_w = TOLERANCE + electron_offset - ELECTRON_D/2;
electron_connector_w = SOCKET_OPENING_W - TOLERANCE;
electron_connector_offset = electron_offset - electron_connector_w / 2;
assembly_connector_w = 2 * (electron_connector_offset + electron_connector_w);
    
//oxygen();
//oxygen_double_bond();
//nitrogen();
//carbon_double_bond();
//hydrogen();
//carbon_double_bond();
sulfur();

module carbon() {
    disk(2);
    placed_electron_pair(1, 0);
    placed_bond(2, 270);
    placed_bond(2, 0);
    placed_bond(2, 90);
    placed_bond(2, 180);
    label("C");
}

module carbon_long_bond() {
    disk(2);
    placed_electron_pair(1, 0);
    placed_long_bond(2, 270);
    placed_bond(2, 0);
    placed_bond(2, 90);
    placed_bond(2, 180);
    label("C");
}

module carbon_double_bond() {
    disk(2);
    placed_electron_pair(1, 0);
    placed_bond(2, 0);
    placed_double_bond(2, 90);
    placed_bond(2, 180);
    label("C");
}

module sulfur() {
    disk(3);
    placed_electron_pair(1, 0);
    placed_electron_pair(2, 90);
    placed_electron_pair(2, 0);
    placed_electron_pair(2, 180);
    placed_electron_pair(2, 270);
    placed_electron_pair(3, 0);
    placed_electron_pair(3, 180);
    placed_bond(3, 90);
    placed_bond(3, 270);
    label("S");
}

module nitrogen() {
    disk(2);
    placed_electron_pair(1, 0);
    placed_electron_pair(2, 270);
    placed_bond(2, 0);
    placed_bond(2, 90);
    placed_bond(2, 180);
    label("N");
}

module oxygen() {
    disk(2);
    placed_electron_pair(1, 0);
    placed_electron_pair(2, 90);
    placed_electron_pair(2, 0);
    placed_bond(2, 270);
    placed_bond(2, 180);
    label("O");
}

module oxygen_double_bond() {
    disk(2);
    placed_electron_pair(1, 0);
    placed_electron_pair(2, 90);
    placed_electron_pair(2, 180);
    placed_double_bond(2, 270);
    label("O");
}

module hydrogen() {
    disk(1);
    placed_bond(1, 0);
    label("H");
}

module label(symbol) {
    translate([0, 0, RING_H / 2 + OVERLAP_FIX/2]) write(symbol,center=true,h=CORE_RADIUS * 2, rotate=0, t=RING_H);
}

module placed_bond(shell_num, angle) {
    rotate(angle) translate([CORE_RADIUS + shell_num * SHELL_DISTANCE + 3.7, 0, 0]) bond();
}

module placed_long_bond(shell_num, angle) {
    rotate(angle) translate([CORE_RADIUS + shell_num * SHELL_DISTANCE + 3.7 +  -ASSEMBLY_CONNECTOR_DEPTH + LONG_BOND_LENGTH, 0, 0]) long_bond();
}

module placed_double_bond(shell_num, angle) {
    bond_offset = (bond_w + socket_electron_gap_w) / 2;
    rotate(angle) translate([CORE_RADIUS + shell_num * SHELL_DISTANCE + 3.7, bond_offset, 0]) double_bond();
}

module placed_electron_pair(shell_num, angle) {
    rotate(angle) translate([CORE_RADIUS + shell_num * SHELL_DISTANCE, 0, 0]) electron_pair(); 
}

module electron_pair() {
    translate([0, ELECTRON_D/2], 0) cylinder(h = INNER_ELECTRON_H, d = ELECTRON_D, $fn = 20);
    translate([0, -ELECTRON_D/2], 0) cylinder(h = INNER_ELECTRON_H, d = ELECTRON_D, $fn = 20);
}

module disk(num_shells) {
    disk_r = CORE_RADIUS + num_shells * SHELL_DISTANCE;
    cylinder(r = disk_r, h = DISC_H);
    for (ring = [1 : num_shells]) {
        difference() {
            cylinder(r = CORE_RADIUS + ring * SHELL_DISTANCE, h = RING_H);
            translate([0, 0, -OVERLAP_FIX]);
            cylinder(r = CORE_RADIUS + ring * SHELL_DISTANCE - RING_W, h = RING_H + 2 * OVERLAP_FIX);
        }
    }
}

module long_bond() {
    // So you can build the side chain of an amino acid without overlapping.
    bond();
    translate([-LONG_BOND_LENGTH - (TOLERANCE + ELECTRON_D / 2), -assembly_connector_w / 2, 0]) cube([LONG_BOND_LENGTH, assembly_connector_w, DISC_H]);
}

module bond() {
    translate([0, electron_offset]) cylinder(h = OUTER_ELECTRON_H, d = ELECTRON_D, $fn = 20);
    translate([-ELECTRON_D, electron_connector_offset, 0]) cube([ELECTRON_D , electron_connector_w, DISC_H]);
    translate([-ASSEMBLY_CONNECTOR_DEPTH - (TOLERANCE + ELECTRON_D / 2), -assembly_connector_w / 2, 0]) cube([ASSEMBLY_CONNECTOR_DEPTH, assembly_connector_w, DISC_H]);
    
    translate([0, -(ELECTRON_D/2 + SOCKET_W + TOLERANCE / 2)]) 
    difference() {
        difference() {
            cylinder(h = OUTER_ELECTRON_H, d = ELECTRON_D + 2 * SOCKET_W, $fn = 20);
            translate([0, 0, -0.03]) cylinder(h = OUTER_ELECTRON_H + 0.06, d = ELECTRON_D + TOLERANCE, $fn = 20);
        }
        
        union() {
            translate([0, - SOCKET_OPENING_W/2, -0.03]) cube([ELECTRON_D + SOCKET_W, SOCKET_OPENING_W, OUTER_ELECTRON_H + 0.06]);
            truncator_width = ELECTRON_D + 2 * SOCKET_W;
            translate([ELECTRON_D/2, -truncator_width/2, -0.03])
            cube([ELECTRON_D, truncator_width, OUTER_ELECTRON_H + 0.06]);
        }
    }
}

module double_bond() {
    bond();
    translate([0, -(bond_w + socket_electron_gap_w), 0]) bond();
    
    connector_connector_w = ELECTRON_D + socket_electron_gap_w + socket_outer_d + TOLERANCE;
    translate([-ASSEMBLY_CONNECTOR_DEPTH - (TOLERANCE + ELECTRON_D / 2), -connector_connector_w, 0]) cube([ASSEMBLY_CONNECTOR_DEPTH, connector_connector_w, DISC_H]);
}
