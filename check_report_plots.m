% @brief check info in channel bands and stats, source bands and stats and connection stats; this checks the HTML files wrt the MAT files on the command line; plots are not made

% no checks of spectra - not easy to spot check

% @todo trim to 1st and last val in the group of 4 only

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% channel bands (no check of ratios)
%
% for ea task, show bands at ea. channel (for checking)
% plot is 5 bands x 1 channel x 4 cond's
disp( '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%' );
disp( 'for ea task, show bands at ea. channel (for checking)' )
for f = 1:size(IN.IN_FILEZ,1) % for each task or subject
   tmp = channels_band_power_data{f}; % 5 x 19 x cond x 2
   bands_first_channel_mean{f} = squeeze( tmp(1:5,INTHEON_FIRST_ELECTRODE_IDX,:,INTHEON_MEAN_IDX) ); % @todo could replace 1:5 w/ constants
   bands_first_channel_sem{f} = squeeze( tmp(1:5,INTHEON_FIRST_ELECTRODE_IDX,:,INTHEON_SEM_IDX) );
   bands_last_channel_mean{f} = squeeze( tmp(1:5,INTHEON_LAST_ELECTRODE_IDX,:,INTHEON_MEAN_IDX) );
   bands_last_channel_sem{f} = squeeze( tmp(1:5,INTHEON_LAST_ELECTRODE_IDX,:,INTHEON_SEM_IDX) );
   
   %figure(fig_num); fig_num = fig_num + 1;
   %h = barweb( tmp_mean{f}, tmp_sem{f} );
   %title( mt_escape_underscores( sprintf( 'BandPower on FP1 for %s (for checking)', IN.IN_FILEZ{f} ) ) );
end

for f = 1:size(IN.IN_FILEZ,1)
   tmp = bands_first_channel_mean{f};
   conds = size( tmp, 3 );
   
   disp( '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%' );
   disp( sprintf( 'delta first displayed channel for task %s for %d conditions', IN.IN_FILEZ{f}, conds ) ); 
   disp( sprintf( 'first displayed channel is %s', cognionics_index_to_name( INTHEON_FIRST_ELECTRODE_IDX ) ) );
   tmp = bands_first_channel_mean{f};
   delta_first_channel_mean = squeeze( tmp(INTHEON_DELTA_IDX,:,:) )
   tmp2 = bands_first_channel_sem{f};
   delta_first_channel_sem = squeeze( tmp2(INTHEON_DELTA_IDX,:,:) )

   disp( sprintf( 'gamma last displayed channel for task %s', IN.IN_FILEZ{f} ) ); 
   disp( sprintf( 'last displayed channel is %s', cognionics_index_to_name( INTHEON_LAST_ELECTRODE_IDX ) ) );
   tmp = bands_last_channel_mean{f}; % 5 bands x 1 channel x 4 cond's
   gamma_last_channel_mean = squeeze( tmp(INTHEON_GAMMA_IDX,:,:) )
   tmp2 = bands_last_channel_sem{f};
   gamma_last_channel_sem = squeeze( tmp2(INTHEON_GAMMA_IDX,:,:) )
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% channel stats (no check of ratios...)
disp( '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%' );
disp( 'for ea task, show bands'' stats at channel (for checking)' )
for f = 1:size(IN.IN_FILEZ,1)
   tmp = channels_band_power_stats{f};
   bands_first_channel_testval{f} = squeeze( tmp(1:5,INTHEON_FIRST_ELECTRODE_IDX,INTHEON_TESTVAL_IDX) ); % @todo could replace 1:5 w/ constants
   bands_first_channel_pval{f} = squeeze( tmp(1:5,INTHEON_FIRST_ELECTRODE_IDX,INTHEON_PVAL_IDX) );
   bands_last_channel_testval{f} = squeeze( tmp(1:5,INTHEON_LAST_ELECTRODE_IDX,INTHEON_TESTVAL_IDX) );
   bands_last_channel_pval{f} = squeeze( tmp(1:5,INTHEON_LAST_ELECTRODE_IDX,INTHEON_PVAL_IDX) );
   
   %figure(fig_num); fig_num = fig_num + 1;
   %h = barweb( tmp_mean{f}, tmp_sem{f} );
   %title( mt_escape_underscores( sprintf( 'BandPower on FP1 for %s (for checking)', IN.IN_FILEZ{f} ) ) );
end

