Image stitching using Homography estimated from RANSAC
Written by, Rachit Bhargava

The code is yet to be commented properly. 

USAGE:
I = mymosaic(Image_Set);
imshow(I); To view the mosaic
Image_Set = Set of the images to be stitched stored in a cell array from a left to right order

Example:
Run test.m:
% To get the stitched image of the golden gate bridge.
load('Im_group1.mat');
I = mymosaic(Im_cell);
imshow(I);

Example Data:
Im_group1.mat contains greyscale image cell array for GOLDEN GATE panorama.
Im_group2.mat contains RGB image cell array for LONDON panorama.
Golden_Gate.mat contains the mosaic for the 1st image group.
London.mat contains the mosaic for the 2nd image group.