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
translate([105,150+40-2.5,-20]) sphere(r=2);
translate([105,150+40+2.5,-20]) sphere(r=2);

translate([300,0,0]) FrontPanel();
translate([0,0,0]) EndPlate();

// Read and write bars
translate([0,150+40-2,10-2]) cube([400,4,4]);
translate([0,180+40-2,10-2]) cube([400,4,4]);

translate([300+7,180+40,10]) rotate([7,0,0]) ReadToggle();
translate([304,0,60]) ReadOutputBar();
translate([304,150+40,10]) WriteToggle();
