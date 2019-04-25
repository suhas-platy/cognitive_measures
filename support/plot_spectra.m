function h = plot_spectra( fig_num, a_mean, varargin )
   has_sem = 0;
   if (nargin==3)
      a_sem = varargin{1};
      has_sem = 1;
   end
   
   n=size(a_mean,1);
   ALPHA = 0.5;
   
   h = figure(fig_num);
   
   for i = 1:n
      if ( i == 1 )
         clr = [0,0,1];
      else
         clr = [255,165,0]./255;
      end
      
      if ( ~has_sem )
         plot( a_mean(i,:), 'Color', clr ); hold on;
      else
         lower = a_mean(i,:) - a_sem(i,:);
         upper = a_mean(i,:) + a_sem(i,:);
         ciplot( lower, upper, a_mean(i,:), clr, ALPHA ); hold on;
      end
   end   
      