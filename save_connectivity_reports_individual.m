
% connectivity, mean
fname = strcat( IN.SAVE_PATH, IN.IN_FILEZ{f} );   
save_fname = strrep( fname, 'dana_indiv_2-4_fixed_mat\', 'dana_indiv_2-4_fixed_mat\excel\' );
save_fname = strrep( fname, '.mat', '_connectivity_mean.xlsx' );
disp( sprintf( 'writing %s', save_fname ) );
mat = conn{f};
mat = squeeze( mat(:,:,:,:,1) );
T = intheon_to_xlsx_connectivity( save_fname, mat, tier_bands_combined_col_hdr, from_to_label );

% connectivity stats, pvals
fname = strcat( IN.SAVE_PATH, IN.IN_FILEZ{f} );   
save_fname = strrep( fname, 'dana_indiv_2-4_fixed_mat\', 'dana_indiv_2-4_fixed_mat\excel\' );
save_fname = strrep( fname, '.mat', '_connectivity_tier1_pvals.xlsx' );
disp( sprintf( 'writing %s', save_fname ) );
mat = conn_stats{f};
mat = squeeze( mat(:,:,:,2) );
T = intheon_to_xlsx_connectivity_stats( save_fname, mat, bands_combined_col_hdr, from_to_label );
