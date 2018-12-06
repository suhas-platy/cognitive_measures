% @brief get RT's

IN.IN_FNAME = 'test.csv';
IN.MARKERS_FROM_EEGLAB = 1;

IN.IN_FNAME = '32960218_flanker_arrows_2018-11-06_10-41-17_2_markers.csv';
IN.MARKERS_FROM_EEGLAB = 0;

if ( IN.MARKERS_FROM_EEGLAB == 1 )
   data = readtable( IN.IN_FNAME, 'HeaderLines', 1 );
else
   data = readtable( IN.IN_FNAME, 'HeaderLines', 0 );
end

trial_ctr = 1;
for r = 1:size( data,1 )
   if ( IN.MARKERS_FROM_EEGLAB == 1 )
      event_label = data{r,2}{1};
      event_latency = data{r,3};
   else
      event_label = data.Var1(r);
      event_label = strtrim( event_label{1} );
      event_latency = data.Var2(r) * 1000.;
   end
   
   
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