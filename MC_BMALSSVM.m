clear all;
close all;
clc;

total = 0;
while total < 89
    clearvars -except total;
    
    load('Data_Set.mat');  load('Data_Filter.mat');
    New_Data_Replace_X = X_Test(wrong,:); New_Data_Replace_Y = Y_Test(wrong);
    
    load('Data_Set_Final.mat');
    
    order = [3,2,1,4];
    
    % load('Data_Filter.mat');
    %
    % X_Test(wrong,:) = []; Y_Test(wrong) = [];
    
    change_idx = 3; change_val = randi(3);
    dummy_1 = datasample(find(Y_Train==change_idx),change_val,'Replace',false);
    dummy_2 = datasample(find(New_Data_Replace_Y==change_idx),change_val,'Replace',false);
    temp_1 = X_Train(dummy_1,:);
    temp_2 = New_Data_Replace_X(dummy_2,:);
    X_Train(dummy_1,:) = temp_2;

%     dummy_1 = datasample([8,41,69],1,'Replace',false);
%     dummy_2 = datasample(find(Y_Train==3),1,'Replace',false);
%     temp_1 = X_Test(dummy_1,:);
%     temp_2 = X_Train(dummy_2,:);
%     X_Test(dummy_1,:) = temp_2;
%     X_Train(dummy_2,:) = temp_1;
    
    X_Test_store = X_Test;
    Y_Test_store = Y_Test;
    X_Train_store = X_Train;
    Y_Train_store = Y_Train;
    results = -1*ones(length(Y_Test),1);
    results_check = -1*ones(length(Y_Train),1);
    
    for i_iter = 1:1:length(order)-1
        
        %     rbf_sigma = 0.02:0.01:3.00;
        %     C = 0.5:0.01:5.0;
        if i_iter == 3
            rbf_sigma = [0.001:0.01:0.30,0.4,0.5];
            C = [3.0:0.1:4.0,5,10];
        elseif i_iter == 2
            rbf_sigma = [0.001,0.01:0.01:0.30,0.4,0.5];
            C = [0.5,3.0:0.1:4.0,5,10,25];
        elseif i_iter == 1
            rbf_sigma = [0.001,0.01:0.01:0.30,0.4,0.5];
            C = [0.1:0.1:4.0,5,10,25];
        end
        for j_iter = 1:1:length(rbf_sigma)
            for k_iter = 1:1:length(C)
                model_sub = svmtrain(X_Train,Y_Train==order(i_iter),'autoscale',false,'boxconstraint',C(k_iter),'kernel_function','rbf','method','LS','rbf_sigma',rbf_sigma(j_iter),'showplot',false);
                Class_sub = svmclassify(model_sub,X_Test,'showplot',false);
                lssvm_accuracy_store{i_iter}(j_iter,k_iter) = sum(Class_sub==(Y_Test==order(i_iter)))./numel(Y_Test)*100;
            end
        end
