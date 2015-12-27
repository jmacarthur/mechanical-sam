include <globals.scad>

barHoleRadius = sqrt(2*2+2*2);

$fn=20;

module SupportPlate() 
{
  difference() {
    translate([0,-20,-20]) cube([3,300+40,40]);
    // Holes for read rods.
    translate([-1,40+150,10]) rotate([0,90,0]) cylinder(r=barHoleRadius, h=3+2);
    // Holes for write rods.
    translate([-1,40+180,10]) rotate([0,90,0]) cylinder(r=barHoleRadius, h=3+2);
  }
}

module ReadWriteHead()
{
  SupportPlate();
  color([1.0,1.0,0.0,0.5]) translate([12,0,0]) SupportPlate();
  translate([4,40+180,10]) ReadHead();
  translate([8,40+150,10]) WriteHead();
}

module ReadHead2D() 
{
  difference() {
    translate([-5,-5])
    polygon(points= [[0,0], [30,0], [33.5,30], [31.5,30], [20,10], [0,10]], paths = [[0,1,2,3,4,5]]);
    translate([-2,-2]) square(size=[4,4]);
  }
}

module ReadHead()
{
  color([1.0,0.0]) rotate([-90,0,0]) rotate ([0,90,0]) linear_extrude(height=3) ReadHead2D();
}

module WriteHead2D() 
{
  difference() {
    translate([0,0])
      polygon(points= [[-15,-5], [15,-5], [9,30], [6,30], [6,5], [-6,5], [-6,30], [-9,30]], paths = [[0,1,2,3,4,5,6,7]]);
    translate([-2,-2]) square(size=[4,4]);
  }
}

module WriteHead()
{
  color([0.0,0.1,1.0,0.5]) rotate([-90,0,0]) rotate ([0,90,0]) linear_extrude(height=3) WriteHead2D();
}
