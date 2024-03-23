% A=imread ('andromeda.bmp') ;
% for i=1:size(A,1)
%     for j=1:size(A,2)
%         B(i,j,1)=A(i,j,1);
%         B(i,j,2)=A(i,j,2);
%         B(i,j,3)=A(i,j,3);
%     end
% end
% imshow (B)
% imwrite(B,'andromeda_copiee.bmp');

% A=imread ('andromeda.bmp') ;

% B(1:size(A,1), 1:size(A,2), 1:3) = A(1:size(A,1), 1:size(A,2), 1:3);
% B(:,:,1:3)=0;

% imshow(B)
% imwrite(B,'andromeda_copiee.bmp');


% A=imread ('andromeda.bmp') ;

% B(1:size(A,1), 1:size(A,2), 1:3) = A(1:size(A,1), 1:size(A,2), 1:3);
% B(50:150,50:150,1)=255;
% B(50:150,50:150,2)=0;
% B(50:150,50:150,3)=0;

% imshow(B)
% imwrite(B,'andromeda_copiee.bmp');

A=imread ('andromeda.bmp') ;

B(1:size(A,1), 1:size(A,2), 1:3) = A(1:size(A,1), 1:size(A,2), 1:3);
B(50:150,50:150,1)=255;
B(50:150,50:150,2)=0;
B(50:150,50:150,3)=0;

imshow(B)
imwrite(B,'andromeda_copiee.bmp');