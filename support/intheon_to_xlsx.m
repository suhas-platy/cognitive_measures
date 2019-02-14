function T = intheon_to_xlsx( fname, mat, col_hdr, row_hdr )
% @brief write out band and ratios

% @param mat should be 8x19x4 (bands and ratios x electrodes x conditions; conditions are tier 1 before, tier 1 after, etc.)
% @param col_hdr should be something like {tier 1 after, tier 1 before, tier 2 after, tier 2 before}x{delta, theta, alpha, beta, gamma, attention, workload, memory}; see ./test_intheon_to_xlsx.m
% @param row_hdr should be the electrodes

sz = size( mat );
bands = sz(1);
electrodes = sz(2);
conds = sz(3);
   
mat2 = permute( mat, [2 3 1] ); % now electrodes x (cond's x bands and ratios)
mat3 = reshape( mat2, electrodes, bands*conds );

T = array2table( mat3, 'VariableNames', col_hdr, 'RowNames', row_hdr );

writetable( T, fname, 'WriteRowNames', true );