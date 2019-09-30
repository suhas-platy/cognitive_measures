IN.IN_PATH = 'C:\Users\suhas\Go Platypus Dropbox\Projects\EPS Assesment\Subject Data Room\Corporate\Fujitsu\Dec. 2018 Reports\v11\';
IN.IN_FILENAME = 'tpi_fuj_CSS_group_analysis_ttest_db_conn_2-20.mat'

fname = [IN.IN_PATH, IN.IN_FILENAME];

% mean
cxn_mtx = get_connectivity_sept2019( fname,...
                                     'group', 1, 'time', 1, 'band', 1, 'stat', 1, 'SRT2', 0 );

% tier 1 changes
tval_cxn_mtx = get_connectivity_sept2019( fname,...
                                     'group', 1, 'time', -1, 'band', 1, 'stat', 3, 'SRT2', 0 );   
pval_cxn_mtx = get_connectivity_sept2019( fname,...
                                     'group', 1, 'time', -1, 'band', 1, 'stat', 4, 'SRT2', 0 );   
                                 
for i = 1:12
   for j = 1:12
      if ( pval_cxn_mtx(i,j) < 0.05 )
         to_roi = intheon_index_to_name( i );
         from_roi = intheon_index_to_name( j );
         pval = pval_cxn_mtx( i,j );
         tval = tval_cxn_mtx( i,j );
         disp( sprintf( '%s (%d) to %s (%d): %.3g pval, %.3g tval',...
                        from_roi, i, to_roi, j, pval, tval ) );

      end
   end
end
