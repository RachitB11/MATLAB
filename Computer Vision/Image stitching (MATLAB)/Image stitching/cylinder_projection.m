function proj_img = cylinder_projection(image, f)

if ndims(image)==3
    [ysize, xsize, ~] = size(image);
else
    [ysize, xsize] = size(image);
end

xc = xsize/2;
yc = ysize/2;

for y = 1 : ysize
    for x = 1 : xsize
        theta = (x - xc)/f;
        h = (y - yc)/f;
        xcap = sin(theta);
        ycap = h;
        zcap = cos(theta);
        xnew = xcap / zcap;
        ynew = ycap / zcap;

        ximg = round(f * xnew + xc);
        yimg = round(f * ynew + yc);
        
        if (ximg > 0 && ximg <= xsize && yimg > 0 && yimg <= ysize)
            if ndims(image) == 3
                proj_img(y, x, :) = [image(yimg, ximg, 1) image(yimg, ximg, 2) image(yimg, ximg, 3)];
            else
                proj_img(y, x) = image(yimg, ximg);
            end
        end
                               
    end
end