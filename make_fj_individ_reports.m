% @brief makes "group average before, you before, group average after, you after" plots for average brain power

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
IN.IN_PATH = 'C:\Data\DANA individual reports 2019.02.04\va_indiv_2session_2-4\excel\';
IN.IN_TASKZ = ["ec"; "eo"];
IN.IS_VA = 1;

IN.IN_SUBJECTZ = [310910318;
                  319100118;    
                  319100418;    
                  31950218;     
                  31950418;     
                  31960118;     
                  31970118;     
                  31970318;     
                  3209110318;   
                  3209120218;   
                  32950318;     
                  32950518;     
                  32960218;     
                  32960318;     
                  32960418;     
                  32970418];

% fill up IN.IN_FILEZ% fill up IN.IN_FILEZ
ctr = 1;
tmp_arr = [];
for i = 1:size( IN.IN_SUBJECTZ,1 )
   for j = 1:size( IN.IN_TASKZ,1 )
      if ( ~IN.IS_VA )
         str = sprintf( '%d_tpi_fuj_dana_%s_indiv_2session_analysis.mat',...
                        IN.IN_SUBJECTZ(i), IN.IN_TASKZ{j} );
      else
         str = sprintf( '%d_tpi_fuj_va-%s_indiv_2session_analysis_channels_bandsAndRatios_mean_meanB_meanE.xlsx',...
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
ALGO.SAVE2 = 1;
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
  tmp_data = xlsread( fname );
  data{f} = tmp_data;
  data_arr(f,:) = data{f};
end

%%%}}} eo-load data

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ calculate
disp( 'calculate' );

mean_over_subjs = mean( data_arr );

for f = 1:size(IN.IN_FILEZ,1)
   FigH = figure('Position', get(0, 'Screensize'));

   bar( [mean_over_subjs(2), data_arr(f,2),...
         mean_over_subjs(1), data_arr(f,1)] );
   ylabel( 'Average power over bands and electrodes (dB)' );
   xticklabels( {'Group average before', 'Your average before', 'Group average after', 'Your average after'} );
   
   if ( ~isempty( strfind( IN.IN_FILEZ{f}, 'eo' ) ) )
       title_str = 'Eyes Open';
   else
       title_str = 'Eyes Closed';
   end
   filename = IN.IN_FILEZ{f};
   end_of_subj = strfind( filename, "_tpi" );
   subj = filename(1:end_of_subj-1);
   title_str = [title_str " for " num2str( subj ) ];
   title_str = [title_str sprintf( " (values %.2g %.2g %.2g %.2g)",...
         mean_over_subjs(2), data_arr(f,2), mean_over_subjs(1), data_arr(f,1) ) ];
   title( title_str );
   
   fname = IN.IN_FILEZ{f};
   fname = strrep( fname, '.xlsx', '.png' );
   disp( sprintf( 'writing %s', fname ) );
   %saveas( gcf, fname );
                
   F    = getframe(FigH);
   imwrite(F.cdata, fname, 'png')                
end


%%%}}} eo-calculate

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ display
%%%}}} eo-dispaly

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ save
disp( 'save' );

disp( 'no saving here (done above)' );
%%%}}} % eo-save