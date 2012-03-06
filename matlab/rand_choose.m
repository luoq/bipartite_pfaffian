function x=rand_choose(n,k)
%% randomly choose k from n
%% x is a 0-1 vector of size n,where 1 means chosen
x=zeros(1,n);
i=1;
while k>0
	if rand<k/(n-i+1)
		x(i)=1;
		k=k-1;
	end
	i=i+1;
end