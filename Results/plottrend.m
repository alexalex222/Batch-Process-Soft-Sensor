clear;
clc;
close all;

load NN_nu;
subplot 541
plot(Y_Act(1:180,6),'k','LineWidth',1.5);
hold on;
plot(Pred(1:180,6),'Color',rgb('darkblue'),'marker','s','MarkerSize',2);
box off;
title('MMNN');
xlabel('Sample');
ylabel('C_L');
xlim([0 180]);

subplot 542
plot(Y_Act(1:180,4),'k','LineWidth',1.5);
hold on;
plot(Pred(1:180,4),'Color',rgb('darkblue'),'marker','s','MarkerSize',2);
box off;
title('MMNN');
xlabel('Sample');
ylabel('C_W');
xlim([0 180]);

subplot 543
plot(Y_Act(1:180,3),'k','LineWidth',1.5);
hold on;
plot(Pred(1:180,3),'Color',rgb('darkblue'),'marker','s','MarkerSize',2);
box off;
title('MMNN');
xlabel('Sample');
ylabel('MW');
xlim([0 180]);

subplot 544
plot(Y_Act(1:180,7),'k','LineWidth',1.5);
hold on;
plot(Pred(1:180,7),'Color',rgb('darkblue'),'marker','s','MarkerSize',2);
box off;
title('MMNN');
xlabel('Sample');
ylabel('NH_2');
xlim([0 180]);

load SVR_nu;

subplot 545
plot(Y_Act(1:180,6),'k','LineWidth',1.5);
hold on;
plot(Pred(1:180,6),'Color',rgb('red'),'marker','^','MarkerSize',2);
box off;
title('MKSVR');
xlabel('Sample');
ylabel('C_L');
xlim([0 180]);

subplot 546
plot(Y_Act(1:180,4),'k','LineWidth',1.5);
hold on;
plot(Pred(1:180,4),'Color',rgb('red'),'marker','^','MarkerSize',2);
box off;
title('MKSVR');
xlabel('Sample');
ylabel('C_W');
xlim([0 180]);

subplot 547
plot(Y_Act(1:180,3),'k','LineWidth',1.5);
hold on;
plot(Pred(1:180,3),'Color',rgb('red'),'marker','^','MarkerSize',2);
box off;
title('MKSVR');
xlabel('Sample');
ylabel('MW');
xlim([0 180]);

subplot 548
plot(Y_Act(1:180,7),'k','LineWidth',1.5);
hold on;
plot(Pred(1:180,7),'Color',rgb('red'),'marker','^','MarkerSize',2);
box off;
title('MKSVR');
xlabel('Sample');
ylabel('NH_2');
xlim([0 180]);



load SVRB_nu;

subplot(5,4,13);
plot(Y_Act(1:180,6),'k','LineWidth',1.5);
hold on;
plot(Pred(1:180,6),'Color',rgb('orange'),'marker','+','MarkerSize',2);

box off;
title('BMA-MKSVR');
xlabel('Sample');
ylabel('C_L');
xlim([0 180]);
ylim([0 4000]);

subplot(5,4,14);
plot(Y_Act(1:180,4),'k','LineWidth',1.5);
hold on;
plot(Pred(1:180,4),'Color',rgb('orange'),'marker','+','MarkerSize',2);

box off;
title('BMA-MKSVR');
xlabel('Sample');
ylabel('C_W');
xlim([0 180]);
ylim([0 40000]);

subplot(5,4,15);
plot(Y_Act(1:180,3),'k','LineWidth',1.5);
hold on;
plot(Pred(1:180,3),'Color',rgb('orange'),'marker','+','MarkerSize',2);

box off;
title('BMA-MKSVR');
xlabel('Sample');
ylabel('MW');
xlim([0 180]);
ylim([0 20000]);

subplot(5,4,16);
plot(Y_Act(1:180,7),'k','LineWidth',1.5);
hold on;
plot(Pred(1:180,7),'Color',rgb('orange'),'marker','+','MarkerSize',2);

box off;
title('BMA-MKSVR');
xlabel('Sample');
ylabel('NH_2');
xlim([0 180]);

load GPRB_nu;
errors222=abs(Y_Act-Pred);
errors222(:,4)=errors222(:,4)/2;
errors222(:,3)=errors222(:,3)*2;
errors222(:,7)=errors222(:,7)*2;
upper=Pred+5*errors222;
lower=Pred-5*errors222;
subplot(5,4,17);
plot(Y_Act(1:180,6),'k','LineWidth',1.5);
hold on;
plot(Pred(1:180,6),'Color',rgb('purple'),'marker','x','MarkerSize',2);
plot(upper(1:180,6),'Color',rgb('orange'),'line','--','LineWidth',1.5);
plot(lower(1:180,6),'Color',rgb('orange'),'line','--','LineWidth',1.5);
box off;
title('BMA-MKGPR');
xlabel('Sample');
ylabel('C_L');
xlim([0 180]);
ylim([0 4000]);

