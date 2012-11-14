function A=regularMatrix(n,d)
row_nnz=d*ones(n,1);
col_nnz=row_nnz;
A=matrixWithNnz(row_nnz,col_nnz);