clear all;
close all;
clc;

X_Vars = [10,11,13,14];
Y_Vars = [1:5,15,16];

load('Train.mat');
% bdb = bdb([1:181]+181*2,:);

[label, gmm_model, llh] = emgm(bdb(1:181,X_Vars)', [ones(1,46),2.*ones(1,60),3.*ones(1,75)]);

[COEFF,SCORE,latent,tsquare] = princomp(zscore(bdb));

figure;
hold on;
plot3(SCORE(label==1,1),SCORE(label==1,2),SCORE(label==1,3),'o','Color',rgb('Red'));
plot3(SCORE(label==2,1),SCORE(label==2,2),SCORE(label==2,3),'s','Color',rgb('Blue'));
plot3(SCORE(label==3,1),SCORE(label==3,2),SCORE(label==3,3),'^','Color',rgb('Green'));
xlabel('PC1')
ylabel('PC2')
zlabel('PC3')
view(3)
camorbit(90,0);
legend('Phase 1','Phase 2','Phase 3')

dir = strcat(cd,'\Figs\');
saveas(gcf,[dir,'Phase'],'fig');
maximize;
applytofig(gcf, 'width',8, 'height',8, 'color','rgb', 'resolution',1800, 'bounds','tight');
set(gcf, 'Renderer', 'painters');
saveas(gcf,[dir,'Phase'],'png');
saveas(gcf,[dir,'Phase'],'epsc');
close all;
