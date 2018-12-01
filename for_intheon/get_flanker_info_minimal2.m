% @brief get RT's

IN.FNAME = 'test.csv';

data = readtable( IN.FNAME ); % header is dropped
trial_ctr = 1;
for r = 1:size( data,1 )
   event_label = data{r,2}{1};
   event_latency = data{r,3};
   
   if ( strcmp( event_label, 'congruent-stimulus' ) ||...
        strcmp( event_label, 'incongruent-stimulus' ) )
      start_t = event_latency;
   end
   
   if ( strcmp( event_label, 'arrow_left pressed' ) ||...
        strcmp( event_label, 'arrow_right pressed' ) )
     end_t = event_latency;
     rt(trial_ctr) = end_t - start_t;
     
     % trace
     if ( trial_ctr == 1 || r == size(data,1)-12 )
        trial_ctr
        start_t
        end_t
        rt(end)
     end
     
     trial_ctr = trial_ctr + 1;
   end   

end

mean( rt )

figure(1);
hist( rt );