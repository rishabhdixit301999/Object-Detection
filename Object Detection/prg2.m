clc ;clear all;close all

%% Step 1: Load image
k=ls;
colorImage = imcrop(imread(k(10,:)));
figure; imshow(colorImage); title('Original image')

%% Step 2: Detect MSER Regions
% Detect and extract regions
grayImage = colorImage;% rgb2gray(colorImage);
mserRegions = detectMSERFeatures(grayImage,'RegionAreaRange',[10 50]);
mserRegionsPixels = vertcat(cell2mat(mserRegions.PixelList));  % extract regions

% Visualize the MSER regions overlaid on the original image
figure; imshow(colorImage); hold on;
plot(mserRegions, 'showPixelList', true,'showEllipses',false);
title('MSER regions');
%% Step 3: Use Canny Edge Detector to Further Segment the Text
% Convert MSER pixel lists to a binary mask
mserMask = false(size(grayImage));
ind = sub2ind(size(mserMask), mserRegionsPixels(:,2), mserRegionsPixels(:,1));
mserMask(ind) = true;
figure,imshow(mserMask);
% Run the edge detector


blobAnalyzer = vision.BlobAnalysis('MaximumCount', 500);
BW1=im2bw(colorImage,0.6);
% Run the blob analyzer to find connected components and their statistics.
[area, centroids, roi] = step(blobAnalyzer,~BW1 );
% Show all the connected regions
img = insertShape(colorImage, 'rectangle', roi);
figure;
imshow(img);
results = ocr(colorImage, roi, 'TextLayout', 'Block');

text = deblank( {results.Text} );
img  = insertObjectAnnotation(colorImage, 'rectangle', roi, text);

figure;
imshow(img)