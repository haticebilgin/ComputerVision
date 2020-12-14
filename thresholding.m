function Threshold = thresholding(I,option)
%option 1 ---- iterative basic thresholding
%option 2 ---- Otsu's Thresholding
%option 3 ---- Optimum Tresholding

if option == 1  %iterative basic thresholding
    
figure 
subplot(1, 2, 1);
imshow(I);
title('Gray Image');
subplot(1, 2, 2);
imhist(I);
title('Histogram of Gray Image');

counts=imhist(I); % histogram
N=sum(counts);

for i=1:256
    P(i)=counts(i)/N; %probability 
end

i=1;
T(i)=240;  %initial Treshold given by me
mean_1=mean(I(1:T(i)));
mean_2 =mean(I(T(i):end));

i=i+1;
T(i)=round((mean_2+mean_1)/2);


while abs(T(i)-T(i-1))>=1      
    
    w0=sum(P(1:T(i))); % Probability of class 1 (1:T)
    w1=sum(P(T(i)+1:256)); %probability of class2 (T+1 : 256)
   
    mean_1=dot([0:T(i)-1],P(1:T(i)))/w0;     % class 1  mean 
    mean_2=dot([T(i):255],P(T(i)+1:256))/w1; % class 2 mean 
    
    i=i+1;
    T(i)=round((mean_2+mean_1)/2); %update T as the average of the means 
    Threshold=T(i);
   
    img = I >= Threshold;
end
figure 
subplot(1, 2, 1);
imshow(I);
title('Gray Image');
subplot(1, 2, 2);
imshow(img);
title('Binary Image');

%Histogram of binary image
img_vec = img(:);
total = numel(img_vec);
white = sum(img_vec);
black = total - white;
figure
bar([black white]);
set(gca(),'XTickLabel',{'Black' 'White'});
set(gca(),'YLim',[0 total]);
title('Histogram of Binary Image');
 

elseif option == 2 %OTSU's method
figure 
subplot(1, 2, 1);
imshow(I);
title('Gray Image');
subplot(1, 2, 2);
imhist(I);
title('Histogram of Gray Image');
%%=================================================================================================
counts=imhist(I); % histogram
N=sum(counts);   
max=0; 
%%================================================================================================
for i=1:256
    P(i)=counts(i)/N; %probability 
end
%%================================================================================================
for T=2:255      
    w0=sum(P(1:T)); % Probability of class 1 
    w1=sum(P(T+1:256)); %probability of class2
  
    mean_1=sum([0:T-1].*P(1:T))/w0; % class 1 mean 
    mean_2=sum([T:255].*P(T+1:256))/w1; % class 2 mean 
    
    sigma_vb=w0*w1*((mean_2-mean_1)^2); % variance(between class)
    
    if sigma_vb>max % compare sigma with maximum 
        max=sigma_vb; % update the value of max i.e max=sigma
        Threshold=T-1; % desired threshold corresponds to maximum variance of between class
        g = I >= Threshold;
    end

end
%%====================================================================================================

figure 
subplot(1, 2, 1);
imshow(I);
title('Gray Image');
subplot(1, 2, 2);
imshow(g);
title('Binary Image');

elseif option ==3 
figure 
subplot(1, 2, 1);
imshow(I);
title('Gray Image');
subplot(1, 2, 2);
imhist(I);
title('Histogram of Gray Image');

counts=imhist(I); % histogram
N=sum(counts);

for i=1:256
    P(i)=counts(i)/N; %probability
end

for T=2:255       
    
    w0=sum(P(1:T)); % Probability of class 1 (separated by threshold)
    w1=sum(P(T+1:256)); %probability of class2 (separated by threshold)
   
    mean_1=dot([0:T-1],P(1:T))/w0; % class mean u0
    mean_2=dot([T:255],P(T+1:256))/w1; % class mean u1
    var_1 =dot(((1:T)-mean_1).^2,P(1:T))/w0;
    var_2 =dot(((T:255)-mean_2).^2,P(T+1:256))/w1;

    error = ((sum(P(1:T))*w0 + sum(P(T+1:255))*w1)-imhist(I(1:T)))/N ;
    y(T)=error(T);
    %y(T)=abs(error(T));
        
     
end
minimum = min(min(y(2:end)));
[~,Threshold]=find(y==minimum);
img = I >= Threshold;

figure 
subplot(1, 2, 1);
imshow(I);
title('Gray Image');
subplot(1, 2, 2);
imshow(img);
title('Binary Image');


%Histogram of binary image
img_vec = img(:);
total = numel(img_vec);
white = sum(img_vec);
black = total - white;
figure
bar([black white]);
set(gca(),'XTickLabel',{'Black' 'White'});
set(gca(),'YLim',[0 total]);
title('Histogram of Binary Image');    
      
end
end