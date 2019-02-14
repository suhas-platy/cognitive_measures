% @brief view data in neuroscale .mat files

% to view the json
%json_data = jsonencode( data ); % this returns a string
%fid = fopen( 'entities_and_worth_OUT.json', 'w' );
%fprintf( fid, json_dat );
%fclose( fid );

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

% don't think this ever worked (data.channels.channels_spectra field DNE; this was probably an adapataiton of view_neuroscale_datastructure.m)
IN.IN_PATH = 'C:\Users\suhas\Go Platypus Dropbox\Science And Research\Fujitsu\Dec. 2018 Reports\DANA individual reports 2019.02.04\dana_indiv_2session_reports_2-4\'
IN.IN_FILEZ = ["31950218_tpi_fuj_dana_CSS_indiv_2session_analysis.mat"];

IN.SAVE_PATH = './data/';
IN.SAVE_FILENAME = './data/flanker.csv';
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

for f = 1:size(IN.IN_FILEZ,1) % for each task
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   % extract band power
   % 4D matrix (8 bands & ratios, 19 electrodes, 4 conditions, 2: mean and SEM)
   % bands & ratios, space, instance/condition, statistic
   
   channels_band_power_data{f} = data{f}.channels.dB.bands.chunks.eeg.block.data

   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   % extract workload
   % 19 electrodes x 4 conditions
   tmp = channels_band_power_data{f};
   workload_mean{f} = squeeze( tmp(NEUROSCALE_BETA_THETA_ALPHA_RATIO_IDX,:,:,NEUROSCALE_MEAN_IDX) );
   workload_sem{f} = squeeze( tmp(NEUROSCALE_BETA_THETA_ALPHA_RATIO_IDX,:,:,NEUROSCALE_SEM_IDX) );

end
keyboard;


electrodes = size(workload_mean{1},1);
for i = 1:electrodes
   electrode_label{i} = cognionics_index_to_name( i );
end

%%%}}} eo-calculate

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ display
disp( 'display' );

disp( 'for excel: sum of workload across all 4 conditions, all electrodes)' );
for f = 1:size(IN.IN_FILEZ,1) % for each task
  x = sum( workload_mean{f}, 2 )';
  sprintf( '%.3g\t', x )
  disp( 'sum across all electrodes' );
  sum_x(f) = sum( x )
end

figure; plot( sum_x );

disp( sprintf( 'for excel: workload, %s, mean',...
               cognionics_index_to_name( IN.ELECTRODE_OF_INTEREST ) ) );
x = workload_mean{1}(IN.ELECTRODE_OF_INTEREST,:);
sprintf( '%.3g\t', x )

%disp( 'for plotting' );
%x( [IN.PLOT_ORDER] )'

disp( sprintf( 'for excel: workload, %s, sem',...
               cognionics_index_to_name( IN.ELECTRODE_OF_INTEREST ) ) );
x = workload_sem{1}(IN.ELECTRODE_OF_INTEREST,:);
sprintf( '%.3g\t', x )

%disp( 'for plotting' );
%x( [IN.PLOT_ORDER] )'

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