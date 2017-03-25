% Adaptive Non-Maximal Suppression
% cimg = corner strength map
% max_pts = number of corners desired
% [x, y] = coordinates of corners
% rmax = suppression radius used to get max_pts corners

function [x, y, rmax] = anms(cimg, max_pts)
%     locmax = imregionalmax(cimg);
%     cimg = cimg.*locmax;
    mask = ones(17,17);
    mask(9,9) = 0;
    locmax = cimg > imdilate(cimg, mask);
    cimg = cimg.*locmax;
    [y,x,val] = find(cimg);
    X = repmat(x',numel(x),1);
    Y = repmat(y',numel(y),1);
    Dist_mat = sqrt((X-X').^2 + (Y-Y').^2);
    Val_mat = repmat(val',numel(val),1);
    mask=bsxfun(@gt,Val_mat,val);
    Dist_mat = mask.*Dist_mat;
    Dist_mat(Dist_mat==0) = inf;
    rad = min(Dist_mat,[],2);
    [rad, ind] = sort(rad,'descend');
    x = x(ind(1:max_pts));
    y = y(ind(1:max_pts));
    rad = rad(1:max_pts);
    rmax = rad(2);    
end