for f = 1:size(IN.IN_FILEZ,1)
   disp( '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%' );
   disp( sprintf( 'delta testval and pval first displayed channel for task %s', IN.IN_FILEZ{f} ) ); 
   disp( sprintf( 'first displayed channel is %s', cognionics_index_to_name( INTHEON_FIRST_ELECTRODE_IDX ) ) );
   tmp = bands_first_channel_testval{f};
   delta_first_channel_testval = squeeze( tmp(INTHEON_DELTA_IDX,:,:) )
   tmp2 = bands_first_channel_pval{f};
   delta_first_channel_pval = squeeze( tmp2(INTHEON_DELTA_IDX,:,:) )

   disp( sprintf( 'gamma testval and pval last displayed channel for task %s', IN.IN_FILEZ{f}  ) ); 
   disp( sprintf( 'last displayed channel is %s', cognionics_index_to_name( INTHEON_LAST_ELECTRODE_IDX ) ) );
   tmp = bands_last_channel_testval{f};
   gamma_last_channel_testval = squeeze( tmp(INTHEON_GAMMA_IDX,:,:) )
   tmp2 = bands_last_channel_pval{f};
   gamma_last_channel_pval = squeeze( tmp2(INTHEON_GAMMA_IDX,:,:) )
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% source bands (no check of ratios...)

% for ea task, show bands at sources (for checking)
% plot is 5 bands x 1 source x 4 cond's
disp( '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%' );
disp( 'for ea task, show bands at sources (for checking)' )
for f = 1:size(IN.IN_FILEZ,1)
   tmp = sources_band_power_data{f};
   bands_first_source_mean{f} = squeeze( tmp(1:5,INTHEON_FIRST_SOURCE_IDX,:,INTHEON_MEAN_IDX) ); % @todo could replace 1:5 w/ constants
   bands_first_source_sem{f} = squeeze( tmp(1:5,INTHEON_FIRST_SOURCE_IDX,:,INTHEON_SEM_IDX) );
   bands_last_source_mean{f} = squeeze( tmp(1:5,INTHEON_LAST_SOURCE_IDX,:,INTHEON_MEAN_IDX) );
   bands_last_source_sem{f} = squeeze( tmp(1:5,INTHEON_LAST_SOURCE_IDX,:,INTHEON_SEM_IDX) );
   
   %figure(fig_num); fig_num = fig_num + 1;
   %h = barweb( tmp_mean{f}, tmp_sem{f} );
   %title( mt_escape_underscores( sprintf( 'BandPower on FP1 for %s (for checking)', IN.IN_FILEZ{f} ) ) );
end

for f = 1:size(IN.IN_FILEZ,1)
   disp( '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%' );
   disp( sprintf( 'delta first source for task %s', IN.IN_FILEZ{f} ) ); 
   disp( sprintf( 'first source is %s', intheon_index_to_name( INTHEON_FIRST_SOURCE_IDX ) ) );
   tmp = bands_first_source_mean{f};
   delta_first_source_mean = squeeze( tmp(INTHEON_DELTA_IDX,:,:) )
   tmp2 = bands_first_source_sem{f};
   delta_first_source_sem = squeeze( tmp2(INTHEON_DELTA_IDX,:,:) )

   disp( sprintf( 'gamma last source for task %s', IN.IN_FILEZ{f}  ) ); 
   disp( sprintf( 'last source is %s', intheon_index_to_name( INTHEON_LAST_SOURCE_IDX ) ) );
   tmp = bands_last_source_mean{f};
   gamma_last_source_mean = squeeze( tmp(INTHEON_GAMMA_IDX,:,:) )
   tmp2 = bands_last_source_sem{f};
   gamma_last_source_sem = squeeze( tmp2(INTHEON_GAMMA_IDX,:,:) )
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% sources stats (no check of ratios...)
disp( '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%' );
disp( 'for ea task, show bands'' stats at sources (for checking)' )
for f = 1:size(IN.IN_FILEZ,1)
   tmp = sources_band_power_stats{f};
   bands_first_source_testval{f} = squeeze( tmp(1:5,INTHEON_FIRST_SOURCE_IDX,INTHEON_TESTVAL_IDX) ); % @todo could replace 1:5 w/ constants
   bands_first_source_pval{f} = squeeze( tmp(1:5,INTHEON_FIRST_SOURCE_IDX,INTHEON_PVAL_IDX) );
   bands_last_source_testval{f} = squeeze( tmp(1:5,INTHEON_LAST_SOURCE_IDX,INTHEON_TESTVAL_IDX) );
   bands_last_source_pval{f} = squeeze( tmp(1:5,INTHEON_LAST_SOURCE_IDX,INTHEON_PVAL_IDX) );
   
   %figure(fig_num); fig_num = fig_num + 1;
   %h = barweb( tmp_mean{f}, tmp_sem{f} );
   %title( mt_escape_underscores( sprintf( 'BandPower on FP1 for %s (for checking)', IN.IN_FILEZ{f} ) ) );
