function [Pred,weight,x] = bayesian_model_averaging_SVR(Time,X_Test,Y_Test,Y_real,Model,modes,Mu,Sigma,posterior)

M = numel(Model);

z = -Inf;
accuracy = 0;
for m = 1:M
    T = numel(Time{modes(m)});
    T = 1;
    [P(m),~,~] = svmpredict(Y_Test, X_Test, Model{m});
    P_act(m) = (P(m).*Sigma(m))+Mu(m);
    % accuracy = 1-abs((Y_real-P_act(m))/Y_real);
    accuracy = 1-(abs(Y_real-P_act(m))/abs(mean([Y_real,P_act(m)])));
    if accuracy > 1 || accuracy < 0
        accuracy = 0.0;
    end
    prior(m) = posterior(m);
    x(m) = accuracy;
    log_likelihood(m) = T * (x(m) * log(x(m)) + (1 - x(m)) * log(1 - x(m)));
    if isnan(log_likelihood(m))
        log_likelihood(m) = -10;
    end
    z = max(z, log_likelihood(m));
end
clc;
for m=1:M
    weight(m) = prior(m) * exp(log_likelihood(m) - z);
end
weight = weight./sum(weight);

Pred = sum(P_act.*weight);

end