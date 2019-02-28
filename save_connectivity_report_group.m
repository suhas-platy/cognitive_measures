
% connectivity, mean
fname = strcat( IN.SAVE_PATH, IN.IN_FILEZ{f} );   
save_fname = strrep( fname, 'v11\', 'v11\excel\' );
save_fname = strrep( fname, '.mat', '_connectivity_mean.xlsx' );
disp( sprintf( 'writing %s', save_fname ) );
mat = conn{f};
mat = squeeze( mat(:,:,:,:,1) );
T = intheon_to_xlsx_connectivity( save_fname, mat, tier_bands_combined_col_hdr, from_to_label );

% connectivity stats, pvals
% tier 1
fname = strcat( IN.SAVE_PATH, IN.IN_FILEZ{f} );   
save_fname = strrep( fname, 'v11\', 'v11\excel\' );
save_fname = strrep( fname, '.mat', '_connectivity_tier1_pvals.xlsx' );
disp( sprintf( 'writing %s', save_fname ) );
mat = tier1_conn_stats{f};
mat = squeeze( mat(:,:,:,2) );
T = intheon_to_xlsx_connectivity_stats( save_fname, mat, bands_combined_col_hdr, from_to_label );

% tier 2
fname = strcat( IN.SAVE_PATH, IN.IN_FILEZ{f} );   
save_fname = strrep( fname, 'v11\', 'v11\excel\' );
save_fname = strrep( fname, '.mat', '_connectivity_tier2_pvals.xlsx' );
disp( sprintf( 'writing %s', save_fname ) );
mat = tier2_conn_stats{f};
mat = squeeze( mat(:,:,:,2) );
T = intheon_to_xlsx_connectivity_stats( save_fname, mat, bands_combined_col_hdr, from_to_label );

% Before
fname = strcat( IN.SAVE_PATH, IN.IN_FILEZ{f} );   
save_fname = strrep( fname, 'v11\', 'v11\excel\' );
save_fname = strrep( fname, '.mat', '_connectivity_before_pvals.xlsx' );
disp( sprintf( 'writing %s', save_fname ) );
mat = Before_conn_stats{f};
mat = squeeze( mat(:,:,:,2) );
T = intheon_to_xlsx_connectivity_stats( save_fname, mat, bands_combined_col_hdr, from_to_label );

% After
fname = strcat( IN.SAVE_PATH, IN.IN_FILEZ{f} );   
save_fname = strrep( fname, 'v11\', 'v11\excel\' );
save_fname = strrep( fname, '.mat', '_connectivity_after_pvals.xlsx' );
disp( sprintf( 'writing %s', save_fname ) );
mat = After_conn_stats{f};
mat = squeeze( mat(:,:,:,2) );
T = intheon_to_xlsx_connectivity_stats( save_fname, mat, bands_combined_col_hdr, from_to_label );
