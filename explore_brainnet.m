% @brief explore head model file

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ handle include paths
addpath( './support' );
%%%}}} eo-handle include paths

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ handle function parameters or command line arg's
%%%}}} eo-handle varargin or command line arg's

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ params (IN & ALGO)
disp( 'params' );

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ IN: input files, model parameters, etc.
IN.NUM_ROIS = 12;
IN.BANDS = {'delta', 'theta', 'alpha', 'beta', 'gamma'};

IN.SIG_THOLD = 0.05;

IN.SAVE_PATH = './doc/';
IN.SAVE_FNAME = [IN.SAVE_PATH, 'CSS_tier1_before_%s.txt']; % before
IN.SAVE_FNAME2 = [IN.SAVE_PATH 'CSS_tier1_changes_%s.txt']; % changes (t-value when p<.05; this will give inc. or dec.)
%%%}}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ ALGO: what do w/ IN and model
ALGO.TRACE_LEVEL = 1; % level of verbosity
ALGO.SAVE = 0;% whether or not to save results (sometimes can take a long
                     % time or don't want to overwrite existing saved files)
%%%}}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ with a JSON file
%%%}}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ trace param's
IN
ALGO
%%%}}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ derived "constants" or "internal" var's
fig_num = 1;
%%%}}}

%%%}}} eo-params (IN & ALGO)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ load data
disp( 'load data' );
data = load( 'C:\Users\suhas\Go Platypus Dropbox\Projects\EPS Assesment\Subject Data Room\Corporate\Fujitsu\Dec. 2018 Reports\v11\tpi_fuj_CSS_group_analysis_ttest_db_conn_2-20.mat' );
data = data.data;

% tier 1, before
edge_val = data.connectivity.values.chunks.eeg_dDTF08.block.data; % 12x12x5x4x2
delta = squeeze( edge_val(:,:,1,1,1) );
theta = squeeze( edge_val(:,:,2,1,1) );
alpha = squeeze( edge_val(:,:,3,1,1) );
beta = squeeze( edge_val(:,:,4,1,1) );
gamma = squeeze( edge_val(:,:,4,1,1) );

% tier 1 changes
changes_val = data.connectivity.tier1.stats.chunks.eeg_dDTF08.block.data;
changes_tval = changes_val(:,:,:,1);
changes_pval = changes_val(:,:,:,2);

%%%}}} eo-load data

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ calculate
disp( 'calculate' );

% make a mask of where things are significant and fill it in w/ t-values
for i = 1:length( IN.BANDS )
   tmp = changes_tval(:,:,i); % make indexing easier
   tmp2 = changes_pval(:,:,i);
   tmp3 = zeros( size( tmp ) );
   
   % block out self connections
   for j = 1:IN.NUM_ROIS
       tmp2(j,j) = Inf;
   end
   changes_sig_pval_idx = find( tmp2 < IN.SIG_THOLD );
   tmp3( changes_sig_pval_idx ) = tmp( changes_sig_pval_idx );
   changes_sig_tval(:,:,i) = tmp3;
   
   % check first "decoding"
   if ( i == 1 )
      [r,c] = ind2sub( [IN.NUM_ROIS, IN.NUM_ROIS], changes_sig_pval_idx );
      for ii = 1:length(r)
         from_roi = intheon_index_to_name( r(ii) );
         to_roi = intheon_index_to_name( c(ii) );
         pval = changes_pval( r(ii), c(ii) );
         tval = changes_tval( r(ii), c(ii) );
         disp( sprintf( '%s to %s: %.3g pval, %.3g tval', from_roi, to_roi, pval, tval ) );
      end
   end
   
end

%%%}}} eo-calculate

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ display
disp( 'display' );

%%%}}} eo-display

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ save
disp( 'save' );

if ( ALGO.SAVE )
   % before
   save( sprintf( IN.SAVE_FNAME, 'delta' ), 'delta', '-ascii' );
   save( sprintf( IN.SAVE_FNAME, 'theta' ), 'theta', '-ascii' );
   save( sprintf( IN.SAVE_FNAME, 'alpha' ), 'alpha', '-ascii' );
   save( sprintf( IN.SAVE_FNAME, 'beta' ), 'beta', '-ascii' );
   save( sprintf( IN.SAVE_FNAME, 'gamma' ), 'gamma', '-ascii' );
   
   % changes
   for i = 1:length( IN.BANDS )
      tmp = changes_sig_tval(:,:,i);
      fname = sprintf( IN.SAVE_FNAME2, IN.BANDS{i} );
      disp( sprintf( 'writing out %s', fname ) );
      save( fname, 'tmp', '-ascii' );
   end
else
   disp( 'ALGO.SAVE off; not saving' );
end
%%%}}} % eo-save