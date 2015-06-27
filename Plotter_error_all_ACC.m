%%% Plotter

clear all;
close all;
clc;

Tags = {'C_A (mol/L)','C_C (mol/L)','C_L (mol/L)','C_W (mol/L)','C_{SE} (mol/L)','MW (g/mol)','NH_2 (mol/g)'};
Titles = {'(a)','(b)','(c)','(d)','(e)','(f)','(g)'};
Colors = {'Red','Blue','Green','Orange','Purple'};
Styles = {'--',':','.-','--+',':*'};
Methods = {'MMNN','MKSVR','MKGPR','BMA-MKSVR','BMA-MKGPR'};

timings = 0:1:180;

X_Vars = [10,11,13,14];
Y_Vars = [1:5,15,16];

wwww_iter = zeros(5,7);
wwww_iter(:,[1,2,5,6]) = [1:1:4 ; 5:1:8 ; 9:1:12 ; 13:1:16 ; 17:1:20];
for iiii_iter = [1,2,5,6]
    for jjjj_iter = 1:1:5
        if jjjj_iter == 1
            load('Results\NN_nu.mat')
        elseif jjjj_iter == 2
            load('Results\SVR_nu.mat')
        elseif jjjj_iter == 3
            load('Results\GPR_nu.mat')
        elseif jjjj_iter == 4
            load('Results\SVRB_nu.mat')
        elseif jjjj_iter == 5
            load('Results\GPRB_nu.mat')
        end
        subplot(5,4,wwww_iter(jjjj_iter,iiii_iter));
        hold on;
        plot(timings,abs(P(:,iiii_iter)-Y_Act(:,iiii_iter)), Styles{jjjj_iter},'Color',rgb(Colors(jjjj_iter)),'LineWidth',0.5,'MarkerSize',2);
        xlabel('Sample');
        ylabel(['Prediction Error of ',Tags{iiii_iter}]);
        title(Methods{jjjj_iter});
        axis tight;
        if jjjj_iter == 1
            Y_Lim = get(gca,'YLim');
        end
        ylim([0,Y_Lim(end)])
    end
end

dir = strcat(cd,'\Figs\');
saveas(gcf,[dir,'Error_all_ACC'],'fig');
maximize;
applytofig(gcf, 'width',8, 'height',8, 'color','rgb', 'resolution',4000, 'bounds','tight', 'FontMode','fixed', 'FontSize',6, 'LockAxes',0);
set(gcf, 'Renderer', 'painters');
saveas(gcf,[dir,'Error_all_ACC'],'png');
saveas(gcf,[dir,'Error_all_ACC'],'epsc');
% close all;
