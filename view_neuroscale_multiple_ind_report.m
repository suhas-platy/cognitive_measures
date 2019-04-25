% @brief view data in >1 neuroscale .mat files and write it out in Excel format; individual DANA files

% view_neuroscale_multiple_ind_report( "./conf/flanker_before_tier1.json" );
function [OUT, varargout] = view_neuroscale_multiple_ind_report( CONFIG_FILENAME, varargin )

% load: each DANA file
% calculate: saving them out for Excel
% display: 
%  view_neuroscale_multiple_ind_report__display

% use the publish functionality to get a record of plots in html

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
IN.INDIVID_PLOT_ORDER = [2 1];
IN.NUM_ELECTRODES = 19;

IN.IS_INDIVID = 1;
IN.IN_PATH = 'C:\Data\DANA individual reports 2019.02.04\dana_indiv_2-4_fixed_mat\';
IN.TASKZ = ["CSS";"GNG";"MS";"MTS";"PRT";"SP";"SRT1";"SRT2"];
IN.IS_VA = 0;
IN.HAS_AFTER = 1;

% IN.IS_INDIVID = 1;
% IN.IN_PATH = 'C:\Data\DANA individual reports 2019.02.04\va_indiv_2session_2-4\';
% IN.TASKZ = ["ec"; "eo"];
% IN.IS_VA = 1;
% IN.HAS_AFTER = 1;

% IN.IS_INDIVID = 1;
% IN.IN_PATH = 'C:\Users\suhas\Go Platypus Dropbox\Science And Research\Fujitsu\Dec. 2018 Reports\individual reports 2019.03.14\dana_3-14_mat\';
% IN.TASKZ = ["MS"];
% IN.IS_VA = 0;
%IN.HAS_AFTER = 1;

CONF = jsondecode( fileread( './conf/dana/fujitsu_ms.json' ) );
IN = CONF{1}.IN;
ALGO = CONF{2}.ALGO;

%IN.SUBJECTZ is Nx1

% fill up IN.IN_FILEZ

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% @todo put into another script
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ctr = 1;
tmp_arr = [];
for i = 1:size( IN.SUBJECTZ,1 )
   for j = 1:size( IN.TASKZ,1 )
      if ( ~IN.IS_VA )
         str = sprintf( '%d_tpi_fuj_dana_%s_indiv_2session_analysis.mat',...
                        IN.SUBJECTZ(i), IN.TASKZ{j} );
      else
         str = sprintf( '%d_tpi_fuj_va-%s_indiv_2session_analysis.mat',...
                        IN.SUBJECTZ(i), IN.TASKZ{j} );
      end
      
      tmp_arr = [tmp_arr; string( str )];
      ctr = ctr+1;
   end
end
IN.IN_FILEZ = tmp_arr; %(N*T)x1

%%%}}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ ALGO: what do w/ IN and model
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
IN.N_SUBJECTS = size(IN.SUBJECTZ,1);
IN.N_TASKS = size(IN.TASKZ,1);

NEUROSCALE = jsondecode( fileread( './conf/neuroscale_constants.json' ) );
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% @todo put into another script
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%% make labels to save out var's

% for bands
tier_bands_and_ratios_combined_col_hdr = {};
ctr = 1;
for j = 1:size( NEUROSCALE.BANDS_AND_RATIOS_COL_HDR, 2 )
   for i = 1:size( NEUROSCALE.TIER_BY_TIME_COL_HDR, 2 )
      tier_bands_and_ratios_combined_col_hdr{ctr} =...
          strcat( NEUROSCALE.TIER_BY_TIME_COL_HDR{i}, NEUROSCALE.BANDS_AND_RATIOS_COL_HDR{j} );
      ctr = ctr+1;
   end
end

for i = 1:IN.NUM_ELECTRODES
   electrode_label{i} = cognionics_index_to_name( i );
end

% for connections
tier_bands_combined_col_hdr = {};
ctr = 1;
for j = 1:size( NEUROSCALE.BANDS_COL_HDR, 2 )
   for i = 1:size( NEUROSCALE.TIER_BY_TIME_COL_HDR, 2 )
      tier_bands_combined_col_hdr{ctr} =...
          strcat( NEUROSCALE.TIER_BY_TIME_COL_HDR{i}, NEUROSCALE.BANDS_COL_HDR{j} );
      ctr = ctr+1;
   end
end

% for connections stats
bands_combined_col_hdr = strrep( NEUROSCALE.BANDS_COL_HDR, '_', '' );
for i = 1:size( NEUROSCALE.BANDS_COL_HDR, 2 )
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
      if ( IN.HAS_AFTER )
         channels_band_power_data{f} = tmp(:,:,1:2,:); % 8x19x2x2; get rid of After-Before
      else
         channels_band_power_data{f} = tmp(:,:,1,:); % 8x19x1x2
      end
   else
      mat = squeeze( channels_band_power_data{f} ); % 8     1     3     2    19; get rid of time axis
      mat = permute( mat, [1 4 2 3] ); % 8 19 3 2 
      if ( IN.HAS_AFTER )
         mat = mat(:,:,1:2,:); % get rid of After-Before
      else
         mat = mat(:,:,1,:);
      end
      channels_band_power_data{f} = mat;
   end
   
   %%%%%%%%%%%%%%%%%%%%
   % extract workload
   % 19 electrodes x 2 conditions
   tmp = channels_band_power_data{f};
   workload_mean{f} = squeeze( tmp(NEUROSCALE.BETA_THETA_ALPHA_RATIO_IDX,:,:,NEUROSCALE.MEAN_IDX) );
   workload_sem{f} = squeeze( tmp(NEUROSCALE.BETA_THETA_ALPHA_RATIO_IDX,:,:,NEUROSCALE.SEM_IDX) );   

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
      % not sure why this is here; probably overzealous C&P from view_neuroscale_multiple_grp_report
      
      % channels, bands and ratios, mean
      % fname = strcat( IN.SAVE_PATH, IN.IN_FILEZ{f} ); 
      % [filepath,name,ext] = fileparts(fname);
      % if ( ~IN.IS_VA )
      %   save_fname = strrep( fname, 'dana_indiv_2-4_fixed_mat\', 'dana_indiv_2-4_fixed_mat\excel\' );
      % else
      %   save_fname = strrep( fname, 'va_indiv_2session_2-4\', 'va_indiv_2session_2-4\excel' );
      % end
      % save_fname = strrep( fname, '.mat', '_channels_bandsAndRatios_mean.xlsx' );
      % disp( sprintf( 'writing %s', save_fname ) );
      % mat = channels_band_power_data{f};
      % mat = squeeze( mat(:,:,:,1) );
      % T = intheon_to_xlsx( save_fname, mat, tier_bands_and_ratios_combined_col_hdr, electrode_label );

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
%view_neuroscale_multiple_ind_report__memory_scores;
view_neuroscale_multiple_ind_report__display;
%%%}}} eo-dispaly

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ save
disp( 'save' );

disp( 'no saving here (done above)' );
%%%}}} % eo-save