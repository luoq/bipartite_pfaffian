% rng(123)
% res=bilayer_test(4,4,1000);
% save('bilayer_4_4_1000_123.mat','res')
% rng(267)
% res=bilayer_test(5,5,1000);
% save('bilayer_5_5_1000_267.mat','res')
% rng(1234)
% res=bilayer_test(6,6,1000);
% save('bilayer_6_6_1000_1234.mat','res')
% rng(1234)
% res=bilayer_test(7,7,500);
% save('bilayer_7_7_500_1234.mat','res')
% rng(1544)
% res=bilayer_test(7,7,500);
% save('bilayer_7_7_500_1544.mat','res')
% rng(2301)
% res=bilayer_test(8,8,250);
% save('bilayer_8_8_250_2301.mat','res')
% rng(4628)
% res=bilayer_test(8,8,50);
% save('bilayer_8_8_50_4628.mat','res')
% rng(5467)
% res=bilayer_test(8,8,150);
% save('bilayer_8_8_150_5467.mat','res')
% rng(5490)
% res=bilayer_test(8,8,10);
% save('bilayer_8_8_10_5490.mat','res')
% rng(6997)
% res=bilayer_test(8,8,40);
% save('bilayer_8_8_40_6997.mat','res')
% rng(37745)
% res=bilayer_test(8,8,500);
% save('bilayer_8_8_500_37745.mat','res')

% rng(2637)
% res=bilayer_test(10,10,1000);
% save('bilayer_10_10_1000_2637.mat','res')

%% diag_test
% diag_test_result={};

% R=1000;

% seed=1234;
% tic
% res=diag_test(mc20,R,seed);
% time=toc
% diag_test_result=[diag_test_result; {'mc20' seed res time}];
% save('diag_test_result.mat','diag_test_result')

% seed=7628;
% tic
% res=diag_test(mc26,R,seed);
% time=toc
% diag_test_result=[diag_test_result; {'mc26' seed res time}];
% save('diag_test_result.mat','diag_test_result')
% seed=7634;
% tic
% res=diag_test(mc24,R,seed);
% time=toc
% diag_test_result=[diag_test_result; {'mc24' seed res time}];
% save('diag_test_result.mat','diag_test_result')

% seed=13884;
% tic
% res=diag_test(mc30{1},R,seed);
% time=toc
% diag_test_result=[diag_test_result; {'mc30_1' seed res time}];
% save('diag_test_result.mat','diag_test_result')

% seed=7843;
% tic
% res=diag_test(F60,R,seed);
% time=toc
% diag_test_result=[diag_test_result; {'F60' seed res time}];
% save('diag_test_result.mat','diag_test_result')

% seed=4374;
% tic
% res=diag_test(mc40{13},R,seed);
% time=toc
% diag_test_result=[diag_test_result; {'mc40_13' seed res time}];
% save('diag_test_result.mat','diag_test_result')
% 
% seed=43277;
% tic
% res=diag_test(mc46{52},R,seed);
% time=toc
% diag_test_result=[diag_test_result; {'mc46_52' seed res time}];
% save('diag_test_result.mat','diag_test_result')
% 
% seed=43277;
% tic
% res=diag_test(mc50{111},R,seed);
% time=toc
% diag_test_result=[diag_test_result; {'mc50_111' seed res time}];
% save('diag_test_result.mat','diag_test_result')
% 
% seed=43277;
% tic
% res=diag_test(mc56{512},R,seed);
% time=toc
% diag_test_result=[diag_test_result; {'mc56_512' seed res time}];
% save('diag_test_result.mat','diag_test_result')

for i=1:89
    seed=7621+i^3;
    tic
    res=diag_test(mc44{i},R,seed);
    time=toc
    diag_test_result=[diag_test_result; {sprintf('mc44_%d',i) seed res time}];
    save('diag_test_result.mat','diag_test_result')
end
