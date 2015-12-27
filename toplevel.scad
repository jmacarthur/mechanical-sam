include <parts.scad>
include <assemblies.scad>

// Two lead screws and nuts, 300mm apart

rotate([0,90,0]) 
{
  LeadScrewNut();
  LeadScrew();
  translate([0,300,0]) {
    LeadScrewNut();
    LeadScrew();
  }
};

ReadWriteHead();


// Example data
translate([5,150+40-2.5,-20]) sphere(r=2);
translate([5,150+40+2.5,-20]) sphere(r=2);
