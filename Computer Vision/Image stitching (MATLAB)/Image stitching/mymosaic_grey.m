% img_input is a cell array of color images (HxWx3 uint8 values in the
% range [0,255])
% img_mosaic is the output mosaic
function [img_mosaic] = mymosaic_grey(img_input)
img_mosaic = img_input{1};
H_to1 = eye(3);
H_cell = {};
X_shift = 0;
Y_shift = 0;
for i = 1:(numel(img_input)-1)
i
I0  = img_input{i};
I1  = img_input{i+1};
display('ok0');
cimg0 = corner_detector(I0);
cimg1 = corner_detector(I1);
display('ok1');
[x0, y0, rmax0] = anms(cimg0, 500);
[x1, y1, rmax1] = anms(cimg1, 500);
display('ok2');
descs0 = feat_desc(I0, x0, y0);
descs1 = feat_desc(I1, x1, y1);
display('ok3');
[match] = feat_match(descs0, descs1);
display('ok3.5');
[ind,~,match_red] = find(match.*(match~=-1));
match_tab = [ind,match(ind)];
x0 = x0(match_tab(:,1));
x1 = x1(match_tab(:,2));
y0 = y0(match_tab(:,1));
y1 = y1(match_tab(:,2));
display('ok4');
[H, inlier_ind] = ransac_est_homography(x0, y0, x1, y1, 2);
display('ok5');
H_cell = [H_cell; {H}];
% visual_match( I0,I1,x0, y0, x1, y1, inlier_ind)
H_to1 = H_to1*H;
[h, w] = size(I1);
corn1 = [1,1;w,1;w,h;1,h;1,1];
[Xc, Yc] = apply_homography(H_to1,corn1(:,1),corn1(:,2));
pad_Y = ceil(max(max(max(Yc)-size(img_mosaic,1),0),max(0-min(Yc),0)));
pad_X = 0;
padder = ceil(max(max(Xc)-size(img_mosaic,2),0));
img_mosaic  = padarray(img_mosaic,[pad_Y,0]);
img_mosaic  = padarray(img_mosaic,[0,padder],'post');
I0 = img_mosaic;
X_shift = X_shift +pad_X;
Y_shift = Y_shift +pad_Y;
corn0  = [round(Xc)+X_shift,round(Yc)+Y_shift];
[h0, w0] = size(I0);
mask  = poly2mask(corn0(:,1),corn0(:,2),h0,w0);
x_coord = 1:w0;
y_coord = 1:h0;
[x,y] = meshgrid(x_coord,y_coord);
x_seg = nonzeros(mask.*x);
y_seg = nonzeros(mask.*y);
[X_seg, Y_seg] = apply_homography(inv(H_to1),x_seg(:)-X_shift,y_seg(:)-Y_shift);
X_seg = min(max(X_seg,1),w);
Y_seg = min(max(Y_seg,1),h);
idx = sub2ind([h0,w0],y_seg,x_seg);
double(I0);
I0(idx) = interp2(double(I1),X_seg,Y_seg);
% imshow(uint8(I0));
img_mosaic = I0;
% pause();
display('ok6');
end
end
%