function T=trisectors(G)
n=size(G,1);
T=[];
for i=1:n
    for j=i+1:n
        for k=j+1:n
            G1=minor(G,[i j k]);
            [c,sizes]=components(G1);
            len=length(sizes);
            if len>=3
                T=[T;[repmat([i j k],n-k,1),(k+1:n)']];
            elseif len==2
                for s=1:len
                    mask=(c==s);
                    a=biconnected_components(G1(mask,mask));
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

% function x=old_index(x,i,j,k)
% if x>k-3
%     x=x+3;
% elseif x>j-2
%     x=x+2;
% elseif x>i-1
%     x=x+1;
% end
    