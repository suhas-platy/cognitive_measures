% @brief plot data in neuroscale .mat files

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
IN.IN_PATH = 'C:\Data\Fujitsu v5_combined reports\Group Analysis Reports\';
IN.IN_FILENAME = 'tpi_fuj_CSS_group_analysis.mat';
IN.IN_FILENAME = 'tpi_fuj_MS_group_analysis.mat';
IN.IS_INDIVID = 0;
IN.IS_VA = 0;

IN.IN_PATH = 'C:\Users\suhas\Go Platypus Dropbox\Science And Research\Fujitsu\Dec. 2018 Reports\old reports\DANA individual reports 2019.02.04\dana_indiv_2-4_fixed_mat\';
IN.IN_FILENAME = '31950218_tpi_fuj_dana_CSS_indiv_2session_analysis.mat';
IN.IS_INDIVID = 1;
IN.IS_VA = 0;

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

% group
NEUROSCALE_AFTER_TIER1_IDX = 1;
NEUROSCALE_BEFORE_TIER1_IDX = 2;
NEUROSCALE_AFTER_TIER2_IDX = 3;
NEUROSCALE_BEFORE_TIER2_IDX = 4;
% individual 
NEUROSCALE_AFTER_IDX = 1;
NEUROSCALE_BEFORE_IDX = 2;

NEUROSCALE_DELTA_IDX = 1;
NEUROSCALE_THETA_ALPHA_RATIO_IDX = 6;
NEUROSCALE_BETA_THETA_ALPHA_RATIO_IDX = 7; % beta/(theta+alpha)

NEUROSCALE_FP1_IDX = 2;
NEUROSCALE_ANT_CIN_L_IDX = 1;

NEUROSCALE_MEAN_IDX = 1;
NEUROSCALE_SEM_IDX = 2;

% group
NEUROSCALE_TASK_IDX = 2;
NEUROSCALE_PRF_IDX = 5;
% individual
NEUROSCALE_TVAL_IDX = 1;
NEUROSCALE_PVAL_IDX = 2;

% group
TIER1_AFTER_CLR = [31 119 180]./255; % blue
TIER1_BEFORE_CLR = [255 127 14]./255; % orange
TIER2_AFTER_CLR = [44 160 44]./255; % green
TIER2_BEFORE_CLR = [214 39 40]./255; % red
% individual
AFTER_CLR = [31 119 180]./255; % blue
BEFORE_CLR = [255 127 14]./255; % orange
% both
SIGDIFF_CLR = [210 210 210]./255; % gray

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

% unpack
if ( ~IN.IS_INDIVID )
   % 4D matrix (79 frequencies x 19 electrodes x 4 conditions x 2: mean and SEM; frequencies are 1:0.5:40)
   channels_spectra_data = data.channels.channels_spectra.chunks.eeg.block.data;
   
else
   % spectra, channels
   channels_spectra_data = data.channels.dB.spectra.chunks.eeg.block.data; % 79    19     3     2
   channels_spectra_stats = data.channels.dB.spectra_stats.chunks.eeg.block.data;  % 79    19     2 
   
   % band power, channels
   channels_band_power_data = data.channels.dB.bands.chunks.eeg.block.data; % 8    19     2     2
   channels_band_power_stats = data.channels.dB.bands_stats.chunks.eeg.block.data; % 8    19     2
   if ( ~IN.IS_VA )
      tmp = channels_band_power_data;
      channels_band_power_data = tmp(:,:,1:2,:); % get rid of After-Before
   else
      mat = squeeze( channels_band_power_data ); % get rid of time axis
      mat = permute( mat, [1 4 2 3] ); % 8 19 3 2 
      mat = mat(:,:,1:2,:); % get rid of After-Before
      channels_band_power_data = mat;
      
      mat = squeeze( channels_band_power_stats ); % get rid of time axis
      channels_band_power_stats = mat;
   end
   
   % topoplots
   
   % spectra, sources
   sources_spectra_data = data.sources.dB.spectra.chunks.eeg.block.data; % 79    12     3     2
   sources_spectra_stats = data.sources.dB.spectra_stats.chunks.eeg.block.data;  % 79    12     2 

   % band power, sources
   sources_band_power_data = data.sources.dB.bands.chunks.eeg.block.data; % 8    12     3     2
   sources_band_power_stats = data.sources.dB.spectra_stats.chunks.eeg.block.data; % 79    12     2 
   
   
