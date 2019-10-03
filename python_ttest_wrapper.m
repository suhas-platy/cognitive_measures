function [tval,pval] = python_ttest_wrapper( mean1, mean2, std1, std2, nobs1, nobs2, varargin )
   equal_var = true;
   for r = 1:size( mean1, 1 )
      for c = 1:size( mean1, 2 )
         stat = py.scipy.stats.ttest_ind_from_stats(mean1(r,c), std1(r,c), nobs1(r,c), mean2(r,c), std2(r,c), nobs2(r,c), equal_var);
         tval(r,c) = stat.statistic;
         pval(r,c) = stat.pvalue;
      end
   end
   