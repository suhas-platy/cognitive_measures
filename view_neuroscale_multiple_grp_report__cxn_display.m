% channels_band_power_data is 8 tasks x 8 bands & ratios, 19 electrodes, 4 conditions, 2: mean and SEM
% workload_mean is 8 tasks x 19 electrodes x 4 conditions
% workload_sem is the same size as workload_mean

disp( 'display connections' );

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

disp( 'for each task, tier1 changes' );
bands = {'delta','theta','alpha','beta','gamma'};
from_to_labels = intheon_connection_labels();

for f = 1:size(IN.IN_FILEZ,1) % for each task
   foo = conn{f}; % 12 posn x 12 posn x 5 freq's x 4 cond's x 2: mean and SEM
   t1_after = squeeze( foo(:,:,:,1,1) );
   t1_before = squeeze( foo(:,:,:,2,1) );
   
   pre = t1_before;
   post = t1_after;
   
   foo = tier1_conn_stats{f}; 
   foo = squeeze( foo(:,:,:,2) ); % get p val; 12 posn x 12 posn x 5
   sig_inc = foo < .05 .* (post>pre);
   sig_dec = foo < .05 .* (pre>post);
   
   pre_for_func = reshape( pre, 5,12*12 );
   post_for_func = reshape( post, 5,12*12 );
   sig_inc_for_func = reshape( sig_inc, 5,12*12 );
   sig_dec_for_func = reshape( sig_dec, 5,12*12 );
   
   figure(fig_num); fig_num = fig_num + 1;
   make_matrix_diff_plot_images( pre_for_func, post_for_func, sig_inc_for_func, sig_dec_for_func, bands, from_to_labels );
end

disp( 'for each task, changes due to training' );
bands = {'delta','theta','alpha','beta','gamma'};
from_to_labels = intheon_connection_labels();

for f = 1:size(IN.IN_FILEZ,1) % for each task
   foo = conn{f}; % 12 posn x 12 posn x 5 freq's x 4 cond's x 2: mean and SEM
   t1_after = squeeze( foo(:,:,:,1,1) );
   t2_after = squeeze( foo(:,:,:,3,1) );
   t1_before = squeeze( foo(:,:,:,2,1) );
   t2_before = squeeze( foo(:,:,:,4,1) );
   
   pre = (t1_before+t2_before)./2;
   post = (t1_after+t2_after)./2;
   
   foo = Before_conn_stats{f}; 
   foo = squeeze( foo(:,:,:,2) ); % get p val; 12 posn x 12 posn x 5
   sig_inc = foo < .05 .* (post>pre);
   sig_dec = foo < .05 .* (pre>post);
   
   pre_for_func = reshape( pre, 5,12*12 );
   post_for_func = reshape( post, 5,12*12 );
   sig_inc_for_func = reshape( sig_inc, 5,12*12 );
   sig_dec_for_func = reshape( sig_dec, 5,12*12 );
   
   figure(fig_num); fig_num = fig_num + 1;
   make_matrix_diff_plot_images( pre_for_func, post_for_func, sig_inc_for_func, sig_dec_for_func, bands, from_to_labels );
end

