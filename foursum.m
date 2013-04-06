function X=foursum(X1,cycle1,X2,cycle2)
% foursum of X1,X2 along a 4-cycle
% cycle2,cycle2 are 2*2 matrices
% 1st(2nd) row of cycle1(2) is the two vertices in row(column) color class in
% cycle
n1=size(X1,1);n2=size(X2,1);
mask1_r=false(n1,1);mask1_c=false(n1,1);
mask2_r=false(n2,1);mask2_c=false(n2,1);
mask1_r(cycle1(1,:))=true;mask1_c(cycle1(2,:))=true;
mask2_r(cycle2(1,:))=true;mask2_c(cycle2(2,:))=true;

X=[blkdiag(X1(~mask1_r,~mask1_c),X2(~mask2_r,~mask2_c)) [X1(~mask1_r,mask1_c);X2(~mask2_r,mask2_c)];
    [X1(mask1_r,~mask1_c) X2(mask2_r,~mask2_c)] ones(2)];
end
