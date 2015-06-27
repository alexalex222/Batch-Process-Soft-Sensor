function [Pred,weight,x] = bayesian_model_averaging_GPR(Time,X_Test,Y_Test,Model,modes,Mu,Sigma)

M = numel(Model);

z = -Inf;
accuracy = 0;
for m = 1:M
    T = numel(Time{modes(m)});
    [P(m),~,~] = svmpredict(Y_Test, X_Test, Model{m});
    P_act(m) = (P(m).*Sigma(m))+Mu(m);
    Y_act = (Y_Test.*Sigma(m))+Mu(m);
    accuracy = 1-abs((Y_act-P_act(m))/Y_act);
    if accuracy > 1 || accuracy < 0
        accuracy = 0.000001;
    end
    prior(m) = 1;
    x(m) = accuracy;
    log_likelihood(m) = T * (x(m) * log(x(m)) + (1 - x(m)) * log(1 - x(m)));
    z = max(z, log_likelihood(m));
end
clc;
for m=1:M
    weight(m) = prior(m) * exp(log_likelihood(m) - z);
end
weight = weight./sum(weight);

Pred = sum(P_act.*weight);

end