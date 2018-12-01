% @brief get # correct and RT for flanker data

% example events
    % [  6599]    'trial-begin'            [3.7341e+05]    [       1]
    % [  6600]    'response-window-b¡­'    [3.7341e+05]    [       1]
    % [  6601]    'left-flanker'           [3.7341e+05]    [       1]
    % [  6602]    'picture-begin'          [3.7341e+05]    [       1]
    % [  6603]    'picture-end'            [3.7347e+05]    [       1]
    % [  6604]    'incongruent-stimu¡­'    [3.7347e+05]    [       1]
    % [  6605]    'picture-begin'          [3.7347e+05]    [       1]
    % [  6606]    'picture-end'            [3.7354e+05]    [       1]
    % [  6607]    'fixation-cross'         [3.7354e+05]    [       1]
    % [  6608]    'crosshair-begin'        [3.7354e+05]    [       1]
    % [  6609]    'arrow_right pressed'    [3.7365e+05]    [       1]
    % [  6610]    'response-received¡­'    [3.7366e+05]    [       1]
    % [  6611]    'crosshair-end'          [3.7423e+05]    [       1]
    % [  6612]    'response-window-end'    [3.7423e+05]    [       1]
    % [  6613]    'response-was-corr¡­'    [3.7423e+05]    [       1]
    % [  6614]    'trial-end'              [3.7423e+05]    [       1]

% example with missed
% 668	trial-begin	21188.621561	1
% 669	response-window-begin	21188.634083	1
% 670	right-flanker	21188.636865	1
% 671	picture-begin	21188.671765	1
% 672	picture-end	21226.767164	1
% 673	congruent-stimulus	21226.781077	1
% 674	picture-begin	21226.816556	1
% 675	picture-end	21266.698305	1
% 676	fixation-cross	21266.712566	1
% 677	crosshair-begin	21266.769263	1
% 678	crosshair-end	21599.994002	1
% 679	response-window-end	21600.016148	1
% 680	response-was-missed	21600.019278	1
% 681	trial-end	21600.02322	1


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ handle include paths
addpath( 'C:\Program Files\eeglab_current\eeglab15rc1\plugins\xdfimport1.13' );
addpath( './support' );
%%%}}} eo-handle include paths

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ params (IN & ALGO)
disp( 'params' );

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tier 1 after
IN.SETTING1 = '1before';
IN.IN_PATH = 'C:\Data\Fujitsu Study Data\';
IN.FZ = [...
   "11062018\32960218\32960218_flanker_arrows_2018-11-06_10-41-17_2.xdf",...
   "11052018\31970318\31970318_flanker_arrows_2018-11-05_15-28-55_2.xdf",...
   "11062018\32950518\32950518_flanker_arrows_2018-11-06_12-17-43_2.xdf",...
   "11052018\32950318\32950318_flanker_arrows_2018-11-05_10-57-44_2.xdf",...
   "11062018\31960118\31960118_flanker_arrows_2018-11-06_09-16-05_2.xdf",...
   "11072018\31970218\31970218_flanker_arrows_2018-11-07_18-06-34_2.xdf",...
   "11142018\319100118\319100118_flanker_arrows_2018-11-14_17-02-13_2.xdf",...
   "11072018\319110218\319110218_flanker_arrows_2018-11-07_15-11-39_2.xdf",...
   "11122018\32960418\32960418_flanker_arrows_2018-11-12_15-10-20_2.xdf",...
   "11052018\319110118\319110118_flanker_arrows_2018-11-05_12-22-24_2.xdf"];
IN.SAVE_FILENAME = './1after.mat';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tier 1 after
IN.SETTING1 = '1after';
IN.IN_PATH = 'C:\Data\Fujitsu Data Post-Testing\';
IN.FZ = [...
   "11062018\32960218\32960218_flanker_arrows_2018-11-06_10-41-17_2.xdf",...
   "11052018\31970318\31970318_flanker_arrows_2018-11-05_15-28-55_2.xdf",...
   "11062018\32950518\32950518_flanker_arrows_2018-11-06_12-17-43_2.xdf",...
   "11052018\32950318\32950318_flanker_arrows_2018-11-05_10-57-44_2.xdf",...
   "11062018\31960118\31960118_flanker_arrows_2018-11-06_09-16-05_2.xdf",...
   "11072018\31970218\31970218_flanker_arrows_2018-11-07_18-06-34_2.xdf",...
   "11142018\319100118\319100118_flanker_arrows_2018-11-14_17-02-13_2.xdf",...
   "11072018\319110218\319110218_flanker_arrows_2018-11-07_15-11-39_2.xdf",...
   "11122018\32960418\32960418_flanker_arrows_2018-11-12_15-10-20_2.xdf",...
   "11052018\319110118\319110118_flanker_arrows_2018-11-05_12-22-24_2.xdf"];
