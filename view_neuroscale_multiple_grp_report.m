% @brief view data in neuroscale .mat files

% @todo topoplots - these are just intropolations

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

%%%%%%%%%%%%%%%%%%%%
% shared
IN.ELECTRODE_OF_INTEREST = 17; % @todo tie to NEUROSCALE constants

% {"index": "1", "name": "F7"},
% {"index": "2", "name": "Fp1"},
% {"index": "3", "name": "Fp2"},
% {"index": "4", "name": "F8"},
% {"index": "5", "name": "F3"},
% {"index": "6", "name": "Fz"},
% {"index": "7", "name": "F4"},
% {"index": "8", "name": "C3"},
% {"index": "9", "name": "Cz"},
% {"index": "10", "name": "P8"},
% {"index": "11", "name": "P7"},
% {"index": "12", "name": "Pz"},
% {"index": "13", "name": "P4"},
% {"index": "14", "name": "T3"},
% {"index": "15", "name": "P3"},
% {"index": "16", "name": "O1"},
% {"index": "17", "name": "O2"},
% {"index": "18", "name": "C4"},
% {"index": "19", "name": "T4"},
% {"index": "20", "name": "A2"}

IN.PLOT_ORDER = [2 1 4 3];
IN.NUM_ELECTRODES = 19;

IN.IN_PATH = 'C:\Users\suhas\Go Platypus Dropbox\Science And Research\Fujitsu\Dec. 2018 Reports\v9\';
IN.IN_FILEZ = ["tpi_fuj_SRT1_group_analysis__2-5_db_ttest.mat";
    "tpi_fuj_PRT_group_analysis__2-5_db_ttest.mat";
    "tpi_fuj_GNG_group_analysis__2-5_db_ttest.mat";
    "tpi_fuj_CSS_group_analysis__2-5_db_ttest.mat";
    "tpi_fuj_SP_group_analysis__2-5_db_ttest.mat";
    "tpi_fuj_MTS_group_analysis__2-5_db_ttest.mat";
    "tpi_fuj_MS_group_analysis__2-5_db_ttest.mat";
    "tpi_fuj_SRT2_group_analysis__2-5_db_ttest.mat"];
IN.COL_HDR = {'Tier 1 After', 'Tier 1 Before', 'Tier 2 After', 'Tier 2 Before'};
IN.COL_HDR = strrep( IN.COL_HDR, ' ', '_' );
IN.COL_HDR2 = {'_delta', '_theta', '_alpha', '_beta', '_gamma',...
               '_attention', '_workload', '_memory'};

IN.SAVE_PATH = [IN.IN_PATH 'excel\'];
% IN.SAVE_FILEZ will be .csv
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

NEUROSCALE_AFTER_TIER1_IDX = 1;
NEUROSCALE_BEFORE_TIER1_IDX = 2;
NEUROSCALE_AFTER_TIER2_IDX = 3;
NEUROSCALE_BEFORE_TIER2_IDX = 4;

NEUROSCALE_DELTA_IDX = 1;
NEUROSCALE_THETA_ALPHA_RATIO_IDX = 6;
NEUROSCALE_BETA_THETA_ALPHA_RATIO_IDX = 7; % beta/(theta+alpha)
NEUROSCALE_THETA_BETA_RATIO_IDX = 8;

NEUROSCALE_FP1_IDX = 2;
NEUROSCALE_C3_IDX = 8;

NEUROSCALE_MEAN_IDX = 1;
NEUROSCALE_SEM_IDX = 2;

NEUROSCALE_TASK_IDX = 2;
NEUROSCALE_PRF_IDX = 5;

TIER1_AFTER_CLR = [31 119 180]./255; % blue
TIER1_BEFORE_CLR = [255 127 14]./255; % orange
TIER2_AFTER_CLR = [44 160 44]./255; % green
TIER2_BEFORE_CLR = [214 39 40]./255; % red
%%%}}}

%%%}}} eo-params (IN & ALGO)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ load data
disp( 'load data' );

for f = 1:size(IN.IN_FILEZ,1) % for each task
  % load
  fname = strcat( IN.IN_PATH, IN.IN_FILEZ{f} )
  mt_check_filename( fname );
  disp( sprintf( 'loading file %s', fname ) );
  tmp_data = load( fname );
  data{f} = tmp_data.data;
end

%%%}}} eo-load data

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ calculate
disp( 'calculate' );

combined_col_hdr = {};
ctr = 1;
for j = 1:8
   for i = 1:4
      combined_col_hdr{ctr} = strcat( IN.COL_HDR{i}, IN.COL_HDR2{j} );
      ctr = ctr+1;
   end
end

for i = 1:IN.NUM_ELECTRODES
   electrode_label{i} = cognionics_index_to_name( i );
end

