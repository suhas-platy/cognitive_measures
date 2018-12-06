% @brief get events
IN.IN_FNAME = ".\32960218_flanker_arrows_2018-11-06_10-41-17_2.xdf";
IN.SAVE_FNAME = 'test.csv';

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;

% eeg_load_xdf_noClockSynchro calls load_xdf_noClockSyncrho
% it appears that eeg_load_xdf does not pass in varargin (line 35) to load_xdf so this just handles the HandleClockSynchronization parameter
%
% setting effective_rate doesn't help
%EEG = eeg_load_xdf_noClockSynchro( IN.FNAME , 'streamtype', 'EEG', 'exclude_markerstreams', {}, 'effective_rate', 1/256., 'HandleClockSynchronization',0);
%EEG = eeg_load_xdf_noClockSynchro( IN.FNAME , 'streamtype', 'EEG', 'exclude_markerstreams', {}, 'HandleClockSynchronization',0);

% even with xdfimport 1.14, the markers come out wrong.
EEG = eeg_load_xdf( IN.IN_FNAME , 'streamtype', 'EEG', 'exclude_markerstreams', {}, 'HandleClockSynchronization', 1);
EEG = eeg_load_xdf( IN.IN_FNAME , 'streamtype', 'EEG', 'exclude_markerstreams', {}, 'HandleClockSynchronization', 1, 'with_time_sync', 0);
EEG = eeg_load_xdf( IN.IN_FNAME , 'streamtype', 'EEG', 'exclude_markerstreams', {}, 'with_time_sync', 0);
EEG = eeg_load_xdf( IN.IN_FNAME , 'streamtype', 'EEG', 'exclude_markerstreams', {}, 'effective_rate', 1);

% also tried just getting 'streamtype' 'Markers' but it errors out with no effective_srate
% EEG = eeg_load_xdf( IN.IN_FNAME , 'streamtype', 'Markers', 'exclude_markerstreams', {});

events = eeg_eventtable(EEG, 'exportFile', IN.SAVE_FNAME, 'dispTable', true);
