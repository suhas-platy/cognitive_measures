% channels_band_power_data is 8 tasks x 8 bands & ratios, 19 electrodes, 4 conditions, 2: mean and SEM
%   this is an average over subjects (which is an average trials)
% workload_mean is 8 tasks x 19 electrodes x 4 conditions
% workload_sem is the same size as workload_mean

disp( 'display' );

%%%%
% for each task, sum of workload across all electrodes, all conditions (for excel)
%
% this is 8 tasks x 4 cond's, then 8 tasks x 1 summed cond
%
% see if workload varies by task; to get workload curve
%%
% 
% <<FILENAME.PNG>>
% 
disp( 'for each task, sum of workload across all electrodes, all conditions (for excel)' );
for f = 1:size(IN.IN_FILEZ,1) % for each task
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
%
% this is 1 electrode x 4 conditions
if ( ~IN.IS_VA )
disp( 'for 1st task, workload for one electrode, all conditions (for early plots in powerpoint)' );
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
end

%%%%
% for 1st task, for each cond, workload across all electrodes
%
% this is 4 plots; 19 electrodes each
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
% this is 8 plots (one for each task), 5 bands x 4 cond's each
figure(fig_num); fig_num = fig_num + 1
if ( ~IN.IS_VA )
   T = 8;
else
   T = 2;
end

for t = 1:T
  for b = 1:5
   tmp = channels_band_power_data{t}; % 8 bands & ratios, 19 electrodes, 4 conditions, 2: mean and SEM
   tmp = tmp(:,:,:,1); % get mean
   tmp = tmp(b,:,:); % get band
   channels_band_power_data_meanE(t,b,:) = squeeze( mean( tmp, 2 ) ); % mean over electrodes; t: 8 tasks, b: 5 bands, 4 conditions

   % pooled sem...
  end

  subplot(T,1,t);
  foo = channels_band_power_data_meanE(t,:,:); % 5 bands x 4 cond's
  foo = squeeze( foo );
  bar( foo );
  title( sprintf( 'Bands for task %d', t ) );
  set( gca, 'XTickLabel', {'delta', 'theta', 'alpha', 'beta', 'gamma'} );
  
   if ( ALGO.SAVE2 )
      fname = strcat( IN.SAVE_PATH, IN.IN_FILEZ{t} );   
      save_fname = strrep( fname, 'v11\', 'v11\excel\' );
      save_fname = strrep( fname, '.mat', '_channels_bandsAndRatios_mean_meanE.xlsx' );
      disp( sprintf( 'writing %s', save_fname ) );
      mat = squeeze( channels_band_power_data_meanE(t,:,:) );
      %size( mat )
      %xlswrite( save_fname, mat );
      col_hdr = IN.TIER_BY_TIME_COL_HDR;
      row_hdr = IN.BANDS_COL_HDR;
      mt_writetable( mat, save_fname, col_hdr, row_hdr );
   end  
end

%%%%
% for each task, sum across bands
%
% this is 8 plots (one for each task), 1 sum of bands x 4 cond's
channels_band_power_data_meanB_meanE = squeeze( mean( channels_band_power_data_meanE, 2 ) ); % 8 tasks, 4 conditions

figure(fig_num); fig_num = fig_num + 1
if ( ~IN.IS_VA )
   T = 8;
else
   T = 2;
end

for t = 1:T
   subplot(T,1,t);
   bar( channels_band_power_data_meanB_meanE(t,:) );
   set( gca, 'XTickLabel', {'Tier 1 after', 'Tier 1 before', 'Tier 2 after', 'Tier 2 before'} );
   title( sprintf( 'Mean of Bands for task %d', t ) );
   
   if ( ALGO.SAVE2 )
      fname = strcat( IN.SAVE_PATH, IN.IN_FILEZ{t} );   
      save_fname = strrep( fname, 'v11\', 'v11\excel\' );
      save_fname = strrep( fname, '.mat', '_channels_bandsAndRatios_mean_meanB_meanE.xlsx' );
      disp( sprintf( 'writing %s', save_fname ) );
      mat = squeeze( channels_band_power_data_meanB_meanE(t,:) );
      %size( mat )
      %xlswrite( save_fname, mat );
      col_hdr = IN.TIER_BY_TIME_COL_HDR;
      row_hdr = "_mean_over_bands";
      mt_writetable( mat, save_fname, col_hdr, row_hdr );
   end
end
   
%%%%
% sum over tasks
%
% this is 1 plot, 4 cond's
channels_band_power_data_meanT_meanB_meanE = mean( channels_band_power_data_meanB_meanE, 1 ); % 4 conditions

figure(fig_num); fig_num = fig_num + 1
bar( squeeze( channels_band_power_data_meanT_meanB_meanE ) );
set( gca, 'XTickLabel', {'Tier 1 after', 'Tier 1 before', 'Tier 2 after', ...
                    'Tier 2 before' } );
title( 'Mean of Tasks' );
