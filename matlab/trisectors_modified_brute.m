function T=trisectors_modified_brute(G,findone)
if nargin==1
    findone=false;
end
n=size(G,1);p=n/2;%n should be even
T=[];
for i=1:p
    for j=i+1:p
        for k=p+1:n
            for l=k+1:n
                G1=minor(G,[i j k l]);
                [~,sizes]=components(G1);
                if length(sizes) >=3 
                    T=[T;[i j k l]];
                    if findone
                        return
                    end
                end
            end
        end
    end
end