end

for f = 1:size(IN.IN_FILEZ,1)
   disp( '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%' );
   disp( sprintf( 'delta testval and pval first source for task %s', IN.IN_FILEZ{f} ) ); 
   disp( sprintf( 'first source is %s', intheon_index_to_name( INTHEON_FIRST_SOURCE_IDX ) ) );
   tmp = bands_first_source_testval{f};
   delta_first_source_testval = squeeze( tmp(INTHEON_DELTA_IDX,:,:) )
   tmp2 = bands_first_source_pval{f};
   delta_first_source_pval = squeeze( tmp2(INTHEON_DELTA_IDX,:,:) )

   disp( sprintf( 'gamma testval and pval last source for task %s', IN.IN_FILEZ{f}  ) ); 
   disp( sprintf( 'last source is %s', intheon_index_to_name( INTHEON_LAST_SOURCE_IDX ) ) );
   tmp = bands_last_source_testval{f};
   gamma_last_source_testval = squeeze( tmp(INTHEON_GAMMA_IDX,:,:) )
   tmp2 = bands_last_source_pval{f};
   gamma_last_source_pval = squeeze( tmp2(INTHEON_GAMMA_IDX,:,:) )
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% connectivity stats

% for ea task, show connectivity stats (for checking)
disp( '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%' );
disp( 'for ea task, show conn''s stats at sources (for checking)' )
for f = 1:size(IN.IN_FILEZ,1)
   tmp = conn_stats{f};
   conn_first_source_testval{f} = squeeze( tmp(INTHEON_FIRST_SOURCE_IDX,:,INTHEON_DELTA_IDX,INTHEON_TESTVAL_IDX) );
   conn_first_source_pval{f} = squeeze( tmp(INTHEON_FIRST_SOURCE_IDX,:,INTHEON_DELTA_IDX,INTHEON_PVAL_IDX) );
   conn_last_source_testval{f} = squeeze( tmp(INTHEON_LAST_SOURCE_IDX,:,INTHEON_GAMMA_IDX,INTHEON_TESTVAL_IDX) );
   conn_last_source_pval{f} = squeeze( tmp(INTHEON_LAST_SOURCE_IDX,:,INTHEON_GAMMA_IDX,INTHEON_PVAL_IDX) );
   
   %figure(fig_num); fig_num = fig_num + 1;
   %h = barweb( tmp_mean{f}, tmp_sem{f} );
   %title( mt_escape_underscores( sprintf( 'BandPower on FP1 for %s (for checking)', IN.IN_FILEZ{f} ) ) );
end

for f = 1:size(IN.IN_FILEZ,1)
   disp( '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%' );
   disp( sprintf( 'first source to second source for task %s', IN.IN_FILEZ{f} ) ); 
   disp( sprintf( 'first source is %s; second source is %s',...
                  intheon_index_to_name( INTHEON_FIRST_SOURCE_IDX ), intheon_index_to_name( INTHEON_LAST_SOURCE_IDX ) ) );
   tmp = conn_first_source_testval{f};
   delta_first_source_second_source_testval = squeeze( tmp(1,INTHEON_FIRST_SOURCE_IDX+1) )
   tmp2 = conn_first_source_pval{f};
   delta_first_source_second_source_pval = squeeze( tmp2(1,INTHEON_FIRST_SOURCE_IDX+1) )

   disp( sprintf( 'last source to second to last source for task %s', IN.IN_FILEZ{f}  ) ); 
   disp( sprintf( 'last source is %s; second to last source is %s',...
                  intheon_index_to_name( INTHEON_LAST_SOURCE_IDX ), intheon_index_to_name( INTHEON_LAST_SOURCE_IDX-1 ) ) );
   tmp = conn_last_source_testval{f};
   gamma_last_source_secondtolast_source_testval = squeeze( tmp(1,INTHEON_LAST_SOURCE_IDX-1) )
   tmp2 = conn_last_source_pval{f};
   gamma_last_source_secondtolast_source_pval = squeeze( tmp2(1,INTHEON_LAST_SOURCE_IDX-1) )
end


mt_continue_prompt;

