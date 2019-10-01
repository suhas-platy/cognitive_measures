IN.IN_PATH = 'C:\Users\suhas\Go Platypus Dropbox\Projects\EPS Assesment\Subject Data Room\Corporate\Fujitsu\Dec. 2018 Reports\v11\';

IN.TASKS = {'eo', 'ec', 'SRT1', 'CSS', 'PRT', 'SP', 'GNG', 'MTS', 'MS', 'SRT2'};
IN.IN_FILENAME = 'tpi_fuj_%s_group_analysis_ttest_db_conn_2-20.mat'; % pass in task

task = 7; % GNG
fname = sprintf( IN.IN_FILENAME, IN.TASKS{task} );
fname = [IN.IN_PATH fname];

group = 1;

for band = 1:5
   tval_cxn_mtx = get_connectivity_sept2019( fname, 'group', group, 'time', -1, 'band', band, 'stat', 3, 'SRT2', 0 );
   pval_cxn_mtx = get_connectivity_sept2019( fname, 'group', group, 'time', -1, 'band', band, 'stat', 4, 'SRT2', 0 );
   tval_masked = get_tval_masked( tval_cxn_mtx, pval_cxn_mtx );

   cxn_mtx_before = get_connectivity_sept2019( fname, 'group', group, 'time', 1, 'band', band, 'stat', 1, 'SRT2', 0 );
   cxn_mtx_after = get_connectivity_sept2019( fname, 'group', group, 'time', 2, 'band', band, 'stat', 1, 'SRT2', 0 );
   
   for i = 1:3
      for j = 1:3
         inc_mtx(band,i,j) = get_cxn_tbl( i, j, tval_masked, '>' );
         dec_mtx(band,i,j) = get_cxn_tbl( i, j, tval_masked, '<' );

         wt_mtx_before(band,i,j) = get_cxn_tbl( i, j, cxn_mtx_before, 'sum' );
         wt_mtx_after(band,i,j) = get_cxn_tbl( i, j, cxn_mtx_after, 'sum' );
      end
   end
   disp( sprintf( 'dec for band %d', band ) );
   squeeze( dec_mtx(band,:,:) )

   disp( sprintf( 'inc for band %d', band ) );
   squeeze( inc_mtx(band,:,:) )
end

disp( 'wt before' )
wt_mtx_before2 = squeeze( sum( wt_mtx_before, 1 ) )

disp( 'wt after' )
wt_mtx_after2 = squeeze( sum( wt_mtx_after, 1 ) )

disp( 'wt after-before' )
wt_mtx_diff = wt_mtx_after2-wt_mtx_before2

