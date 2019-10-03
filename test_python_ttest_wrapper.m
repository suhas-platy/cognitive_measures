x_mean = 5;
x_std = .5;
y_mean = 8;
y_std = .5;

x = x_std.*randn(1,100) + x_mean;
y = y_std.*randn(1,100) + y_mean;

% same
mean1 = mean( x ); std1 = std( x ); nobs1 = 100;
mean2 = mean( x ); std2 = std( x ); nobs2 = 100;
[tval,pval] = python_ttest_wrapper( mean1, mean2, std1, std2, nobs1, nobs2 )

% different
mean1 = mean( x ); std1 = std( x ); nobs1 = 100;
mean2 = mean( y ); std2 = std( y ); nobs2 = 100;
[tval,pval] = python_ttest_wrapper( mean1, mean2, std1, std2, nobs1, nobs2 )

% same, vector
mean1 = mean( x ); std1 = std( x ); nobs1 = 100;
mean1 = repmat( mean1, 1,3 ); std1 = repmat( std1, 1,3 ); nobs1 = repmat( nobs1, 1,3 );
mean2 = repmat( mean1, 1,3 ); std2 = repmat( std1, 1,3 ); nobs2 = repmat( nobs1, 1,3 );
[tval,pval] = python_ttest_wrapper( mean1, mean2, std1, std2, nobs1, nobs2 )

% different, matrix
mean1 = mean( x ); std1 = std( x ); nobs1 = 100;
mean2 = mean( y ); std1 = std( y ); nobs1 = 100;
mean1 = repmat( mean1, 2,3 ); std1 = repmat( std1, 2,3 ); nobs1 = repmat( nobs1, 2,3 );
mean2 = repmat( mean2, 2,3 ); std2 = repmat( std2, 2,3 ); nobs2 = repmat( nobs2, 2,3 );
[tval,pval] = python_ttest_wrapper( mean1, mean2, std1, std2, nobs1, nobs2 )