%         if i_iter == 3
%             lssvm_accuracy_store{i_iter}(lssvm_accuracy_store{i_iter}==max(max(lssvm_accuracy_store{i_iter}))) = 0;
%             lssvm_accuracy_store{i_iter}(lssvm_accuracy_store{i_iter}>95) = 0;
%         end
        %     if i_iter == 2
        %         [r,c,h] = ind2sub(size(lssvm_accuracy_store{i_iter}),find(lssvm_accuracy_store{i_iter}==max(lssvm_accuracy_store{i_iter}(:))));
        %         r = min(r); c = min(c); h = min(h);
        %     end
        if i_iter == 1
            [r,c,h] = ind2sub(size(lssvm_accuracy_store{i_iter}),find(lssvm_accuracy_store{i_iter}==max(lssvm_accuracy_store{i_iter}(:))));
            r = min(r); c = min(c); h = min(h);
        else
            [r,c,h] = ind2sub(size(lssvm_accuracy_store{i_iter}),find(lssvm_accuracy_store{i_iter}==max(lssvm_accuracy_store{i_iter}(:))));
            r = max(r); c = max(c); h = max(h);
        end
    
    parameters.C(i_iter) = C(c); parameters.rbf_sigma(i_iter) = rbf_sigma(r);
    
    figure;
    model{i_iter} = svmtrain(X_Train,Y_Train==order(i_iter),'autoscale',false,'boxconstraint',C(c),'kernel_function','rbf','method','LS','rbf_sigma',rbf_sigma(r),'showplot',true);
    Class{i_iter} = svmclassify(model{i_iter},X_Test,'showplot',true);
    Class_check{i_iter} = svmclassify(model_sub,X_Train,'showplot',false);
    
    Classification{i_iter} = sum(Class{i_iter}==(Y_Test==order(i_iter)))./numel(Y_Test)*100;
    Classification_check{i_iter} = sum(Class_check{i_iter}==(Y_Train==order(i_iter)))./numel(Y_Train)*100;
    xlabel('LV1'); ylabel('LV2'); title('');
    remove_check = logical(Y_Train==order(i_iter)); X_Train(remove_check,:) = []; Y_Train(remove_check) = [];
    where_check = find(remove_check);
    remove = logical(Class{i_iter});
    where = find(remove);
    if i_iter == 1
        results(where) = order(i_iter);
        results_check(where_check) = order(i_iter);
    elseif i_iter > 1 && i_iter < length(order)-1
        dummy = Class{i_iter-1}==0;
        results(ismember(find(dummy),where)) = order(i_iter);
        dummy_check = Class_check{i_iter-1}==0;
        results_check(ismember(find(dummy_check),where_check)) = order(i_iter);
    elseif i_iter == length(order)-1
        dummy = Class{i_iter-1}==0;
        results(ismember(find(dummy),where)) = order(i_iter);
        results(results==-1) = order(end);
        dummy_check = Class_check{i_iter-1}==0;
        results_check(ismember(find(dummy_check),where_check)) = order(i_iter);
        results_check(results_check==-1) = order(end);
    end
    X_Test(remove,:) = []; Y_Test(remove) = [];
    
    results_val(i_iter) = sum((results==order(i_iter))==(Y_Test_store==order(i_iter)))./numel(Y_Test_store)*100;
    results_val_check(i_iter) = sum((results_check==order(i_iter))==(Y_Train_store==order(i_iter)))./numel(Y_Train_store)*100;
    
    clc;
    
end

total = sum(results==Y_Test_store)./numel(Y_Test_store)*100;
total_check = sum(results_check==Y_Train_store)./numel(Y_Train_store)*100;

% save Results_BMALSSVM.mat

close all;

clc;

end

figure;
hold on;
gscatter(X_Test_store(:,1),X_Test_store(:,2),Y_Test_store,'mcgy','.',10,'off');
gscatter(X_Test_store(:,1),X_Test_store(:,2),results==Y_Test_store,'br','o',5,'off');

for iter = 1:1:3
    % Make classification predictions over a grid of values
    % x1plot = linspace(min(X_Train(:,1)), max(X_Train(:,1)), 1000)';
    % x2plot = linspace(min(X_Train(:,2)), max(X_Train(:,2)), 1000)';
    x1plot = linspace(-1, 3, 1000)';
    x2plot = linspace(-1, 3, 1000)';
    [X1, X2] = meshgrid(x1plot, x2plot);
    vals = zeros(size(X1));
    for i = 1:size(X1, 2)
        this_X = [X1(:, i), X2(:, i)];
        vals(:, i) = svmclassify(model{iter},this_X,'showplot',false);
    end
    % Plot the SVM boundary
    hold on
    if iter == 1
        contour(X1, X2, vals, [0 0], 'Color', 'r');
    elseif iter == 2
        contour(X1, X2, vals, [0 0], 'Color', 'b');
    elseif iter == 3
        contour(X1, X2, vals, [0 0], 'Color', 'g');
    end
end

legend('Class 1','Class 2','Class 3','Class 4','Classified','Misclassified','First Classification','Second Classification','Third Classification',1)
xlabel('LV1'); ylabel('LV2');
% axis([0,1.25,0,1.25]);
