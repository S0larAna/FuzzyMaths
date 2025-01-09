% Матрица критериев (6x6)
criteria_matrix = [1     3     2     1/2   2     1;      % Цена
                  1/3   1     1/2   1/4   1/2   1/3;    % Увлажнение
                  1/2   2     1     1/3   1     1/2;    % Натуральность
                  2     4     3     1     3     2;      % Срок годности
                  1/2   2     1     1/3   1     1/2;    % Объем
                  1     3     2     1/2   2     1];     % Рейтинг

% Матрица сравнений по цене (меньше - лучше)
price_matrix = [1     1/4   1/2   1/2   4     1/2;
                4     1     3     3     7     3;
                2     1/3   1     1     5     1;
                2     1/3   1     1     5     1;
                1/4   1/7   1/5   1/5   1     1/5;
                2     1/3   1     1     5     1];

% Матрица сравнений по увлажняющему эффекту
effect_matrix = [1     3     2     1     4     2;
                1/3   1     1/2   1/3   2     1/2;
                1/2   2     1     1/2   3     1;
                1     3     2     1     4     2;
                1/4   1/2   1/3   1/4   1     1/3;
                1/2   2     1     1/2   3     1];

% Матрица сравнений по натуральности
natural_matrix = [1     2     1     1     3     1/2;
                 1/2   1     1/2   1/2   2     1/3;
                 1     2     1     1     3     1/2;
                 1     2     1     1     3     1/2;
                 1/3   1/2   1/3   1/3   1     1/4;
                 2     3     2     2     4     1];

% Матрица сравнений по сроку годности
shelf_matrix = [1     3     1     1     3     1;
                1/3   1     1/3   1/3   1     1/3;
                1     3     1     1     3     1;
                1     3     1     1     3     1;
                1/3   1     1/3   1/3   1     1/3;
                1     3     1     1     3     1];

% Матрица сравнений по объему
volume_matrix = [1     1/2   1/2   1/2   1/3   1;
                2     1     1     1     1/2   2;
                2     1     1     1     1/2   2;
                2     1     1     1     1/2   2;
                3     2     2     2     1     3;
                1     1/2   1/2   1/2   1/3   1];

% Матрица сравнений по рейтингу покупателей
rating_matrix = [1     3     2     2     3     1;
                1/3   1     1/2   1/2   1     1/3;
                1/2   2     1     1     2     1/2;
                1/2   2     1     1     2     1/2;
                1/3   1     1/2   1/2   1     1/3;
                1     3     2     2     3     1];

criteria_weights = calculate_weights(criteria_matrix);
price_weights = calculate_weights(price_matrix);
effect_weights = calculate_weights(effect_matrix);
natural_weights = calculate_weights(natural_matrix);
shelflife_weights = calculate_weights(shelf_matrix);
volume_weights = calculate_weights(volume_matrix);
rating_weights = calculate_weights(rating_matrix);

disp('Criteria weights:')
disp(['Price: ', num2str(criteria_weights(1))])
disp(['Effect: ', num2str(criteria_weights(2))])
disp(['Natural Ingredients %: ', num2str(criteria_weights(3))])
disp(['Shelf life: ', num2str(criteria_weights(4))])
disp(['Volume: ', num2str(criteria_weights(5))])
disp(['Rating: ', num2str(criteria_weights(6))])

disp('Price weights for each product')
for i=1:length(price_weights)
    disp([num2str(i), ': ', num2str(price_weights(i))])
end
disp(' ')

disp('Effect weights for each product')
for i=1:length(effect_weights)
    disp([num2str(i), ': ', num2str(effect_weights(i))])
end
disp(' ')

disp('Natural ingredients weights for each product')
for i=1:length(natural_weights)
    disp([num2str(i), ': ', num2str(natural_weights(i))])
end
disp(' ')

disp('Shelf life weights for each product')
for i=1:length(shelflife_weights)
    disp([num2str(i), ': ', num2str(shelflife_weights(i))])
end
disp(' ')

disp('Volume weights for each product')
for i=1:length(volume_weights)
    disp([num2str(i), ': ', num2str(volume_weights(i))])
end
disp(' ')

disp('Rating weights for each product')
for i=1:length(rating_weights)
    disp([num2str(i), ': ', num2str(rating_weights(i))])
end
disp(' ')

[lambda_criteria, CI_criteria] = check_consistency(criteria_matrix, criteria_weights);
disp(CI_criteria)
disp(lambda_criteria)

[lambda_price, CI_price] = check_consistency(price_matrix, price_weights);
disp(CI_price)
disp(lambda_price)

[lambda_effect, CI_effect] = check_consistency(effect_matrix, effect_weights);
disp(CI_effect)
disp(lambda_effect)

[lambda_natural, CI_natural] = check_consistency(natural_matrix, natural_weights);
disp(CI_natural)
disp(lambda_natural)

[lambda_shelf, CI_shelf] = check_consistency(shelf_matrix, shelflife_weights);
disp(CI_shelf)
disp(lambda_shelf)

[lambda_volume, CI_volume] = check_consistency(volume_matrix, volume_weights);
disp(CI_volume)
disp(lambda_volume)

[lambda_rating, CI_rating] = check_consistency(rating_matrix, rating_weights);
disp(CI_rating)
disp(lambda_rating)

global_prio = [price_weights, effect_weights, natural_weights, shelflife_weights, volume_weights, rating_weights]*criteria_weights;
for i=1:length(profit_weights)
    disp(['Product ', num2str(i), ': ', num2str(global_prio(i))]);
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
