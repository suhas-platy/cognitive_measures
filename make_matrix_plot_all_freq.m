function make_matrix_plot_all_freq( connectivity_freq_tval, connectivity_freq_pval,...
                           varargin )
% @brief show matrix plot
   
% example calls   
   
% figure(fig_num); fig_num = fig_num + 1;
% make_matrix_plot_all_freq( tier1_connectivity_data_tval, tier1_connectivity_data_pval, 'inc', IN.COLLAPSE );
% title( 'Tier 1 changes, all freq., inc (FROM is x axis; TO is y axis; L then R)' );

% figure(fig_num); fig_num = fig_num + 1;
% make_matrix_plot_all_freq( tier1_connectivity_data_tval, tier1_connectivity_data_pval, 'dec', IN.COLLAPSE );
% title( 'Tier 1 changes, all freq., dec (FROM is x axis; TO is y axis; L then R)' );

% figure(fig_num); fig_num = fig_num + 1;
% make_matrix_plot_all_freq( tier2_connectivity_data_tval, tier2_connectivity_data_pval, 'inc', IN.COLLAPSE );
% title( 'Tier 2 changes, all freq., inc (FROM is x axis; TO is y axis; L then R)' );

% figure(fig_num); fig_num = fig_num + 1;
% make_matrix_plot_all_freq( tier2_connectivity_data_tval, tier2_connectivity_data_pval, 'dec', IN.COLLAPSE );
% title( 'Tier 2 changes, all freq., dec (FROM is x axis; TO is y axis; L then R)' );

%figure(fig_num); fig_num = fig_num + 1;
%title( 'Tier 1 changes (FROM is x axis; TO is y axis; L then R)' );
%for i = 1:5
%   subplot(5,1,i);
%   make_matrix_plot( tier1_connectivity_data_tval(:,:,i), tier1_connectivity_data_pval(:,:,i) );
%end   
   
inc_dec = 'both';
if ( nargin >= 3 )
   inc_dec = varargin{1};
end

collapse = 'none';
if ( nargin >= 4 )
   collapse = varargin{2};
end

if ( collapse == 'front_back' )
   connectivity_freq_tval = collapse_connectivity( connectivity_freq_tval, 'front_back' );
   connectivity_freq_pval = collapse_connectivity( connectivity_freq_pval, 'front_back' );
end

% connectivity_freq_tval is 12x12x5
n_loc = size( connectivity_freq_tval, 1 )
n_freq = size( connectivity_freq_tval, 3 )
   
mask = zeros( size( connectivity_freq_tval(:,:,1) ) );
for i = 1:5 % for each freq. band
   if ( inc_dec == 'inc' )
      term1 = connectivity_freq_tval(:,:,i) > 0;
   elseif ( inc_dec == 'dec' )
      term1 = connectivity_freq_tval(:,:,i) < 0;
   else
      term1 = connectivity_freq_tval(:,:,i);
   end
   
   term2 = connectivity_freq_pval(:,:,i)<.05;
   
   mask = mask +...
          term1.*term2;
end
imagesc( mask )
mt_jetbar;

if ( n_loc == 12 )
   xticklabels( {'ACC', 'DLPFC', 'INF. PAR.',...
                 'LAT. OCP', 'OFPFC', 'PRE. CENT.'} );
elseif ( n_loc == 2 )
   xticklabels( {'Front', 'Back'} );
else
   ;
end

xtickangle( 90 );
if ( n_loc == 12 )
   yticklabels( {'ACC', 'DLPFC', 'INF. PAR.',...
                 'LAT. OCP', 'OFPFC', 'PRE. CENT.'} );
elseif ( n_loc == 2 )
   xticklabels( {'Front','Back'} );
else
   ;
end
