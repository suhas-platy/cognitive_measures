function val = get_cxn_tbl( from, to, mtx, thresh )
% @brief get table of cxn's b/t 2 grouped brain areas

% from prefrontal to motor, eg.
   if ( from == 1 )
      from2 = [1 2 3 4 9 10];
   elseif ( from == 2 )
      from2 = [11 12];
   else
      from2 = [5 6 7 8];
   end
   
   if ( to == 1 )
      to2 = [1 2 3 4 9 10];
   elseif ( to == 2 )
      to2 = [11 12];
   else
      to2 = [5 6 7 8];
   end

   val = 0;
   for i = 1:length( to2 )
      for j = 1:length( from2 )
         t = to2( i );
         f = from2( j );
         if ( strcmp( thresh, '>' ) ) % count inc.
            if ( mtx(t,f) > 0 )
               val = val+1;
            end
         elseif ( strcmp( thresh, '<' ) ) % count dec.
            if ( mtx(t,f) < 0 )
               val = val+1;
            end
         else % sum cxn. weights
            val = val+mtx(t,f);
         end
         
      end
   end
   