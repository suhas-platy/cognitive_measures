% no checks of spectra - not easy to spot check

% @todo trim to 1st and last val in the group of 4 only

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% this checks bands at channels (no check of ratios...)

% for ea task, show bands at elec''s (for checking)
% 
% plot is 5 bands x 1 elec x 4 cond's
disp( '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%' );
disp( 'for ea task, show bands at elec''s (for checking)' )
for f = 1:8
   tmp = channels_band_power_data{f};
   bands_first_elec_mean{f} = squeeze( tmp(1:5,NEUROSCALE_FIRST_ELECTRODE_IDX,:,NEUROSCALE_MEAN_IDX) ); %delta, theta, etc.; 5x1x4x1
   bands_first_elec_sem{f} = squeeze( tmp(1:5,NEUROSCALE_FIRST_ELECTRODE_IDX,:,NEUROSCALE_SEM_IDX) );
   bands_last_elec_mean{f} = squeeze( tmp(1:5,NEUROSCALE_LAST_ELECTRODE_IDX,:,NEUROSCALE_MEAN_IDX) ); %delta, theta, etc.; 5x1x4x1
   bands_last_elec_sem{f} = squeeze( tmp(1:5,NEUROSCALE_LAST_ELECTRODE_IDX,:,NEUROSCALE_SEM_IDX) );
   
   %figure(fig_num); fig_num = fig_num + 1;
   %h = barweb( tmp_mean{f}, tmp_sem{f} );
   %title( mt_escape_underscores( sprintf( 'BandPower on FP1 for %s (for checking)', IN.IN_FILEZ{f} ) ) );
end

for f = 1:8
   disp( '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%' );
   disp( sprintf( 'delta first elec for task %s', IN.IN_FILEZ{f} ) ); 
   tmp = bands_first_elec_mean{f}; % 5 bands x 1 electrode x 4 cond's
   delta_first_elec_mean = squeeze( tmp(1,:,:) )
   tmp2 = bands_first_elec_sem{f};
   delta_first_elec_sem = squeeze( tmp2(1,:,:) )

   % disp( sprintf( 'gamma last elec for task %s', IN.IN_FILEZ{f} ) ); 
   % tmp = bands_last_elec_mean{f}; % 5 bands x 1 electrode x 4 cond's
   % gamma_last_elec_mean = squeeze( tmp(5,:,:) )
   % tmp2 = bands_last_elec_sem{f};
   % gamma_last_elec_sem = squeeze( tmp2(5,:,:) )
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% this checks bands at sources (no check of ratios...)

% for ea task, show bands at sources (for checking)
% 
% plot is 5 bands x 1 source x 4 cond's
disp( '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%' );
disp( 'for ea task, show bands at sources (for checking)' )
for f = 1:8
   tmp = sources_band_power_data{f};
   bands_first_source_mean{f} = squeeze( tmp(1:5,NEUROSCALE_FIRST_SOURCE_IDX,:,NEUROSCALE_MEAN_IDX) ); %delta, theta, etc.; 5x1x4x1
   bands_first_source_sem{f} = squeeze( tmp(1:5,NEUROSCALE_FIRST_SOURCE_IDX,:,NEUROSCALE_SEM_IDX) );
   bands_last_source_mean{f} = squeeze( tmp(1:5,NEUROSCALE_LAST_SOURCE_IDX,:,NEUROSCALE_MEAN_IDX) ); %delta, theta, etc.; 5x1x4x1
   bands_last_source_sem{f} = squeeze( tmp(1:5,NEUROSCALE_LAST_SOURCE_IDX,:,NEUROSCALE_SEM_IDX) );
   
   %figure(fig_num); fig_num = fig_num + 1;
   %h = barweb( tmp_mean{f}, tmp_sem{f} );
   %title( mt_escape_underscores( sprintf( 'BandPower on FP1 for %s (for checking)', IN.IN_FILEZ{f} ) ) );
end

for f = 1:8
   disp( '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%' );
   disp( sprintf( 'delta first source for task %s', IN.IN_FILEZ{f} ) ); 
   tmp = bands_first_source_mean{f}; % 5 bands x 1 source x 4 cond's
   delta_first_source_mean = squeeze( tmp(1,:,:) )
   tmp2 = bands_first_source_sem{f};
   delta_first_source_sem = squeeze( tmp2(1,:,:) )

   % disp( sprintf( 'gamma last source for task %s', IN.IN_FILEZ{f}  ) ); 
   % tmp = bands_last_source_mean{f}; % 5 bands x 1 source x 4 cond's
   % gamma_last_source_mean = squeeze( tmp(5,:,:) )
   % tmp2 = bands_last_source_sem{f};
   % gamma_last_source_sem = squeeze( tmp2(5,:,:) )
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% this checks connectivity
% for ea task, show bands at sources (for checking)
% 
% plot is ...
disp( '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%' );
disp( 'for ea task, show bands at sources (for checking)' )
for f = 1:8
   tmp = tier1_conn_stats{f};
   %tier1_source1_to_source12_delta_tval{f} = squeeze( tmp(1,12,1,1) ); % 12 posn x 12 posn x 5 x 2 (t value and PR(>F))
   tier1_conn_stats_tval{f} = tmp(:,:,:,1);
   tier1_conn_stats_pval{f} = tmp(:,:,:,2);
   
   tmp = After_conn_stats{f};
   %tier1_source12_to_source11_gamma_tval{f} = squeeze( tmp(12,11,5,1) ); % 12 posn x 12 posn x 5 x 2 (t value and PR(>F))
   % 12,12 would be the last but typically that's 0 
   After_conn_stats_tval{f} = tmp(:,:,:,1);
   After_conn_stats_pval{f} = tmp(:,:,:,2);
   
   %figure(fig_num); fig_num = fig_num + 1;
   %h = barweb( tmp_mean{f}, tmp_sem{f} );
   %title( mt_escape_underscores( sprintf( 'BandPower on FP1 for %s (for checking)', IN.IN_FILEZ{f} ) ) );
end

for f = 1:8
   disp( '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%' );
   %disp( sprintf( 't-stat for delta from first source (%s) to last source (%s) for task %s',...
   %           neuroscale_index_to_name( 1 ), neuroscale_index_to_name( 12 ), IN.IN_FILEZ{f} ) ); 
   %source1_to_source12_delta_tier1{f}
   tmp = tier1_conn_stats_tval{f}; % 12 posn x 12 posn x 5
   tmp2 = tier1_conn_stats_pval{f};
   for b = 1:5
      tmp_tval = squeeze( tmp(:,:,b) );
      tmp2_pval = squeeze( tmp2(:,:,b) );
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
   
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% this checks stats

% no one using them for now

mt_continue_prompt;