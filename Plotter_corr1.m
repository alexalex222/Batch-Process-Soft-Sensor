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

for iii_iter = 1:1:length(Y_Vars)
    % figure;
    for jjj_iter = 3:-1:1
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
        subplot(2,4,iii_iter);
        hold on;
        if jjj_iter == 1
            [Y_plot,Mu,Sigma] = zscore(Y_Act(:,iii_iter));
            plot([min(Y_Act(:,iii_iter)).*0.80,max(Y_Act(:,iii_iter))*1.20],[min(Y_Act(:,iii_iter)),max(Y_Act(:,iii_iter))], 'Color',rgb('Black'),'LineWidth',1.5);
        end
        % P_plot = (P(:,iii_iter)-repmat(Mu,length(P(:,iii_iter)),1))./repmat(Sigma,length(P(:,iii_iter)),1);
        plot(Y_Act(:,iii_iter),P(:,iii_iter), Styles{jjj_iter},'Color',rgb(Colors(jjj_iter)),'LineWidth',0.5);
        % set(gca,'XTick',[0,60,120,180]);
        % set(gca,'XTickLabel',['0';'1';'2';'3']);
        title(Titles(iii_iter));
        axis tight;
        if iii_iter < 5
            if jjj_iter == 3
                y_lim = get(gca,'ylim');
                ylim([y_lim(1)-500,y_lim(end)+500]);
                strnrm = num2str(min(nonzeros(get(gca,'YTick'))));
                strnrm = str2double(strnrm(1));
                str = num2str((get(gca,'YTick')./min(nonzeros(get(gca,'YTick'))).*strnrm)','%2.1f\n');
                strlb = num2str(min(nonzeros(get(gca,'YTick')))','%2.1e\n');
                strlb = strlb(4:end);
                strlb1 = strlb(1);
                strlb2 = strlb(end);
                set(gca, 'YTickLabel', str)
                ylabel(['Predicted ',Tags{iii_iter},' [*',strlb1,'^',strlb2,']']);
            end
            if jjj_iter == 1
                x_lim = get(gca,'xlim');
                xlim([x_lim(1)-500,x_lim(end)+500]);
                strnrm = num2str(min(nonzeros(get(gca,'XTick'))));
                strnrm = str2double(strnrm(1));
                str = num2str((get(gca,'XTick')./min(nonzeros(get(gca,'XTick'))).*strnrm)','%2.1f\n');
                strlb = num2str(min(nonzeros(get(gca,'XTick')))','%2.1e\n');
                strlb = strlb(4:end);
                strlb1 = strlb(1);
                strlb2 = strlb(end);
                set(gca, 'XTickLabel', str)
                xlabel(['Actual ',Tags{iii_iter},' [*',strlb1,'^',strlb2,']']);
            end
        else
            y_lim = get(gca,'ylim');
            ylim([y_lim(1)-5,y_lim(end)+5]);
            x_lim = get(gca,'xlim');
            xlim([x_lim(1)-5,x_lim(end)+5]);
            xlabel(['Actual ',Tags{iii_iter}]);
            ylabel(['Predicted ',Tags{iii_iter}]);
        end
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
h(1) = plot([-100,100],[-100,100], 'Color',rgb('Black'),'LineWidth',1.0);
h(2) = plot(Y_Act(:,1),P(:,1),Styles{1},'Color',rgb(Colors(1)),'LineWidth',0.5);
h(3) = plot(Y_Act(:,2),P(:,2),Styles{2},'Color',rgb(Colors(2)),'LineWidth',0.5);
h(4) = plot(Y_Act(:,3),P(:,3),Styles{3},'Color',rgb(Colors(3)),'LineWidth',0.5);
% h(5) = plot(Y_Act(:,4),P(:,4),Styles{4},'Color',rgb(Colors(4)),'LineWidth',0.5);
% h(6) = plot(Y_Act(:,5),P(:,5),Styles{5},'Color',rgb(Colors(5)),'LineWidth',0.5);
hl = legend('Actual','MMNN','MKSVR','MKGPR',4);
set(hl,'Color','w');
axis('off');
set(h,'Visible','Off');

dir = strcat(cd,'\Figs\');
saveas(gcf,[dir,'Correlation1'],'fig');
maximize;
applytofig(gcf, 'width',8, 'height',8, 'color','rgb', 'resolution',1800, 'bounds','tight');
set(gcf, 'Renderer', 'painters');
saveas(gcf,[dir,'Correlation1'],'png');
saveas(gcf,[dir,'Correlation1'],'epsc');
close all;
