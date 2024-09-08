% myUnitTest.m
a = [2 3 4];b = [5 6 7];

exp = [7 9 11];
act = a + b;

assert(isequal(exp,act))

% 単体テスト
% result = runtests('myUnitTest1.m')
% myUnitTest1 を実行しています
% .
% myUnitTest1 が完了しました
% __________
% 
% 
% result = 
% 
%   TestResult のプロパティ:
% 
%           Name: 'myUnitTest1/myUnitTest1'
%         Passed: 1
%         Failed: 0
%     Incomplete: 0
%       Duration: 0.0307
%        Details: [1×1 struct]
% 
% 合計:
%    1 Passed, 0 Failed, 0 Incomplete.
%    0.030695 秒間のテスト時間。
