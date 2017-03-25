function  desc  = make_desc( samp )
g=fspecial('gaussian', [40, 40],10);
g=g/max(g(:));
samp = samp.*g;
samp = samp(1:5:end,1:5:end);
samp = samp(:);
desc = samp-mean(samp);
desc = desc/std(samp);
end

