addpath( 'C:\Program Files\eeglab_current\eeglab15rc1\plugins\xdfimport1.13' );

% tier 1 before
IN.IN_PATH = 'C:\Data\Fujitsu Study Data\';
IN.FZ = ["09062018\32960218\32960218_visual_arrest_2018-09-06_10-38-08_1.xdf",...
         "09072018\31970318\31970318_visual_arrest_2018-09-07_15-05-13_1.xdf",...
         "09052018\32950518\32950518_visual_arrest_2018-09-05_16-42-59_1.xdf",...
         "09052018\32950318\32950318_visual_arrest_2018-09-05_13-58-14_1.xdf",...
         "09052018\32950518\32950518_visual_arrest_2018-09-05_16-42-59_1.xdf"];

% tier 2 before
% 32050118 is missing in before
IN.IN_PATH = 'C:\Data\Fujitsu Study Data\';
IN.FZ = ["09072018\32970418\32970418_visual_arrest_2018-09-07_16-37-55_1.xdf",...
         "09112018\3209110318\3209110318_visual_arrest_2018-09-11_15-19-51_1.xdf",...
         "09072018\31970118\31970118_visual_arrest_2018-09-07_10-51-26_1.xdf",...
         "09122018\3109120318\3109120318_visual_arrest_2018-09-12_16-50-33_1.xdf"];
     
% tier 1 after
% IN.IN_PATH = 'C:\Data\Fujitsu Data Post-Testing\'
% IN.FZ = ["11062018\32960218\32960218_visual_arrest_2018-11-06_10-38-31_2.xdf",...
%          "11052018\31970318\31970318_visual_arrest_2018-11-05_15-26-28_2.xdf",...
%          "11062018\32950518\32950518_visual_arrest_2018-11-06_12-14-46_2.xdf",...
%          "11052018\32950318\32950318_visual_arrest_2018-11-05_10-54-45_2.xdf",...
%          "11062018\32950518\32950518_visual_arrest_2018-11-06_12-14-46_2.xdf"];
% tier 2
% IN.IN_PATH = 'C:\Data\Fujitsu Data Post-Testing\'
% 1 and 4 are 2x the length for some reason
% IN.FZ = ["11022018\32960318\32960318_visual_arrest_2018-11-02_14-53-48_2.xdf",...
%          "11122018\32970418\32970418_visual_arrest_2018-11-12_12-07-29_2.xdf",...
%          "11092018\3209110318\3209110318_visual_arrest_2018-11-09_12-04-33_2.xdf",...
%          "11012018\3209120218\3209120218_visual_arrest_2018-11-01_15-13-39_2.xdf",...
%          "11092018\31970118\31970118_visual_arrest_2018-11-09_10-47-55_2.xdf"];
% IN.FZ = ["11122018\32970418\32970418_visual_arrest_2018-11-12_12-07-29_2.xdf",...
%          "11092018\3209110318\3209110318_visual_arrest_2018-11-09_12-04-33_2.xdf",...
%          "11092018\31970118\31970118_visual_arrest_2018-11-09_10-47-55_2.xdf",...
%          "11072018\32050118\32050118_visual_arrest_2018-11-07_12-09-53_2.xdf",...
%          "11072018\3109120318\3109120318_visual_arrest_2018-11-07_16-37-25_2.xdf"];
"C:\Data\Fujitsu Study Data\09052018\32950518\32950518_visual_arrest_2018-09-05_16-42-59_1.xdf"

IN.OPEN = 0

%IN.SAVE_FILENAME = './tier1_open_before.mat';
%IN.SAVE_FILENAME = './tier1_closed_before.mat';

IN.SAVE_FILENAME = './tier2_open_before.mat';
IN.SAVE_FILENAME = './tier2_closed_before.mat';

%IN.SAVE_FILENAME = './tier1_open.mat';
%IN.SAVE_FILENAME = './tier1_closed.mat';

%IN.SAVE_FILENAME = './tier2_open.mat';
%IN.SAVE_FILENAME = './tier2_closed.mat';


[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;

% % %
% load
for f = 1:size(IN.FZ,2)
  fname = strcat( IN.IN_PATH, IN.FZ(f) );
  if (~isfile( fname ))
      disp( 'check filename' ); keyboard;
  end

  EEG{f} = eeg_load_xdf_noClockSynchro( fname , 'streamtype', 'EEG', 'exclude_markerstreams', {}, 'HandleClockSynchronization',0);
  
  % remove non-EEG
  EEG{f} = eeg_checkset( EEG{f} );
  EEG{f} = pop_select( EEG{f}, 'channel',{'F7' 'Fp1' 'Fp2' 'F8' 'F3' 'Fz' 'F4' 'C3' 'Cz' 'P8' 'P7' 'Pz' 'P4' 'T3' 'P3' 'O1' 'O2' 'C4' 'T4' 'A2'});

  % epoch
  if ( IN.OPEN )
    EEG{f} = pop_epoch( EEG{f}, {  'eyes-open-end'  }, [-10   0], 'epochinfo', 'yes');
  else
    EEG{f} = pop_epoch( EEG{f}, {  'eyes-closed-end'  }, [-10   0], 'epochinfo', 'yes');
  end

  %[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'overwrite','off','gui','off'); 
  %EEG = eeg_checkset( EEG );
end

% avg
EEG_avg = EEG{f};
EEG_avg.data = zeros( size( EEG{f}.data ) );
for f = 1:size(IN.FZ,2)
   EEG_avg.data = EEG_avg.data + EEG{f}.data;
end
EEG_avg.data = EEG_avg.data/size(IN.FZ,2);


% get chanlocs
EEG_avg=pop_chanedit(EEG_avg, 'lookup','C:\\Program Files\\eeglab_current\\eeglab15rc1\\plugins\\dipfit2.4\\standard_BESA\\standard-10-5-cap385.elp');
[ALLEEG EEG] = eeg_store(ALLEEG, EEG_avg, CURRENTSET);


% plot
EEG = eeg_checkset( EEG );
figure; pop_eegplot( EEG, 1, 1, 1);

figure; pop_topoplot_clip(EEG, 1, [-4000:1000:0] ,'EDF file epochs',[2 3] ,0,'electrodes','on');

figure; pop_spectopo(EEG, 1, [-10000     -2], 'EEG' , 'percent', 15, 'freq', [6 10 22], 'freqrange',[2 25],'electrodes','off');

% time-freq decomp. (param's from Golf data)
%EEG = eeg_checkset( EEG );
%figure; pop_newtimef( EEG, 1, 1, [-4000   999], [3         0.5] , 'topovec', 1, 'elocs', EEG.chanlocs, 'chaninfo', EEG.chaninfo, 'caption', 'F3', 'baseline',[0], 'plotphase', 'off', 'padratio', 1, 'winsize', 4096);

figure; pop_newtimef( EEG, 1, 1, [-10000   0], [3         0.5] , 'topovec', 1, 'elocs', EEG.chanlocs, 'chaninfo', EEG.chaninfo, 'caption', 'F3', 'baseline',[0], 'plotphase', 'off', 'padratio', 1, 'winsize', 1024);


% topoplot
%EEG = eeg_checkset( EEG );
%figure; pop_topoplot(EEG, 1, [-10000:1000:0] ,'XDF file epochs',[2 3]
%,0,'electrodes','on');

disp( ['saving ', IN.SAVE_FILENAME] );
save( IN.SAVE_FILENAME );