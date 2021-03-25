clc; clear all; close all;

n = [10 15 20 25 30 35 40 45 50];

figure(1);
Fib_recursive_time_measured = (10^13) * [0.0000103 0.0000921 0.0003313 0.001123 0.0047802 0.0530822 0.657733 5.8565681 67.841351];
Fib_recursive_time_analytic = 2.^n;
plot(n, Fib_recursive_time_measured, n, Fib_recursive_time_analytic);
title('Fibinacci Recursive, Measured time vs Analytic time');
xlabel('n'); ylabel('time cost');
legend('Measured, scale = 10^1^3','Analytic');


figure(2);
Fib_memo_time_measured = (10^6.25) * [0.000004 0.0000053 0.000006 0.0000099 0.000013 0.0000247 0.0000278 0.0000279 0.0000288];
Fib_memo_time_analytic = n;
plot(n, Fib_memo_time_measured, n, Fib_memo_time_analytic);
title('Fibinacci Memoized, Measured time vs Analytic time');
xlabel('n'); ylabel('time cost');
legend('Measured, scale = 10^6^.^2^5','Analytic');

figure(3);
Fib_bottomup_time_measured = (10^7) * [0.0000019 0.0000021 0.0000021 0.0000025 0.0000027 0.0000032 0.0000033 0.0000036 0.0000038];
Fib_bottomup_time_analytic = n;
plot(n, Fib_bottomup_time_measured, n, Fib_bottomup_time_analytic);
title('Fibinacci Bottom-up, Measured time vs Analytic time');
xlabel('n'); ylabel('time cost');
legend('Measured, scale = 10^7','Analytic');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n2 = [9 10 15 20 21 22 23 24 25];

figure(4);
MCM_recursive_time_measured = (10^5) *[0.0002091 0.000354 0.009989 1.6328187 4.4026697 12.1277889 35.0766308 99.7583389 310.3068068];
MCM_recursive_time_analytic = 2.^(n2);
plot(n2, MCM_recursive_time_measured, n2, MCM_recursive_time_analytic);
title('MCM Recursive, Measured time vs Analytic time');
xlabel('n'); ylabel('time cost');
legend('Measured, scale = 10^5','Analytic');

n3 =[100 200 300 400 500 600 700 800 900 1000];

figure(5);
MCM_memo_time_measured = (10^8.5) *[0.0334225 0.0628519 0.0825136 0.1312796 0.202252 0.3742886 0.9300596 0.9610571 1.905447 2.7381927];
MCM_memo_time_analytic = n3.^3;
plot(n3, MCM_memo_time_measured, n3, MCM_memo_time_analytic);
title('MCM Memoized, Measured time vs Analytic time');
xlabel('n'); ylabel('time cost');
legend('Measured, scale = 10^8^.^5','Analytic');
