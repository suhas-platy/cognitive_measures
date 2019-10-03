% @brief call brainnet

IN.SURF_FILE = 'C:\Users\suhas\Desktop\prjs\BrainNetViewer_20181219\Data\SurfTemplate\BrainMesh_Ch2.nv';
IN.NODE_FILE = '.\conf\rois_posn_withLRdistinction.node';

% testing
IN.EDGE_FILE = '.\data_out\CSS_tier1_before_theta.edge';
%IN.EDGE_FILE = '.\data_out\CSS_tier1_changes_theta.edge';

% too busy
IN.EDGE_FILE = '.\data_out\tpi_fuj_GNG_tier1_before_theta_mean_group_analysis_ttest_db_conn_2-20.edge';
IN.EDGE_FILE = '.\data_out\tpi_fuj_GNG_tier1_na_theta_tval_group_analysis_ttest_db_conn_2-20.edge'

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% GNG
% GNG, delta
IN.PVAL_FILE = '.\data_out\tpi_fuj_GNG_tier1_na_delta_pval_group_analysis_ttest_db_conn_2-20.edge';
IN.EDGE_FILE = '.\data_out\tpi_fuj_GNG_tier1_na_delta_sig_tval_group_analysis_ttest_db_conn_2-20.edge';

IN.PVAL_FILE = '.\data_out\tpi_fuj_GNG_tier2_na_delta_pval_group_analysis_ttest_db_conn_2-20.edge';
IN.EDGE_FILE = '.\data_out\tpi_fuj_GNG_tier2_na_delta_sig_tval_group_analysis_ttest_db_conn_2-20.edge';

% GNG, theta
%IN.EDGE_FILE = '.\data_out\tpi_fuj_GNG_tier1_na_theta_sig_tval_group_analysis_ttest_db_conn_2-20.edge'
%IN.EDGE_FILE = '.\data_out\tpi_fuj_GNG_tier2_na_theta_sig_tval_group_analysis_ttest_db_conn_2-20.edge'

% GNG, beta
%IN.EDGE_FILE = '.\data_out\tpi_fuj_GNG_tier1_na_beta_sig_tval_group_analysis_ttest_db_conn_2-20.edge'
%IN.EDGE_FILE = '.\data_out\tpi_fuj_GNG_tier2_na_beta_sig_tval_group_analysis_ttest_db_conn_2-20.edge'

% GNG, gamma
%IN.PVAL_FILE = '.\data_out\tpi_fuj_GNG_tier1_na_gamma_pval_group_analysis_ttest_db_conn_2-20.edge';
%IN.EDGE_FILE = '.\data_out\tpi_fuj_GNG_tier1_na_gamma_sig_tval_group_analysis_ttest_db_conn_2-20.edge';

%IN.PVAL_FILE = '.\data_out\tpi_fuj_GNG_tier2_na_gamma_pval_group_analysis_ttest_db_conn_2-20.edge';
%IN.EDGE_FILE = '.\data_out\tpi_fuj_GNG_tier2_na_gamma_sig_tval_group_analysis_ttest_db_conn_2-20.edge';

IN.EDGE_FILE = '.\data_out\Fujitsu\tpi_fuj_GNG_pooled_after_gamma_mean_group_analysis_ttest_db_conn_2-20.edge';
ALGO.ONLY_CTRL_NET = 1;
ALGO.DO_PVAL = 0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EC
% EC, delta
%IN.PVAL_FILE = '.\data_out\tpi_fuj_EC_tier1_na_delta_pval_group_analysis_ttest_db_conn_2-20.edge';
%IN.EDGE_FILE = '.\data_out\tpi_fuj_EC_tier1_na_delta_sig_tval_group_analysis_ttest_db_conn_2-20.edge';

%IN.PVAL_FILE = '.\data_out\tpi_fuj_EC_tier2_na_delta_pval_group_analysis_ttest_db_conn_2-20.edge';
%IN.EDGE_FILE = '.\data_out\tpi_fuj_EC_tier2_na_delta_sig_tval_group_analysis_ttest_db_conn_2-20.edge';

% EC, beta
%IN.EDGE_FILE = '.\data_out\tpi_fuj_ec_tier1_na_beta_sig_tval_group_analysis_ttest_db_conn_2-20.edge'
%IN.EDGE_FILE = '.\data_out\tpi_fuj_ec_tier2_na_beta_sig_tval_group_analysis_ttest_db_conn_2-20.edge'

% EC, gamma
%IN.PVAL_FILE = '.\data_out\tpi_fuj_EC_tier1_na_gamma_pval_group_analysis_ttest_db_conn_2-20.edge';
%IN.EDGE_FILE = '.\data_out\tpi_fuj_EC_tier1_na_gamma_sig_tval_group_analysis_ttest_db_conn_2-20.edge';

%IN.PVAL_FILE = '.\data_out\tpi_fuj_EC_tier2_na_gamma_pval_group_analysis_ttest_db_conn_2-20.edge';
%IN.EDGE_FILE = '.\data_out\tpi_fuj_EC_tier2_na_gamma_sig_tval_group_analysis_ttest_db_conn_2-20.edge';


IN.CONFIG_FILE = '.\conf\BrainNet_FullView.mat';
IN.CONFIG_FILE = '.\conf\BrainNet_RotView.mat';


IN.SAVE_PATH = './data_out/';
%IN.SAVE_PATH = ''; % take fro IN.EDGE_FILE
IN.SAVE_FNAME = strrep( IN.EDGE_FILE, '.edge', '.jpg' );

ALGO.DO_PVAL = 0;
ALGO.SAVE = 1;

IN
ALGO

% draw and save
disp( sprintf( 'loading %s', IN.EDGE_FILE ) );
tval = load( IN.EDGE_FILE );
if ( ALGO.ONLY_CTRL_NET )
   tval = get_control_net( tval );
end

if ( ALGO.DO_PVAL )
   disp( sprintf( 'loading %s', IN.PVAL_FILE ) );
   pval = load( IN.PVAL_FILE );
end

disp( 'close all BrainNet windows to continue' );
if ( ALGO.SAVE )
   save_fname = [IN.SAVE_PATH, IN.SAVE_FNAME];
   disp( sprintf( 'saving to %s', save_fname ) );

   BrainNet_MapCfg( IN.SURF_FILE, IN.NODE_FILE, IN.EDGE_FILE, IN.CONFIG_FILE, save_fname );
else
   BrainNet_MapCfg( IN.SURF_FILE, IN.NODE_FILE, IN.EDGE_FILE, IN.CONFIG_FILE );
end

% p-vals
if ( ALGO.DO_PVAL )
for i = 1:12
   for j = 1:12
      if ( pval(i,j) < .05 )
         disp( sprintf( 'from %s (%d) to %s (%d): pval %.3g',...
                     intheon_index_to_name( j ), j, intheon_index_to_name( i ), i,...
                     pval(i,j) ) );
      end
   end
end
end

% tbl
disp (' increases' )
for i = 1:3
   for j = 1:3
      val = get_cxn_tbl( i, j, tval, '>' );
      inc_mtx(i,j) = val;
   end
end

disp (' decreases' )
for i = 1:3
   for j = 1:3
      val = get_cxn_tbl( i, j, tval, '<' );
      dec_mtx(i,j) = val;
   end
end

sum_mtx = inc_mtx + dec_mtx

