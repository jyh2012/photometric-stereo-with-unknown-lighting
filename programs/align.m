function [ images_out, bkgs_out ] = align( images, bkgs, targetimage )
%ALIGN: Align images and the background image to the targetimage. The
%       purpose is to adjust the image size according to the distance 
%       between two eye centers.
%   Input:  images: a series of images of a model under the same view
%                   direction but different illuminating conditions.
%           bkg: the background image of the series of images. It's a binary
%                image with values '0' and '1', '0' means the background
%                while '1' means the foreground.
%           targetimage: the reference image that the other input images to
%                        be aligned to.
%   Output: images_out: the aligned images
%           bkg_out: the aligned background image
%
% Jing Wu, Cardiff University, UK, 2010.
% J.Wu@cs.cardiff.ac.uk

%get the eye center positions of the reference image
disp('Please click at:');
disp('1. left corner of left eye');
disp('2. right corner of left eye');
disp('3. left corner of right eye');
disp('4. right corner of right eye');
disp('5. tip of nose');
disp('6. middle of mouth');
disp('....................................');
figure(8);imshow(targetimage);
A = in_mouse(6,8);
base_points=round(A);
close(8);
%dist_base=sqrt((base_points(1,1)-base_points(2,1)).^2+(base_points(1,2)-base_points(2,2)).^2);

for i=1:64
    image_in=images(:,:,i);
    bkg_in=bkgs(:,:,i);
%get the eye center positions of one of the input image, the other images
%have the same positions.
disp('Please click at:');
disp('1. left corner of left eye');
disp('2. right corner of left eye');
disp('3. left corner of right eye');
disp('4. right corner of right eye');
disp('5. tip of nose');
disp('6. middle of mouth');
disp('....................................');
if (i==1)
    figure(8);imshow(image_in);
    A = in_mouse(6,8);
    input_points=round(A);
    close(8);
end
%dist_input=sqrt((input_points(1,1)-input_points(2,1)).^2+(input_points(1,2)-input_points(2,2)).^2);

TFORM = fitgeotrans(input_points, base_points, 'similarity');
image_out = imwarp(image_in, TFORM, 'OutputView', imref2d(size(targetimage)));
bkg_out = imwarp(bkg_in, TFORM, 'OutputView', imref2d(size(targetimage)));
% imwrite(image_out,['image_yaleB_',num2str(floor(i/10)),num2str(mod(i,10)),'.png']);
% imwrite(bkg_out,['bkg_yaleB_',num2str(floor(i/10)),num2str(mod(i,10)),'.png']);
images_out(:,:,i)=image_out;
bkgs_out(:,:,i)=bkg_out;
end

end