disp( '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%' );
disp( 'for ea task, show connectivity stats2 (for checking)' )
for f = 1:size(IN.IN_FILEZ,1)
   tmp = conn_stats{f};
   %source1_to_source12_delta_tval{f} = squeeze( tmp(1,12,1,1) ); % 12 posn x 12 posn x 5 x 2 (t value and PR(>F))
   if ( ~IN.IS_INDIVID )
     conn_stats_tval{f} = tmp(:,:,:,1);
     conn_stats_pval{f} = tmp(:,:,:,2);
   else
     conn_stats_testval{f} = tmp(:,:,1);
     conn_stats_pval{f} = tmp(:,:,2);
   end
   
   if ( ~IN.IS_INDIVID )
     tmp = After_conn_stats{f};
     %tier1_source12_to_source11_gamma_tval{f} = squeeze( tmp(12,11,5,1) ); % 12 posn x 12 posn x 5 x 2 (t value and PR(>F))
     % 12,12 would be the last but typically that's 0 
     After_conn_stats_tval{f} = tmp(:,:,:,1);
     After_conn_stats_pval{f} = tmp(:,:,:,2);
   end
   
   %figure(fig_num); fig_num = fig_num + 1;
   %h = barweb( tmp_mean{f}, tmp_sem{f} );
   %title( mt_escape_underscores( sprintf( 'BandPower on FP1 for %s (for checking)', IN.IN_FILEZ{f} ) ) );
end



for f = 1:size(IN.IN_FILEZ,1)
   disp( '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%' );
   %disp( sprintf( 't-stat for delta from first source (%s) to last source (%s) for task %s',...
   %           neuroscale_index_to_name( 1 ), neuroscale_index_to_name( 12 ), IN.IN_FILEZ{f} ) ); 
   %source1_to_source12_delta_tier1{f}
   tmp = conn_stats_tval{f}; % 12 posn x 12 posn x 5
   tmp2 = conn_stats_pval{f};
   if ( ~IN.IS_INDIVID )
      num_b = 5;
   else
      num_b = 1;
   end
   
   for b = 1:num_b
      if ( ~IN.IS_INDIVID )
         tmp_tval = squeeze( tmp(:,:,b) );
         tmp2_pval = squeeze( tmp2(:,:,b) );
      else
         tmp_tval = tmp(:,:);
         tmp2_pval = tmp(:,:);
      end
      
      sig_conn_idx = find( tmp2_pval < 0.05 & tmp2_pval ~= 0 );

      if ( isempty( sig_conn_idx ) )
         disp( sprintf( 'nothing significant for task %s for band %d', ...
                        IN.IN_FILEZ{f}, b ) );
      else
         for c = 1:2 %for c = 1:size( sig_conn_idx, 1 )
            if ( length( sig_conn_idx ) < 2 )
               break;
            end
              
            [i,j] = ind2sub( [12,12], sig_conn_idx(c) );
            disp( sprintf( 'tier 1 sig conn: from %s to %s in band %d for task %s: tval %.3g, pval %.3g',...
                           neuroscale_index_to_name( j ), neuroscale_index_to_name( i ), b, IN.IN_FILEZ{f},...
                           tmp_tval(i,j), tmp2_pval(i,j) ) );
         end
      end % fi isempty
   end % rof b

   % individual reports don't pool over tiers so After_conn_stats DNE
   if ( ~IN.IS_INDIVID )
       tmp = After_conn_stats_tval{f}; % 12 posn x 12 posn x 5
       tmp2 = After_conn_stats_pval{f};
       for b = 1:5
          tmp_tval = squeeze( tmp(:,:,b) );
          tmp2_pval = squeeze( tmp2(:,:,b) );
          sig_conn_idx = find( tmp2_pval < 0.05 & tmp2_pval ~= 0 );

          if ( isempty( sig_conn_idx ) )
             disp( sprintf( 'After nothing significant for task %s for band %d', ...
                            IN.IN_FILEZ{f}, b ) );
          else
             for c = 1:2 %for c = 1:size( sig_conn_idx, 1 )
                if ( length( sig_conn_idx ) < 2 )
                   break;
                end

                [i,j] = ind2sub( [12,12], sig_conn_idx(c) );
                disp( sprintf( 'After sig conn: from %s to %s in band %d for task %s: tval %.3g, pval %.3g',...
                               neuroscale_index_to_name( j ), neuroscale_index_to_name( i ), b, IN.IN_FILEZ{f},...
                               tmp_tval(i,j), tmp2_pval(i,j) ) );
             end
          end % fi isempty        
       end % rof b
   end % fi ~IN.IS_INDIVID
   
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% this checks stats

% no one using them for now

