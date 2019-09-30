% @brief view connectivity on flanker task

% BrainNetView: "C:\Users\suhas\Desktop\prjs\BrainNetViewer_20181219\Data\ExampleFiles\Desikan-Killiany68\Desikan-Killinay68.csv"
% Intheon head model: "C:\Program Files\Intheon\NeuroPype Enterprise Suite\NeuroPype\resources\headmodels\Colin-339ch-4495v-scalar-4shell-1.1.hm"

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
IN.IN_PATH = 'C:\Users\suhas\Go Platypus Dropbox\Projects\EPS Assesment\Subject Data Room\Corporate\Fujitsu\Dec. 2018 Reports\v11\';

IN.TASKS = {'eo', 'ec', 'SRT1', 'CSS', 'PRT', 'SP', 'GNG', 'MTS', 'MS', 'SRT2'};
IN.IN_FILENAME = 'tpi_fuj_%s_group_analysis_ttest_db_conn_2-20.mat'; % pass in task
% IN.IN_FILENAME = 'tpi_fuj_eo_group_analysis_ttest_db_conn_2-20.mat'
% IN.IN_FILENAME = 'tpi_fuj_ec_group_analysis_ttest_db_conn_2-20.mat'
% IN.IN_FILENAME = 'tpi_fuj_SRT1_group_analysis_ttest_db_conn_2-20.mat'
% IN.IN_FILENAME = 'tpi_fuj_CSS_group_analysis_ttest_db_conn_2-20.mat'
% IN.IN_FILENAME = 'tpi_fuj_PRT_group_analysis_ttest_db_conn_2-20.mat'
% IN.IN_FILENAME = 'tpi_fuj_SP_group_analysis_ttest_db_conn_2-20.mat'
% IN.IN_FILENAME = 'tpi_fuj_GNG_group_analysis_ttest_db_conn_2-20.mat'
% IN.IN_FILENAME = 'tpi_fuj_MTS_group_analysis_ttest_db_conn_2-20.mat'
% IN.IN_FILENAME = 'tpi_fuj_MS_group_analysis_ttest_db_conn_2-20.mat'
% IN.IN_FILENAME = 'tpi_fuj_SRT2_group_analysis_ttest_db_conn_2-20.mat'

IN.SAVE_PATH = './data/';
IN.SAVE_FILENAME = './data/tpi_fuj_%s_%s_%s_%s_%s_group_analysis_ttest_db_conn_2-20.mat' % pass in task, group, band, stat
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

% figure out structure
%data = load( 'C:\Users\suhas\Go Platypus Dropbox\Projects\EPS Assesment\Subject Data Room\Corporate\Fujitsu\Dec. 2018 Reports\v11\tpi_fuj_CSS_group_analysis_ttest_db_conn_2-20.mat' );
%data = data.data;
%structree( data, './doc/v11_reports.txt' ); 

% values
%data.connectivity.values.chunks.eeg_dDTF08.block.axes{1}.names % ANT_CIN_L, DORLAT_PF_L, etc.
%data.connectivity.values.chunks.eeg_dDTF08.block.axes{1}.positions % x,y,z
%
%also space for axes{2}
%
%frequency for axes{3}
%
%data.connectivity.values.chunks.eeg_dDTF08.block.axes{4}.data.recarray.Group is tier1, tier1, tier2, tier2
% .Task is After, Before, After, Before 
%
% data.connectivity.values.chunks.eeg_dDTF08.block.axes{5} is conditional-mean
%
% data.connectivity.values.chunks.eeg_dDTF08.block.data is 12x12x5x4x2

% stat's
% data.connectivity.tier1.stats.chunks.eeg_dDTF08.block.data is 12x12x5x2

% values
for task = 1:length( IN.TASKS )
   fname = sprintf( IN.IN_FILENAME, IN.TASKS{task} );
   fname = [IN.IN_PATH fname];
   disp( sprintf( 'loading values %s', fname ) );
   for group = 1:2
      for time = 1:2
         for band = 1:5
            curr_task = IN.TASKS{task};
            if ( strcmp(curr_task, 'SRT2') )
                SRT2 = 1;
            else
                SRT2 = 0;
            end
            mean_cxn_mtx(task,:,:,group,time,band) = get_connectivity_sept2019( fname,...
                'group', group, 'time', time, 'band', band, 'stat', 1, 'SRT2', SRT2, 'verbose', 1 );
            sem_cxn_mtx(task,:,:,group,time,band) = get_connectivity_sept2019( fname,...
                'group', group, 'time', time, 'band', band, 'stat', 2, 'SRT2', SRT2, 'verbose', 1 );

         end
      end
   end
end

