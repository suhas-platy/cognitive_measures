% @brief export data for brainnet

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

IN.SAVE_PATH = './data_out/';
IN.SAVE_FNAME = [IN.SAVE_PATH, 'CSS_tier1_before_%s.edge']; % before
IN.TIER1_CHANGES_SAVE_FNAME = [IN.SAVE_PATH 'CSS_tier1_changes_%s.edge']; % changes (t-value when p<.05; this will give inc. or dec.)
IN.TIER2_CHANGES_SAVE_FNAME = [IN.SAVE_PATH 'CSS_tier2_changes_%s.edge']; % changes (t-value when p<.05; this will give inc. or dec.)
%%%}}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ ALGO: what do w/ IN and model
ALGO.TRACE_LEVEL = 1; % level of verbosity
ALGO.SAVE = 1;% whether or not to save results (sometimes can take a long
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
edge_val = data.connectivity.values.chunks.eeg_dDTF08.block.data; % 12x12x5x4x2; 5 is bands, 4 is group*time, 2 is the stat
delta = squeeze( edge_val(:,:,1,1,1) );
theta = squeeze( edge_val(:,:,2,1,1) );
alpha = squeeze( edge_val(:,:,3,1,1) );
beta = squeeze( edge_val(:,:,4,1,1) );
gamma = squeeze( edge_val(:,:,5,1,1) );

% tier 1 changes
tier1_changes_val = data.connectivity.tier1.stats.chunks.eeg_dDTF08.block.data; % 12x12x5x2; 5 is bands, 2 is stat (tval or pval)
tier1_changes_tval = tier1_changes_val(:,:,:,1);
tier1_changes_pval = tier1_changes_val(:,:,:,2);

% tier 2 changes
tier2_changes_val = data.connectivity.tier2.stats.chunks.eeg_dDTF08.block.data;
tier2_changes_tval = tier2_changes_val(:,:,:,1);
tier2_changes_pval = tier2_changes_val(:,:,:,2);

%%%}}} eo-load data

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ calculate
disp( 'calculate' );

% tier 1 -> tier1_changes_sig_tval
% make a mask of where things are significant and fill it in w/ t-values
for i = 1:length( IN.BANDS )
   tmp = tier1_changes_tval(:,:,i); % make indexing easier
   tmp2 = tier1_changes_pval(:,:,i);
   tmp3 = zeros( size( tmp ) );
   
   % block out self connections
   for j = 1:IN.NUM_ROIS
       tmp2(j,j) = Inf;
   end
   changes_sig_pval_idx = find( tmp2 < IN.SIG_THOLD );
   tmp3( changes_sig_pval_idx ) = tmp( changes_sig_pval_idx );
   tier1_changes_sig_tval(:,:,i) = tmp3;
   
   % check first "decoding"
   if ( i == 1 )
      [r,c] = ind2sub( [IN.NUM_ROIS, IN.NUM_ROIS], changes_sig_pval_idx );
      for ii = 1:length(r)
         to_roi = intheon_index_to_name( r(ii) );
         from_roi = intheon_index_to_name( c(ii) );
         pval = tier1_changes_pval( r(ii), c(ii) );
         tval = tier1_changes_tval( r(ii), c(ii) );
         disp( sprintf( '%s (%d) to %s (%d): %.3g pval, %.3g tval',...
                        from_roi, c(ii), to_roi, r(ii), pval, tval ) );
      end
   end
   
end

% tier 2 -> tier2_changes_sig_tval
for i = 1:length( IN.BANDS )
   tmp = tier2_changes_tval(:,:,i); % make indexing easier
   tmp2 = tier2_changes_pval(:,:,i);
   tmp3 = zeros( size( tmp ) );
   
   % block out self connections
   for j = 1:IN.NUM_ROIS
       tmp2(j,j) = Inf;
   end
   changes_sig_pval_idx = find( tmp2 < IN.SIG_THOLD );
   tmp3( changes_sig_pval_idx ) = tmp( changes_sig_pval_idx );
   tier2_changes_sig_tval(:,:,i) = tmp3;   
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
   
   % tier 1, changes
   for i = 1:length( IN.BANDS )
      tmp = tier1_changes_sig_tval(:,:,i);
      %tmp = tmp'; % transpose needed for some reason
      fname = sprintf( IN.TIER1_CHANGES_SAVE_FNAME, IN.BANDS{i} );
      disp( sprintf( 'writing out %s', fname ) );
      save( fname, 'tmp', '-ascii' );
   end

   % tier 2, changes
   for i = 1:length( IN.BANDS )
      tmp = tier2_changes_sig_tval(:,:,i);
      %tmp = tmp';  % transpose needed for some reason
      fname = sprintf( IN.TIER2_CHANGES_SAVE_FNAME, IN.BANDS{i} );
      disp( sprintf( 'writing out %s', fname ) );
      save( fname, 'tmp', '-ascii' );
   end
else
   disp( 'ALGO.SAVE off; not saving' );
end
%%%}}} % eo-save