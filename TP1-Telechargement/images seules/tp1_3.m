% close all
% clear all
% for i=1:100
%     for j=1:200
%         B(i,j,1)=0;
%         B(i,j,2)=0;
%         B(i,j,3)=255;
%     end
%     for j =201:400
%         B(i,j,1)=0;
%         B(i,j,2)=255;
%         B(i,j,3)=0;
%     end
% end
% imshow(uint8(B));


% close all
% clear all
% B(1:100, 1:200, 1) = 0;
% B(1:100, 1:200, 2) = 0;
% B(1:100, 1:200, 3) = 255;

% B(1:100, 201:400, 1) = 0;
% B(1:100, 201:400, 2) = 255;
% B(1:100, 201:400, 3) = 0;
% imshow(uint8(B));


% B(1:100, 1:200, 3) = 255;
% B(1:100, 201:400, 2) = 255;
% imshow(uint8(B));


B(1:100, 1:200, 3) = 255;
B(1:100, 201:400, 2) = 255;
imshow(uint8(B));