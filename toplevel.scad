include <parts.scad>
include <assemblies.scad>

// Two lead screws and nuts, 300mm apart
translate([0,0,0]) rotate([0,90,0]) 
{
  LeadScrew();
  translate([0,300,0]) {
    LeadScrew();
  }
};

translate([100,0,0]) rotate([0,90,0]) 
{
  LeadScrewNut();
  translate([0,300,0]) {
    LeadScrewNut();
  }
};

translate([100,0,0]) ReadWriteHead();

// Example data
translate([105,bit0Y-2.5,-20]) sphere(r=2);
translate([105,bit0Y+2.5,-20]) sphere(r=2);

translate([300,0,0]) FrontPanel();
translate([0,0,0]) EndPlate();

// Read and write bars
translate([0,bit0Y,10]) rotate([writeBarRotate,0,0 ]) translate([0,-2,-2]) cube([400,4,4]); // Write.
translate([0,bit0Y+30+readHeadAdjustY,0]) rotate([readBarRotate, 0, 0]) translate([0,-2,-2]) cube([400,4,4]); // Read

translate([300+10,bit0Y+30+readHeadAdjustY,0]) rotate([readBarRotate,0,0]) ReadToggle();
translate([304,0,60]) ReadOutputBar();
translate([310,bit0Y,10]) rotate([writeBarRotate]) WriteToggle();

// The grid (floor)
translate([-500,-500,-20-2-bbRadius+bbHeight]) color([0.5,0.5,0.5]) cube([1000,1000,2]);
