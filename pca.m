clear all;
clc;
close all;
% P = '/Users/dinghaoran/Desktop/Final Project/9th week/unkown';
% D = dir(fullfile(P,'*.png'));
% C = cell(size(D));
% for k = 1:numel(D)
%     C{k,1} = imread(fullfile(P,D(k).name));
% end
% save C C;
load('I.mat');
num = 64;
M=(zeros(num,142*124));
for i=1:num
    M(i,:)=reshape(I(:,:,i),1,142*124);
end
save M M;
load('M.mat');
[U,S,V] = svd(M,'econ');

L1 = U(:,1:4) * sqrt(S(1:4,1:4));
S1 = sqrt(S(1:4,1:4)) * V(:,1:4)';
for i = 1:17608
    S1(2,i)=S1(2,i)/S1(1,i);
    S1(3,i)=S1(3,i)/S1(1,i);
    S1(4,i)=S1(4,i)/S1(1,i);
    S1(1,i)=1;
end
St_struct = load('targetZ');
St = St_struct.targetZ;
[Nx, Ny, Nz] = surfnorm(St);
S2 = zeros(4,142*124);
S2(1,:)=1;
S2(2,:)=reshape(Nx,1,142*124);
S2(3,:)=reshape(Ny,1,142*124);
S2(4,:)=reshape(Nz,1,142*124);
% for j=1:142
%     for k=1:124
%         S2(1,(j-1)*124+k)=1;
%         S2(2,(j-1)*124+k)=Nx(j,k);
%         S2(3,(j-1)*124+k)=Ny(j,k);
%         S2(4,(j-1)*124+k)=Nz(j,k);
%     end
% end

% [Uu,Ss,Vv] = svd(M1,'econ');
% S2 = sqrt(Ss) * Vv';

% for i=1:142
%     for j=1:124
%         normN = sqrt(N(i,j,1).^2 + N(i,j,2).^2 + N(i,j,3).^2);
%         temp=N(i,j,3);
%         N(i,j,1) = -N(i,j,1)./normN/temp;
%         N(i,j,2) = -N(i,j,2)./normN/temp;
%         N(i,j,3) = -1/normN;
% 
%     end
% end


%for j=1:142
%    for k=1:124
%        P(j,k,1:3)=IMAGE(2:4,(j-1)*124+k);
%    end
%end

score = zeros(64,1);
for i=1:64
    a = 0;
    ima = M(i,:);
    ima1 = L1(i,:)*S1;
    for j=1:142*124
        a = a+(ima1(1,j)-ima(1,j))^2;
    end
    score(i) = a;
end
[ minvalue, index]=sort(score);
for i=1:19
    number = index(i);
    LL(i,:)=L1(number,:);
    MM(i,:)=M(number,:);
end
for i=1:142*124;
    S1(:,i)=(LL'*LL+diag([-1 1 1 1]))^-1*LL'*MM(:,i);
end
A = linsolve(S1',S2');
IMAGE = (A*S1)';
N(:,:,1) = reshape(IMAGE(:,2),142,124);
N(:,:,2) = reshape(IMAGE(:,3),142,124);
N(:,:,3) = reshape(IMAGE(:,4),142,124);
normN = sqrt(N(:,:,1).^2 + N(:,:,2).^2 + N(:,:,3).^2);
temp=N(:,:,1);
N(:,:,1) = N(:,:,1)./normN;
N(:,:,2) = N(:,:,2)./normN;
N(:,:,3) = N(:,:,3)./normN;
mask = ones(142,124);
Z = Integration_FC(N, mask,4,'F',0,0);
showsurf(Z);