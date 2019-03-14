% @brief view data in neuroscale .mat files; individual DANA files

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
IN.ELECTRODE_OF_INTEREST = 17; % 02; @todo tie to NEUROSCALE constants

IN.PLOT_ORDER = [2 1 4 3];
IN.NUM_ELECTRODES = 19;

IN.IS_INDIVID = 1;
IN.IN_PATH = 'C:\Data\DANA individual reports 2019.02.04\dana_indiv_2-4_fixed_mat\';
IN.IN_TASKZ = ["CSS";"GNG";"MS";"MTS";"PRT";"SP";"SRT1";"SRT2"];
IN.IS_VA = 0;

IN.IS_INDIVID = 1;
IN.IN_PATH = 'C:\Data\DANA individual reports 2019.02.04\va_indiv_2session_2-4\';
IN.IN_TASKZ = ["ec"; "eo"];
IN.IS_VA = 1;

IN.IN_SUBJECTZ = [32960218;
                  31970318;
                  32950518;
                  32950318;
                  31960118;
                  31970218;
                  319100118;
                  319110218;
                  32960418;
                  319110118;
                  31950418;
                  310910318;
                  32960318;
                  32970418;
                  3209110318;
                  3209120218;
                  319100418;
                  31970118;
                  32050118;
                  31950218;
                  3109120318];
%32910218]; % includes 1 previously excluded subject

% fill up IN.IN_FILEZ
ctr = 1;
tmp_arr = [];
for i = 1:size( IN.IN_SUBJECTZ,1 )
   for j = 1:size( IN.IN_TASKZ,1 )
      if ( ~IN.IS_VA )
         str = sprintf( '%d_tpi_fuj_dana_%s_indiv_2session_analysis.mat',...
                        IN.IN_SUBJECTZ(i), IN.IN_TASKZ{j} );
      else
         str = sprintf( '%d_tpi_fuj_va-%s_indiv_2session_analysis.mat',...
                        IN.IN_SUBJECTZ(i), IN.IN_TASKZ{j} );
      end
      
      tmp_arr = [tmp_arr; string( str )];
      ctr = ctr+1;
   end
end
IN.IN_FILEZ = tmp_arr;

IN.SAVE_PATH = [IN.IN_PATH 'excel\'];

IN.TIER_BY_TIME_COL_HDR = {'After', 'Before'}; % get rid of After-Before
IN.TIER_BY_TIME_COL_HDR = strrep( IN.TIER_BY_TIME_COL_HDR, ' ', '_' );

% for bands
IN.BANDS_AND_RATIOS_COL_HDR = {'_delta', '_theta', '_alpha', '_beta', '_gamma',...
               '_attention', '_workload', '_memory'};

% for connections
IN.TIER_BY_TIME_COL_HDR2 = {'After', 'Before'};
IN.BANDS_COL_HDR = {'_delta', '_theta', '_alpha', '_beta', '_gamma'};
%%%}}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ ALGO: what do w/ IN and model
ALGO.TRACE_LEVEL = 1; % level of verbosity
ALGO.SAVE = 1;% whether or not to save results (sometimes can take a long
                     % time or don't want to overwrite existing saved files)
ALGO.SAVE_BANDS_POOLED = 1;
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
NEUROSCALE_FIRST_ELECTRODE_IDX = cognionics_name_to_index( 'Fz' ); % what's displayed first
NEUROSCALE_LAST_ELECTRODE_IDX = cognionics_name_to_index( 'P4' ); % what's dispayed last
NEUROSCALE_FIRST_SOURCE_IDX = 1;
NEUROSCALE_LAST_SOURCE_IDX = 12;

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
  fname = strcat( IN.IN_PATH, IN.IN_FILEZ{f} );
  mt_check_filename( fname );
  disp( sprintf( 'loading file %s', fname ) );
  tmp_data = load( fname );
  data{f} = tmp_data.data;
end

%%%}}} eo-load data

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ calculate
disp( 'calculate' );

%%%% make labels to save out var's

% for bands
tier_bands_and_ratios_combined_col_hdr = {};
ctr = 1;
for j = 1:size( IN.BANDS_AND_RATIOS_COL_HDR, 2 )
   for i = 1:size( IN.TIER_BY_TIME_COL_HDR, 2 )
      tier_bands_and_ratios_combined_col_hdr{ctr} =...
          strcat( IN.TIER_BY_TIME_COL_HDR{i}, IN.BANDS_AND_RATIOS_COL_HDR{j} );
      ctr = ctr+1;
   end
end

for i = 1:IN.NUM_ELECTRODES
   electrode_label{i} = cognionics_index_to_name( i );
end

% for connections
tier_bands_combined_col_hdr = {};
ctr = 1;
for j = 1:size( IN.BANDS_COL_HDR, 2 )
   for i = 1:size( IN.TIER_BY_TIME_COL_HDR2, 2 )
      tier_bands_combined_col_hdr{ctr} =...
          strcat( IN.TIER_BY_TIME_COL_HDR2{i}, IN.BANDS_COL_HDR{j} );
      ctr = ctr+1;
   end
end

