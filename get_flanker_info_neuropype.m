% @brief get # correct and RT for flanker data

% first run like so: get_flanker_info_neuropype( "./conf/flanker/flanker_before_tier1.json" );
% then: get_flanker_info_neuropype( "./conf/flanker/flanker_before_tier2.json" );
% then: get_flanker_info_neuropype( "./conf/flanker/flanker_after_tier1.json" );
% then: get_flanker_info_neuropype( "./conf/flanker/flanker_after_tier2.json" );

% mat files are saved in ./data (e.g., flanker_after_tier1.mat)

% flanker markers look like what's below.  in summary:

% trial-begin
% response-window-begin
% flanker
% congruent-stimulus / inconcgruent-stimulus -- strart timer for RT
% fixation-cross and crosshair-begin
% arrow pressed or not -- end timer for RT
% crosshair-end
% response-window-end
% judgement of response
% trial end

% correct

% trial-begin , 1868.46203288
% response-window-begin , 1868.4620876
% right-flanker , 1868.46209919
% picture-begin , 1868.46232876
% picture-end , 1868.55227393
% incongruent-stimulus , 1868.55239961
% picture-begin , 1868.55270662
% picture-end , 1868.71189572
% fixation-cross , 1868.71194766
% crosshair-begin , 1868.7122018
% arrow_left pressed , 1868.99393483
% response-received-arrow_left , 1868.99670029
% crosshair-end , 1870.10074055
% response-window-end , 1870.10082263
% response-was-correct , 1870.10083933
% trial-end , 1870.10086112

% incorrect

% trial-begin , 1878.35612432
% response-window-begin , 1878.35616374
% right-flanker , 1878.35617673
% picture-begin , 1878.35641928
% picture-end , 1878.49482735
% incongruent-stimulus , 1878.49488162
% picture-begin , 1878.49502909
% picture-end , 1878.64060843
% fixation-cross , 1878.64066547
% crosshair-begin , 1878.64089225
% arrow_right pressed , 1878.73593934
% response-received-arrow_right , 1878.73808103
% crosshair-end , 1880.00146829
% response-window-end , 1880.00155548
% response-was-incorrect , 1880.00156893
% trial-end , 1880.00158052

% missed

% trial-begin 
% response-window-begin 
% right-flanker 
% picture-begin 
% picture-end 
% incongruent-stimulus 
% picture-begin 
% picture-end 
% fixation-cross 
% crosshair-begin 
% crosshair-end 
% response-window-end 
% response-was-missed 
% trial-end 

% response too early

% trial-begin 
% response-window-begin 
% left-flanker 
% picture-begin 
% picture-end 
% congruent-stimulus 
% picture-begin 
% arrow_left pressed 
% response-received-arrow_left 
% picture-end 
% fixation-cross 
% crosshair-begin 
% crosshair-end 
% response-window-end 
% response-was-correct 
% trial-end 


function [OUT, varargout] = get_flanker_info_neuropype( CONFIG_FILENAME, varargin )

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ handle include paths
addpath( './support' );
%%%}}} eo-handle include paths

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ params (IN & ALGO)
disp( 'params' );

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% test
% IN.SETTING = 'test_1after';
% IN.IN_PATH = 'C:\Data\Fujitsu Data Post-Testing\';
% IN.FZ = ["11012018\3209120218\3209120218_flanker_arrows_2018-11-01_15-16-24_2_markers.csv"];
% IN.SAVE_FILENAME = './test.mat';

params = jsondecode( fileread( CONFIG_FILENAME ) );
IN = params{1}.IN;
ALGO = params{2}.ALGO;

ALGO.SAVE = 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ trace param's
IN
ALGO
%%%}}}

%%%}}} eo-params (IN & ALGO)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ load data
disp( 'load data' );
disp( '(in calculate below)' );
%%%}}} eo-load data

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ calculate
disp( 'calculate data' );

% load
corr = zeros(1,size(IN.IN_FILEZ,1));
incorr = zeros(1,size(IN.IN_FILEZ,1));
missed = zeros(1,size(IN.IN_FILEZ,1));

