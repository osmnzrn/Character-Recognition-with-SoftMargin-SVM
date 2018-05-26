clear all
close all
clc
warning off

load SVMBEST.mat LAMBDASbest SVbest SGbest SV T Y MinT MaxT


vid=videoinput('macVideo',1);
vidRes=get(vid,'VideoResolution');
nBands=get(vid,'NumberofBands');
hImage=image(zeros(vidRes(2),vidRes(1),nBands));
preview(vid,hImage);

htext=text(0.1,0.1,['0',num2str(10)]);
set(htext,'FontSize',30);
set(htext,'Color',[rand rand rand]);
pause(1)

for k=1:10
    delete(htext)
    htext=text(0.1,0.1,['0',num2str(10-k)]);
    set(htext,'FontSize',30);
    set(htext,'Color',[rand rand rand]);
    pause(1)
end

OriginalImage=getsnapshot(vid);%resmi alýrýz
stop(vid)
delete(vid)
close all

subplot(321),
imshow(OriginalImage)%aldýðýmýz resmi gösterir.
title('orjinal resim')

subplot(322),
[x]=rgb2gray(OriginalImage);
imshow(x)
title('grey image');%gri tonlamalý


subplot(323),
%[x]=im2bw(x);
%[x] = imbinarize(x,'adaptive','ForegroundPolarity','dark','Sensitivity',0.4);
%[x] = imbinarize(x,'adaptive','ForegroundPolarity','dark');
%[x] = imbinarize(x, 'adaptive');
[x] = imbinarize(x);
imshow(x)
title('imbinarized image')



loop=1; left=0;
while loop
    left=left+1;
    I=length(find(x(:,left)==0));
    if I>5 | left>=size(x,2)
        loop=0;
    end
end
line([left,left],[1,size(x,1)])

loop=1;
right=size(x,2);


while loop
    right=right-1;
    I=length(find(x(:,right)==0));
    if I>5 | right<=1
        loop=0;
    end
end
line([right,right],[1,size(x,1)])


loop=1;
up=0;
while loop
    up=up+1;
    I=length(find(x(up,:)==0));
    if I>5 | up>=size(x,1)
        loop=0;
    end
end
line([1,size(x,2)],[up,up])


loop=1;
bottom=size(x,1);
while loop
    bottom=bottom-1;
    I=length(find(x(bottom,:)==0));
    if I>5 | bottom<=1
        loop=0;
    end
end
line([1,size(x,2)],[bottom,bottom])


subplot(324),
[x]=x(up:bottom,left:right);
imshow(x)
title('cropped image')


subplot(325),
[a,b]=size(x);
[x]=x(1:a/28:end,1:b/28:end);
imshow(x)
title('28x28 image')

subplot(326),
x = abs(x-1);
imshow(x);
title('Test image')

[FV] = feature_extractor(x);
test = FV;
%test = [(FV - MinT)/(MaxT - MinT)];  %normalization


for i=1:SVbest(:,1)
    yhat = ModelKernelSMC(test,LAMBDASbest(:,1),T,Y(:,1),SGbest(:,1));
end
for i=1:SVbest(:,2)
    yhat1 = ModelKernelSMC(test,LAMBDASbest(:,2),T,Y(:,2),SGbest(:,2));
end

if yhat>0
    if yhat1 > 0
        ANS = ('O')
    else
        ANS = ('Z')
    end
    
else
    if yhat1 > 0
        ANS = ('H')
    else
        ANS = ('X')
    end
    
end 




