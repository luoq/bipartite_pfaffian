function A=grid_graph_color_class(varargin)
% grid_graph_color_class(x...) get the color class of grid_graph(x...)
k = length(varargin);
if k==1 && numel(varargin{1}) > 1
    varargin = num2cell(varargin{1});
    k = length(varargin);
else
    if any(cellfun('prodofsize',varargin)~=1)
        error('matlab_bgl:invalidArgument',...
            'please specific the size of dimension in the arguments');
    end
end
dim_size = cell2mat(varargin);

A=1;
for i=1:length(dim_size)
    A=kron(line_class(dim_size(i)),A);
end

function x=line_class(n)
if mod(n,2)==0
    x=repmat([1 -1],1,n/2);
else
    x=[repmat([1 -1],1,(n-1)/2) 1];
end
