clear all;
clc;
close all;
load('C.mat');
for i=1:64
    C{i}=im2double(C{i});
    for j=1:480
        for k=1:640
            images(j,k,i)=double(C{i}(j,k));
        end
    end
end
bkgs=ones(480,640,64);
targetimage=imread('targetimage.png');
I=align(images,bkgs,targetimage);
save I I;