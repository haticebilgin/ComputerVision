img = im2double(imread('Kýz-Kulesi-Gece.jpg')); 
img = rgb2gray(img);
mask =[-1 -1 -1; -1 8 -1; -1 -1 -1];
mask2=[0 0 1 0 0 ; 0 1 2 1 0 ; 1 2 -16 2 1 ;0 1 2 1 0;0 0 1 0 0];
mask3=[0 0 0 -1 -1 -2 -1 -1 0 0 0;
    0 0 -2 -4 -8 -9 -8 -4 -2 0 0 ; 
    0 -2 -7 -15 -22 -23 -22 -15 -7 -2 0  ;
    0 -2 -7 -15 -22 -23 -22 -15 -7 -2 0;
    -1 -4 -15 -24 -14 -1 -14 -24 -15 -4 -1;
    -1 -8 -22 -14 52 103 52 -14 -22 -8 -1;
    -1 -8 -22 -14 52 103 52 -14 -22 -8 -1;
    -1 -4 -15 -24 -14 -1 -14 -24 -15 -4 -1;
    0 -2 -7 -15 -22 -23 -22 -15 -7 -2 0;
    0 0 -2 -4 -8 -9 -8 -4 -2 0 0;
    0 0 0 -1 -1 -2 -1 -1 0 0 0];

%----------------------------------------------------
out_1 = imfilter(img, mask, 'conv');
%Normalize
minR = min(out_1(:));
maxR = max(out_1(:));
out_1 = (out_1 - minR) / (maxR - minR);
%----------------------------------------------------
out_2 = imfilter(img, mask2, 'conv'); 
%Normalize
minR = min(out_2(:));
maxR = max(out_2(:));
out_2 = (out_2 - minR) / (maxR - minR);
%----------------------------------------------------
out_3 = imfilter(img, mask3, 'conv'); 
%Normalize
minR = min(out_3(:));
maxR = max(out_3(:));
out_3 = (out_3 - minR) / (maxR - minR);
%----------------------------------------------------

figure; 
subplot(1,3,1);
imshow(out_1); 
title('Laplacian filtered(3*3) Image');

subplot(1,3,2);
imshow(out_2); 
title('Laplacian filtered(5*5) Image');

subplot(1,3,3);
imshow(out_3); 
title('Laplacian filtered(11*11) Image');
%----------------------------------------------------
figure 
subplot(1,2,1);
imshow(img); 
title('Original Image');
subplot(1,2,2);
imshow(out_1); 
title('Laplacian filtered(3*3) Image');
%----------------------------------------------------
figure 
subplot(1,2,1);
imshow(img); 
title('Original Image');
subplot(1,2,2);
imshow(out_2); 
title('Laplacian filtered(5*5) Image');
%----------------------------------------------------
figure 
subplot(1,2,1);
imshow(img); 
title('Original Image');
subplot(1,2,2);
imshow(out_3); 
title('Laplacian filtered(11*11) Image');
%----------------------------------------------------
mask_1 = imresize(mask,[512 512]);
mask_2 = imresize(mask2,[512 512]);
mask_3 = imresize(mask3,[512 512]);

F_1= fft2(mask_1);
F_2= fft2(mask_2);
F_3= fft2(mask_3);

Shifted_1 =fftshift(F_1);
Shifted_2 =fftshift(F_2);
Shifted_3 =fftshift(F_3);

S_1= log(1+abs(Shifted_1));
S_2= log(1+abs(Shifted_2));
S_3= log(1+abs(Shifted_3));

figure 
subplot(1,3,1);
imshow(S_1,[]);
title('Fft of Laplacian Kernel(3*3)');
subplot(1,3,2);
imshow(S_2,[]);
title('Fft of Laplacian Kernel(5*5)');
subplot(1,3,3);
imshow(S_3,[]);
title('Fft of Laplacian Kernel(11*11)');












