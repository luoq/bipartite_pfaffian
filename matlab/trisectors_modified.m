function T=trisectors_modified(G)
n=size(G,1);p=n/2;%n should be even
T=[];
for i=1:p
    for j=i+1:p
        for k=p+1:n
            G1=minor(G,[i j k]);
            [c,sizes]=components(G1);
            len=length(sizes);
            if len>=4
                T=[T;[repmat([i j k],n-k,1),(k+1:n)']];
            elseif len==3
                % pay attention
                % if some components have single vertex v
                % removing v leaves 2 components
                single=(sizes==1);
                temp=(k+1:n);
                temp=temp(~single(c(temp-3)));%shift -3 because of 3 vetices removed before
                if ~isempty(temp)
                    T=[T;[repmat([i j k],length(temp),1),temp']];
                end
            elseif len==2
                nonsingle=find(sizes>1);
                if isempty(nonsingle)
                    continue
                end
                for s=nonsingle'
                    mask=(c==s);
                    a=biconnected_components(G1(mask,mask));
                    temp=find(mask);a=temp(a);
                    a=a(a>k-3);
                    if ~isempty(a)
                        T=[T;[repmat([i,j,k],length(a),1) a+3]];
                    end
                end
            else %len==1
                [a C]=biconnected_components(G1);
                a=a(a>k-3);
                if ~isempty(a)
                    for l=a'
                        neighbor=C(l,:);
                        if length(unique(neighbor(neighbor~=0)))>=3
                            T=[T;[i j k l+3]];
                        end
                    end
                end
            end
        end
    end
end