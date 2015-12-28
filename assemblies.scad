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
    // Holes for leadscrews.
    translate([-1,0,0]) rotate([0,90,0]) cylinder(r=4, h=3+2);
    translate([-1,300,0]) rotate([0,90,0]) cylinder(r=4, h=3+2);
  }
}

module ReadWriteHead()
{
  SupportPlate();
  //color([1.0,1.0,0.0,0.5]) translate([12,0,0]) SupportPlate();
  translate([4,40+180,10])   rotate([6,0,0]) ReadHead();
  translate([8,40+150,10]) WriteHead();
}

module ReadHead2D() 
{
  difference() {
    translate([-5,-5])
    polygon(points= [[0,0], [30,0], [37.5,30], [35.5,30], [20,10], [0,10]], paths = [[0,1,2,3,4,5]]);
    translate([-2,-2]) square(size=[4,4]);
  }
}

module ReadHead()
{
  color([1.0,0.0,0.0]) rotate([-90,0,0]) rotate ([0,90,0]) linear_extrude(height=3) ReadHead2D();
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

module EndPlate() 
{
  SupportPlate();
}

module WriteBowdenPlate()
{
  difference() {
    cube([10,30,3]);
    translate([5,5,-thin]) cylinder(r=1, h=3+2*thin);
    translate([5,25,-thin]) cylinder(r=1, h=3+2*thin);
  }
}

module FrontPanel()
{
  union(){
    SupportPlate();
    translate([0,-20,20-thin]) cube([3,300+40,40]);
    translate([0, 150+40-15, 40])  WriteBowdenPlate();
  }
}


module ReadToggle2D()
{
  difference() {
    union() {
      translate([-20,0]) circle(r=5);
      translate([ 20,0]) circle(r=5);
      translate([-20,-5]) square([40,10]);
    }
    translate([-2,-2]) square([4,4]);
  }
}

module ReadToggle()
{
  color([0,1.0,0]) rotate([0,90,0]) linear_extrude(height=3) ReadToggle2D();
}

module WriteToggle2D()
{
  difference() {
    union() {
      translate([0,-10]) circle(r=5);
      translate([0,10]) circle(r=5);
      translate([-5,-10]) square([10,20]);
    }
    translate([-2,-2]) square([4,4]);
    translate([0,-10]) circle(r=1.5);
    translate([0,10]) circle(r=1.5);
  }
}

module WriteToggle()
{
  color([0,0,1.0]) rotate([0,90,0]) linear_extrude(height=3) WriteToggle2D();
}

module ReadOutputBar2D()
{
  difference() {
    union() {
      square([10,300]);
      translate([0,180+40-5])square([20,10]);
    }
    // Holes for toggles 
    translate([15,180+40]) circle(r=1.5);
    // Dowel holes at each end for slots
    translate([5,5]) circle(r=1.5);
    translate([5,300-5]) circle(r=1.5);
  }

}

module ReadOutputBar()
{
  color([0,1.0,0]) rotate([0,90,0]) linear_extrude(height=3) ReadOutputBar2D();
}
