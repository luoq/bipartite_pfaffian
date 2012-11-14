function T=trisectors_brute(G,findone)
if nargin==1
    findone=false;
end
n=size(G,1);
T=[];
for i=1:n
    for j=i+1:n
        for k=j+1:n
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