%%% To Detect the Text from Natutal Images
%function textext();   unlimited-scans
clc;
clear all;
close all;
aplh=[48 122];
%% read the image file
k=input('Enter image number 1 to 8 for im1 to im8 : ')
text_image =imread(['im' , num2str(k), '.jpg']);
[a b c]=size(text_image);
if c==1
Igray= text_image;%rgb2gray(text_image);
else
  Igray= rgb2gray(text_image);
  
end
th = graythresh(Igray);
Ib = im2bw(Igray,th);
figure
subplot(1,2,1)
imshow(text_image,[]),title('original Image');
subplot(1,2,2)
imshow(Igray),title('Gray scale Image');
figure,imshow(Ib)
%% IMPLEMENTATION OF Edge detection ALGORITHM %%%%%%%%%%%%%%%%%%%%%%%%%
% [Gx Gy Gxy]= echeck(Ib,'lap');
[Gx, Gy] = imgradientxy(Igray);
Gxy=sqrt(Gx.^2 + Gy.^2);
figure

subplot (2,2,1);
imshow(Gx,[]); title ('Vertical detect');
subplot(2,2,2);
imshow(Gy,[]); title ('horizontal detect');
subplot(2,2,3);
imshow(Gxy,[]); title ('edge detection');
%%
% Morphological processing
Gxy8 = im2bw(uint8((Gxy))) & Ib;
figure,imshow(Gxy8);title('Edge ')
se=strel('disk',5);
dIM1 =imclose( imdilate(Gxy8,se),se);

figure;
imshow(dIM1);
title (' dilated image'); 
se2=strel('disk',1);
Iop = imerode(dIM1,se2);
figure;
imshow(Iop);
title ('eroded image');
final = ((Iop & Ib));
figure;
imshow(final);
title( 'final');

 Icorrected = imtophat(Igray, strel('disk', 10));
 th  = graythresh(Icorrected)
  BW1 = im2bw(Icorrected, th);
 figure,imshow(BW1)
   %%
% character segmentation and regonition 
textnew = ocr(final,'TextLayout', 'Block');
load R1
[r1 c1]=size(txt{k});
textext=txt{k}
newtxt=textext;
tempttxt=textext;




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Effect of noise
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cnew=[randi(c1,1,ceil(randi(c1)/2))];rnew=[randi(r1,1,ceil(randi(r1)/2))];
adr1=reshape(char(randi([aplh(1),aplh(2)],1,length(rnew)*length(cnew))),length(cnew),length(rnew));
newtxt(rnew,cnew)=adr1';
In=imnoise(text_image,'salt & pepper',0.02);
figure,imshow(In);
text_image=In;
title('Image with salt and pepper niose')


sum(sum((([newtxt~=textext]))))/numel(textext);
[a b c]=size(text_image);
if c==1
Igray= text_image;%rgb2gray(text_image);
else
  Igray= rgb2gray(text_image);
  
end
Iblur1 = medfilt2(Igray,[2,2]);
Igray=Iblur1;
figure,imshow(Iblur1);
title('Image after removing niose')
th = graythresh(Igray);
Ib = im2bw(Igray,th);
figure

imshow(Igray),title('Noisy Gray scale Image');
figure,imshow(Ib)
%% IMPLEMENTATION OF Edge detection ALGORITHM %%%%%%%%%%%%%%%%%%%%%%%%%
% [Gx Gy Gxy]= echeck(Ib,'lap');
[Gx, Gy] = imgradientxy(Igray);
Gxy=sqrt(Gx.^2 + Gy.^2);
figure

subplot (2,2,1);
imshow(Gx,[]); title ('Vertical detect');
subplot(2,2,2);
imshow(Gy,[]); title ('horizontal detect');
subplot(2,2,3);
imshow(Gxy,[]); title ('edge detection');
%%
% Morphological processing
Gxy8 = im2bw(uint8((Gxy))) & Ib;
figure,imshow(Gxy8);title('Edge in noisy image')
se=strel('disk',5);
dIM1 =imclose( imdilate(Gxy8,se),se);

figure;
imshow(dIM1);
title (' dilated noisy image'); 
se2=strel('disk',1);
Iop = imerode(dIM1,se2);
figure;imshow(Iop);
title ('eroded noisy image');
final = ((Iop & Ib));
figure;
imshow(final);
title( 'final noisy image');

 Icorrected = imtophat(Igray, strel('disk', 10));
 th  = graythresh(Icorrected);
  BW1 = im2bw(Icorrected, th);
 figure,imshow(BW1)
   %%
% character segmentation and regonition 
textnew = ocr(final,'TextLayout', 'Block');
load R1
newtxt
figure,plot([2*r1*ones(1,c1)],'w')
text(1,2*r1,tempttxt)
title('Exttracted Text')

orgtx=org{k};
accuracy1=100-100*(sum(sum((orgtx~=textext)))/numel(textext))
accuracy2=100-100*(sum(sum((orgtx~=newtxt)))/numel(textext))