thin = 0.01;

readBarRotate = 10; // Min 10, Max 20ish?
writeBarRotate = 12; // +/- 12 degrees; should be zero to move.

readHeadAdjustY = -13;

// Grid: RS stock no 817448, confirmed by measurement                                                                                                 
gridPitch = 5;
holeDiameter = 3;
gridThickness = 0.7;
gridSpacingY = gridPitch*sin(60);
gridSpacingX = gridPitch;

// Ball bearings. Available from simplybearings.co.uk.
bbDiameter= 4;

// Calculated stuff
bbRadius = bbDiameter / 2;
halfHoleDiameter = holeDiameter / 2;
bbHeight = sqrt(bbRadius*bbRadius - halfHoleDiameter * halfHoleDiameter);

//        /|\                                                                                                                                       
//       / | \                                                                                                                                      
//      /  |  \ bbRadius                                                                                                                            
//     /   |   \                                                                                                                                    
//    /    |    \                                                                                                                                   
//   /     |a    \  a=bbHeight                                                                     
//  /      |      \                                                                                                                                  
//  <------------->                                                                                                                 
//  holeDiameter     

// If bb centres are at zero height, then the grid starts at height bbHeight - bbRadius

