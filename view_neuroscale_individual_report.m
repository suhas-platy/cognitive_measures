% @brief view data in neuroscale .mat files

% to view the json
%json_data = jsonencode( data ); % this returns a string
%fid = fopen( 'entities_and_worth_OUT.json', 'w' );
%fprintf( fid, json_dat );
%fclose( fid );

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ handle include paths
%%%}}} eo-handle include paths

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ handle function parameters or command line arg's
%%%}}} eo-handle varargin or command line arg's

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ params (IN & ALGO)
disp( 'params' );

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ IN: input files, model parameters, etc.

% don't think this ever worked (data.channels.channels_spectra field DNE; this was probably an adapataiton of view_neuroscale_datastructure.m)
%IN.IN_PATH = 'C:\Users\suhas\Go Platypus Dropbox\Science And Research\Fujitsu\Dec. 2018 Reports\flanker_v2\Select Individual Flanker Reports-20181224T225312Z-001\';
%IN.IN_FILENAME = 'tpi_fuj_flanker_indiv_multisession_report__32950518.mat'

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

NEUROSCALE_FP1_IDX = 2;

NEUROSCALE_MEAN_IDX = 1;
NEUROSCALE_SEM_IDX = 2;

TIER1_AFTER_CLR = [31 119 180]./255; % blue
TIER1_BEFORE_CLR = [255 127 14]./255; % orange
TIER2_AFTER_CLR = [44 160 44]./255; % green
TIER2_BEFORE_CLR = [214 39 40]./255; % red
%%%}}}

%%%}}} eo-params (IN & ALGO)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ load data
disp( 'load data' );

fname = [IN.IN_PATH IN.IN_FILENAME];
mt_check_filename( fname );
disp( sprintf( 'loading file %s', fname ) );
data = load( fname );
data = data.data;

%%%}}} eo-load data

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ calculate
disp( 'calculate' );
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% extract eeg means
% 4D matrix (79 frequencies x 19 electrodes x 4 conditions x 2: mean and SEM; frequencies are 1:0.5:40)
channels_spectra_data = data.channels.channels_spectra.chunks.eeg.block.data;

fp1_eeg_after_tier1_mean = channels_spectra_data(:,NEUROSCALE_FP1_IDX,NEUROSCALE_AFTER_TIER1_IDX,1);

fp1_eeg_before_tier1_mean = channels_spectra_data(:,NEUROSCALE_FP1_IDX,NEUROSCALE_BEFORE_TIER1_IDX,1);

fp1_eeg_tier1_mean = mean( [fp1_eeg_after_tier1_mean, fp1_eeg_before_tier1_mean], 2 );

fp1_eeg_after_tier2_mean = channels_spectra_data(:,NEUROSCALE_FP1_IDX,NEUROSCALE_AFTER_TIER2_IDX,1);

fp1_eeg_before_tier2_mean = channels_spectra_data(:,NEUROSCALE_FP1_IDX,NEUROSCALE_BEFORE_TIER2_IDX,1);

fp1_eeg_tier2_mean = mean( [fp1_eeg_after_tier2_mean, fp1_eeg_before_tier2_mean], 2 );

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% extract band power
% 4D matrix (8 bands & ratios, 19 electrodes, 4 conditions, 2: mean and SEM)
channels_band_power_data = data.channels.channels_bands_power.chunks.eeg.block.data;

% extract delta
fp1_delta_mean = channels_band_power_data(NEUROSCALE_DELTA_IDX,NEUROSCALE_FP1_IDX,:,NEUROSCALE_MEAN_IDX);
fp1_delta_mean = squeeze( fp1_delta_mean );
fp1_delta_sem = channels_band_power_data(NEUROSCALE_DELTA_IDX,NEUROSCALE_FP1_IDX,:,NEUROSCALE_SEM_IDX);
fp1_delta_sem = squeeze( fp1_delta_sem );

% extract theta/alpha
fp1_theta_alpha_ratio_mean = channels_band_power_data(NEUROSCALE_THETA_ALPHA_RATIO_IDX,NEUROSCALE_FP1_IDX,:,NEUROSCALE_MEAN_IDX);
fp1_theta_alpha_ratio_mean = squeeze( fp1_theta_alpha_ratio_mean );
fp1_theta_alpha_ratio_sem = channels_band_power_data(NEUROSCALE_THETA_ALPHA_RATIO_IDX,NEUROSCALE_FP1_IDX,:,NEUROSCALE_SEM_IDX);
fp1_theta_alpha_ratio_sem = squeeze( fp1_theta_alpha_ratio_sem );


%%%}}} eo-calculate

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ display
disp( 'display' );

figure(fig_num); fig_num = fig_num + 1;
plot( fp1_eeg_after_tier1_mean, 'Color', [0 0 1] ); hold on;
plot( fp1_eeg_after_tier2_mean, 'Color', [.75 .5 0] ); hold on;
plot( fp1_eeg_before_tier1_mean, 'LineStyle', '--', 'Color', [0 0 1] ); hold on;
plot( fp1_eeg_before_tier2_mean, 'LineStyle', '--', 'Color', [.75 .5 0] ); hold on;
title( 'Fp1 mean EEG (blue: after tier 1, orange: after tier 2; dashes are before)' );

figure(fig_num); fig_num = fig_num + 1;
plot( fp1_eeg_tier1_mean, 'Color', [0 0 1] ); hold on;
plot( fp1_eeg_tier2_mean, 'Color', [.75 .5 0] ); hold on;
title( 'Fp1 mean EEG (blue: tier 1, orange: tier 2)' );

figure(fig_num); fig_num = fig_num + 1;
h = barweb( fp1_delta_mean, fp1_delta_sem ); hold on;
set(h.bars(1), 'FaceColor', TIER1_AFTER_CLR );
set(h.bars(2), 'FaceColor', TIER1_BEFORE_CLR );
set(h.bars(3), 'FaceColor', TIER2_AFTER_CLR );
set(h.bars(4), 'FaceColor', TIER2_BEFORE_CLR );
title( 'Fp1 delta (left to right: tier 1 after, tier 1 before, tier 2 after, tier 2 before)' );

figure(fig_num); fig_num = fig_num + 1;
h = barweb( fp1_theta_alpha_ratio_mean, fp1_theta_alpha_ratio_sem ); hold on;
set(h.bars(1), 'FaceColor', TIER1_AFTER_CLR );
set(h.bars(2), 'FaceColor', TIER1_BEFORE_CLR );
set(h.bars(3), 'FaceColor', TIER2_AFTER_CLR );
set(h.bars(4), 'FaceColor', TIER2_BEFORE_CLR );
title( 'Fp1 theta/alpha (left to right: tier 1 after, tier 1 before, tier 2 after, tier 2 before)' );
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