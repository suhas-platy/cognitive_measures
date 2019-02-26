function [tot, corr1_sub_corr2, incorr1_sub_incorr2] = make_matrix_diff_calc( corr1, incorr1, corr2, incorr2, varargin )
% @brief correct1 - correct2 and sim. for incorr, L2 norm
   
   %corr1_sub_corr2 = corr1-corr2;
   %corr1_sub_corr2 = sum( corr1_sub_corr2(:) );
   corr1_sub_corr2 = norm( corr1-corr2 );
   
   %incorr1_sub_incorr2 = incorr1-incorr2;
   %incorr1_sub_incorr2 = sum( incorr1_sub_incorr2(:) );
   incorr1_sub_incorr2 = norm( incorr1-incorr2 );
   
   tot = (corr1_sub_corr2 + incorr1_sub_incorr2);