function A=matrixWithNnz(row_nnz,col_nnz)
n=length(row_nnz);
restart=true;
while true
    if restart
        left_r=row_nnz;
        left_c=col_nnz;
        A=sparse(n,n);
        restart=false;
    end
    i=chooseWithWeight(left_r);
    if i==-1
        break
    end
    j=chooseWithWeight(left_c);
    if A(i,j)==0
        A(i,j)=1;
        left_r(i)=left_r(i)-1;
        left_c(j)=left_c(j)-1;
    else
        restart=true;
    end
end
