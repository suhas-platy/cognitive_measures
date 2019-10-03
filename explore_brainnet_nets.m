% @brief call brainnet - just control net

IN.SURF_FILE = 'C:\Users\suhas\Desktop\prjs\BrainNetViewer_20181219\Data\SurfTemplate\BrainMesh_Ch2.nv';
IN.NODE_FILE = '.\conf\rois_posn_withLRdistinction_control_net.node';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Pooled

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Pooled - before

% alpha
IN.TVAL_FILE = '.\data_out\Fujitsu\tpi_fuj_GNG_pooled_before_alpha_mean_group_analysis_ttest_db_conn_2-20.edge';
IN.HAVE_PVAL = 0;

% beta
IN.TVAL_FILE = '.\data_out\Fujitsu\tpi_fuj_GNG_pooled_before_beta_mean_group_analysis_ttest_db_conn_2-20.edge';
IN.HAVE_PVAL = 0;

% gamma
IN.TVAL_FILE = '.\data_out\Fujitsu\tpi_fuj_GNG_pooled_before_gamma_mean_group_analysis_ttest_db_conn_2-20.edge';
IN.HAVE_PVAL = 0;


% after pooled tvals and pvals were exported
%IN.PVAL_FILE = '.\data_out\Fujitsu\tpi_fuj_GNG_pooled_na_gamma_pval_group_analysis_ttest_db_conn_2-20.edge';
%IN.EDGE_FILE = '.\data_out\Fujitsu\tpi_fuj_GNG_pooled_na_gamma_tval_group_analysis_ttest_db_conn_2-20.edge';
%IN.HAVE_PVAL = 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Tier 1

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Tier 1 - before
% for this section, these are not tvals but means but the code below refers to IN.TVAL_FILE

% alpha
%IN.TVAL_FILE = '.\data_out\Fujitsu\tpi_fuj_GNG_tier1_before_alpha_mean_group_analysis_ttest_db_conn_2-20.edge';
%IN.HAVE_PVAL = 0;

% beta
%IN.TVAL_FILE = '.\data_out\Fujitsu\tpi_fuj_GNG_tier1_before_beta_mean_group_analysis_ttest_db_conn_2-20.edge';
%IN.HAVE_PVAL = 0;

% gamma
%IN.TVAL_FILE = '.\data_out\Fujitsu\tpi_fuj_GNG_tier1_before_gamma_mean_group_analysis_ttest_db_conn_2-20.edge';
%IN.HAVE_PVAL = 0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Tier 1 - changes
% delta - one change
%IN.PVAL_FILE = '.\data_out\Fujitsu\tpi_fuj_GNG_tier1_na_delta_pval_group_analysis_ttest_db_conn_2-20.edge';
%IN.TVAL_FILE = '.\data_out\Fujitsu\tpi_fuj_GNG_tier1_na_delta_tval_group_analysis_ttest_db_conn_2-20.edge';
%IN.HAVE_PVAL = 1;

% theta - one change
%IN.PVAL_FILE = '.\data_out\Fujitsu\tpi_fuj_GNG_tier1_na_theta_pval_group_analysis_ttest_db_conn_2-20.edge';
%IN.TVAL_FILE = '.\data_out\Fujitsu\tpi_fuj_GNG_tier1_na_theta_tval_group_analysis_ttest_db_conn_2-20.edge';
%IN.HAVE_PVAL = 1;

% alpha - two changes
%IN.PVAL_FILE = '.\data_out\Fujitsu\tpi_fuj_GNG_tier1_na_alpha_pval_group_analysis_ttest_db_conn_2-20.edge';
%IN.TVAL_FILE = '.\data_out\Fujitsu\tpi_fuj_GNG_tier1_na_alpha_tval_group_analysis_ttest_db_conn_2-20.edge';
%IN.HAVE_PVAL = 1;

% beta - no changes in ctrl net
%IN.PVAL_FILE = '.\data_out\Fujitsu\tpi_fuj_GNG_tier1_na_beta_pval_group_analysis_ttest_db_conn_2-20.edge';
%IN.TVAL_FILE = '.\data_out\Fujitsu\tpi_fuj_GNG_tier1_na_beta_tval_group_analysis_ttest_db_conn_2-20.edge';
%IN.HAVE_PVAL = 1;

% gamma - one changes in ctrl net
%IN.PVAL_FILE = '.\data_out\Fujitsu\tpi_fuj_GNG_tier1_na_gamma_pval_group_analysis_ttest_db_conn_2-20.edge';
%IN.TVAL_FILE = '.\data_out\Fujitsu\tpi_fuj_GNG_tier1_na_gamma_tval_group_analysis_ttest_db_conn_2-20.edge';
%IN.HAVE_PVAL = 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Tier 2

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Tier 2 - before
% for this section, these are not tvals but means but the code below refers to IN.TVAL_FILE

% alpha
IN.TVAL_FILE = '.\data_out\Fujitsu\tpi_fuj_GNG_tier2_before_alpha_mean_group_analysis_ttest_db_conn_2-20.edge';
IN.HAVE_PVAL = 0;

% beta
IN.TVAL_FILE = '.\data_out\Fujitsu\tpi_fuj_GNG_tier2_before_beta_mean_group_analysis_ttest_db_conn_2-20.edge';
IN.HAVE_PVAL = 0;

% gamma
IN.TVAL_FILE = '.\data_out\Fujitsu\tpi_fuj_GNG_tier2_before_gamma_mean_group_analysis_ttest_db_conn_2-20.edge';
IN.HAVE_PVAL = 0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Tier 2 - changes
% delta - one change
%IN.PVAL_FILE = '.\data_out\Fujitsu\tpi_fuj_GNG_tier2_na_delta_pval_group_analysis_ttest_db_conn_2-20.edge';
%IN.TVAL_FILE = '.\data_out\Fujitsu\tpi_fuj_GNG_tier2_na_delta_tval_group_analysis_ttest_db_conn_2-20.edge';
%IN.HAVE_PVAL = 1;

