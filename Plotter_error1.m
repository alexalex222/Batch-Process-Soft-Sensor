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
    for jjjj_iter = 3:-1:1
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
        subplot(2,4,iiii_iter);
        hold on;
        if jjjj_iter == 1
            [Y_plot,Mu,Sigma] = zscore(Y_Act(:,iiii_iter));
            % plot(timings,Y_Act(:,ii_iter), 'Color',rgb('Black'),'LineWidth',1.0);
        end
        % P_plot = (P(:,iiii_iter)-repmat(Mu,length(P(:,iiii_iter)),1))./repmat(Sigma,length(P(:,iiii_iter)),1);
        plot(timings,abs(P(:,iiii_iter)-Y_Act(:,iiii_iter)), Styles{jjjj_iter},'Color',rgb(Colors(jjjj_iter)),'LineWidth',0.5);
        % set(gca,'XTick',[0,60,120,180]);
        % set(gca,'XTickLabel',['0';'1';'2';'3']);
        % xlabel('Time (h)');
        xlabel('Sample');
        ylabel(['Residuals of ',Tags{iiii_iter}]);
        title(Titles(iiii_iter));
        axis tight;
        ylim auto;
        % if ii_iter == 6
        %     ylim([0,5000]);
        % end
    end
%     if any(ii_iter == [1,2,4,6,7])
%         legend('Actual','NN','SVR','GPR','B-SVR','B-GPR',1);
%     else
%         legend('Actual','NN','SVR','GPR','B-SVR','B-GPR',4);
%     end
end
subplot(2,4,8,'Color','None');
hold on
% h(1) = plot(timings,Y_Act(:,1), 'Color',rgb('Black'),'LineWidth',1.0);
h(1) = plot(timings,P(:,1), Styles{1},'Color',rgb(Colors(1)),'LineWidth',0.5);
h(2) = plot(timings,P(:,2), Styles{2},'Color',rgb(Colors(2)),'LineWidth',0.5);
h(3) = plot(timings,P(:,3), Styles{3},'Color',rgb(Colors(3)),'LineWidth',0.5);
% h(4) = plot(timings,P(:,4), Styles{4},'Color',rgb(Colors(4)),'LineWidth',0.5);
% h(5) = plot(timings,P(:,5), Styles{5},'Color',rgb(Colors(5)),'LineWidth',0.5);
hl = legend('MMNN','MKSVR','MKGPR',4);
set(hl,'Color','w');
axis('off');
set(h,'Visible','Off');

dir = strcat(cd,'\Figs\');
saveas(gcf,[dir,'Error1'],'fig');
maximize;
applytofig(gcf, 'width',8, 'height',8, 'color','rgb', 'resolution',1800, 'bounds','tight');
set(gcf, 'Renderer', 'painters');
saveas(gcf,[dir,'Error1'],'png');
saveas(gcf,[dir,'Error1'],'epsc');
close all;
