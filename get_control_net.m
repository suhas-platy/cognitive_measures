function mtx_out = get_control_net( mtx )
% checked - OK
   idx_keep = [1 2 3 4 5 6 11 12];
   mtx_out = zeros( length(idx_keep) );
   
   for i = 1:length(idx_keep)
      ii = idx_keep(i);
      for j = 1:length(idx_keep)
         jj = idx_keep(j);
         mtx_out(i,j) = mtx(ii,jj);
      end
   end
   
