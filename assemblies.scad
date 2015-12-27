include <globals.scad>

barHoleRadius = sqrt(2*2+2*2);

module ReadHead()
{
 
  difference() {
    translate([0,-20,-20]) cube([3,300+40,40]);
    // Holes for read rods.
    translate([-1,40+150,10]) rotate([0,90,0]) cylinder(r=barHoleRadius, h=3+2);
    // Holes for write rods.
    translate([-1,40+180,10]) rotate([0,90,0]) cylinder(r=barHoleRadius, h=3+2);
  }
}
