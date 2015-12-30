include <globals.scad>

// Leadscrew nut. This is a Rondo ball screw nut, from:
// http://www.mooreinternational.co.uk/category-24/RONDO8x2.html

l2 = 3;
l3 = 5;
l4 = 25;

module LeadScrewNut()
{
  difference() {
    union() {
      cylinder(r=10.25,h=l4);
      cylinder(r=10.5, h = l2+l3);
      cylinder(r=19,h=l3);
    }
    rotate([0,0,120]) translate([29/2,0,-thin]) cylinder(r=1.5, h=l3+2*thin);
    rotate([0,0,240]) translate([29/2,0,-thin]) cylinder(r=1.5, h=l3+2*thin);
    rotate([0,0,000]) translate([29/2,0,-thin]) cylinder(r=1.5, h=l3+2*thin);
    translate([0,0,-thin]) cylinder(r=4, h=l4+2*thin);
  }
}

module LeadScrew()
{
  cylinder(r=4, h=400);
}

// Other parts, not modelled:

/* Hexagon pattern perforated steel sheet:
   http://uk.rs-online.com/web/p/perforated-steel-sheets/0817448
   When used as a rectangular grid, it's 5mm between the spaces on the 
   short axis, and 8.666mm between spaces on the long axis.
   Hexagon grid is used because no appropriate square pattern grid exists. */


