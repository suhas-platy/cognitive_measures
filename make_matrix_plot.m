function make_matrix_plot( connectivity_tval, connectivity_pval,...
                           varargin )
% @brief show matrix plot
   sig_idx = (connectivity_pval<.05); 
   sig_idx( 1:1+size(sig_idx,1):end ) = 0; % 0 out self connections

   dec_idx = (connectivity_tval<0); 
   sig_dec_idx = dec_idx.*sig_idx;

   inc_idx = (connectivity_tval>0); 
   sig_inc_idx = inc_idx.*sig_idx;
   
   img = zeros( size( connectivity_tval ) );
   idx = find( sig_dec_idx );
   img( idx ) = connectivity_tval( idx );
   idx = find( sig_inc_idx );
   img( idx ) = connectivity_tval( idx );
   imagesc( img );
   mt_jetbar;

xticklabels( {'ACC', 'DLPFC', 'INF. PAR.',...
              'LAT. OCP', 'OFPFC', 'PRE. CENT.'} );
xtickangle( 90 );
yticklabels( {'ACC', 'DLPFC', 'INF. PAR.',...
              'LAT. OCP', 'OFPFC', 'PRE. CENT.'} );
