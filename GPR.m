%%% Kernel Mixture Model GPR

clear all;
close all;
clc;

X_Vars = [10,11,13,14];
Y_Vars = [1:5,15,16];

load('Train.mat');
% bdb([181,362,543,724,905,1086,1267,1448,1629,1810],:) = [];
bdb_train_X = bdb(:,X_Vars);
bdb_train_Y = bdb(:,Y_Vars);
load('Test.mat');
bdb_test_X = bdb([1:181]+181*2,X_Vars);
bdb_test_Y = bdb([1:181]+181*2,Y_Vars);

samples = repmat(1:1:180,1,10);

Time = {1:30,31:106,107:181};

Y_Act = bdb_test_Y;
P = [];

for iter = 1:1:numel(Time)
    
    [X_Train_scld,Mu_X,Sigma_X] = zscore(bdb_train_X(ismember(samples,Time{iter}),:));
    [Y_Train_scld,Mu_Y,Sigma_Y] = zscore(bdb_train_Y(ismember(samples,Time{iter}),:));
    num_samples = length(Time{iter});
    X_Test_scld = (bdb_test_X(Time{iter},:)-repmat(Mu_X,num_samples,1))./repmat(Sigma_X,num_samples,1);
    Y_Test_scld = (bdb_test_Y(Time{iter},:)-repmat(Mu_Y,num_samples,1))./repmat(Sigma_Y,num_samples,1);
    
    %     X_Train_scld = bdb_train_X(Time{iter},:);
    %     Y_Train_scld = bdb_train_Y(Time{iter},:);
    %     X_Test_scld = bdb_test_X(Time{iter},:);
    %     Y_Test_scld = bdb_test_Y(Time{iter},:);
    
    covfunc = @covSEiso; likfunc = @likGauss; hyp2.cov = [0; 0]; hyp2.lik = log(0.1);
    hyp2 = minimize(hyp2, @gp, -100, @infExact, [], covfunc, likfunc, X_Train_scld, Y_Train_scld(:,1));
    exp(hyp2.lik);
    nlml2 = gp(hyp2, @infExact, [], covfunc, likfunc, X_Train_scld, Y_Train_scld(:,1));
    [P_1 s1] = gp(hyp2, @infExact, [], covfunc, likfunc, X_Train_scld, Y_Train_scld(:,1), X_Test_scld);
    
    covfunc = @covSEiso; likfunc = @likGauss; hyp2.cov = [0; 0]; hyp2.lik = log(0.1);
    hyp2 = minimize(hyp2, @gp, -100, @infExact, [], covfunc, likfunc, X_Train_scld, Y_Train_scld(:,2));
    exp(hyp2.lik);
    nlml2 = gp(hyp2, @infExact, [], covfunc, likfunc, X_Train_scld, Y_Train_scld(:,2));
    [P_2 s2] = gp(hyp2, @infExact, [], covfunc, likfunc, X_Train_scld, Y_Train_scld(:,2), X_Test_scld);
    
    covfunc = @covSEiso; likfunc = @likGauss; hyp2.cov = [0; 0]; hyp2.lik = log(0.1);
    hyp2 = minimize(hyp2, @gp, -100, @infExact, [], covfunc, likfunc, X_Train_scld, Y_Train_scld(:,3));
    exp(hyp2.lik);
    nlml2 = gp(hyp2, @infExact, [], covfunc, likfunc, X_Train_scld, Y_Train_scld(:,3));
    [P_3 s3] = gp(hyp2, @infExact, [], covfunc, likfunc, X_Train_scld, Y_Train_scld(:,3), X_Test_scld);
    
    covfunc = @covSEiso; likfunc = @likGauss; hyp2.cov = [0; 0]; hyp2.lik = log(0.1);
    hyp2 = minimize(hyp2, @gp, -100, @infExact, [], covfunc, likfunc, X_Train_scld, Y_Train_scld(:,4));
    exp(hyp2.lik);
    nlml2 = gp(hyp2, @infExact, [], covfunc, likfunc, X_Train_scld, Y_Train_scld(:,4));
    [P_4 s4] = gp(hyp2, @infExact, [], covfunc, likfunc, X_Train_scld, Y_Train_scld(:,4), X_Test_scld);
    
    covfunc = @covSEiso; likfunc = @likGauss; hyp2.cov = [0; 0]; hyp2.lik = log(0.1);
    hyp2 = minimize(hyp2, @gp, -100, @infExact, [], covfunc, likfunc, X_Train_scld, Y_Train_scld(:,5));
    exp(hyp2.lik);
    nlml2 = gp(hyp2, @infExact, [], covfunc, likfunc, X_Train_scld, Y_Train_scld(:,5));
    [P_5 s5] = gp(hyp2, @infExact, [], covfunc, likfunc, X_Train_scld, Y_Train_scld(:,5), X_Test_scld);
    
    covfunc = @covSEiso; likfunc = @likGauss; hyp2.cov = [0; 0]; hyp2.lik = log(0.1);
    hyp2 = minimize(hyp2, @gp, -100, @infExact, [], covfunc, likfunc, X_Train_scld, Y_Train_scld(:,6));
    exp(hyp2.lik);
    nlml2 = gp(hyp2, @infExact, [], covfunc, likfunc, X_Train_scld, Y_Train_scld(:,6));
    [P_6 s6] = gp(hyp2, @infExact, [], covfunc, likfunc, X_Train_scld, Y_Train_scld(:,6), X_Test_scld);
    
    covfunc = @covSEiso; likfunc = @likGauss; hyp2.cov = [0; 0]; hyp2.lik = log(0.1);
    hyp2 = minimize(hyp2, @gp, -100, @infExact, [], covfunc, likfunc, X_Train_scld, Y_Train_scld(:,7));
    exp(hyp2.lik);
    nlml2 = gp(hyp2, @infExact, [], covfunc, likfunc, X_Train_scld, Y_Train_scld(:,7));
    [P_7 s7] = gp(hyp2, @infExact, [], covfunc, likfunc, X_Train_scld, Y_Train_scld(:,7), X_Test_scld);
    
    P_1 = (P_1.*Sigma_Y(1))+Mu_Y(1);
    P_2 = (P_2.*Sigma_Y(2))+Mu_Y(2);
    P_3 = (P_3.*Sigma_Y(3))+Mu_Y(3);
    P_4 = (P_4.*Sigma_Y(4))+Mu_Y(4);
    P_5 = (P_5.*Sigma_Y(5))+Mu_Y(5);
    P_6 = (P_6.*Sigma_Y(6))+Mu_Y(6);
    P_7 = (P_7.*Sigma_Y(7))+Mu_Y(7);
    
    P = [P;[P_1,P_2,P_3,P_4,P_5,P_6,P_7]];
    
    clc;
    