% stats
for task = 1:length( IN.TASKS )
   fname = sprintf( IN.IN_FILENAME, IN.TASKS{task} );
   fname = [IN.IN_PATH fname];
   disp( sprintf( 'loading stats %s', fname ) );
   for group = 1:2
      for band = 1:5
         tval_cxn_mtx(task,:,:,group,band) = get_connectivity_sept2019( fname,...
                'group', group, 'time', -1, 'band', band, 'stat', 3, 'SRT2', SRT2, 'verbose', 1 );
         pval_cxn_mtx(task,:,:,group,band) = get_connectivity_sept2019( fname,...
                'group', group, 'time', -1, 'band', band, 'stat', 4, 'SRT2', SRT2, 'verbose', 1 );
      end
   end
end

%%%}}} eo-load data

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ calculate
disp( 'calculate' );
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% values

%lbl = data.connectivity.values.chunks.eeg_dDTF08.block.axes{1}.names;
%posn = data.connectivity.values.chunks.eeg_dDTF08.block.axes{1}.positions;
%edge_val = data.connectivity.values.chunks.eeg_dDTF08.block.data; % 12x12x5x4x2

% sanity check, stats
task = 4; % 'CSS'
for group = 1:2
   for i = 1:12
      for j = 1:12
         for band = 1:1
            tmp_pval = pval_cxn_mtx(task,i,j,group,band);
            tmp_tval = tval_cxn_mtx(task,i,j,group,band);
            if ( tmp_pval < 0.05 )
               if ( group == 1 )
                  group_str = 'tier 1';
               else
                  group_str = 'tier 2';
               end
               switch band
                  case 1
                     band_str = 'delta';
                  case 2
                     band_str = 'theta';
                  case 3
                     band_str = 'alpha';
                  case 4
                     band_str = 'beta';
                  case 5
                     band_str = 'gamma';
               end
               
               disp( sprintf( '%s: from %s (%d) to %s (%d) at %s band: pval %.3g, tval %.3g',...
                     group_str, intheon_index_to_name( i ), i, intheon_index_to_name( j ), j, band_str,...
                     tmp_pval, tmp_tval ) );
            end
         end
      end
   end
end

% ranges
min( mean_cxn_mtx(:) )
mean( mean_cxn_mtx(:) )
max( mean_cxn_mtx(:) )

min( tval_cxn_mtx(:) )
mean( tval_cxn_mtx(:) )
max( tval_cxn_mtx(:) )

keyboard;

%%%}}} eo-calculate

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ display
disp( 'display' );


%%%}}} eo-display

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ save
disp( 'save' );

if ( ALGO.SAVE )
   % values
   %%% {{{
   for i = 1:length( IN.TASKS )
      for group = 1:2
         for time = 1:2
            for band = 1:5
               for stat = 1:4
                  if ( group == 1 )
                     group_str = 'tier1';
                  else
                     group_str = 'tier2';
                  end
                  
                  if ( time == 1 )
                     time_str = 'before';
                  else
                     time_str = 'after';
                  end

                  switch band
                     case 1
                        band_str = 'delta';
                     case 2
                        band_str = 'theta';
                     case 3 
                        band_str = 'alpha';
                     case 4
                        band_str = 'beta';
                     case 5
                        band_str = 'gamma';
                     otherwise
                        error( ['unknown band'] );
                  end
                  
                  if ( stat == 1 )
                     stat_str = 'mean';
                     tmp = mean_cxn_mtx(task,:,:,group,time,band);
                  else ( stat == 2 )
                     stat_str = 'sem';
                     tmp = sem_cxn_mtx(task,:,:,group,time,band);
                  end
                  
                  fname = sprintf( IN.SAVE_FILENAME, IN.TASKS{i},...
                                   group_str, time_str, band_str, stat_str );
                  fname = [IN.SAVE_PATH fname];
                  
                  disp( sprintf( 'writing %s', fname ) );
                  csvwrite( fname, tmp );
               end
            end
         end
      end   
   end
   % }}}

   % stats
   for i = 1:length( IN.TASKS )
      for group = 1:2
         for band = 1:5
            for stat = 3:4
               if ( group == 1 )
                  group_str = 'tier1';
               else
                  group_str = 'tier2';
               end
               
               if ( time == 1 )
                  time_str = 'before';
               else
                  time_str = 'after';
               end

               switch band
                  case 1
                     band_str = 'delta';
                  case 2
                     band_str = 'theta';
                  case 3 
                     band_str = 'alpha';
                  case 4
                     band_str = 'beta';
                  case 5
                     band_str = 'gamma';
                  otherwise
                     error( ['unknown band'] );
               end
               
               time_str = 'na';
               
               if ( stat == 3 )
                  stat_str = 'pval';
                  tmp = pval_cxn_mtx(task,:,:,group,band);
               else ( stat == 4 )
                  stat_str = 'tval';
                  tmp = tval_cxn_mtx(task,:,:,group,band);
               end
               
               fname = sprintf( IN.SAVE_FILENAME, IN.TASKS{i},...
                                group_str, time_str, band_str, stat_str );
               fname = [IN.SAVE_PATH fname];
               
               disp( sprintf( 'writing %s', fname ) );
               csvwrite( fname, tmp );
            end
         end
      end
   end   

else
   disp( 'ALGO.SAVE off; not saving' );
end
%%%}}} % eo-save