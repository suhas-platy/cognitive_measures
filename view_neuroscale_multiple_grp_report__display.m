% @brief various plots and calcuations

% channels_band_power_data is 8 tasks x 8 bands & ratios, 19 electrodes, 4 conditions, 2: mean and SEM
%   this is an average over subjects (which is an average trials)
%   for individual reports, it's 8x19x2x2
% workload_mean is 8 tasks x 19 electrodes x 4 conditions
% workload_sem is the same size as workload_mean

disp( 'display' );

%%%%
% for each task, sum of workload across all electrodes, all conditions (for excel)
% x-axis is task, y-axis is workload (sum across all electrodes, all conditions)
%
% see if workload varies by task; to get workload curve
disp( 'for each task, sum of workload across all electrodes, all conditions (for excel)' );
for f = 1:size(IN.IN_FILEZ,1) % for each task or subject
  x = sum( workload_mean{f}, 2 )'; % sum over cond's, so you get by electrode
  disp( 'sum across all cond''s' );
  sprintf( '%.3g\t', x )
  
  disp( 'sum across all electrodes' );
  sum_x(f) = sum( x )
end

figure(fig_num); fig_num = fig_num + 1
plot( sum_x );
xticklabels( {'SRT', 'PRT', 'GNG', 'CSL', 'SP', 'MTS', 'MS', 'SRT2'} );
title( 'sum of workload across all 4 conditions, all electrodes' );

%%%%
% for 1st task, workload for one electrode, all conditions (for early plots in powerpoint)
% no plot is made; prints out to C&P for Excel/Powerpoint
%
% for early FJ plots in Powerpoint
if ( ~IN.IS_VA )
   disp( 'for 1st task, workload for one electrode, all conditions (for early FJ plots in powerpoint)' );
   disp( sprintf( 'for excel: workload, %s, mean',...
                  cognionics_index_to_name( IN.ELECTRODE_OF_INTEREST ) ) );
   x = workload_mean{1}(IN.ELECTRODE_OF_INTEREST,:);
   sprintf( '%.3g\t', x )
   
   disp( 'for plotting' );
   if ( ~IN.IS_INDIVID )
      x( [IN.PLOT_ORDER] )'
   else
      x( [IN.INDIVID_PLOT_ORDER] )'
   end

   disp( sprintf( 'for excel: workload, %s, sem',...
                  cognionics_index_to_name( IN.ELECTRODE_OF_INTEREST ) ) );
   x = workload_sem{1}(IN.ELECTRODE_OF_INTEREST,:);
   sprintf( '%.3g\t', x )
   
   disp( 'for plotting' );
   if ( ~IN.IS_INDIVID )
      x( [IN.PLOT_ORDER] )'
   else
      x( [IN.INDIVID_PLOT_ORDER] )'
   end
end

%%%%
% for 1st task, for each cond, workload across all electrodes
% 
% x-axis is electrode, y-axis is workload; repeated 4 times (1 for each condition)
if ( ~IN.IS_VA )
   disp( 'workload across all electrodes, all cond''s' );
   figure(fig_num); fig_num = fig_num + 1
   conds = size(workload_mean{1},2);
   for i = 1:conds
      subplot(conds,1,i);
      bar( workload_mean{1}(:,i) );
      set( gca, 'XTick', 1:IN.NUM_ELECTRODES );
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
end

%%%%
% for first two tasks, workload across all electrodes, all cond's
% figure(fig_num); fig_num = fig_num + 1;
% bar( sum( workload_mean{1}, 2 ) );
% set( gca, 'XTick', 1:IN.NUM_ELECTRODES );
% set( gca, 'XTickLabel', electrode_label );   
% title( 'Workload{1}: sum over 4 cond''s' );

% figure(fig_num); fig_num = fig_num + 1;
% bar( sum( workload_mean{2}, 2 ) );
% set( gca, 'XTick', 1:IN.NUM_ELECTRODES );
% set( gca, 'XTickLabel', electrode_label );   
% title( 'Workload{2}: sum over 4 cond''s' );

