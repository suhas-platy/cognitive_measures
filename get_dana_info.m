% @brief get ISI info for DANA tasks

% example events

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SRT1
% 4	trial-begin	32365.525417
% 5	picture-begin	32804.964997
% 6	response	33071.968126
% 7	trial-end	33100.46846
% 8	trial-begin	33100.46846

% 20	trial-begin	36114.62729
% 21	picture-begin	36833.686771
% 22	response-was-missed	37283.692044
% 23	trial-end	37283.692044

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% GNG
% 532	trial-begin	276866.375939
% 533	stimulus-go-#3	277416.192701
% 534	response-was-missed	278166.687691
% 535	trial-end	278167.187697

% 540	trial-begin	279626.208699
% 541	stimulus-go-#0	280226.749702
% 542	response-was-correct	280676.254969
% 543	trial-end	280728.255578

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CSL (CSS in the events)

% 168	trial-begin	110743.799953
% 169	stimulus-nomatch-#8	111194.305232
% 170	response-was-incorrect	111670.810815
% 171	trial-end	111696.81112

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MS
% 758	trial-begin	458101.38148
% 759	stimulus-in-set-letter-Z	458551.985142
% 760	response-was-correct	459269.042566
% 761	trial-end	459319.043152
% 762	trial-begin	459319.043152

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
IN.IN_PATH = 'C:\Data\Fujitsu Data Post-Testing\';
IN.FZ = ["11012018\3209120218\3209120218_dana_tasks_2018-11-01_15-29-00_2.xdf"];

IN.SAVE_PATH = './';
IN.SAVE_EVENT_FNAME = 'dana_events.csv';
IN.SAVE_FNAME = 'dana.mat';

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

for f = 1:size(IN.FZ,2)
  % load
  fname = strcat( IN.IN_PATH, IN.FZ(f) )
  if (~isfile( fname ))
      disp( 'check filename' ); keyboard;
  end

  EEG{f} = eeg_load_xdf_noClockSynchro( fname , 'streamtype', 'EEG', 'exclude_markerstreams', {}, 'HandleClockSynchronization',0);
  if ( ALGO.SAVE_EVENT_FILE )
     events = eeg_eventtable(EEG{f}, 'exportFile', [IN.SAVE_PATH IN.SAVE_EVENT_FNAME], 'dispTable', false);
  else
     events = eeg_eventtable(EEG{f}, 'dispTable', false);
  end
end

%%%}}} eo-calculate

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ display
%%%}}} eo-display

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ save
disp( 'save' );

if ( ALGO.SAVE )
   fname = [IN.SAVE_PATH IN.SAVE_FNAME];
   disp( ['saving ', fname] );
   save( fname );
else
  disp( 'ALGO.SAVE off; not saving' );
end
%%%}}} % eo-save