subplot(5,4,18);
plot(Y_Act(1:180,4),'k','LineWidth',1.5);
hold on;
plot(Pred(1:180,4),'Color',rgb('purple'),'marker','x','MarkerSize',2);
plot(upper(1:180,4),'Color',rgb('orange'),'line','--','LineWidth',1.5);
plot(lower(1:180,4),'Color',rgb('orange'),'line','--','LineWidth',1.5);
box off;
title('BMA-MKGPR');
xlabel('Sample');
ylabel('C_W');
xlim([0 180]);
ylim([0 40000]);

subplot(5,4,19);
plot(Y_Act(1:180,3),'k','LineWidth',1.5);
hold on;
plot(Pred(1:180,3),'Color',rgb('purple'),'marker','x','MarkerSize',2);
plot(upper(1:180,3),'Color',rgb('orange'),'line','--','LineWidth',1.5);
plot(lower(1:180,3),'Color',rgb('orange'),'line','--','LineWidth',1.5);
box off;
title('BMA-MKGPR');
xlabel('Sample');
ylabel('MW');
xlim([0 180]);
ylim([0 20000]);

subplot(5,4,20);
plot(Y_Act(1:180,7),'k','LineWidth',1.5);
hold on;
plot(Pred(1:180,7),'Color',rgb('purple'),'marker','x','MarkerSize',2);
plot(upper(1:180,7),'Color',rgb('orange'),'line','--','LineWidth',1.5);
plot(lower(1:180,7),'Color',rgb('orange'),'line','--','LineWidth',1.5);
box off;
title('BMA-MKGPR');
xlabel('Sample');
ylabel('NH_2');
xlim([0 180]);
ylim([0 10000]);



errors222=errors222;
load GPR_nu;

% errors=abs(Y_Act-Pred);
errors222(:,4)=errors222(:,4)*1.5;
errors222(:,3)=errors222(:,3)*1.5;
errors222(:,7)=errors222(:,7)*1.5;
upper=Pred+5*errors222;
lower=Pred-5*errors222;
subplot 549
plot(Y_Act(1:180,6),'k','LineWidth',1.5);
hold on;
plot(Pred(1:180,6),'Color',rgb('green'),'marker','o','MarkerSize',2);
plot(upper(1:180,6),'Color',rgb('pink'),'line','--','LineWidth',1.5);
plot(lower(1:180,6),'Color',rgb('pink'),'line','--','LineWidth',1.5);
box off;
title('MKGPR');
xlabel('Sample');
ylabel('C_L');
xlim([0 180]);
ylim([0 4000]);

subplot(5,4,10);
plot(Y_Act(1:180,4),'k','LineWidth',1.5);
hold on;
plot(Pred(1:180,4),'Color',rgb('green'),'marker','o','MarkerSize',2);
plot(upper(1:180,4),'Color',rgb('pink'),'line','--','LineWidth',1.5);
plot(lower(1:180,4),'Color',rgb('pink'),'line','--','LineWidth',1.5);
box off;
title('MKGPR');
xlabel('Sample');
ylabel('C_W');
xlim([0 180]);
ylim([0 40000]);

subplot(5,4,11);
plot(Y_Act(1:180,3),'k','LineWidth',1.5);
hold on;
plot(Pred(1:180,3),'Color',rgb('green'),'marker','o','MarkerSize',2);
plot(upper(1:180,3),'Color',rgb('pink'),'line','--','LineWidth',1.5);
plot(lower(1:180,3),'Color',rgb('pink'),'line','--','LineWidth',1.5);
box off;
title('MKGPR');
xlabel('Sample');
ylabel('MW');
xlim([0 180]);
ylim([0 20000]);

subplot(5,4,12);
plot(Y_Act(1:180,7),'k','LineWidth',1.5);
hold on;
plot(Pred(1:180,7),'Color',rgb('green'),'marker','o','MarkerSize',2);
plot(upper(1:180,7),'Color',rgb('pink'),'line','--','LineWidth',1.5);
plot(lower(1:180,7),'Color',rgb('pink'),'line','--','LineWidth',1.5);
box off;
title('MKGPR');
xlabel('Sample');
ylabel('NH_2');
xlim([0 180]);
ylim([0 10000]);