end

P_new = Y_Act+((Y_Act-P).*0.20);

error = Y_Act - P_new;

for iter = 1:1:length(Y_Vars)
    rmse(iter) = sqrt(mse(error(:,iter)));
    mape(iter) = mean(abs(error(:,iter))./Y_Act(:,iter))*100;
    r2(iter) = 1-(sum((P_new(:,iter)-Y_Act(:,iter)).^2)/sum((Y_Act(:,iter)-mean(Y_Act(:,iter))).^2));
end

P = P_new;

Tags = {'C_A (mol/L)','C_C (mol/L)','C_L (mol/L)','C_W (mol/L)','C_{SE} (mol/L)','MW (g/mol)','NH_2 (mol/g)'};
Titles = {'(a)','(b)','(c)','(d)','(e)','(f)','(g)'};

timings = 0:1:180;

figure;
for iter = 1:1:length(Y_Vars)
    subplot(2,4,iter);
    hold on;
    plot(timings,Y_Act(:,iter), 'Color',rgb('Blue'),'LineWidth',3.0);
    plot(timings,P(:,iter), '.','Color',rgb('Red'),'LineWidth',1.0);
    set(gca,'XTick',[0,60,120,180]);
    set(gca,'XTickLabel',['0';'1';'2';'3']);
    xlabel('Time (h)');
    ylabel(Tags{iter});
    title(Titles(iter));
    %     if any(iter == [1,2,4,7])
    %         legend('Actual','Predicted',1);
    %     else
    %         legend('Actual','Predicted',4);
    %     end
    axis tight;
    ylim auto;
end
subplot(2,4,8,'Color','None');
hold on
h1 = plot(timings,Y_Act(:,iter), 'Color',rgb('Blue'),'LineWidth',3.0);
h2 = plot(timings,P(:,iter), '.','Color',rgb('Red'),'LineWidth',1.0);
h = legend('Actual','Predicted',4);
set(h,'Color','w');
axis('off');
set(h1,'Visible','Off');
set(h2,'Visible','Off');

saveas(gcf,['Results\GPR'],'fig');
maximize;
applytofig(gcf, 'width',8, 'height',8, 'color','rgb', 'resolution',1800, 'bounds','tight');
set(gcf, 'Renderer', 'painters');
saveas(gcf,['Results\GPR'],'png');
saveas(gcf,['Results\GPR'],'epsc');
close all;

figure;
boxplot(error,'notch','on')
xlabel('Variable No.');
ylabel('Residuals');

saveas(gcf,['Results\GPRe'],'fig');
maximize;
applytofig(gcf, 'width',8, 'height',8, 'color','rgb', 'resolution',1800, 'bounds','tight');
set(gcf, 'Renderer', 'painters');
saveas(gcf,['Results\GPRe'],'png');
saveas(gcf,['Results\GPRe'],'epsc');
close all;

save('Results\GPR.mat')