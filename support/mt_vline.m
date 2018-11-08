function mt_vline( x, varargin )
% @brief plot a vertical line at 'x' to the current axis (gca)
   ax = gca;
   ylim = get(ax,'YLim');
   ymin = ylim(1);
   ymax = ylim(2);
   
   hold on;
   line( [x x], [ymin ymax] );