IN.SAVE_FILENAME = './1after.mat';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tier 2 after
IN.SETTING = '2after';
IN.IN_PATH = 'C:\Data\Fujitsu Data Post-Testing\';
IN.FZ = [...
   "11142018\31950418\31950418_flanker_arrows_2018-11-14_13-41-22_2.xdf",...
   "11132018\310910318\310910318_flanker_arrows_2018-11-13_12-19-24_2.xdf",...
   "11022018\32960318\32960318_flanker_arrows_2018-11-02_14-56-03_2.xdf",...
   "11122018\32970418\32970418_flanker_arrows_2018-11-12_12-10-12_2.xdf",...
   "11092018\3209110318\3209110318_flanker_arrows_2018-11-09_12-07-13_2.xdf",...
   "11012018\3209120218\3209120218_flanker_arrows_2018-11-01_15-16-24_2.xdf",...
   "11132018\319100418\319100418_flanker_arrows_2018-11-13_15-51-31_2.xdf",...
   "11092018\31970118\31970118_flanker_arrows_2018-11-09_10-50-49_2.xdf",...
   "11072018\32050118\32050118_flanker_arrows_2018-11-07_12-12-42_2.xdf",...
   "11132018\31950218\31950218_flanker_arrows_2018-11-13_10-43-55_2.xdf",...
   "11072018\3109120318\3109120318_flanker_arrows_2018-11-07_16-40-10_2.xdf"];
IN.SAVE_FILENAME = './2after.mat';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% test
IN.SETTING = 'test';
IN.IN_PATH = '.\data\';
IN.FZ = ["Testdata_flanker_arrows_2018-07-05_07-32-07_1.xdf"];
IN.SAVE_FILENAME = './test.mat'; % rt is 165 ms

IN.SETTING = 'test_1after';
IN.IN_PATH = 'C:\Data\Fujitsu Data Post-Testing\';
IN.FZ = ["11062018\32960218\32960218_flanker_arrows_2018-11-06_10-41-17_2.xdf"];
IN.SAVE_FILENAME = './test.mat'; % rt is 165 ms

ALGO.SAVE_EVENT_FILE = 1;
ALGO.SAVE = 0
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
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;

% load
corr = zeros(1,size(IN.FZ,2));
incorr = zeros(1,size(IN.FZ,2));
missed = zeros(1,size(IN.FZ,2));

for f = 1:size(IN.FZ,2)
  % load
  fname = strcat( IN.IN_PATH, IN.FZ(f) )
  if (~isfile( fname ))
      disp( 'check filename' ); keyboard;
  end

  EEG{f} = eeg_load_xdf_noClockSynchro( fname , 'streamtype', 'EEG', 'exclude_markerstreams', {}, 'HandleClockSynchronization',0);
  if ( ALGO.SAVE_EVENT_FILE )
     events = eeg_eventtable(EEG{f}, 'exportFile', 'test.csv', 'dispTable', false);
  else
     events = eeg_eventtable(EEG{f}, 'dispTable', false);
  end
  %events = eeg_eventtable( EEG{f} ); % do this to see the events
  %keyboard; % examine
  
  % get stats
  curr_events = events{1}; % type (includes write begin, etc.)
  curr_time_stamps = events{2}; % latency
  trial_ctr = 1;
  for t = 1:size( curr_events.values, 1 )
     % correct or not
     if ( strcmp( curr_events.values{t}, 'response-was-correct' ) )
        corr(f) = corr(f) + 1;
     elseif ( strcmp( curr_events.values{t}, 'response-was-incorrect' ) )
        incorr(f) = incorr(f) + 1;
     elseif ( strcmp( curr_events.values{t}, 'response-was-missed' ) )
        missed(f) = missed(f) + 1;
     else
        ;
     end

     % rt
     if ( strcmp( curr_events.values{t}, 'incongruent-stimulus' ) ||...
          strcmp( curr_events.values{t}, 'congruent-stimulus' ) )
        start_t = curr_time_stamps.values{t};
     end
     
     if ( strcmp( curr_events.values{t}, 'arrow_right pressed' ) ||...
          strcmp( curr_events.values{t}, 'arrow_left pressed' ) )
        end_t = curr_time_stamps.values{t};
        rt(f,trial_ctr) = end_t - start_t;
        trial_ctr = trial_ctr + 1;
     end     
  end % rof t
  
  rt_avg(f) = mean( rt(f,1:trial_ctr-1), 2 ); % diff. subjects do a diff. number of trials
  %keyboard; % examine
end

%%%}}} eo-calculate

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ display
corr
rt_avg
%%%}}} eo-display

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ save
disp( 'save' );

if ( ALGO.SAVE )
   disp( ['saving ', IN.SAVE_FILENAME] );
   save( IN.SAVE_FILENAME );
else
  disp( 'ALGO.SAVE off; not saving' );
end
%%%}}} % eo-save