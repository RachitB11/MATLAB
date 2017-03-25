% y1, x1, y2, x2 are the corresponding point coordinate vectors Nx1 such
% that (y1i, x1i) matches (x2i, y2i) after a preliminary matching

% thresh is the threshold on distance used to determine if transformed
% points agree

% H is the 3x3 matrix computed in the final step of RANSAC

% inlier_ind is the nx1 vector with indices of points in the arrays x1, y1,
% x2, y2 that were found to be inliers

function [H, inlier_ind] = ransac_est_homography(x1, y1, x2, y2, thresh)
num_corr = numel(x1);
num_iter = 5000;
H_cell = {};
inlier_cell = {};
R_score = [];
for i = 1:num_iter
    pts = randperm(num_corr,4);
    H_in  = est_homography(x1(pts),y1(pts),x2(pts),y2(pts));
    H_cell = [H_cell;{H_in}];
   [X, Y] = apply_homography(H_in, x2, y2);
   SSD = ((X-x1).^2+(Y-y1).^2);
   log_inlier = sqrt(SSD)<thresh;
   inlier_cell = [inlier_cell;{log_inlier}];
   R_score = [R_score;sum(log_inlier)];
end

[~,ind] = max(R_score);
inlier_ind = inlier_cell{ind};
H = est_homography(x1(inlier_ind),y1(inlier_ind),x2(inlier_ind),y2(inlier_ind));
end