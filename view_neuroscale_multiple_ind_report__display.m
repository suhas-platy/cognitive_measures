% @brief various plots and calcuations

% channels_band_power_data is 8 tasks x 8 bands & ratios, 19 electrodes, 4 conditions, 2: mean and SEM
%   this is an average over subjects (which is an average trials)
%   for individual reports, it's 8x19x2x2
% workload_mean is 8 tasks x 19 electrodes x 4 conditions
% workload_sem is the same size as workload_mean

disp( 'display' );

for i = 1:19
   electrodes{i} = cognionics_index_to_name( i );
end

%%%
% for each subject, one task, show diff's in electrodes
for f = 1:size(IN.IN_FILEZ,1)
   for b = 1:NEUROSCALE.NUM_BANDS
      tmp = channels_band_power_data{f};  % 8 bands & ratios, 19 electrodes, 4 conditions, 2: mean and SEM
      bands_mean{f,b} = squeeze( tmp(b,:,:,1) ); % 1x19 for some reason
      bands_sem{f,b} = squeeze( tmp(b,:,:,2) );      
   end
   
   disp( 'memory score' );
   memory_score(f) = tmp(NEUROSCALE.THETA_ALPHA_RATIO_IDX,cognionics_name_to_index( 'PZ' ),1,NEUROSCALE.MEAN_IDX);
   memory_score(f)
end

figure(fig_num); fig_num = fig_num + 1
if ( isfield(IN,"DO_CC") && IN.DO_CC )
for b = 1:NEUROSCALE.NUM_BANDS
    % sig bars: https://www.mathworks.com/matlabcentral/fileexchange/39696-raacampbell-sigstar
    % https://www.mathworks.com/matlabcentral/answers/175193-creating-sigstar-in-bar-graph
%    diff(b,:) = bands_mean{1,b} - bands{2,b};
%    for chnls = 1:19
%        if ( diff(b,chnls) > 0 )
%          bigger_idx = 1; smaller_idx = 2;
%        else
%          bigger_idx = 2; smaller_idx = 1;
%        end
%        bigger_mean = bands_mean{bigger_idx,b}; bigger_sem = bands_sem{bigger_idx,b};
%        bigger_mean = bigger_mean(chnls); bigger_sem = bigger_sem(chnls);
%        
%        smaller_mean = smaller_mean{smaller_idx,b}; smaller_sem = bands_sem{smaller_idx,b};
%        smaller_mean = smaller_mean(chnls); smaller_sem = smaller_sem(chnls);
% 
%        if ( bigger_mean-bigger_std > smaller_mean+small_std )
%            is_sig(b,chnls) = 1;
%        else
%            is_sig(b,chnls) = 0;
%        end
%    end
   stack_mean = [bands_mean{1,b}; bands_mean{2,b}]'; % 19x2
   stack_sem = [bands_sem{1,b}; bands_sem{2,b}]';
   %stack_mean = [bands_mean{1,b}];
   %stack_sem = [bands_sem{1,b}];

   subplot(NEUROSCALE.NUM_BANDS,1,b);
   hndls = barweb( stack_mean, stack_sem );
