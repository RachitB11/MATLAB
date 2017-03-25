% descs1 is a 64x(n1) matrix of double values
% descs2 is a 64x(n2) matrix of double values
% match is n1x1 vector of integers where m(i) points to the index of the
% descriptor in p2 that matches with the descriptor p1(:,i).
% If no match is found, m(i) = -1

function [match] = feat_match(descs1, descs2)
rat_thresh = 0.6;
D1 = descs1';
D2 = descs2';
[idx,SSD] = knnsearch(D2,D1,'K',2,'NSMethod','kdtree');
rat_bin = (SSD(:,1)./SSD(:,2))<rat_thresh;
match = idx(:,1).*rat_bin;
match(match==0) = -1;


% for  i = 1:n1
%     curr_desc = repmat(descs1(:,i),1,n2);
%     SSD = sum((curr_desc-descs2).^2)';
%     [SSD,ind] = sort(SSD,'ascend');
%     SSD1=SSD(1);
%     SSD2=SSD(2);
%     if (SSD1/SSD2)<rat_thresh
%        match  = [match;ind(1)];
%     else
%        match  = [match;-1];
%     end
% end