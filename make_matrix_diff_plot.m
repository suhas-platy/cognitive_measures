function make_matrix_diff_plot( foo1, foo2, foo3, foo4,...
                                title_str1, title_str2, ...
                                varargin )
% @brief show matrix plot and diff's for flanker task
   
subplot(3,3,1);
imagesc( foo1 );
mt_jetbar;

subplot(3,3,2);
imagesc( foo2 );
mt_jetbar;

subplot(3,3,3);
imagesc( foo1-foo2 ); 
str = sprintf( '%s: corr, incorr, corr-incorr', title_str1 );
title( str );
mt_jetbar;

subplot(3,3,4);
imagesc( foo3 );
mt_jetbar;

subplot(3,3,5);
imagesc( foo4 );
mt_jetbar;

subplot(3,3,6);
imagesc( foo3-foo2 ); 
str = sprintf( '%s: corr, incorr, corr-incorr', title_str2 );
title( str );
mt_jetbar;
xticklabels( {'ACC', 'DLPFC', 'INF. PAR.',...
              'LAT. OCP', 'OFPFC', 'PRE. CENT.'} );
xtickangle( 90 );
yticklabels( {'ACC', 'DLPFC', 'INF. PAR.',...
              'LAT. OCP', 'OFPFC', 'PRE. CENT.'} );

subplot(3,3,7);
imagesc( foo1-foo3 ); 
str = sprintf( '%s-%s after: corr', title_str1, title_str2 );
title( str );
mt_jetbar;
xticklabels( {'ACC', 'DLPFC', 'INF. PAR.',...
              'LAT. OCP', 'OFPFC', 'PRE. CENT.'} );
xtickangle( 90 );
yticklabels( {'ACC', 'DLPFC', 'INF. PAR.',...
              'LAT. OCP', 'OFPFC', 'PRE. CENT.'} );

subplot(3,3,8);
imagesc( foo2-foo4 ); 
str = sprintf( '%s-%s after: incorr', title_str1, title_str2 );
title( str );
mt_jetbar;
xticklabels( {'ACC', 'DLPFC', 'INF. PAR.',...
              'LAT. OCP', 'OFPFC', 'PRE. CENT.'} );
xtickangle( 90 );
yticklabels( {'ACC', 'DLPFC', 'INF. PAR.',...
              'LAT. OCP', 'OFPFC', 'PRE. CENT.'} );
   