for f = 1:size(IN.IN_FILEZ,1) % for each subject
  % load
  fname = strcat( IN.IN_PATH, IN.IN_FILEZ{f} )
  if (~isfile( fname ))
      disp( 'check filename' ); keyboard;
  end

  events = readtable( fname, 'HeaderLines', 0 );
  
  % get stats
  curr_events = events.Var1; % type (includes write begin, etc.)
  curr_time_stamps = events.Var2; % latency
  trial_ctr = 1;
  for row_ctr = 1:size( curr_events, 1 ) % for each trial
     curr_event = curr_events(row_ctr);
     curr_event = strtrim( curr_event{1} );
     curr_time_stamp = curr_time_stamps(row_ctr) * 1000.;
     
     if ( row_ctr == 1 )
        resp_tmp = [];
        congruent_tmp = [];
        rt_tmp = [];
        last_event = '';
     end

     % stimulus, incongruent or not
     if ( strcmp( curr_event, 'left-flanker' ) ||...
          strcmp( curr_event, 'right-flanker' ) )
        flanker_OK_trial = 1;
     end     
     
     if ( strcmp( curr_event, 'congruent-stimulus' ) )
        congruent_tmp = [congruent_tmp "congruent"];
     elseif ( strcmp( curr_event, 'incongruent-stimulus' ) )
        congruent_tmp = [congruent_tmp "incongruent"];
     else
        ;
     end     

     % rt / response
     if ( strcmp( curr_event, 'incongruent-stimulus' ) ||...
          strcmp( curr_event, 'congruent-stimulus' ) )
        resp_OK_trial = 0;
        resp_missed_trial = 0;
        
        start_t = curr_time_stamp;
     end
     
     if( strcmp( last_event, 'crosshair-begin' ) )
        if ( strcmp( curr_event, 'arrow_right pressed' ) ||...
             strcmp( curr_event, 'arrow_left pressed' ) )
          resp_OK_trial = 1;
          
          end_t = curr_time_stamp;
          rt_tmp = [rt_tmp, end_t - start_t];
        end
     end
     
     % assessment of response, correct or not
     % can't trust response-was-correct because sometimes that says yes when the response was too early (hence good_trial flag)
     if ( strcmp( curr_event, 'response-was-correct' ) )
        if ( resp_OK_trial )
          corr(f) = corr(f) + 1;
          resp_tmp = [resp_tmp "correct"];
          % rt_tmp set above
        end
     elseif ( strcmp( curr_event, 'response-was-incorrect' ) )
        if ( resp_OK_trial )
          incorr(f) = incorr(f) + 1;
          resp_tmp = [resp_tmp "incorrect"];
          % rt_tmp set above
        end
     elseif ( strcmp( curr_event, 'response-was-missed' ) )
        resp_missed_trial = 1; 
         
        missed(f) = missed(f) + 1;
        resp_tmp = [resp_tmp "missed"];
        rt_tmp = [rt_tmp, nan];
     else
        ;
     end
      
     % trial ctr and other book keeping
     if ( strcmp( curr_event, 'trial-end' ) )    
       trial_ctr = trial_ctr + 1;
       
       if ( ~exist( "flanker_OK_trial" ) ||... % flanker missing
          (~resp_OK_trial && ~resp_missed_trial) ) % e.g., early resp.
         missed(f) = missed(f) + 1;
         resp_tmp = [resp_tmp "other"];
         rt_tmp = [rt_tmp, nan];
       end       
        
       % guard against weird trials (if one comes up, find the value of
       % row_ctr and then step a breakpoint when row_ctr >= that value
       if ( length( congruent_tmp ) ~= length( rt_tmp ) )
         disp( 'congruent_tmp diff. size than rt_tmp' );
         keyboard;
       end        
     end
     last_event = curr_event;   
          
  end % rof row_ctr
  
  num_trial(f) = trial_ctr-1;
  resp{f} = resp_tmp;
  congruent{f} = congruent_tmp;
  rt{f} = rt_tmp;
  
  foo = rt{f};
  foo = foo( ~isnan( foo ) );
  rt_avg(f) = mean( foo, 2 ); % diff. subjects do a diff. number of trials
  %keyboard; % examine
end

%%%}}} eo-calculate

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ display
corr
num_trial
%rt_avg
% keyboard; % examine
%%%}}} eo-display

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ save
disp( 'save' );

if ( ALGO.SAVE )
  fname = [IN.SAVE_PATH IN.SAVE_FILENAME];
  disp( sprintf( 'saving as file %s', fname ) );
  save( fname, '-v7.3' );
else
   disp( 'ALGO.SAVE off; not saving' );
end
%%%}}} % eo-save