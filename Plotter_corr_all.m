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

www_iter = zeros(5,7);
www_iter(:,[3,4,6,7]) = [1:1:4 ; 5:1:8 ; 9:1:12 ; 13:1:16 ; 17:1:20];
for iii_iter = [3,4,6,7]
    % figure;
    for jjj_iter = 1:1:5
        if jjj_iter == 1
            load('Results\NN_nu.mat')
        elseif jjj_iter == 2
            load('Results\SVR_nu.mat')
        elseif jjj_iter == 3
            load('Results\GPR_nu.mat')
        elseif jjj_iter == 4
            load('Results\SVRB_nu.mat')
        elseif jjj_iter == 5
            load('Results\GPRB_nu.mat')
        end
        subplot(5,4,www_iter(jjj_iter,iii_iter));
        hold on;
        plot([min(Y_Act(:,iii_iter)).*0.80,max(Y_Act(:,iii_iter))*1.20],[min(Y_Act(:,iii_iter)),max(Y_Act(:,iii_iter))], 'Color',rgb('Black'),'LineWidth',1.5);
        plot(Y_Act(:,iii_iter),P(:,iii_iter), Styles{jjj_iter},'Color',rgb(Colors(jjj_iter)),'LineWidth',0.5,'MarkerSize',2);
        xlabel(['Actual ',Tags{iii_iter}]);
        ylabel(['Predicted ',Tags{iii_iter}]);
        title(Methods(jjj_iter));
        axis tight;
        if jjj_iter == 1
            Y_Lim = get(gca,'YLim');
        end
        ylim(Y_Lim)
        
        y_lim = get(gca,'ylim');
        ylim([y_lim(1)-500,y_lim(end)+500]);
        x_lim = get(gca,'xlim');
        xlim([x_lim(1)-500,x_lim(end)+500]);
        
        y_lim = get(gca,'ylim');
        strnrm = num2str(min(nonzeros(get(gca,'YTick'))));
        strnrm = str2double(strnrm(1));
        str = num2str((get(gca,'YTick')./min(nonzeros(get(gca,'YTick'))).*strnrm)','%2.1f\n');
        strlb = num2str(min(nonzeros(get(gca,'YTick')))','%2.1e\n');
        strlb = strlb(4:end);
        strlb1 = strlb(1);
        strlb2 = strlb(end);
        set(gca, 'YTickLabel', str)
        ylabel(['Predicted ',Tags{iii_iter},' [x10^',strlb2,']']);
        
        x_lim = get(gca,'xlim');
        strnrm = num2str(min(nonzeros(get(gca,'XTick'))));
        strnrm = str2double(strnrm(1));
        str = num2str((get(gca,'XTick')./min(nonzeros(get(gca,'XTick'))).*strnrm)','%2.1f\n');
        strlb = num2str(min(nonzeros(get(gca,'XTick')))','%2.1e\n');
        strlb = strlb(4:end);
        strlb1 = strlb(1);
        strlb2 = strlb(end);
        set(gca, 'XTickLabel', str)
        xlabel(['Actual ',Tags{iii_iter},' [x10^',strlb2,']']);
    end
end

dir = strcat(cd,'\Figs\');
saveas(gcf,[dir,'Correlation_all'],'fig');
maximize;
applytofig(gcf, 'width',8, 'height',8, 'color','rgb', 'resolution',4000, 'bounds','tight', 'FontMode','fixed', 'FontSize',6, 'LockAxes',0);
set(gcf, 'Renderer', 'painters');
saveas(gcf,[dir,'Correlation_all'],'png');
saveas(gcf,[dir,'Correlation_all'],'epsc');
