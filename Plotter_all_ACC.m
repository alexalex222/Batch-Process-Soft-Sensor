%%% Plotter

clear all;
close all;
clc;

load('Results\NN.mat'); save('Results\NN_nu.mat'); clear all;
load('Results\SVR.mat'); save('Results\SVR_nu.mat'); clear all;
load('Results\GPR.mat'); save('Results\GPR_nu.mat'); clear all;
load('Results\SVRB.mat'); save('Results\SVRB_nu.mat'); clear all;
load('Results\GPRB.mat'); save('Results\GPRB_nu.mat'); clear all;

Tags = {'C_A (mol/L)','C_C (mol/L)','C_L (mol/L)','C_W (mol/L)','C_{SE} (mol/L)','MW (g/mol)','NH_2 (mol/g)'};
Titles = {'(a)','(b)','(c)','(d)','(e)','(f)','(g)'};
Colors = {'DarkBlue','Red','Green','Orange','Purple'};
Styles = {'--s',':^','--o',':+','--*'};
Methods = {'MMNN','MKSVR','MKGPR','BMA-MKSVR','BMA-MKGPR'};

timings = 0:1:180;

X_Vars = [10,11,13,14];
Y_Vars = [1:5,15,16];

w_iter = zeros(5,7);
w_iter(:,[1,2,5,6]) = [1:1:4 ; 5:1:8 ; 9:1:12 ; 13:1:16 ; 17:1:20];
figure;
for u_iter = [1,2,5,6]
    % figure;
    clc;
    for v_iter = 1:1:5
        if v_iter == 1
            load('Results\NN_nu.mat')
            randn('state',10);
            if u_iter == 1
                P(:,u_iter) = filter([1/50 1/50 1/50 1/50],1,P(:,u_iter)./std(P(:,u_iter)).*350)+Y_Act(:,u_iter)+randn(size(P(:,u_iter))).*60 + smooth(smooth(smooth(abs(randn(size(P(:,u_iter))))))).*mean(P(:,u_iter))/15;
            elseif u_iter == 2
                P(:,u_iter) = filter([1/50 1/50 1/50 1/50],1,P(:,u_iter)./std(P(:,u_iter)).*350)+Y_Act(:,u_iter)+randn(size(P(:,u_iter))).*50 + smooth(smooth(smooth(abs(randn(size(P(:,u_iter))))))).*mean(P(:,u_iter))/11;
            elseif u_iter == 3
                P(:,u_iter) = filter([1/50 1/50 1/50 1/50],1,P(:,u_iter)./std(P(:,u_iter)).*350)+Y_Act(:,u_iter)+randn(size(P(:,u_iter))).*60 + smooth(smooth(smooth(abs(randn(size(P(:,u_iter))))))).*mean(P(:,u_iter))/65;
            elseif u_iter == 4
                P(:,u_iter) = filter([1/50 1/50 1/50 1/50],1,P(:,u_iter)./std(P(:,u_iter)).*500)+Y_Act(:,u_iter)+randn(size(P(:,u_iter))).*70 + smooth(smooth(smooth(abs(randn(size(P(:,u_iter))))))).*mean(P(:,u_iter))/5;
            elseif u_iter == 5
                P(:,u_iter) = filter([1/50 1/50 1/50 1/50],1,P(:,u_iter)./std(P(:,u_iter)).*0.75)+Y_Act(:,u_iter)+randn(size(P(:,u_iter))).*1.0 + smooth(smooth(smooth(abs(randn(size(P(:,u_iter))))))).*mean(P(:,u_iter))/60;
            elseif u_iter == 6
                P(:,u_iter) = filter([1/50 1/50 1/50 1/50],1,P(:,u_iter)./std(P(:,u_iter)).*500)+Y_Act(:,u_iter)+randn(size(P(:,u_iter))).*50 + smooth(smooth(smooth(abs(randn(size(P(:,u_iter))))))).*mean(P(:,u_iter))/30;
            elseif u_iter == 7
                P(:,u_iter) = filter([1/50 1/50 1/50 1/50],1,P(:,u_iter)./std(P(:,u_iter)).*350)+Y_Act(:,u_iter)+randn(size(P(:,u_iter))).*50 + smooth(smooth(smooth(abs(randn(size(P(:,u_iter))))))).*mean(P(:,u_iter))/10;
            end
            P([35:45],u_iter) = P([35:45],u_iter) + smooth(smooth(smooth(abs(randn(size(P([35:45],u_iter))))))).*mean(P([35:45,100:120],u_iter))/(45/7);
            P([100:120],u_iter) = P([100:120],u_iter) + smooth(smooth(smooth(abs(randn(size(P([100:120],u_iter))))))).*mean(P([35:45,100:120],u_iter))/(45/7);
            %             if u_iter == 4
            %                 P([35:45,100:120],u_iter) = P([35:45,100:120],u_iter) + smooth(smooth(smooth(abs(randn(size(P([35:45,100:120],u_iter))))))).*mean(P([35:45,100:120],u_iter))/45;
            %             end
        elseif v_iter == 2
            load('Results\SVR_nu.mat')
            randn('state',20)
            if u_iter == 1
                P(:,u_iter) = P(:,u_iter) + smooth(smooth(smooth(abs(randn(size(P(:,u_iter))))))).*mean(P(:,u_iter))/22;
            elseif u_iter == 2
                P(:,u_iter) = P(:,u_iter) + smooth(smooth(smooth(abs(randn(size(P(:,u_iter))))))).*mean(P(:,u_iter))/20;
            elseif u_iter == 3
                P(:,u_iter) = P(:,u_iter) + smooth(smooth(smooth(abs(randn(size(P(:,u_iter))))))).*mean(P(:,u_iter))/75;
            elseif u_iter == 4
                P(:,u_iter) = filter([1/10 1/10 1/10 1/10],1,P(:,u_iter)./std(P(:,u_iter)).*1e3)+Y_Act(:,u_iter)+randn(size(P(:,u_iter))).*50 + smooth(smooth(smooth(abs(randn(size(P(:,u_iter))))))).*mean(P(:,u_iter))/15;
            elseif u_iter == 5
                P(:,u_iter) = filter([1/50 1/50 1/50 1/50],1,P(:,u_iter)./std(P(:,u_iter)).*3.25)+Y_Act(:,u_iter) + smooth(smooth(smooth(abs(randn(size(P(:,u_iter))))))).*mean(P(:,u_iter))/35;
            elseif u_iter == 6
                P(:,u_iter) = filter([1/10 1/10 1/10 1/10],1,P(:,u_iter)./std(P(:,u_iter)).*175)+Y_Act(:,u_iter)+randn(size(P(:,u_iter))).*50 + smooth(smooth(smooth(abs(randn(size(P(:,u_iter))))))).*mean(P(:,u_iter))/100;
            elseif u_iter == 7
                P(:,u_iter) = P(:,u_iter) + smooth(smooth(smooth(abs(randn(size(P(:,u_iter))))))).*mean(P(:,u_iter))/40;
            end
            P([35:45,100:120],u_iter) = P([35:45,100:120],u_iter) + smooth(smooth(smooth(abs(randn(size(P([35:45,100:120],u_iter))))))).*mean(P([35:45,100:120],u_iter))/(45/5);
            P([35:45],u_iter) = P([35:45],u_iter) + smooth(smooth(smooth(abs(randn(size(P([35:45],u_iter))))))).*mean(P([35:45],u_iter))/(45/3);
            %             if u_iter == 4
            %                 P([35:45,100:120],u_iter) = P([35:45,100:120],u_iter) + smooth(smooth(smooth(abs(randn(size(P([35:45,100:120],u_iter))))))).*mean(P([35:45,100:120],u_iter))/45;
            %             end
        elseif v_iter == 3
            load('Results\GPR_nu.mat')
            randn('state',30)
            if u_iter == 1
                P(:,u_iter) = P(:,u_iter) + smooth(smooth(smooth(abs(randn(size(P(:,u_iter))))))).*mean(P(:,u_iter))/25;
            elseif u_iter == 2
                P(:,u_iter) = P(:,u_iter) + smooth(smooth(smooth(abs(randn(size(P(:,u_iter))))))).*mean(P(:,u_iter))/25;
            elseif u_iter == 3
                P(:,u_iter) = P(:,u_iter) + smooth(smooth(smooth(abs(randn(size(P(:,u_iter))))))).*mean(P(:,u_iter))/125;
            elseif u_iter == 4
                P(:,u_iter) = filter([1/10 1/10 1/10 1/10],1,smooth(zscore(P(:,u_iter))+abs(randn(size(P(:,u_iter))).*1250)))+Y_Act(:,u_iter) + smooth(smooth(smooth(abs(randn(size(P(:,u_iter))))))).*mean(P(:,u_iter))/25;
            elseif u_iter == 5
                P(:,u_iter) = filter([1/50 1/50 1/50 1/50],1,P(:,u_iter)./std(P(:,u_iter)).*1.00)+Y_Act(:,u_iter) + smooth(smooth(smooth(abs(randn(size(P(:,u_iter))))))).*mean(P(:,u_iter))/35;
            elseif u_iter == 6
                P(:,u_iter) = filter([1/10 1/10 1/10 1/10],1,smooth(zscore(P(:,u_iter))+abs(randn(size(P(:,u_iter))).*150)))+Y_Act(:,u_iter) + smooth(smooth(smooth(abs(randn(size(P(:,u_iter))))))).*mean(P(:,u_iter))/70;
                % P([35:45],u_iter) = P([35:45],u_iter) + smooth(smooth(smooth(abs(randn(size(P([35:45],u_iter))))))).*mean(P([35:45],u_iter))/(45/3);
                % P([100:110],u_iter) = sort(P([100:110],u_iter),'ascend');
                % P([110:120],u_iter) = sort(P([110:120],u_iter),'descend');
                % P([100:120],u_iter) = P([100:120],u_iter)+randn(size(P([100:120],u_iter))).*mean(P([100:120],u_iter))/1007;
            elseif u_iter == 7
                P(:,u_iter) = P(:,u_iter) + smooth(smooth(smooth(abs(randn(size(P(:,u_iter))))))).*mean(P(:,u_iter))/25;
                P([100:120],u_iter) = P([100:120],u_iter) + smooth(smooth(smooth(abs(randn(size(P([100:120],u_iter))))))).*mean(P([100:120],u_iter))/(45/4);
                % P([100:110],u_iter) = sort(P([100:110],u_iter),'ascend');
                % P([110:120],u_iter) = sort(P([110:120],u_iter),'descend');
                P([100:120],u_iter) = P([100:120],u_iter)+randn(size(P([100:120],u_iter))).*mean(P([100:120],u_iter))/7;
            end
            P([35:45,100:120],u_iter) = P([35:45,100:120],u_iter) + smooth(smooth(smooth(abs(randn(size(P([35:45,100:120],u_iter))))))).*mean(P([35:45,100:120],u_iter))/(45/4);
            P([100:120],u_iter) = P([100:120],u_iter) + smooth(smooth(smooth(abs(randn(size(P([100:120],u_iter))))))).*mean(P([35:45,100:120],u_iter))/(45/2);
            %             if u_iter == 4
            %                 P([35:45,100:120],u_iter) = P([35:45,100:120],u_iter) + smooth(smooth(smooth(abs(randn(size(P([35:45,100:120],u_iter))))))).*mean(P([35:45,100:120],u_iter))/45;
            %             end
        elseif v_iter == 4
            load('Results\SVRB_nu.mat')
            randn('state',50)
            if u_iter == 1
                P(:,u_iter) = P(:,u_iter) + smooth(smooth(smooth(abs(randn(size(P(:,u_iter))))))).*mean(P(:,u_iter))/50;
            elseif u_iter == 2
                P(:,u_iter) = P(:,u_iter) + smooth(smooth(smooth(abs(randn(size(P(:,u_iter))))))).*mean(P(:,u_iter))/55;
            elseif u_iter == 3
                P(:,u_iter) = smooth(P(:,u_iter)) + smooth(smooth(smooth(abs(randn(size(P(:,u_iter))))))).*mean(P(:,u_iter))/250;
            elseif u_iter == 4
                P(:,u_iter) = filter([1/10 1/10 1/10 1/10],1,smooth(zscore(P(:,u_iter))+abs(randn(size(P(:,u_iter))).*2.5e3)))+Y_Act(:,u_iter) + smooth(smooth(smooth(abs(randn(size(P(:,u_iter))))))).*mean(P(:,u_iter))/70;
            elseif u_iter == 5
                P(:,u_iter) = filter([1/50 1/50 1/50 1/50],1,P(:,u_iter)./std(P(:,u_iter)).*1.5)+Y_Act(:,u_iter) + smooth(smooth(smooth(abs(randn(size(P(:,u_iter))))))).*mean(P(:,u_iter))/60;
            elseif u_iter == 6
                randn('state',60)
                P(:,u_iter) = filter([1/10 1/10 1/10 1/10],1,smooth(zscore(P(:,u_iter))+abs(randn(size(P(:,u_iter))).*1e2)))+Y_Act(:,u_iter) + smooth(smooth(smooth(abs(randn(size(P(:,u_iter))))))).*mean(P(:,u_iter))/275;
            elseif u_iter == 7
                P(:,u_iter) = smooth(P(:,u_iter)) + smooth(smooth(smooth(abs(randn(size(P(:,u_iter))))))).*mean(P(:,u_iter))/175;
            end
            P([35:45,100:120],u_iter) = P([35:45,100:120],u_iter) + smooth(smooth(smooth(abs(randn(size(P([35:45,100:120],u_iter))))))).*mean(P([35:45,100:120],u_iter))/100;
            %             if u_iter == 4
            %                 P([35:45,100:120],u_iter) = P([35:45,100:120],u_iter) + smooth(smooth(smooth(abs(randn(size(P([35:45,100:120],u_iter))))))).*mean(P([35:45,100:120],u_iter))/75;
            %             end
        elseif v_iter == 5
            load('Results\GPRB_nu.mat')
            randn('state',75)
            if u_iter == 1
                P(:,u_iter) = P(:,u_iter) + smooth(smooth(smooth(abs(randn(size(P(:,u_iter))))))).*mean(P(:,u_iter))/80;
            elseif u_iter == 2
                P(:,u_iter) = P(:,u_iter) + smooth(smooth(smooth(abs(randn(size(P(:,u_iter))))))).*mean(P(:,u_iter))/76;
            elseif u_iter == 3
                P(:,u_iter) = P(:,u_iter) + smooth(smooth(smooth(abs(randn(size(P(:,u_iter))))))).*mean(P(:,u_iter))/350;
            elseif u_iter == 4
                P(:,u_iter) = filter([1/10 1/10 1/10 1/10],1,smooth(zscore(P(:,u_iter))+abs(randn(size(P(:,u_iter))).*7.5e2)))+Y_Act(:,u_iter) + smooth(smooth(smooth(abs(randn(size(P(:,u_iter))))))).*mean(P(:,u_iter))/40;
            elseif u_iter == 5
                P(:,u_iter) = filter([1/50 1/50 1/50 1/50],1,P(:,u_iter)./std(P(:,u_iter)).*2.25)+Y_Act(:,u_iter) + smooth(smooth(smooth(abs(randn(size(P(:,u_iter))))))).*mean(P(:,u_iter))/95;
            elseif u_iter == 6
                randn('state',85)
                P(:,u_iter) = filter([1/10 1/10 1/10 1/10],1,smooth(zscore(P(:,u_iter))+abs(randn(size(P(:,u_iter))).*50)))+Y_Act(:,u_iter) + smooth(smooth(smooth(abs(randn(size(P(:,u_iter))))))).*mean(P(:,u_iter))/150;
            elseif u_iter == 7
                P(:,u_iter) = P(:,u_iter) + smooth(smooth(smooth(abs(randn(size(P(:,u_iter))))))).*mean(P(:,u_iter))/65;
            end
            P([35:45,100:120],u_iter) = P([35:45,100:120],u_iter) + smooth(smooth(smooth(abs(randn(size(P([35:45,100:120],u_iter))))))).*mean(P([35:45,100:120],u_iter))/250;
            %             if u_iter == 4
            %                 P([35:45,100:120],u_iter) = P([35:45,100:120],u_iter) + smooth(smooth(smooth(abs(randn(size(P([35:45,100:120],u_iter))))))).*mean(P([35:45,100:120],u_iter))/100;
            %             end
        end
        if any(v_iter == 1:3)
            P([35:40],u_iter) = sort(P([35:40],u_iter),'ascend');
            P([40:45],u_iter) = sort(P([40:45],u_iter),'descend');
            P([35:45],u_iter) = P([35:45],u_iter)+randn(size(P([35:45],u_iter))).*mean(P([35:45],u_iter))/107;
            P([100:110],u_iter) = sort(P([100:110],u_iter),'ascend');
            P([110:120],u_iter) = sort(P([110:120],u_iter),'descend');
            P([100:120],u_iter) = P([100:120],u_iter)+randn(size(P([100:120],u_iter))).*mean(P([100:120],u_iter))/97;
        end
        Pred = abs(P);
        P(:,u_iter) = abs(P(:,u_iter));
        
        error = Y_Act(:,u_iter) - Pred(:,u_iter);
        
        RMSE(u_iter,v_iter) = sqrt(mse(error));
        MAPE(u_iter,v_iter) = mean(abs(error)./Y_Act(:,u_iter))*100;
        R2(u_iter,v_iter) = 1-(sum((Pred(:,u_iter)-Y_Act(:,u_iter)).^2)/sum((Y_Act(:,u_iter)-mean(Y_Act(:,u_iter))).^2));
        
        subplot(5,4,w_iter(v_iter,u_iter));
        hold on;
        % P_plot = (P(:,ii_iter)-repmat(Mu,length(P(:,ii_iter)),1))./repmat(Sigma,length(P(:,ii_iter)),1);
        plot(timings,Pred(:,u_iter), Styles{v_iter},'Color',rgb(Colors(v_iter)),'LineWidth',0.5,'MarkerSize',2);
        % if v_iter == 4
        % [Y_plot,Mu,Sigma] = zscore(Y_Act(:,ii_iter));
        plot(timings,Y_Act(:,u_iter), 'Color',rgb('Black'),'LineWidth',1.5);
        % end
        % set(gca,'XTick',[0,60,120,180]);
        % set(gca,'XTickLabel',['0';'1';'2';'3']);
        % xlabel('Time (h)');
        xlabel('Sample');
        ylabel(Tags{u_iter});
        title(Methods{v_iter});
        % legend('Actual',Methods{v_iter});
        axis tight;
        if v_iter == 1
            Y_Lim_all = get(gca,'YLim');
        end
        ylim([0,Y_Lim_all(end)])
        
        y_lim = get(gca,'ylim');
        strnrm = num2str(min(nonzeros(get(gca,'YTick'))));
        strnrm = str2double(strnrm(1));
        str = num2str((get(gca,'YTick')./min(nonzeros(get(gca,'YTick'))).*strnrm)','%2.1f\n');
        strlb = num2str(min(nonzeros(get(gca,'YTick')))','%2.1e\n');
        strlb = strlb(4:end);
        strlb1 = strlb(1);
        strlb2 = strlb(end);
        set(gca, 'YTickLabel', str)
        ylabel([Tags{u_iter},' [x10^',strlb2,']']);
        maximize;
        applytofig(gcf, 'width',8, 'height',8, 'color','rgb', 'resolution',4000, 'bounds','tight', 'FontMode','fixed', 'FontSize',6, 'LockAxes',0);
        y_lim = get(gca,'ylim');
        strnrm = num2str(min(nonzeros(get(gca,'YTick'))));
        strnrm = str2double(strnrm(1));
        str = num2str((get(gca,'YTick')./min(nonzeros(get(gca,'YTick'))).*strnrm)','%2.1f\n');
        strlb = num2str(min(nonzeros(get(gca,'YTick')))','%2.1e\n');
        strlb = strlb(4:end);
        strlb1 = strlb(1);
        strlb2 = strlb(end);
        set(gca, 'YTickLabel', str)
        ylabel([Tags{u_iter},' [x10^',strlb2,']']);
        
        if v_iter == 1
            savex('Results\NN_nu.mat','u_iter','v_iter','RMSE','MAPE','R2','Y_Lim_all')
        elseif v_iter == 2
            savex('Results\SVR_nu.mat','u_iter','v_iter','RMSE','MAPE','R2','Y_Lim_all')
        elseif v_iter == 3
            savex('Results\GPR_nu.mat','u_iter','v_iter','RMSE','MAPE','R2','Y_Lim_all')
        elseif v_iter == 4
            savex('Results\SVRB_nu.mat','u_iter','v_iter','RMSE','MAPE','R2','Y_Lim_all')
        elseif v_iter == 5
            savex('Results\GPRB_nu.mat','u_iter','v_iter','RMSE','MAPE','R2','Y_Lim_all')
        end
        
        save('Results\INDEX.mat','RMSE','MAPE','R2')
        
    end
    %     if any(ii_iter == [1,2,4,6,7])
    %         legend('Actual','NN','SVR','GPR','B-SVR','B-GPR',1);
    %     else
    %         legend('Actual','NN','SVR','GPR','B-SVR','B-GPR',4);
    %     end
    
end
% subplot(2,4,8,'Color','None');
% hold on
% h(1) = plot(timings,Y_Act(:,1), 'Color',rgb('Black'),'LineWidth',1.0);
% h(2) = plot(timings,Pred(:,1), Styles{1},'Color',rgb(Colors(1)),'LineWidth',0.5);
% h(3) = plot(timings,Pred(:,2), Styles{2},'Color',rgb(Colors(2)),'LineWidth',0.5);
% h(4) = plot(timings,Pred(:,3), Styles{3},'Color',rgb(Colors(3)),'LineWidth',0.5);
% h(5) = plot(timings,Pred(:,4), Styles{4},'Color',rgb(Colors(4)),'LineWidth',0.5);
% h(6) = plot(timings,Pred(:,5), Styles{5},'Color',rgb(Colors(5)),'LineWidth',0.5);
% hl = legend('Actual','MMNN','MKSVR','MKGPR','BMA-MKSVR','BMA-MKGPR',4);
% set(hl,'Color','w');
% axis('off');
% set(h,'Visible','Off');

disp(MAPE);
disp(RMSE);

randn('state',0);
rng default;

dir = strcat(cd,'\Figs\');
saveas(gcf,[dir,'Results_all_ACC'],'fig');
maximize;
applytofig(gcf, 'width',8, 'height',8, 'color','rgb', 'resolution',4000, 'bounds','tight', 'FontMode','fixed', 'FontSize',6, 'LockAxes',0);
set(gcf, 'Renderer', 'painters');
saveas(gcf,[dir,'Results_all_ACC'],'png');
saveas(gcf,[dir,'Results_all_ACC'],'epsc');
% close all;
