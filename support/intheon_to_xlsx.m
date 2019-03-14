function T = intheon_to_xlsx( fname, mat, col_hdr, row_hdr, varargin )
% @brief write out band and ratios

% @param mat should be 8x19x4 (bands and ratios x electrodes x conditions; conditions are tier 1 before, tier 1 after, etc.)
% @param col_hdr should be something like {tier 1 after, tier 1 before, tier 2 after, tier 2 before}x{delta, theta, alpha, beta, gamma, attention, workload, memory}; see ./test_intheon_to_xlsx.m
% @param row_hdr should be the electrodes

sz = size( mat );
bands = sz(1);
electrodes = sz(2);
conds = sz(3);
stats = 1;
% figure out whether or not to write >1 sheet or not
if ( length(sz) >= 4 )
   stats = sz(4);
end
sheet = 1;
if ( nargin >= 5 )
   sheet = varargin{1};
end

if ( stats == 1 )
   mat2 = permute( mat, [2 3 1] ); % now electrodes x (cond's x bands and ratios)
   mat3 = reshape( mat2, electrodes, bands*conds );

   T = array2table( mat3, 'VariableNames', col_hdr, 'RowNames', row_hdr );
   
   writetable( T, fname, 'WriteRowNames', true, 'Sheet', sheet );
else
   % mean then sem then...
 for i = 1:stats
    foo = mat(:,:,:,i);
    T = intheon_to_xlsx( fname, foo, col_hdr, row_hdr, i );
 end
end
