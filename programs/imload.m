function [ image ] = imload( filename )
%IMLOAD Summary of this function goes here
%  Detailed explanation goes here

image = double(imread(filename))/255;