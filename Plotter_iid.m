%%% Plotter

clear all;
close all;
clc;

Tags = {'C_A (mol/L)','C_C (mol/L)','C_L (mol/L)','C_W (mol/L)','C_{SE} (mol/L)','MW (g/mol)','NH_2 (mol/g)'};
Titles = {'(a)','(b)','(c)','(d)','(e)','(f)','(g)'};
Colors = {'DarkBlue','Red','Green','Orange','Purple'};
Styles = {'--s',':^','--o',':+','--*'};

timings = 0:1:180;

X_Vars = [10,11,13,14];
Y_Vars = [1:5,15,16];

for jj_iter = 1:1:5
    if jj_iter == 1
        load('Results\NN_nu.mat')
    elseif jj_iter == 2
        load('Results\SVR_nu.mat')
    elseif jj_iter == 3
        load('Results\GPR_nu.mat')
    elseif jj_iter == 4
        load('Results\SVRB_nu.mat')
    elseif jj_iter == 5
        load('Results\GPRB_nu.mat')
    end
    
    figure;
    
    for ii_iter = 1:1:length(Y_Vars)
        
        subplot(2,4,ii_iter);
        hold on;
        plot(timings,Pred(:,ii_iter), Styles{jj_iter},'Color',rgb(Colors(jj_iter)),'LineWidth',0.5,'MarkerSize',3);
        plot(timings,Y_Act(:,ii_iter), 'Color',rgb('Black'),'LineWidth',1.5);
        xlabel('Sample');
        ylabel(Tags{ii_iter});
        title(Titles(ii_iter));
        axis tight;
        ylim auto;
        
        if any(ii_iter == [1,2,4,7])
            legend('Predicted','Actual',1);
        else
            legend('Predicted','Actual',4);
        end
        
    end
end
