function T = intheon_to_csv( fname, mat, col_hdr, row_hdr )
% @brief write out:
%              tier 1 after, tier 1 before, tier 2 after, tier 2 before
%   electrode1
%   ...
%   electrode19
   T = array2table( mat, 'VariableNames', col_hdr, 'RowNames', row_hdr );
   writetable( T, fname, 'WriteRowNames', true );