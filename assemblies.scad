include <globals.scad>
barHoleRadius = sqrt(2*2+2*2);
outputDriveOffset = 20; // Amount drive slots (top of output bar) are offset from the toggles they drive below

$fn=20;

module SupportPlate2D()
{
  difference() {
    translate([-20,-20]) square([300+40,40]);
    // Holes for read rods.
    translate([40+150,10]) circle(r=barHoleRadius);
    // Holes for write rods.
    translate([40+180,10]) circle(r=barHoleRadius);
    // Holes for leadscrews.
    translate([0,0]) cylinder(r=4);
    translate([300,0]) cylinder(r=4);

  }
}

module SupportPlate() 
{
  rotate([90,0,90]) linear_extrude(height=3) SupportPlate2D();
}

module ReadWriteHead()
{
  SupportPlate();
  //color([1.0,1.0,0.0,0.5]) translate([12,0,0]) SupportPlate();
  translate([4,40+180,10]) rotate([readBarRotate,0,0]) ReadHead();
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
    cube([15,30,3]);
    translate([3+6+1.5,5,-thin]) cylinder(r=1, h=3+2*thin);
    translate([3+6+1.5,25,-thin]) cylinder(r=1, h=3+2*thin);
  }
}

module FrontPanel()
{
  union(){
    rotate([90,0,90]) linear_extrude(height=3) {
      difference() {
	union() {
	  SupportPlate2D();
	  translate([-20,20-thin]) square([300+40,50]);
	}
	for(x=[5,300-5]) {
	  translate([x,40]) circle(r=1.5);
	  translate([x,55]) circle(r=1.5);
	  translate([x-1.5,40]) square([3,15]);
	}
	for(x=[20,120,220]) {
	  translate([x+25,65]) circle(r=1.5);
	}
      }
    }
    translate([0, 150+40-15, 30])  WriteBowdenPlate();
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
  color([0,0,1.0]) translate([6,0,0]) rotate([0,90,0]) linear_extrude(height=3) WriteToggle2D();
}

module ReadOutputBar2D()
{
  difference() {
    union() {
      square([10,300]);
      // Extensions for drive slots
      for(x=[20, 120, 220]) {
	translate([-10,x-5+outputDriveOffset]) square([10,20]);
	translate([0,x-5])square([20,10]);
      }

    }
    for(x=[20,120,220]) {
      // Holes for toggles 
      translate([15,x]) circle(r=1.5);
    }
    // Dowel holes at each end for slots
    translate([5,5]) circle(r=1.5);
    translate([5,300-5]) circle(r=1.5);
    // Drive slots
    for(x=[20, 120, 220]) {
      translate([-5,x+outputDriveOffset]) circle(r=1.5);
      translate([-5-1.5,x+outputDriveOffset]) square([3,10]);
      translate([-5,x+10+outputDriveOffset]) circle(r=1.5);
    }
  }

}


module OutputCrank2D()
{
  difference() {
    union() {
      polygon(points=[[0,0], [30,0], [30,-30], [20,-30], [0,-10]], polys=[[0,1,2,3,4]]);
    }
    translate([5,-5]) circle(r=1.5);
    translate([25,-5]) circle(r=1.5);
    translate([25,-25]) circle(r=1.5);
    translate([25,-20]) circle(r=1.5);
    translate([25-1.5,-25]) square([3,5]);
    
  }
}

module DriveBar2D()
{
  difference() {
    square([400,10]);
    for(x=[20,120,220]) {
      translate([x+25+outputDriveOffset,5]) circle(r=1.5);
    }
  }
}

module OutputToggle2D()
{
  difference() {
    union() {
      translate([-10,0]) circle(r=5);
      translate([10,0]) circle(r=5);
      translate([-10,-5]) square([20,10]);
    }
    for(x=[-10,0,10]) {
      translate([x,0]) circle(r=1.5);
    }
  }
}

module ReadOutputBar()
{
  color([0,1.0,0]) rotate([0,90,0]) linear_extrude(height=3) ReadOutputBar2D();
  for(x=[20,120,220]) {
    color([0.0,1.0,1.0]) translate([3,x+outputDriveOffset,10]) rotate([90,0,90]) linear_extrude(height=3) OutputCrank2D();
    translate([3,x,-15]) rotate([90,0,90]) linear_extrude(height=3) OutputToggle2D();
  }
  translate([9,0,-17.5]) rotate([90,0,90]) linear_extrude(height=3) DriveBar2D();
}

