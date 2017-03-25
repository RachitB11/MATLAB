% img = double (height)x(width) array (grayscale image) with values in the
% range 0-255
% x = nx1 vector representing the column coordinates of corners
% y = nx1 vector representing the row coordinates of corners
% descs = 64xn matrix of double values with column i being the 64 dimensional
% descriptor computed at location (xi, yi) in im

function [descs] = feat_desc(img, x, y)
num_pts = numel(x);
img = double(padarray(img, [20, 20]));
descs = [];
for i = 1:num_pts
    Y = y(i)+20;
    X = x(i)+20;
    samp = img((Y - 19) : (Y + 20), (X - 19) : (X + 20));
    desc = make_desc(samp);
    descs = [descs,desc];
end
end