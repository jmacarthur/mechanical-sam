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

ReadHead();
