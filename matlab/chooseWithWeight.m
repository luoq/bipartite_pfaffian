function i=chooseWithWeight(w)
S=sum(w);
if S<=0
    i=-1;
    return
end
A=0;
p=rand();
for i=1:length(w)
    A=A+w(i);
    if p<A/S
        return
    end
end
