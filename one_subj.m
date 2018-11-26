addpath( 'C:\Program Files\eeglab_current\eeglab15rc1\plugins\xdfimport1.13' );

% load
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = load_xdf_wrapper('C:\Users\suhas\Go Platypus Dropbox\Science And Research\Data Aquisition\Fujitsu Data Post-Testing\11012018\3209120218\3209120218_visual_arrest_2018-11-01_15-13-39_2.xdf' , 'streamtype', 'EEG', 'exclude_markerstreams', {}, 'HandleClockSynchronization', 0);

%[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'overwrite','on','gui','off'); 
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 0,'gui','off'); 

% plot
EEG = eeg_checkset( EEG );
pop_eegplot( EEG, 1, 1, 1);
%EEG = pop_rmdat( EEG, {'eyes-closed-end'},[-10 0] ,0);
%[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'overwrite','on','gui','off'); 
%EEG = eeg_checkset( EEG );
%pop_eegplot( EEG, 1, 1, 1);

% get channel info
EEG=pop_chanedit(EEG, 'lookup','C:\\Program Files\\eeglab_current\\eeglab15rc1\\plugins\\dipfit2.4\\standard_BESA\\standard-10-5-cap385.elp');
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);

% extract epochs
EEG = eeg_checkset( EEG );
EEG = pop_epoch( EEG, {  'eyes-closed-end'  }, [-10   0], 'newname', 'XDF file epochs', 'epochinfo', 'yes');
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'saveold','C:\\Users\\suhas\\Desktop\\EC.set','gui','off'); 
[ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG, CURRENTSET);
%EEG = eeg_checkset( EEG );
%EEG = pop_rmbase( EEG, [],[1:43962] ,[]);
%[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'saveold','C:\\Users\\suhas\\Desktop\\EC.set','gui','off'); 


figure; pop_newtimef( EEG, 1, 1, [-10000   -2], [3         0.5] , 'topovec', 1, 'elocs', EEG.chanlocs, 'chaninfo', EEG.chaninfo, 'caption', 'F3', 'baseline',[0], 'plotphase', 'off', 'padratio', 1, 'winsize', 4096);
EEG = eeg_checkset( EEG );