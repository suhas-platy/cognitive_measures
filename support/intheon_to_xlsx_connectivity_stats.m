function T = intheon_to_xlsx_connectivity_stats( fname, mat, col_hdr, row_hdr )
% @brief write out band and ratios

% @param mat should be 12x12x5 (sources x sources x freq)
% @param col_hdr should be something like {tier 1 after, tier 1 before, tier 2 after, tier 2 before}x{delta, theta, alpha, beta, gamma, attention, workload, memory}; see ./test_intheon_to_xlsx.m
% @param row_hdr should be brain sources

sz = size( mat );
sources = sz(1);
freqs = sz(3);
   
mat2 = permute( mat, [1 2 3] ); % now sources x sources x bands
mat3 = reshape( mat2, sources*sources, freqs );

T = array2table( mat3, 'VariableNames', col_hdr, 'RowNames', row_hdr );

writetable( T, fname, 'WriteRowNames', true );