function tval_masked = get_tval_masked( tval, pval, varargin )
% @brief get only significant t values
   tmp_tval = squeeze( tval );
   tmp_pval = squeeze( pval );
   tmp = zeros( size(tmp_tval) );
   idx = find( tmp_pval < .05 );
   tmp( idx ) = tmp_tval( idx );
   tval_masked = tmp;
   return;