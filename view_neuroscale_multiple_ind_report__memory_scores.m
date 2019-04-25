% @brief various plots and calcuations

% channels_band_power_data is 8 tasks x 8 bands & ratios, 19 electrodes, 4 conditions, 2: mean and SEM
%   this is an average over subjects (which is an average trials)
%   for individual reports, it's 8x19x2x2
% workload_mean is 8 tasks x 19 electrodes x 4 conditions
% workload_sem is the same size as workload_mean

disp( 'display' );

%%%%
% for MS, write out memory on PZ
%

% make sure it's an invidiual MS report
if ( IN.IS_INDIVID )
   for f = 1:size(IN.IN_FILEZ,1)
      fname = IN.IN_FILEZ{f};
      if ( ~isempty( strfind( fname, 'MS' ) ) )
         tmp = channels_band_power_data{f}; % 8 bands & ratios, 19 electrodes, 4 conditions, 2: mean and SEM
         subj_id(f) = IN.IN_SUBJECTZ(f);
         memory_score(f) = tmp(NEUROSCALE_THETA_ALPHA_RATIO_IDX,cognionics_name_to_index( 'PZ' ),NEUROSCALE_INDIVID_BEFORE_IDX,NEUROSCALE_MEAN_IDX);
      end
   end      

   % sort & write out
   [sorted_memory_score,idx] = sort( memory_score, 'descend' );
   sorted_subj_id = subj_id( idx );
   mat = [sorted_subj_id', sorted_memory_score'];
      
   fname = strcat( IN.SAVE_PATH, IN.IN_FILEZ{f} );   
   save_fname = strrep( fname, 'dana_3-14_mat\', 'dana_3-14_mat\excel\' );
   save_fname = strrep( fname, '2session_analysis', 'memory_score' );
   save_fname = strrep( fname, '.mat', '.xlsx' );
   disp( sprintf( 'writing %s', save_fname ) );
   %col_hdr = ['Subject','Before'];
   mt_writetable( mat, save_fname, col_hdr );
   
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