for f = 1:size(IN.IN_FILEZ,1) % for each task
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   % extract band power
   % 4D matrix (8 bands & ratios, 19 electrodes, 4 conditions, 2: mean and SEM)
   % bands & ratios, space, instance/condition, statistic
   channels_band_power_data{f} = data{f}.channels.bands_power_db.chunks.eeg.block.data;

   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   % extract workload
   % 19 electrodes x 4 conditions
   tmp = channels_band_power_data{f};
   workload_mean{f} = squeeze( tmp(NEUROSCALE_BETA_THETA_ALPHA_RATIO_IDX,:,:,NEUROSCALE_MEAN_IDX) );
   workload_sem{f} = squeeze( tmp(NEUROSCALE_BETA_THETA_ALPHA_RATIO_IDX,:,:,NEUROSCALE_SEM_IDX) );

   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   % extract attention
   % 19 electrodes x 4 conditions
   tmp = channels_band_power_data{f};
   attn_mean{f} = squeeze( tmp(NEUROSCALE_THETA_BETA_RATIO_IDX,:,:,NEUROSCALE_MEAN_IDX) );
   attn_sem{f} = squeeze( tmp(NEUROSCALE_THETA_BETA_RATIO_IDX,:,:,NEUROSCALE_SEM_IDX) );   
   
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   % save
   % fname = strcat( IN.SAVE_PATH, IN.IN_FILEZ{f} );
   % save_fname = strrep( fname, '.mat', '_workload_mean.csv' );
   % intheon_to_csv( save_fname, workload_mean{f}, IN.COL_HDR, electrode_label );
   
   % save_fname = strrep( fname, '.mat', '_workload_sem.csv' );   
   % intheon_to_csv( save_fname, workload_sem{f}, IN.COL_HDR, electrode_label );

   % fname = strcat( IN.SAVE_PATH, IN.IN_FILEZ{f} );
   % save_fname = strrep( fname, '.mat', '_attention_mean.csv' );
   % intheon_to_csv( save_fname, attn_mean{f}, IN.COL_HDR, electrode_label );
   
   % save_fname = strrep( fname, '.mat', '_attention_sem.csv' );   
   % intheon_to_csv( save_fname, attn_sem{f}, IN.COL_HDR, electrode_label );

   fname = strcat( IN.SAVE_PATH, IN.IN_FILEZ{f} );   
   save_fname = strrep( fname, 'v8\', 'v8\csv\' );
   save_fname = strrep( fname, '.mat', '_bandsAndRatios_mean.xlsx' )
   mat = channels_band_power_data{f};
   mat = squeeze( mat(:,:,:,1) );
   T = intheon_to_xlsx( save_fname, mat, combined_col_hdr, electrode_label );
   
end
keyboard;




%%%}}} eo-calculate

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ display
disp( 'display' );

% @todo display the task

disp( 'for excel: sum of workload across all 4 conditions, all electrodes)' );
for f = 1:size(IN.IN_FILEZ,1) % for each task
  x = sum( workload_mean{f}, 2 )'; % sum over cond's, so you get by electrode
  sprintf( '%.3g\t', x )
  disp( 'sum across all electrodes' );
  sum_x(f) = sum( x )
end

figure(fig_num); fig_num = fig_num + 1;
plot( sum_x );
xticklabels( {'SRT', 'PRT', 'GNG', 'CSL', 'SP', 'MTS', 'MS', 'SRT2'} );

% @todo for loop; also use barweb

disp( sprintf( 'for excel: workload, %s, mean',...
               cognionics_index_to_name( IN.ELECTRODE_OF_INTEREST ) ) );
x = workload_mean{1}(IN.ELECTRODE_OF_INTEREST,:);
sprintf( '%.3g\t', x )

disp( 'for plotting' );
x( [IN.PLOT_ORDER] )'

disp( sprintf( 'for excel: workload, %s, sem',...
               cognionics_index_to_name( IN.ELECTRODE_OF_INTEREST ) ) );
x = workload_sem{1}(IN.ELECTRODE_OF_INTEREST,:);
sprintf( '%.3g\t', x )

disp( 'for plotting' );
x( [IN.PLOT_ORDER] )'

figure(fig_num); fig_num = fig_num + 1;
conds = size(workload_mean{1},2);
for i = 1:conds
   subplot(conds,1,i);
   bar( workload_mean{1}(:,i) );
   set( gca, 'XTick', 1:electrodes );
   set( gca, 'XTickLabel', electrode_label );   
   
   if ( i == NEUROSCALE_AFTER_TIER1_IDX )
      title( 'Workload{1}: after tier 1' );
   elseif ( i == NEUROSCALE_BEFORE_TIER1_IDX )
      title( 'Workload{1}: before tier 1' );
   elseif ( i == NEUROSCALE_AFTER_TIER2_IDX )
      title( 'Workload{1}: after tier 2' );
   else
      title( 'Workload{1}: abefore tier 2' );
   end
end

figure(fig_num); fig_num = fig_num + 1;
bar( sum( workload_mean{1}, 2 ) );
set( gca, 'XTick', 1:electrodes );
set( gca, 'XTickLabel', electrode_label );   
title( 'Workload{1}: sum over 4 cond''s' );

figure(fig_num); fig_num = fig_num + 1;
bar( sum( workload_mean{2}, 2 ) );
set( gca, 'XTick', 1:electrodes );
set( gca, 'XTickLabel', electrode_label );   
title( 'Workload{2}: sum over 4 cond''s' );

%%%}}} eo-dispaly

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ save
disp( 'save' );

if ( ALGO.SAVE )
  fname = [IN.SAVE_PATH IN.SAVE_FILENAME];
  disp( sprintf( 'saving var %s as file %s', 'OUT', fname ) );
  % can also do fname = sprintf( '%s%d.mat', IN.OUTPUT_FILENAME, parameterOrRunNumber );
  save( fname, 'OUT' ); % Matlab fmt.
  %save( fname, 'OUT', '-ascii' ); % ASCII fmt. (won't work w/ a struct)
else
   disp( 'ALGO.SAVE off; not saving' );
end
%%%}}} % eo-save