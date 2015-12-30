# Mechanical SAM

![Drawing of SAM module](https://raw.githubusercontent.com/jmacarthur/mechanical-sam/master/overview-small.png)

Mechanical, binary, sequential-access memory. Shown in this image is a 3 bit x approximately 30 word memory.

Please note that this design is not complete and has not been constructed yet.

# Priniciple of operation

The memory is based on perforated steel sheet, on which 4mm diameter ball bearings are placed. A single ball bearing is either in the '0' or '1' position to record memory values. No ball bearings are added to or removed from the sheet.

There is a pair of lead screws which move the read head across this sheet; this read head will then read 3 bits of data at a time and present the results on bowden cables. It is sequential access memory (SAM) meaning that you can only move to the memory location one space forward or backwards from the current one. There is no index or record of the current position inside the memory itself.

# To do

* Add the reverse gear and differential drive to the lead screws.
* Add a timing pulley to each leadscrew with a belt between them to keep them synchronised.
* Test the movement of the read output bar.
* Add some means to automatically centre the write bar before movement.
* Add bearings wherever any rotating parts meet. To run square rods in a round hole, it may be necessary to make sleeves which adapt them to round shapes which will then sit in a ball bearing.

# How to operate the memory

There are six boolean inputs to the memory: Three data lines, one for each bit to be written, a direction line, a drive enable bit, and a read enable bit. Each of these is expected to have two bowden cable lines, one for each value. There's also a continuous rotating shaft needed to actually rotate the lead screws.

I'll assume a cycle starts with the memory at rest; the read head is positioned exactly over a data word. At this point, your logic should already have update the write lines to alter the data in the current cell. The direction bit should also be set up. Read enable should be off. The write lines should be set to neutral, i.e. halfway between 1 and 0.

You should then assert drive enable for exactly 13 revolutions of the main drive shaft. During this time, the lead screws will rotate 4 and one third revolutions; the 2mm pitch on the screw will move the read head on 8.66mm in either direction.

Drive enable should then be turned off, and read enable should be cycled on and off. This will set up the read lines. All the read lines are powered from the read enable line, so you must have sufficient force applied to overcome the loading of whatever your read lines are connected to.

There is currently no protection against seeking past the end of the data in either direction.

# Future improvements

There is enough space on the grid to fit five bits of data in, with two rows inside the existing three. There isn't enough space on the front panel to read that data out, but you could have a second front panel with staggered readers in front of the existing panel, or a panel at the other end of the reader.