% theta - no change
%IN.PVAL_FILE = '.\data_out\Fujitsu\tpi_fuj_GNG_tier2_na_theta_pval_group_analysis_ttest_db_conn_2-20.edge';
%IN.TVAL_FILE = '.\data_out\Fujitsu\tpi_fuj_GNG_tier2_na_theta_tval_group_analysis_ttest_db_conn_2-20.edge';
%IN.HAVE_PVAL = 1;

% alpha - no change
%IN.PVAL_FILE = '.\data_out\Fujitsu\tpi_fuj_GNG_tier2_na_alpha_pval_group_analysis_ttest_db_conn_2-20.edge';
%IN.TVAL_FILE = '.\data_out\Fujitsu\tpi_fuj_GNG_tier2_na_alpha_tval_group_analysis_ttest_db_conn_2-20.edge';
%IN.HAVE_PVAL = 1;

% beta - no change
%IN.PVAL_FILE = '.\data_out\Fujitsu\tpi_fuj_GNG_tier2_na_beta_pval_group_analysis_ttest_db_conn_2-20.edge';
%IN.TVAL_FILE = '.\data_out\Fujitsu\tpi_fuj_GNG_tier2_na_beta_tval_group_analysis_ttest_db_conn_2-20.edge';
%IN.HAVE_PVAL = 1;

% gamma - no change
%IN.PVAL_FILE = '.\data_out\Fujitsu\tpi_fuj_GNG_tier2_na_gamma_pval_group_analysis_ttest_db_conn_2-20.edge';
%IN.TVAL_FILE = '.\data_out\Fujitsu\tpi_fuj_GNG_tier2_na_gamma_tval_group_analysis_ttest_db_conn_2-20.edge';
%IN.HAVE_PVAL = 1;


IN.CONFIG_FILE = '.\conf\BrainNet_FullView.mat';
IN.CONFIG_FILE = '.\conf\BrainNet_RotView.mat';
IN.CONFIG_FILE = '.\conf\BrainNet_TopView_ForNet.mat';


%IN.SAVE_PATH = './data_out/';
IN.SAVE_PATH = ''; % take from IN.TVAL_FILE
IN.SAVE_TVAL_FNAME = strrep( IN.TVAL_FILE, '.edge', '_control_net.edge' );
IN.SAVE_IMG_FNAME = strrep( IN.TVAL_FILE, '.edge', '_control_net.jpg' );

ALGO.ONLY_CTRL_NET = 1; % don't show things out ctrl. net
ALGO.SAVE = 1;

IN
ALGO

if ( ~ALGO.SAVE )
   disp( 'not supported; need to save' ); return;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% load

% tval
disp( sprintf( 'loading %s', IN.TVAL_FILE ) );
tval_orig = load( IN.TVAL_FILE );
tval = tval_orig;
if ( ALGO.ONLY_CTRL_NET )
   tval_ctrl = get_control_net( tval );
   tval = tval_ctrl;
   
   if ( ALGO.SAVE )
      % have to save out b/c the cropped network doesn't exist it
      save_fname = [IN.SAVE_PATH, IN.SAVE_TVAL_FNAME];
      disp( sprintf( 'saving to %s', save_fname ) );
      dlmwrite( save_fname, tval, ' ' );
      IN.TVAL_FILE = save_fname; % make sure brainnet loads the cropped net 
   end
end

% pval
if ( IN.HAVE_PVAL )
   disp( sprintf( 'loading %s', IN.PVAL_FILE ) );
   pval_orig = load( IN.PVAL_FILE );
   pval = pval_orig;
   if ( ALGO.ONLY_CTRL_NET )
      pval_ctrl = get_control_net( pval );
      pval = pval_ctrl;
   end

   % threshold tval for significance
   tval_sig = get_tval_masked( tval, pval );
   tval = tval_sig;
   IN.SAVE_TVAL_FNAME = strrep( IN.SAVE_TVAL_FNAME, '_control_net.edge', '_sig_control_net.edge' );
   if ( ALGO.SAVE )
      % have to save out b/c the cropped network doesn't exist it
      save_fname = [IN.SAVE_PATH, IN.SAVE_TVAL_FNAME];
      disp( sprintf( 'saving to %s', save_fname ) );
      dlmwrite( save_fname, tval, ' ' );
      IN.TVAL_FILE = save_fname; % make sure brainnet loads the cropped net 
   end
end

% draw and save
disp( 'close all BrainNet windows to continue' );
if ( ALGO.SAVE )
   save_fname = [IN.SAVE_PATH, IN.SAVE_IMG_FNAME];
   disp( sprintf( 'saving to %s', save_fname ) );
   BrainNet_MapCfg( IN.SURF_FILE, IN.NODE_FILE, IN.TVAL_FILE, IN.CONFIG_FILE, save_fname );
else
   disp( 'not supported; need to save' );
   %BrainNet_MapCfg( IN.SURF_FILE, IN.NODE_FILE, IN.TVAL_FILE, IN.CONFIG_FILE );
end

% other printing
% p-vals
if ( IN.HAVE_PVAL )
   for i = 1:size( pval_orig, 1 )
      for j = 1:size( pval_orig, 2 )
         if ( pval_orig(i,j) < .05 )
            disp( sprintf( 'from %s (%d) to %s (%d): pval %.3g',...
                           intheon_index_to_name( j ), j, intheon_index_to_name( i ), i,...
                           pval_orig(i,j) ) );
         end
      end
   end
end