end

%%%}}} eo-load data

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ calculate
disp( 'calculate' );

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% spectra, channels
if ( ~IN.IS_INDIVID )
   fp1_spectra_after_tier1_mean = channels_spectra_data(:,NEUROSCALE_FP1_IDX,NEUROSCALE_AFTER_TIER1_IDX,NEUROSCALE_MEAN_IDX);
   fp1_spectra_after_tier1_sem = channels_spectra_data(:,NEUROSCALE_FP1_IDX,NEUROSCALE_AFTER_TIER1_IDX,NEUROSCALE_SEM_IDX);
   fp1_spectra_before_tier1_mean = channels_spectra_data(:,NEUROSCALE_FP1_IDX,NEUROSCALE_BEFORE_TIER1_IDX,NEUROSCALE_MEAN_IDX);
   fp1_spectra_before_tier1_sem = channels_spectra_data(:,NEUROSCALE_FP1_IDX,NEUROSCALE_BEFORE_TIER1_IDX,NEUROSCALE_SEM_IDX);

   fp1_spectra_tier1_mean = mean( [fp1_spectra_after_tier1_mean, fp1_spectra_before_tier1_mean], 2 );

   fp1_spectra_after_tier2_mean = channels_spectra_data(:,NEUROSCALE_FP1_IDX,NEUROSCALE_AFTER_TIER2_IDX,NEUROSCALE_MEAN_IDX);
   fp1_spectra_after_tier2_sem = channels_spectra_data(:,NEUROSCALE_FP1_IDX,NEUROSCALE_AFTER_TIER2_IDX,NEUROSCALE_SEM_IDX);
   fp1_spectra_before_tier2_mean = channels_spectra_data(:,NEUROSCALE_FP1_IDX,NEUROSCALE_BEFORE_TIER2_IDX,NEUROSCALE_MEAN_IDX);
   fp1_spectra_before_tier2_sem = channels_spectra_data(:,NEUROSCALE_FP1_IDX,NEUROSCALE_BEFORE_TIER2_IDX,NEUROSCALE_SEM_IDX);

   fp1_spectra_tier2_mean = mean( [fp1_spectra_after_tier2_mean, fp1_spectra_before_tier2_mean], 2 );

   fp1_spectra_after_mean = mean( [fp1_spectra_after_tier1_mean, fp1_spectra_after_tier2_mean], 2 );
   fp1_spectra_before_mean = mean( [fp1_spectra_before_tier1_mean, fp1_spectra_before_tier2_mean], 2 );
