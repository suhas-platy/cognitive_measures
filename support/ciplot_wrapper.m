function ciplot_wrapper( x, sem, color, alpha )
   ciplot( x-sem, x+sem, 1:length(x), color, alpha );