% for connections stats
bands_combined_col_hdr = strrep( IN.BANDS_COL_HDR, '_', '' );
for i = 1:size( IN.BANDS_COL_HDR, 2 )
   curr_str = bands_combined_col_hdr(i);
   curr_str = [upper(curr_str(1)), curr_str(2:end)];
end

anat_label{1} = 'ant_cin_l';
anat_label{3} = 'dorlat_pf_l';
anat_label{5} = 'inf_par_l';
anat_label{7} = 'lat_ocp_l';
anat_label{9} = 'orb_pf_l';
anat_label{11} = 'pre_cent_l';
for i = 2:2:12
   anat_label{i} = strrep( anat_label{ i-1 }, '_l', '_r' );
end

ctr = 1;
for i = 1:12
   for j = 1:12
      from_to_label{ctr} = ['From__', anat_label{i}, '__To__', anat_label{j}];
      ctr = ctr+1;
   end
end

for f = 1:size(IN.IN_FILEZ,1) % for each task
   % uncomment this when the file format changes
   % if ( f == 1 )
   %    disp( 'updating ./doc/individual_reports2.txt; diff with individual_reports.txt to see changes' );
   %    structree( data{f}, './doc/individual_reports2.txt' );
   %    keyboard;
   % end
   
   % dbg
   %keyboard
   
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   % extract band power
   % 4D matrix (8 bands & ratios, 19 electrodes, 3 conditions--After, Before, After-Before, 2: mean and SEM)
   % bands & ratios, space, instance/condition, statistic
   % mean is in (:,:,:,1)
   % sem in s in (:,:,:2)
   channels_band_power_data{f} = data{f}.channels.dB.bands.chunks.eeg.block.data;
   if ( ~IN.IS_VA )
      tmp = channels_band_power_data{f};
      channels_band_power_data{f} = tmp(:,:,1:2,:); % 8x19x2x2; get rid of After-Before
   else
      mat = squeeze( channels_band_power_data{f} ); % 8     1     3     2    19; get rid of time axis
      mat = permute( mat, [1 4 2 3] ); % 8 19 3 2 
      mat = mat(:,:,1:2,:); % get rid of After-Before
      channels_band_power_data{f} = mat;
   end
   
   %%%%%%%%%%%%%%%%%%%%
   % extract workload
   % 19 electrodes x 2 conditions
   tmp = channels_band_power_data{f};
   workload_mean{f} = squeeze( tmp(NEUROSCALE_BETA_THETA_ALPHA_RATIO_IDX,:,:,NEUROSCALE_MEAN_IDX) );
   workload_sem{f} = squeeze( tmp(NEUROSCALE_BETA_THETA_ALPHA_RATIO_IDX,:,:,NEUROSCALE_SEM_IDX) );   

   %%%%%%%%%%%%%%%%%%%%
   % extract attention
   % 19 electrodes x 4 conditions

   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   % extract connectivity
   % 12 posn x 12 posn x 5 freq's x 2 stat's (mean and SEM)??
   conn{f} = data{f}.connectivity.values.chunks.eeg_dDTF08.block.data;
   
   % 12 posn x 12 posn x 5 x 2 (t value and PR(>F))
   conn_stats{f} = data{f}.connectivity.stats.chunks.eeg_dDTF08.block.data;
   
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   % display is below   
   
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   % save
   if ( ALGO.SAVE )
      % channels, bands and ratios, mean
      fname = strcat( IN.SAVE_PATH, IN.IN_FILEZ{f} ); 
      [filepath,name,ext] = fileparts(fname);
      if ( ~IN.IS_VA )
        save_fname = strrep( fname, 'dana_indiv_2-4_fixed_mat\', 'dana_indiv_2-4_fixed_mat\excel\' );
      else
        save_fname = strrep( fname, 'va_indiv_2session_2-4\', 'va_indiv_2session_2-4\excel' );
      end
      save_fname = strrep( fname, '.mat', '_channels_bandsAndRatios_mean.xlsx' );
      disp( sprintf( 'writing %s', save_fname ) );
      mat = channels_band_power_data{f};
      mat = squeeze( mat(:,:,:,1) );
      T = intheon_to_xlsx( save_fname, mat, tier_bands_and_ratios_combined_col_hdr, electrode_label );

      % sources
      % fname = strcat( IN.SAVE_PATH, IN.IN_FILEZ{f} );   
      % save_fname = strrep( fname, 'v10\', 'v10\excel\' );
      % save_fname = strrep( fname, '.mat', '_sources_bandsAndRatios_mean.xlsx' )
      % mat = sources_band_power_data{f};
      % mat = squeeze( mat(:,:,:,1) );
      % T = intheon_to_xlsx( save_fname, mat, bands_and_ratios_combined_col_hdr, anat_label );
      
      % connectivity, mean -and- connectivity stats, pvals
      %save_connectivity_reports_individual;
   end % fi ALGO.SAVE
   
end % rof f
%keyboard;

%%%}}} eo-calculate

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ display
%check_report_plots;
view_neuroscale_multiple_grp_report__display
%%%}}} eo-dispaly

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ save
disp( 'save' );

disp( 'no saving here (done above)' );
%%%}}} % eo-save