else
   fp1_spectra_before_mean = channels_spectra_data(:,NEUROSCALE_FP1_IDX,NEUROSCALE_BEFORE_IDX,NEUROSCALE_MEAN_IDX);
   fp1_spectra_before_sem = channels_spectra_data(:,NEUROSCALE_FP1_IDX,NEUROSCALE_BEFORE_IDX,NEUROSCALE_SEM_IDX);

   fp1_spectra_after_mean = channels_spectra_data(:,NEUROSCALE_FP1_IDX,NEUROSCALE_AFTER_IDX,NEUROSCALE_MEAN_IDX);
   fp1_spectra_after_sem = channels_spectra_data(:,NEUROSCALE_FP1_IDX,NEUROSCALE_AFTER_IDX,NEUROSCALE_SEM_IDX);
   
   fp1_spectra_stats = channels_spectra_stats(:,NEUROSCALE_FP1_IDX,NEUROSCALE_PVAL_IDX);
   
   figure(fig_num); fig_num = fig_num + 1;
   plot( fp1_spectra_before_mean, 'Color', BEFORE_CLR ); hold on;
   ciplot_wrapper( fp1_spectra_before_mean, fp1_spectra_before_sem, BEFORE_CLR, .125 ); hold on;
   
   plot( fp1_spectra_after_mean, 'Color', AFTER_CLR ); hold on;
   ciplot_wrapper( fp1_spectra_after_mean, fp1_spectra_after_sem, AFTER_CLR, .125 ); hold on;
   % % @todo make this function higher level
   % @note Intheon says the CI's are 95% but they if you zoom in closely, they seem like only 1 sem (68%)
   
   title( 'Power Spectra, Fp1, task effect (blue: after, orange: before)' );
   ylim( [-5 25] );
   xticklabels( 0:5:40 );
   
   % add overlap bars
   % have to do vline here b/c it will only draw in ylim (if it was smaller before the lines won't fill the whole thing)
   my_ylim = ylim;
   for i = 1:size(fp1_spectra_stats,1)
      if ( fp1_spectra_stats(i) < .05 )
         %h = vline( i, 'g' );
         h = plot( [i i], my_ylim );
         h.Color(1:3) = SIGDIFF_CLR;
         h.Color(4) = 0.5; % set as transparent (https://undocumentedmatlab.com/blog/plot-line-transparency-and-color-gradient)
      end
   end

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% band power
if ( ~IN.IS_INDIVID )
   channels_spectra_statstable = data.channels.None.chunks.eeg.block.data;
   % 4D matrix (79 frequencies x 10 electrodes x 4 names x 5 stats; frequencies are 1:0.5:40)
   % note electrodes is not all, but you could get stats by querying the means and sem from above and using a calculator
   % names are 
   %                  "Group     ",
   %                  "Task      ",
   %                  "Group:Task",
   %                  "Residual  "
   % stats are
   %                  "df     ",
   %                  "sum_sq ",
   %                  "mean_sq",
   %                  "F      ",
   %                  "PR(>F) "
   fp1_stats = channels_spectra_statstable(:,NEUROSCALE_FP1_IDX,NEUROSCALE_TASK_IDX,NEUROSCALE_PRF_IDX);


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

   % extract workload
   workload_mean = squeeze( channels_band_power_data(NEUROSCALE_BETA_THETA_ALPHA_RATIO_IDX,:,:,NEUROSCALE_MEAN_IDX) );
   % 19 electrodes x 4 conditions
else
   fp1_band_before_mean = channels_band_power_data(1:5,NEUROSCALE_FP1_IDX,NEUROSCALE_BEFORE_IDX,NEUROSCALE_MEAN_IDX);
   fp1_band_before_mean = squeeze( fp1_band_before_mean );
   fp1_band_before_sem = channels_band_power_data(1:5,NEUROSCALE_FP1_IDX,NEUROSCALE_BEFORE_IDX,NEUROSCALE_SEM_IDX);
   fp1_band_before_sem = squeeze( fp1_band_before_sem );

   fp1_band_after_mean = channels_band_power_data(1:5,NEUROSCALE_FP1_IDX,NEUROSCALE_AFTER_IDX,NEUROSCALE_MEAN_IDX);
   fp1_band_after_mean = squeeze( fp1_band_after_mean );
   fp1_band_after_sem = channels_band_power_data(1:5,NEUROSCALE_FP1_IDX,NEUROSCALE_AFTER_IDX,NEUROSCALE_SEM_IDX);
   fp1_band_after_sem = squeeze( fp1_band_after_sem );
   
   %fp1_band_plot_mean = interleave( fp1_band_after_mean, fp1_band_before_mean ); 
   %fp1_band_plot_sem = interleave( fp1_band_after_sem, fp1_band_before_sem );
   fp1_band_plot_mean = [fp1_band_after_mean'; fp1_band_before_mean']';
   fp1_band_plot_sem = [fp1_band_after_sem'; fp1_band_before_sem']';
   
   figure(fig_num); fig_num = fig_num + 1;
   h = barweb( fp1_band_plot_mean, fp1_band_plot_sem );
   
   title( 'Band Power, Fp1, task effect (blue: after, orange: before)' );
   xticklabels( {'delta', 'theta', 'alpha', 'beta', 'gamma' } );
   set(h.bars(1), 'FaceColor', AFTER_CLR );
   set(h.bars(2), 'FaceColor', BEFORE_CLR );   
   ylim( [0 25] );
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ratios
if ( ~IN.IS_INDIVID )
else
   fp1_ratios_before_mean = channels_band_power_data(6:8,NEUROSCALE_FP1_IDX,NEUROSCALE_BEFORE_IDX,NEUROSCALE_MEAN_IDX);
   fp1_ratios_before_mean = squeeze( fp1_ratios_before_mean );
   fp1_ratios_before_sem = channels_band_power_data(6:8,NEUROSCALE_FP1_IDX,NEUROSCALE_BEFORE_IDX,NEUROSCALE_SEM_IDX);
   fp1_ratios_before_sem = squeeze( fp1_ratios_before_sem );

   fp1_ratios_after_mean = channels_band_power_data(6:8,NEUROSCALE_FP1_IDX,NEUROSCALE_AFTER_IDX,NEUROSCALE_MEAN_IDX);
   fp1_ratios_after_mean = squeeze( fp1_ratios_after_mean );
   fp1_ratios_after_sem = channels_band_power_data(6:8,NEUROSCALE_FP1_IDX,NEUROSCALE_AFTER_IDX,NEUROSCALE_SEM_IDX);
   fp1_ratios_after_sem = squeeze( fp1_ratios_after_sem );
   
   %fp1_ratios_plot_mean = interleave( fp1_ratios_after_mean, fp1_ratios_before_mean ); 
   %fp1_ratios_plot_sem = interleave( fp1_ratios_after_sem, fp1_ratios_before_sem );
   fp1_ratios_plot_mean = [fp1_ratios_after_mean'; fp1_ratios_before_mean']';
   fp1_ratios_plot_sem = [fp1_ratios_after_sem'; fp1_ratios_before_sem']';
   
   figure(fig_num); fig_num = fig_num + 1;
   h = barweb( fp1_ratios_plot_mean, fp1_ratios_plot_sem );
   
   title( 'Ratios, Fp1, task effect (blue: after, orange: before)' );
   xticklabels( {'theta/alpha', 'beta/(theta+alpha)', 'theta/beta'} );
   set(h.bars(1), 'FaceColor', AFTER_CLR );
   set(h.bars(2), 'FaceColor', BEFORE_CLR );   
   ylim( [0 1.75] );   
end

% topoplots

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% spectra, sources
if ( ~IN.IS_INDIVID )
else
   antcinl_spectra_before_mean = sources_spectra_data(:,NEUROSCALE_ANT_CIN_L_IDX,NEUROSCALE_BEFORE_IDX,NEUROSCALE_MEAN_IDX);
   antcinl_spectra_before_sem = sources_spectra_data(:,NEUROSCALE_ANT_CIN_L_IDX,NEUROSCALE_BEFORE_IDX,NEUROSCALE_SEM_IDX);

   antcinl_spectra_after_mean = sources_spectra_data(:,NEUROSCALE_ANT_CIN_L_IDX,NEUROSCALE_AFTER_IDX,NEUROSCALE_MEAN_IDX);
   antcinl_spectra_after_sem = sources_spectra_data(:,NEUROSCALE_ANT_CIN_L_IDX,NEUROSCALE_AFTER_IDX,NEUROSCALE_SEM_IDX);
   
   antcinl_spectra_stats = sources_spectra_stats(:,NEUROSCALE_ANT_CIN_L_IDX,NEUROSCALE_PVAL_IDX);
   
   figure(fig_num); fig_num = fig_num + 1;
   plot( antcinl_spectra_before_mean, 'Color', BEFORE_CLR ); hold on;
   ciplot_wrapper( antcinl_spectra_before_mean, antcinl_spectra_before_sem, BEFORE_CLR, .125 ); hold on;
   
   plot( antcinl_spectra_after_mean, 'Color', AFTER_CLR ); hold on;
   ciplot_wrapper( antcinl_spectra_after_mean, antcinl_spectra_after_sem, AFTER_CLR, .125 ); hold on;
   % % @todo make this function higher level
   % @note Intheon says the CI's are 95% but they if you zoom in closely, they seem like only 1 sem (68%)
   
   title( 'Power Spectra, ANT CIN L, task effect (blue: after, orange: before)' );
   ylim( [45 85] );
   xticklabels( 0:5:40 );
   
   % add overlap bars
   % have to do vline here b/c it will only draw in ylim (if it was smaller before the lines won't fill the whole thing)
   my_ylim = ylim;
   for i = 1:size(antcinl_spectra_stats,1)
      if ( antcinl_spectra_stats(i) < .05 )
         %h = vline( i, 'g' );
         h = plot( [i i], my_ylim );
         h.Color(1:3) = SIGDIFF_CLR;
         h.Color(4) = 0.5; % set as transparent (https://undocumentedmatlab.com/blog/plot-line-transparency-and-color-gradient)
      end
   end
   
end


electrodes = size(workload_mean,1);
for i = 1:electrodes
   electrode_label{i} = cognionics_index_to_name( i );
end

%%%}}} eo-calculate

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ display
disp( 'display' );

figure(fig_num); fig_num = fig_num + 1;
plot( fp1_eeg_tier1_mean, 'Color', [0 0 1] ); hold on;
plot( fp1_eeg_tier2_mean, 'Color', [.75 .5 0] ); hold on;
title( 'Fp1 mean EEG, group effect (blue: tier 1, orange: tier 2)' );
% @todo add sem; see https://stats.stackexchange.com/a/231287

figure(fig_num); fig_num = fig_num + 1;
plot( fp1_eeg_after_mean, 'Color', [0 0 1] ); hold on;
plot( fp1_eeg_before_mean, 'Color', [.75 .5 0] ); hold on;
stem( fp1_stats < .05 ); hold on;
title( 'Fp1 mean EEG, task effect (blue: after, orange: before)' );
% @todo add sem; see https://stats.stackexchange.com/a/231287

figure(fig_num); fig_num = fig_num + 1;
plot( fp1_eeg_after_tier1_mean, 'Color', [0 0 1] ); hold on;
ciplot_wrapper( fp1_eeg_after_tier1_mean, fp1_eeg_after_tier1_sem, [0 0 1], .125 ); hold on;
plot( fp1_eeg_after_tier2_mean, 'Color', [.75 .5 0] ); hold on;
ciplot_wrapper( fp1_eeg_after_tier2_mean, fp1_eeg_after_tier2_sem, [.75 .5 0], .125 ); hold on;
title( 'Fp1 mean EEG, group effect after (blue: tier 1, orange: tier 2)' );

figure(fig_num); fig_num = fig_num + 1;
plot( fp1_eeg_before_tier1_mean, 'LineStyle', '--', 'Color', [0 0 1] ); hold on;
ciplot_wrapper( fp1_eeg_before_tier1_mean, fp1_eeg_before_tier1_sem, [0 0 1], .125 ); hold on;
plot( fp1_eeg_before_tier2_mean, 'LineStyle', '--', 'Color', [.75 .5 0] ); hold on;
ciplot_wrapper( fp1_eeg_before_tier2_mean, fp1_eeg_before_tier2_sem, [.75 .5 0], .125 ); hold on;
title( 'Fp1 mean EEG, group effect before (blue: tier 1, orange: tier 2)' );

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

figure(fig_num); fig_num = fig_num + 1;
conds = size(workload_mean,2)
for i = 1:conds
   subplot(conds,1,i);
   bar( workload_mean(:,i) );
   set( gca, 'XTick', 1:electrodes );
   set( gca, 'XTickLabel', electrode_label );   
   
   if ( i == NEUROSCALE_AFTER_TIER1_IDX )
      title( 'Workload: after tier 1' );
   elseif ( i == NEUROSCALE_BEFORE_TIER1_IDX )
      title( 'Workload: before tier 1' );
   elseif ( i == NEUROSCALE_AFTER_TIER2_IDX )
      title( 'Workload: after tier 2' );
   else
      title( 'Workload: abefore tier 2' );
   end
end

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