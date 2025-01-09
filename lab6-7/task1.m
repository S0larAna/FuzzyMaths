criteria_matrix = [1 2 3;
    1/2 1 2;
    1/3 1/2 1];

profit_matrix = [1 2 1 1 3 1/3;
    1/2 1 1/2 1/2 2 1/4;
    1 2 1 1 3 1/3;
    1 2 1 1 3 1/3;
    1/3 1/2 1/3 1/3 1 1/5;
    3 4 3 3 5 1];

cost_matrix = [1/2 1/3 1/2 1 1/5 1;
    3 1 3 2 1/3 2;
    1/2 1/3 1 1/2 1/5 1/2;
    1 1/2 2 1 1/4 1;
    5 3 5 4 1 4;
    1 1/2 2 1 1/4 1];

revenue_matrix = [1 1/2 1/4 1/3 1 1/3;
    2 1 1/3 1/2 2 1/2;
    4 3 1 2 4 2;
    3 2 1/2 1 3 1;
    1 1/2 1/4 1/3 1 1/3;
    3 2 1/2 1 3 1];

disp(revenue_matrix);
disp(cost_matrix);
disp(profit_matrix);
disp(criteria_matrix);

criteria_weights = calculate_weights(criteria_matrix);
profit_weights = calculate_weights(profit_matrix);
cost_weights = calculate_weights(cost_matrix);
revenue_weights = calculate_weights(revenue_matrix);

disp('Criteria weights:')
disp(['Profit: ', num2str(criteria_weights(1))])
disp(['Cost: ', num2str(criteria_weights(2))])
disp(['Revenue: ', num2str(criteria_weights(3))])

disp('Profit weights for each corporation')
for i=1:length(profit_weights)
    disp([num2str(i), ': ', num2str(profit_weights(i))])
end
disp(' ')

disp('Cost weights for each corporation')
for i=1:length(cost_weights)
    disp([num2str(i), ': ', num2str(cost_weights(i))])
end
disp(' ')

disp('Revenue weights for each corporation')
for i=1:length(revenue_weights)
    disp([num2str(i), ': ', num2str(revenue_weights(i))])
end
disp(' ')

[lambda_criteria, CI_criteria] = check_consistency(criteria_matrix, criteria_weights);
disp(CI_criteria)
disp(lambda_criteria)

[lambda_profit, CI_profit] = check_consistency(profit_matrix, profit_weights);
disp(CI_profit)
disp(lambda_profit)

[lambda_cost, CI_cost] = check_consistency(cost_matrix, cost_weights);
disp(CI_cost)
disp(lambda_cost)

[lambda_revenue, CI_revenue] = check_consistency(revenue_matrix, revenue_weights);
disp(CI_revenue)
disp(lambda_revenue)

global_prio = [profit_weights, cost_weights, revenue_weights]*criteria_weights;
for i=1:length(profit_weights)
    disp(['Corporation ', num2str(i), ': ', num2str(global_prio(i))]);
end

function [lambda_max, CI] = check_consistency(matrix, weights)
    n = size(matrix, 1);
    a = zeros(n, 1);
    for i=1:n
        a(i) = sum(matrix(:, i));
    end
    lambda_max = dot(a, weights);
    CI = (lambda_max - n)/(n-1);
end

function weights = calculate_weights(matrix)
    n = size(matrix, 1); % берем размер
    geometric_mean=zeros(n, 1); % инициализация вектора

    for i = 1:n
        geometric_mean(i) = nthroot(prod(matrix(i, :)), n); % заполняем вектор весов
    end

    weights = geometric_mean/sum(geometric_mean);
end
