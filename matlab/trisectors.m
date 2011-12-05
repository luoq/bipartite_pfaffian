function T=trisectors(G)
n=size(G,1);
for i=1:n
    for j=i+1:n
        for k=j+1:n
            [a C]=biconnected_components(minor(G,[i j k]));
        end
    end
end