%    for chnls = 1:19
%        if ( is_sig(b,chnls) 
%    end
   xticklabels( electrodes );
   %title( sprintf( 'Will v. Hang, %s band', neuroscale_bands_index_to_name( b ) ) );
   %title( sprintf( 'Hang day 2 v. Hang day 1, %s band', neuroscale_bands_index_to_name( b ) ) );
   cc_elec_plot_title = IN.CC_ELECTRODE_PLOT_TITLE;
   title( sprintf( '%s, %s band', cc_elec_plot_title, neuroscale_bands_index_to_name( b ) ) );
end   
end

%%%%
% for each task, avg. across electrodes
%
% for DANA, this is 8 plots (one for each task), x-axis is 5 bands, y-axis is channels_band_power_data_meanE (each x-axis set of bars is 4 conditions)
% for VA, this is 2 plots, x-axis is 5 bands...
figure(fig_num); fig_num = fig_num + 1

% for f = 1:size(IN.IN_FILEZ,1)
%   for b = 1:5
%     tmp = channels_band_power_data{f}; % 8 bands & ratios, 19 electrodes, 4 conditions, 2: mean and SEM
%     tmp_mean = squeeze( tmp(:,:,:,1) ); % get mean; 8x19x4
%     tmp_sem = squeeze( tmp(:,:,:,2) ); % get sem; 8x19x4
%     tmp = tmp_mean(b,:,:); % 19x4
%     channels_band_power_data_meanE(f,b,:) = squeeze( mean( tmp, 2 ) ); % mean over electrodes (1st dim is bands); on output side, f: 8 tasks, b: 5 bands, 4 conditions

%     % pooled sem
%     if ( ~IN.IS_INDIVID )
%        C = 4;
%     else
%        if ( IN.HAS_AFTER )
%          C = 2;
%        else
%          C = 1;
%        end
%     end
    
%     for c = 1:C
%        if ( c == 1 | c == 2 ) % tier 1 or 2
%           n = 10;
%        else
%           n = 11;
%        end
%        n = 1;
       
%        foo1 = tmp_mean(b,:,c); % 1x19x1
%        foo2 = tmp_sem(b,:,c); % 1x19x1
%        foo3 = sqrt( n ).*tmp_sem(b,:,c); % 1x19x1
       
%        [n,m,s] = pooledmeanstd_loop( n, foo1', foo3' );
%        channels_band_power_data_semE(f,b,c) = s/sqrt(n);
%     end
   
%   end % rof b

%   if ( ~IN.IS_INDIVID )
%     subplot(size(IN.IN_FILEZ,1),1,f);
%     foo = channels_band_power_data_meanE(f,:,:); % 5 bands x 4 cond's
%     foo = squeeze( foo );
%     bar( foo );
%     title( sprintf( 'Bands for task %d', f ) );
%     set( gca, 'XTickLabel', {'delta', 'theta', 'alpha', 'beta', 'gamma'} );
%   end
    
%   if ( ALGO.SAVE_BANDS_POOLED )
%       fname = strcat( IN.SAVE_PATH, IN.IN_FILEZ{f} );   
%       if ( ~IN.IS_INDIVID )
%          save_fname = strrep( fname, 'v11\', 'v11\excel\' );
%       else
%          save_fname = strrep( fname, 'va_indiv_2session_2-4\', 'va_indiv_2session_2-4\excel' );
%       end
%       save_fname = strrep( fname, '.mat', '_channels_bandsAndRatios_mean_meanE.xlsx' );
%       disp( sprintf( 'writing %s', save_fname ) );
%       mat = squeeze( channels_band_power_data_meanE(f,:,:) );
%       mat2 = squeeze( channels_band_power_data_semE(f,:,:) );
%       mat3 = cat(3,mat,mat2);
%       col_hdr = NEUROSCALE.TIER_BY_TIME_COL_HDR;
%       row_hdr = NEUROSCALE.BANDS_COL_HDR;
%       mt_writetable_tensor( mat3, save_fname, col_hdr, row_hdr );
%   end  
% end

%%%%
% for each task, sum across bands
%
% for DANA, this is 8 plots (one for each task), x-axis is conds, y-axis is channels_band_power_data_meanB_meanE
% for VA, this is 2 plots (one for each task), x-axis is conds
% channels_band_power_data_meanB_meanE = squeeze( mean( channels_band_power_data_meanE, 2 ) ); % 8 tasks, 4 conditions

% % pooled sem
% for f = 1:size(IN.IN_FILEZ,1)
%     if ( ~IN.IS_INDIVID )
%        C = 4;
%     else
%        if ( IN.HAS_AFTER )
%          C = 2;
%        else
%          C = 1;
%        end
%     end
   
%     for c = 1:C
%        n = 1; %%% <- is this right?
   
%        foo1 = channels_band_power_data_meanE(f,:,c); % 1x5x1
%        foo2 = channels_band_power_data_semE(f,:,c); % 1x5x1
%        foo3 = sqrt( n ).* foo2;
%        [n,m,s] = pooledmeanstd_loop( n, foo1', foo3' );
%        channels_band_power_data_meanB_meanE_sem(f,c) = s/sqrt(n);
%     end
% end

% figure(fig_num); fig_num = fig_num + 1
% for f = 1:size(IN.IN_FILEZ,1)
%    if ( ~IN.IS_INDIVID )
%      subplot(size(IN.IN_FILEZ,1),1,f);
%      bar( channels_band_power_data_meanB_meanE(f,:) );
%      set( gca, 'XTickLabel', {'Tier 1 after', 'Tier 1 before', 'Tier 2 after', 'Tier 2 before'} );
%      title( sprintf( 'Mean of Bands for task %d', f ) );
%    end
   
%    if ( ALGO.SAVE_BANDS_POOLED )
%       fname = strcat( IN.SAVE_PATH, IN.IN_FILEZ{f} );   
%       if ( ~IN.IS_INDIVID )
%          save_fname = strrep( fname, 'v11\', 'v11\excel\' );
%       else
%          save_fname = strrep( fname, 'va_indiv_2session_2-4\', 'va_indiv_2session_2-4\excel' );
%       end
%       save_fname = strrep( fname, '.mat', '_channels_bandsAndRatios_mean_meanB_meanE.xlsx' );
%       disp( sprintf( 'writing %s', save_fname ) );
%       mat = squeeze( channels_band_power_data_meanB_meanE(f,:) );
%       mat2 = squeeze( channels_band_power_data_meanB_meanE_sem(f,:) );
%       mat3 = cat(3,mat,mat2);
%       col_hdr = NEUROSCALE.TIER_BY_TIME_COL_HDR;
%       row_hdr = "_mean_over_bands";
%       mt_writetable_tensor( mat3, save_fname, col_hdr, row_hdr );
%    end
% end
   
%%%%
% sum over tasks
%
% x-axis is cond's, y-axis is channels_band_power_data_meanT_meanB_meanE
%channels_band_power_data_meanT_meanB_meanE = mean( channels_band_power_data_meanB_meanE, 1 ); % 4 conditions

%%%%
% for MS, write out memory on PZ
%

% make sure it's an invidiual MS report
if ( IN.IS_INDIVID & ALGO.SAVE_MS_SCORES )
   for f = 1:size(IN.IN_FILEZ,1)
      fname = IN.IN_FILEZ{f};
      if ( ~isempty( strfind( fname, 'MS' ) ) )
         tmp = channels_band_power_data{f}; % 8 bands & ratios, 19 electrodes, 4 conditions, 2: mean and SEM
         subj_id(f) = IN.SUBJECTZ(f);
         memory_score(f) = tmp(NEUROSCALE.THETA_ALPHA_RATIO_IDX,cognionics_name_to_index( 'PZ' ),1,NEUROSCALE.MEAN_IDX);
         % @todo third dim used by 2, now it's 1...
         
         theta_score(f) = tmp(NEUROSCALE.THETA_IDX,cognionics_name_to_index( 'PZ' ),1,NEUROSCALE.MEAN_IDX);
         alpha_score(f) = tmp(NEUROSCALE.ALPHA_IDX,cognionics_name_to_index( 'PZ' ),1,NEUROSCALE.MEAN_IDX);
      end      
   end

   % sort & write out
   [sorted_memory_score,idx] = sort( memory_score, 'descend' );
   sorted_subj_id = subj_id( idx );
   sorted_theta_score = theta_score( idx );
   sorted_alpha_score = alpha_score( idx );
   mat = [sorted_subj_id', sorted_memory_score', sorted_theta_score', sorted_alpha_score'];
      
   fname = strcat( IN.SAVE_PATH, IN.IN_FILEZ{f} );   
   save_fname = strrep( fname, 'v11\', 'v11\excel2\' );
   save_fname = strrep( fname, '2session_analysis', 'memory' );
   save_fname = strrep( fname, '.mat', '.xlsx' );
   disp( sprintf( 'writing %s', save_fname ) );
   col_hdr = {'Subject';'Before_Memory_Score';'Before_Theta_Score';'Before_Alpha_Score'};
   mt_writetable( mat, save_fname, col_hdr );
   
end

% figure(fig_num); fig_num = fig_num + 1
% for f = 1:size(IN.IN_FILEZ,1)
%    if ( ALGO.SAVE_BANDS_POOLED )
%       disp( sprintf( 'writing %s', save_fname ) );
%       mat = squeeze( channels_band_power_data_meanB_meanE(f,:) );
%       mat2 = squeeze( channels_band_power_data_meanB_meanE_sem(f,:) );
%       mat3 = cat(3,mat,mat2);
%       col_hdr = NEUROSCALE.TIER_BY_TIME_COL_HDR;
%       row_hdr = "_mean_over_bands";
%       mt_writetable_tensor( mat3, save_fname, col_hdr, row_hdr );
%    end
% end