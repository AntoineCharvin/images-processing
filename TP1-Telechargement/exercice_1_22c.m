close all
clc

data=regionprops(Fp);
size(data)

FpLabel=bwlabel(Fp);
imshow(FpLabel,[])

grain=(FpLabel==17);
figure, imshow(grain,[])

aires=[data.Area];
figure, hist(aires)