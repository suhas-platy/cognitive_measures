function T = intheon_to_csv( fname, mat, col_hdr, row_hdr )
%T = array2table( mat );
%T = array2table( mat, 'VariableNames', col_hdr );
   T = array2table( mat, 'VariableNames', col_hdr, 'RowNames', row_hdr );
   writetable( T, fname, 'WriteRowNames', true );