include <globals.scad>
barHoleRadius = sqrt(2*2+2*2);
outputDriveOffset = 15; // Amount drive slots (top of output bar) are offset from the toggles they drive below

$fn=20;

module SupportPlate2D()
{
  difference() {
    translate([-20,-20]) square([300+40,40]);
    for(bit=[0,1,2]) {
      // Holes for write rods.
      translate([bit*bitSpacing+bit0Y,10]) circle(r=barHoleRadius);
      // Holes for read rods.
      translate([bit*bitSpacing+bit0Y+30+readHeadAdjustY,0]) circle(r=barHoleRadius);
    }
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
  for(bit=[0,1,2]) {
    translate([4,bit*bitSpacing+bit0Y+30+readHeadAdjustY,0]) rotate([readBarRotate,0,0]) ReadHead();
    translate([8,bit*bitSpacing+bit0Y,10]) WriteHead();
  }
}

module ReadHead2D() 
{
  difference() {
    translate([-5,-5])
    polygon(points= [[0,0], [20,0], [24,20], [21,20], [15,10], [0,10]], paths = [[0,1,2,3,4,5]]);
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
      polygon(points= [[-15,-5], [15,-5], [9,28], [6,30], [6,5], [-6,5], [-6,30], [-9,28]], paths = [[0,1,2,3,4,5,6,7]]);
    translate([-2,-2]) square(size=[4,4]);
  }
}

module WriteHead()
{
  color([0.0,0.1,1.0,0.5]) rotate([-90+writeBarRotate,0,0]) rotate ([0,90,0]) linear_extrude(height=3) WriteHead2D();
}

module EndPlate() 
{
  SupportPlate();
}

module WriteBowdenPlate()
{
  difference() {
    cube([30,50,3]);
    translate([3+15,5,-thin]) cylinder(r=1, h=3+2*thin);
    translate([3+15,25,-thin]) cylinder(r=1, h=3+2*thin);
    translate([3+9,20,-thin]) cylinder(r=1, h=3+2*thin);
    translate([3+9,40,-thin]) cylinder(r=1, h=3+2*thin);
  }
}


module FrontPanel2D()
{
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
    // Holes for crank axles
    translate([0,bit0Y,0]) for(bit=[0,1,2,3]) {
      translate([bit*bitSpacing+60+25+outputDriveOffset,35]) circle(r=1.5);
    }
  }
}

module FrontPanel()
{
  union(){
    rotate([90,0,90]) linear_extrude(height=3) FrontPanel2D();
    //translate([27,0,0]) rotate([90,0,90]) linear_extrude(height=3) FrontPanel2D();
    for(bit=[0,1,2]) 
      translate([0, bit*bitSpacing+bit0Y+readHeadAdjustY, 70])  WriteBowdenPlate();
  }
}


module ReadToggle2D()
{
    difference() {
      rotate(-14.5) { // Adjust this so it's halfway into the range of rotation of the read head
	union() {
	  polygon(points=[[-35,-20], [-35,-15], [-30,-15], [-20,0], [-30,15], [-35,15], [-35,20], [15,1], [15,-1]], paths = [[0,1,2,3,4,5,6,7,8]]);
	  translate([-0,-15]) square([5,30]); // Travel lifting bar
	}
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
      translate([0,bit0Y]) for(bit=[0,1,2]) {
	translate([-10,bit*bitSpacing-5+30+outputDriveOffset]) square([10,20]);
	translate([0,bit*bitSpacing-5+30+readHeadAdjustY])square([20,10]);
	translate([5,bit*bitSpacing-2.5+30+readHeadAdjustY-10])square([65,5]);
      }
    }
    translate([0,bit0Y]) for(bit=[0,1,2]) {
      // Holes for toggles 
      translate([15,bit*bitSpacing+30+readHeadAdjustY]) circle(r=1.5);
      // Hole for transit read raiser pin
      translate([66,bit*bitSpacing+30+readHeadAdjustY-10]) circle(r=1.5);
    }
    // Dowel holes at each end for slots
    translate([5,5]) circle(r=1.5);
    translate([5,300-5]) circle(r=1.5);
    // Drive slots
    translate([0,bit0Y]) for(bit=[0,1,2]) {
      translate([-5,bit*bitSpacing+30+outputDriveOffset]) circle(r=1.5);
      translate([-5-1.5,bit*bitSpacing+30+outputDriveOffset]) square([3,10]);
      translate([-5,bit*bitSpacing+30+10+outputDriveOffset]) circle(r=1.5);
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
    union() {
      for(bit=[0,1,2]) {
	translate([bit*bitSpacing,0]) polygon(points=[[0,5], [10,5], [15,0], [bitSpacing-5,0], [bitSpacing,5], [bitSpacing, 15], [bitSpacing-10,15], [bitSpacing-15,10], [20,10], [15,15],[0,15]
						      ], polys=[[0,1,2,3,4,5,6,7,8,9,10]]);
      }
    }
    for(bit=[0,1,2]) {
      translate([bit*bitSpacing+45+outputDriveOffset,5]) circle(r=1.5);
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
      translate([-15,-5]) square([30,5]);
    }
    for(x=[-10,0,10]) {
      translate([x,0]) circle(r=1.5);
    }
  }
}

module ReadOutputBar()
{
  color([0,1.0,0]) rotate([0,90,0]) linear_extrude(height=3) ReadOutputBar2D();
  //color([0,1.0,0]) translate([21,0,0]) rotate([0,90,0]) linear_extrude(height=3) ReadOutputBar2D();
  translate([0,bit0Y,0]) for(bit=[0,1,2]) {
    color([0.0,1.0,1.0]) translate([3,bit*bitSpacing+30+outputDriveOffset,10]) rotate([90,0,90]) linear_extrude(height=3) OutputCrank2D();
    //color([0.0,1.0,1.0]) translate([18,x-30+outputDriveOffset,10]) rotate([90,0,90]) linear_extrude(height=3) OutputCrank2D();
    translate([6,bit*bitSpacing+30+readHeadAdjustY,-15]) rotate([90,0,90]) linear_extrude(height=3) OutputToggle2D();
  }
  translate([15,bit0Y+10,-17.5]) color([1.0,0.0,1.0]) rotate([90,0,90]) linear_extrude(height=3) DriveBar2D();
}
