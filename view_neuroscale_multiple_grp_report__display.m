% channels_band_power_data is 8 tasks x 8 bands & ratios, 19 electrodes, 4 conditions, 2: mean and SEM
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

figure(fig_num); fig_num = fig_num + 1;
plot( sum_x );
xticklabels( {'SRT', 'PRT', 'GNG', 'CSL', 'SP', 'MTS', 'MS', 'SRT2'} );
title( 'sum of workload across all 4 conditions, all electrodes' );

%%%%
% for 1st task, workload for one electrode, all conditions (for early plots in powerpoint)
%
% this is 1 electrode x 4 conditions
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

%%%%
% for 1st task, for each cond, workload across all electrodes
%
% this is 4 plots; 19 electrodes each
disp( 'workload across all electrodes, all cond''s' );
figure(fig_num); fig_num = fig_num + 1;
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
% for each task, sum across electrodes
%
% this is 8 plots, 5 bands x 4 cond's each
figure(fig_num); fig_num = fig_num + 1;
for t = 1:8
  for b = 1:5
   tmp = channels_band_power_data{t};
   tmp = squeeze( tmp(b,:,:,1) ); % 19x4x1; 1 index = mean
   channels_band_power_data_mean_sumE(t,b,:) = sum( tmp, 1 ); % 4 cond's

   % pooled sem...
  end

  subplot(8,1,t);
  foo = channels_band_power_data_mean_sumE(t,:,:); % 5 bands x 4 cond's
  foo = squeeze( foo );
  bar( foo );
  title( sprintf( 'Bands for task %d', t ) );
  set( gca, 'XTickLabel', {'delta', 'theta', 'alpha', 'beta', 'gamma'} );
end

%%%%
% sum over tasks, sum across electrodes
%
% this is 1 plot, 5 bands x 4 cond's
channels_band_power_data_mean_sumT_sumE = sum( channels_band_power_data_mean_sumE, 1 ); % 5 bands x 4 conditions

figure(fig_num); fig_num = fig_num + 1;
bar( squeeze( channels_band_power_data_mean_sumT_sumE ) );
set( gca, 'XTickLabel', {'delta', 'theta', 'alpha', 'beta', 'gamma'} );

%%%%
% sum over tasks, bands, and electrodes
%
% this is 1 plot, 4 cond's
channels_band_power_data_mean_sumT_sum_B_sumE = sum( channels_band_power_data_mean_sumT_sumE, 1 ); % 4 conditions
figure(fig_num); fig_num = fig_num + 1;
bar( squeeze( channels_band_power_data_mean_sumT_sum_B_sumE ) );
set( gca, 'XTickLabel', {'Tier 1 after', 'Tier 1 before', 'Tier 2 after', ...
                    'Tier 2 before' } );


%channels_band_power_data_mean = channels_band_power_data(:,:,:,1); % could have declared this above
%channels_band_power_data_sem = channels_band_power_data(:,:,:,2);

%n_t1 = 10
%a = channels_band_power_data_mean(1,1,:); % 1x1x19
%b = channels_band_power_data_sem(1,1,:); % "
%b_stddev = mt_stderr2stdev( b, n_t1 );

%pooledmeanstd( n_t1, a

% beta
figure(fig_num); fig_num = fig_num + 1;
for f = 1:8
   tmp = channels_band_power_data{f};
   beta_mean = squeeze( tmp(4,:,1,1) );
   sum_beta_mean(f) = sum( beta_mean(f), 2 );

   subplot(8,1,f);
   bar( sum_beta_mean );
   title( sprintf( 'sum of beta across all electrodes for task %d', f ) );
end

