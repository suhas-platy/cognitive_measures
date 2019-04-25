function [npool,meanpool,stdpool] = pooledmeanstd_loop( n, mean, std )
% @brief wrapper for pooledmeanstd which handles >=2 populations
%
% all parameters should be Nx1 (n can be 1x1 if they are the same value for all populations)   
   
   loops = size(mean,1);
   if ( size(n,1) == 1 )
      n = repmat( n, loops, 1 );
   end
   
   % base case
   i = 1;
   [n_tmp,m_tmp,s_tmp] = pooledmeanstd( n(i), mean(i), std(i),...
                                        n(i+1), mean(i+1), std(i+1) ); 
   if ( n <= 2 )
       [npool,meanpool,stdpool] = deal( n_tmp,m_tmp,s_tmp );
       return;
   end
   
   % the rest
   for i = 3:loops
     %disp('hi')
     [n_tmp,m_tmp,s_tmp] = pooledmeanstd( n(i), mean(i), std(i),...
                                          n_tmp, m_tmp, s_tmp );

   end
   [npool,meanpool,stdpool] = deal( n_tmp,m_tmp,s_tmp );
   return;
   
   
   