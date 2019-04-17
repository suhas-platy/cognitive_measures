addpath( 'C:\Program Files\eeglab_current\eeglab15rc1\plugins\xdfimport1.13' );

IN.IN_PATH = 'C:\Data\Fujitsu Data Post-Testing\11012018\3209120218\'
IN.FILENAME = '3209120218_visual_arrest_2018-11-01_15-13-39_2.xdf'

IN.IN_PATH = 'C:\Data\Fujitsu Data Post-Testing\11022018\32960318\'
IN.FILENAME = '32960318_visual_arrest_2018-11-02_14-53-48_2.xdf'

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;

% % %
% load
fname = [IN.IN_PATH IN.FILENAME];
if (~isfile( fname ))
    disp( 'check filename' ); keyboard;
end

% this won't pass clock syncrho
%EEG = pop_loadxdf('3209120218_visual_arrest_2018-11-01_15-13-39_2.xdf' , 'streamtype', 'EEG', 'exclude_markerstreams', {}, 'HandleClockSynchronization', 0);
% this won't set all fields
%EEG = load_xdf_noClockSynchro('3209120218_visual_arrest_2018-11-01_15-13-39_2.xdf' , 'HandleClockSynchronization', 0);
% just right
EEG = eeg_load_xdf_noClockSynchro( fname , 'streamtype', 'EEG', 'exclude_markerstreams', {}, 'HandleClockSynchronization',0);

% get chanlocs
EEG=pop_chanedit(EEG, 'lookup','C:\\Program Files\\eeglab_current\\eeglab15rc1\\plugins\\dipfit2.4\\standard_BESA\\standard-10-5-cap385.elp');
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);

% remove non-EEG
EEG = eeg_checkset( EEG );
EEG = pop_select( EEG, 'channel',{'F7' 'Fp1' 'Fp2' 'F8' 'F3' 'Fz' 'F4' 'C3' 'Cz' 'P8' 'P7' 'Pz' 'P4' 'T3' 'P3' 'O1' 'O2' 'C4' 'T4' 'A2'});
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 2,'overwrite','on','gui','off'); 

% epoch
EEG = pop_epoch( EEG, {  'eyes-closed-end'  }, [-10   0], 'epochinfo', 'yes');
%EEG = pop_epoch( EEG, {  'eyes-open-end'  }, [-10   0], 'epochinfo', 'yes');
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'overwrite','off','gui','off'); 
EEG = eeg_checkset( EEG );

% plot
EEG = eeg_checkset( EEG );
figure; pop_eegplot( EEG, 1, 1, 1);

figure; pop_topoplot_clip(EEG, 1, [-4000:1000:0] ,'EDF file epochs',[2 3] ,0,'electrodes','on');

figure; pop_spectopo(EEG, 1, [-10000     -2], 'EEG' , 'percent', 15, 'freq', [6 10 22], 'freqrange',[2 25],'electrodes','off');

% time-freq decomp. (param's from Golf data)
%EEG = eeg_checkset( EEG );
%figure; pop_newtimef( EEG, 1, 1, [-4000   999], [3         0.5] , 'topovec', 1, 'elocs', EEG.chanlocs, 'chaninfo', EEG.chaninfo, 'caption', 'F3', 'baseline',[0], 'plotphase', 'off', 'padratio', 1, 'winsize', 4096);

figure; pop_newtimef( EEG, 1, 1, [-10000   0], [3         0.5] , 'topovec', 1, 'elocs', EEG.chanlocs, 'chaninfo', EEG.chaninfo, 'caption', 'F3', 'baseline',[0], 'plotphase', 'off', 'padratio', 1, 'winsize', 4096);


% topoplot
%EEG = eeg_checkset( EEG );
%figure;pop_topoplot(EEG, 1, -10000,'',[1 1] ,0,'electrodes','on'); % this will work; says the valid indices are -10000 to -2
%figure; pop_topoplot(EEG, 1, [-10000:1000:0] ,'XDF file epochs',[2 3] ,0,'electrodes','on'); % won't work b/c of indices

chimera_EEG = EEG;
chimera_EEG.data = rand(20,1);
chimera_EEG.times = [1];
chimera_EEG = eeg_checkset( chimera_EEG );