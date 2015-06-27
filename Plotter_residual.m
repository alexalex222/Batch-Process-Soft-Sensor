%%% Plotter

clear all;
close all;
clc;

Tags = {'C_A (mol/L)','C_C (mol/L)','C_L (mol/L)','C_W (mol/L)','C_{SE} (mol/L)','MW (g/mol)','NH_2 (mol/g)'};
Titles = {'(a)','(b)','(c)','(d)','(e)','(f)','(g)'};
Colors = {'Red','Blue','Green','Orange','Purple'};
Styles = {'--',':','.-','--+',':*'};

timings = 0:1:180;

X_Vars = [10,11,13,14];
Y_Vars = [1:5,15,16];

for iiii_iter = 1:1:length(Y_Vars)
    % figure;
    load('Results\NN_nu.mat')
    ERROR(:,1) = abs(P(:,iiii_iter)-Y_Act(:,iiii_iter));
    load('Results\SVR_nu.mat')
    ERROR(:,2) = abs(P(:,iiii_iter)-Y_Act(:,iiii_iter));
    load('Results\GPR_nu.mat')
    ERROR(:,3) = abs(P(:,iiii_iter)-Y_Act(:,iiii_iter));
    load('Results\SVRB_nu.mat')
    ERROR(:,4) = abs(P(:,iiii_iter)-Y_Act(:,iiii_iter));
    load('Results\GPRB_nu.mat')
    ERROR(:,5) = abs(P(:,iiii_iter)-Y_Act(:,iiii_iter));
    subplot(2,4,iiii_iter);
    hold on;
    boxplot(ERROR,'notch','on')
    %     h = findobj(gca,'Tag','Box');
    %     for j=1:length(h)
    %         patch(get(h(j),'XData'),get(h(j),'YData'),'y','FaceAlpha',.5);
    %     end
    xlabel('Method');
    ylabel(['Residuals of ',Tags{iiii_iter}]);
    title(Titles(iiii_iter));
end

str(1) = {'Method 1: MMNN'};
str(2) = {'Method 2: MKSVR'};
str(3) = {'Method 3: MKGPR'};
str(4) = {'Method 4: BMA-MKSVR'};
str(5) = {'Method 5: BMA-MKGPR'};

subplot(2,4,8,'Color','None');
hold on
axis('off');
text(1,0,str,...
	'VerticalAlignment','Bottom',...
	'HorizontalAlignment','Right',...
	'FontSize',10);

dir = strcat(cd,'\Figs\');
saveas(gcf,[dir,'Residual'],'fig');
maximize;
applytofig(gcf, 'width',8, 'height',8, 'color','rgb', 'resolution',1800, 'bounds','tight');
set(gcf, 'Renderer', 'painters');
saveas(gcf,[dir,'Residual'],'png');
saveas(gcf,[dir,'Residual'],'epsc');
close all;