%%%%
% for each task, avg. across electrodes
%
% for DANA, this is 8 plots (one for each task), x-axis is 5 bands, y-axis is channels_band_power_data_meanE (each x-axis set of bars is 4 conditions)
% for VA, this is 2 plots, x-axis is 5 bands...
figure(fig_num); fig_num = fig_num + 1

for f = 1:size(IN.IN_FILEZ,1)
  for b = 1:5
    tmp = channels_band_power_data{f}; % 8 bands & ratios, 19 electrodes, 4 conditions, 2: mean and SEM
    tmp_mean = squeeze( tmp(:,:,:,1) ); % get mean; 8x19x4
    tmp_sem = squeeze( tmp(:,:,:,2) ); % get sem; 8x19x4
    tmp = tmp_mean(b,:,:); % 19x4
    channels_band_power_data_meanE(f,b,:) = squeeze( mean( tmp, 2 ) ); % mean over electrodes (1st dim is bands); on output side, f: 8 tasks, b: 5 bands, 4 conditions

    % pooled sem
    if ( ~IN.IS_INDIVID )
       C = 4;
    else
       C = 2;
    end
    
    for c = 1:C
       if ( c == 1 | c == 2 ) % tier 1 or 2
          n = 10;
       else
          n = 11;
       end
       n = 1;
       
       foo1 = tmp_mean(b,:,c); % 1x19x1
       foo2 = tmp_sem(b,:,c); % 1x19x1
       foo3 = sqrt( n ).*tmp_sem(b,:,c); % 1x19x1
       
       [n,m,s] = pooledmeanstd_loop( n, foo1', foo3' );
       channels_band_power_data_semE(f,b,c) = s/sqrt(n);
    end
   
  end % rof b

  if ( ~IN.IS_INDIVID )
    subplot(size(IN.IN_FILEZ,1),1,f);
    foo = channels_band_power_data_meanE(f,:,:); % 5 bands x 4 cond's
    foo = squeeze( foo );
    bar( foo );
    title( sprintf( 'Bands for task %d', f ) );
    set( gca, 'XTickLabel', {'delta', 'theta', 'alpha', 'beta', 'gamma'} );
  end
    
  if ( ALGO.SAVE_BANDS_POOLED )
      fname = strcat( IN.SAVE_PATH, IN.IN_FILEZ{f} );   
      if ( ~IN.IS_INDIVID )
         save_fname = strrep( fname, 'v11\', 'v11\excel\' );
      else
         save_fname = strrep( fname, 'va_indiv_2session_2-4\', 'va_indiv_2session_2-4\excel' );
      end
      save_fname = strrep( fname, '.mat', '_channels_bandsAndRatios_mean_meanE.xlsx' );
      disp( sprintf( 'writing %s', save_fname ) );
      mat = squeeze( channels_band_power_data_meanE(f,:,:) );
      mat2 = squeeze( channels_band_power_data_semE(f,:,:) );
      mat3 = cat(3,mat,mat2);
      col_hdr = IN.TIER_BY_TIME_COL_HDR;
      row_hdr = IN.BANDS_COL_HDR;
      mt_writetable_tensor( mat3, save_fname, col_hdr, row_hdr );
  end  
end

%%%%
% for each task, sum across bands
%
% for DANA, this is 8 plots (one for each task), x-axis is conds, y-axis is channels_band_power_data_meanB_meanE
% for VA, this is 2 plots (one for each task), x-axis is conds
channels_band_power_data_meanB_meanE = squeeze( mean( channels_band_power_data_meanE, 2 ) ); % 8 tasks, 4 conditions

% pooled sem
for f = 1:size(IN.IN_FILEZ,1)
    if ( ~IN.IS_INDIVID )
       C = 4;
    else
       C = 2;
    end
   
    for c = 1:C
       n = 1; %%% <- is this right?
   
       foo1 = channels_band_power_data_meanE(f,:,c); % 1x5x1
       foo2 = channels_band_power_data_semE(f,:,c); % 1x5x1
       foo3 = sqrt( n ).* foo2;
       [n,m,s] = pooledmeanstd_loop( n, foo1', foo3' );
       channels_band_power_data_meanB_meanE_sem(f,c) = s/sqrt(n);
    end
end

figure(fig_num); fig_num = fig_num + 1
for f = 1:size(IN.IN_FILEZ,1)
   if ( ~IN.IS_INDIVID )
     subplot(size(IN.IN_FILEZ,1),1,f);
     bar( channels_band_power_data_meanB_meanE(f,:) );
     set( gca, 'XTickLabel', {'Tier 1 after', 'Tier 1 before', 'Tier 2 after', 'Tier 2 before'} );
     title( sprintf( 'Mean of Bands for task %d', f ) );
   end
   
   if ( ALGO.SAVE_BANDS_POOLED )
      fname = strcat( IN.SAVE_PATH, IN.IN_FILEZ{f} );   
      if ( ~IN.IS_INDIVID )
         save_fname = strrep( fname, 'v11\', 'v11\excel\' );
      else
         save_fname = strrep( fname, 'va_indiv_2session_2-4\', 'va_indiv_2session_2-4\excel' );
      end
      save_fname = strrep( fname, '.mat', '_channels_bandsAndRatios_mean_meanB_meanE.xlsx' );
      disp( sprintf( 'writing %s', save_fname ) );
      mat = squeeze( channels_band_power_data_meanB_meanE(f,:) );
      mat2 = squeeze( channels_band_power_data_meanB_meanE_sem(f,:) );
      mat3 = cat(3,mat,mat2);
      col_hdr = IN.TIER_BY_TIME_COL_HDR;
      row_hdr = "_mean_over_bands";
      mt_writetable_tensor( mat3, save_fname, col_hdr, row_hdr );
   end
end
   
%%%%
% sum over tasks
%
% x-axis is cond's, y-axis is channels_band_power_data_meanT_meanB_meanE
channels_band_power_data_meanT_meanB_meanE = mean( channels_band_power_data_meanB_meanE, 1 ); % 4 conditions

figure(fig_num); fig_num = fig_num + 1
bar( squeeze( channels_band_power_data_meanT_meanB_meanE ) );
set( gca, 'XTickLabel', {'Tier 1 after', 'Tier 1 before', 'Tier 2 after', ...
                    'Tier 2 before' } );
title( 'Mean of Tasks' );

%%%%
% for MS, write out memory on PZ
%

% make sure it's an invidiual MS report
if ( IN.IS_INDIVID & ALGO.SAVE_MS_SCORES )
   for f = 1:size(IN.IN_FILEZ,1)
      fname = IN.IN_FILEZ{f};
      if ( ~isempty( strfind( fname, 'MS' ) ) )
         tmp = channels_band_power_data{f}; % 8 bands & ratios, 19 electrodes, 4 conditions, 2: mean and SEM
         subj_id(f) = IN.IN_SUBJECTZ(f);
         memory_score(f) = tmp(NEUROSCALE_THETA_ALPHA_RATIO_IDX,cognionics_name_to_index( 'PZ' ),NEUROSCALE_INDIVID_BEFORE_IDX,NEUROSCALE_MEAN_IDX);
      end
      
      % sort & write out
      [sorted_memory_score,idx] = sort( memory_score, 'descend' );
      sorted_subj_id = subj_id( idx );
      mat = [sorted_subj_id'; sorted_memory_score'];
      
      fname = strcat( IN.SAVE_PATH, IN.IN_FILEZ{f} );   
      save_fname = strrep( fname, 'v11\', 'v11\excel2\' );
      save_fname = strrep( fname, '2session_analysis', 'memory' );
      disp( sprintf( 'writing %s', save_fname ) );
      col_hdr = 'Before';
      mt_writetable( mat, save_fname, col_hdr );
   end
   
end

% figure(fig_num); fig_num = fig_num + 1
% for f = 1:size(IN.IN_FILEZ,1)
%    if ( ALGO.SAVE_BANDS_POOLED )
%       disp( sprintf( 'writing %s', save_fname ) );
%       mat = squeeze( channels_band_power_data_meanB_meanE(f,:) );
%       mat2 = squeeze( channels_band_power_data_meanB_meanE_sem(f,:) );
%       mat3 = cat(3,mat,mat2);
%       col_hdr = IN.TIER_BY_TIME_COL_HDR;
%       row_hdr = "_mean_over_bands";
%       mt_writetable_tensor( mat3, save_fname, col_hdr, row_hdr );
%    end
% end