% @brief get events
IN.FNAME = ".\32960218_flanker_arrows_2018-11-06_10-41-17_2.xdf";

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;

% eeg_load_xdf_noClockSynchro calls load_xdf_noClockSyncrho
% it appears that eeg_load_xdf does not pass in varargin (line 35) to load_xdf so this just handles the HandleClockSynchronization parameter
EEG = eeg_load_xdf_noClockSynchro( IN.FNAME , 'streamtype', 'EEG', 'exclude_markerstreams', {}, 'HandleClockSynchronization',0);
events = eeg_eventtable(EEG, 'exportFile', 'test.csv', 'dispTable', false);
