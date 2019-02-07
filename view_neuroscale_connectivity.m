% @brief view data in neuroscale .mat files

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
IN.IN_PATH = 'C:\Users\suhas\Go Platypus Dropbox\Science And Research\Fujitsu\Dec. 2018 Reports\flanker_v2\';
IN.IN_FILENAME = 'tpi_fuj_flanker_group_report.mat';

IN.IN_TIER1_FILENAME = 'C:\Users\suhas\Go Platypus Dropbox\Science And Research\Fujitsu\Dec. 2018 Reports\flanker_v2\Select Individual Flanker Reports-20181224T225312Z-001\tpi_fuj_flanker_indiv_multisession_report__32950518.mat'
IN.IN_TIER2_FILENAME = 'C:\Users\suhas\Go Platypus Dropbox\Science And Research\Fujitsu\Dec. 2018 Reports\flanker_v2\Select Individual Flanker Reports-20181224T225312Z-001\tpi_fuj_flanker_indiv_multisession_report__32960318.mat'


IN.SAVE_PATH = './data/';
IN.SAVE_FILENAME = './data/vnd.csv';
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

fname = [IN.IN_PATH IN.IN_FILENAME];
mt_check_filename( fname );
disp( sprintf( 'loading file %s', fname ) );
data = load( fname );
data = data.data;

fname = IN.IN_TIER1_FILENAME;
disp( sprintf( 'loading file %s', fname ) );
tier1_data = load( fname );
tier1_data = tier1_data.data;

fname = IN.IN_TIER2_FILENAME;
disp( sprintf( 'loading file %s', fname ) );
tier2_data = load( fname );
tier2_data = tier2_data.data;


%%%}}} eo-load data

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ calculate
disp( 'calculate' );
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% extract matrix
connectivity_data = data.connectivity.connectivity.chunks.eeg_dDTF08.block.data;
% data.connectivity.connectivity.chunks.eeg_dDTF08.block.data 5D
% data.connectivity.connectivity.chunks.eeg_dDTF08.block.axes  
%   1 is time (only 1 value),
%   2 is names (12 options)
%   3 is names (12 options)
%   4 is frequency (only 1 option)
%   5 is instance (8x8x106); 1 is correct, tier1, after; 2 is incorrect, tier1, after, etc.

% instance_data =  data.connectivity.connectivity.chunks.eeg_dDTF08.block.axes{5}.data
% squeeze( instance_data(1,:,:) )

foo1 = squeeze( connectivity_data(1,:,:,1,1) ); % tier1, correct after
foo2 = squeeze( connectivity_data(1,:,:,1,2) ); % tier1, incorrect after

foo3 = squeeze( connectivity_data(1,:,:,1,3) ); % tier2, correct after
foo4 = squeeze( connectivity_data(1,:,:,1,4) ); % tier2, incorrect after

foo5 = squeeze( connectivity_data(1,:,:,1,5) ); % tier1, correct before
foo6 = squeeze( connectivity_data(1,:,:,1,6) ); % tier1, incorrect after

foo7 = squeeze( connectivity_data(1,:,:,1,7) );
foo8 = squeeze( connectivity_data(1,:,:,1,8) );

regions = data.connectivity.connectivity.chunks.eeg_dDTF08.block.axes{2}.names;

% 1 x 12 x 12 x 1 x 4
tier1_connectivity_data = tier1_data.connectivity.connectivity.chunks.eeg_dDTF08.block.data;
t1 = squeeze( tier1_connectivity_data(1,:,:,1,1) ); % correct after
t2 = squeeze( tier1_connectivity_data(1,:,:,1,2) ); % incorrect after

% 1 x 12 x 12 x 1 x 4
tier2_connectivity_data = tier2_data.connectivity.connectivity.chunks.eeg_dDTF08.block.data;
u1 = squeeze( tier2_connectivity_data(1,:,:,1,1) ); % correct after
u2 = squeeze( tier2_connectivity_data(1,:,:,1,2) ); % incorrect after

% tier1 - tier1 subj
[a,b,c] = make_matrix_diff_calc( foo1, foo2, t1, t2 );

% tier2 - tier1 subj
[d,e,f] = make_matrix_diff_calc( foo3, foo4, t1, t2 );

% tier1 - tier2 subj
[a2,b2,c2] = make_matrix_diff_calc( foo1, foo2, u1, u2 );

% tier2 - tier2 subj
[d2,e2,f2] = make_matrix_diff_calc( foo3, foo4, u1, u2 );



keyboard;

%%%}}} eo-calculate

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ display
disp( 'display' );

figure(fig_num); fig_num = fig_num + 1;
make_matrix_diff_plot( foo1, foo2, foo3, foo4, 'Tier 1', 'Tier 2' );              

figure(fig_num); fig_num = fig_num + 1;
make_matrix_diff_plot( foo1, foo2, t1, t2, 'Tier 1', 'T1 Subj' );              

figure(fig_num); fig_num = fig_num + 1;
make_matrix_diff_plot( foo3, foo4, t1, t2, 'Tier 2', 'T1 Subj' );              

figure(fig_num); fig_num = fig_num + 1;
make_matrix_diff_plot( foo1, foo2, u1, u2, 'Tier 1', 'T2 Subj' );              

figure(fig_num); fig_num = fig_num + 1;
make_matrix_diff_plot( foo3, foo4, u1, u2, 'Tier 2', 'T2 Subj' );              


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