ns=[4,5,6,7,8];
files={'bilayer_4_4_1000_123.mat'
    'bilayer_5_5_1000_267.mat'
    'bilayer_6_6_1000_1234.mat'
    'bilayer_7_7_1000.mat'
    'bilayer_8_8_1000.mat'
    };

% summary=zeros(length(ns),4);
% for i=1:length(ns)
%     load(files{i})
%     summary(i,1)=mean(res(:,2));
%     summary(i,2)=std(res(:,2));
%     n_ratio=(res(:,1)-1)/ns(i)^2;
%     summary(i,3)=mean(n_ratio);
%     summary(i,4)=std(n_ratio);
% end
% 
% plot(ns,summary(:,1))

%% plot p
% figure
% styles=repmat({'k-','k--','k:','k-.'},1,4);
% grid on
% hold on
% for i=1:length(ns)
%     n=ns(i);
%     load(files{i})
%     [P,x]=ecdf(res(:,2));
%     linewidth=0.5*ceil(i/4);
%     plot(x,1-P,styles{i},'LineWidth',linewidth,'DisplayName', sprintf('m=n=%d',n))
% end
% legend('-DynamicLegend');
% hold off
% print -deps 'figure/bilayer-p.eps'

%% plot n
% figure
% styles=repmat({'k-','k--','k:','k-.'},1,4);
% grid on
% hold on
% for i=1:length(ns)
%     n=ns(i);
%     load(files{i})
%     [P,x]=ecdf((res(:,1)-1)/n^2);
%     linewidth=0.5*ceil(i/4);
%     plot(x,1-P,styles{i},'LineWidth',linewidth,'DisplayName', sprintf('m=n=%d',n))
% end
% legend('-DynamicLegend');
% hold off
% print -deps 'figure/bilayer-n.eps'

figure
styles=repmat({'k-','k--','k:','k-.'},1,4);
grid on
hold on% figure
% styles=repmat({'k-','k--','k:','k-.'},1,4);
% grid on
% hold on
% for i=1:length(ns)
%     n=ns(i);
%     load(files{i})
%     [P,x]=ecdf(res(:,2));
%     linewidth=0.5*ceil(i/4);
%     plot(x,1-P,styles{i},'LineWidth',linewidth,'DisplayName', sprintf('m=n=%d',n))
% end
% legend('-DynamicLegend');
% hold off
% print -deps 'figure/bilayer-p.eps'

for i=1:length(ns)
    n=ns(i);
    load(files{i})
    [P,x]=ecdf(res(:,1)-1);
    linewidth=0.5*ceil(i/4);
    plot(x,1-P,styles{i},'LineWidth',linewidth,'DisplayName', sprintf('m=n=%d',n))
end
legend('-DynamicLegend');
hold off
print -deps 'figure/bilayer-n-raw.eps'