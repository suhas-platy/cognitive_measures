% @brief compare and contrast raw and preprocessed EEG

IN.IN_ORIG_PATH = 'C:\Users\suhas\Go Platypus Dropbox\Science And Research\Data Aquisition\Fujitsu Study Data\09052018\31950218\';
IN.IN_ORIG_FILENAME = '31950218_dana_tasks_2018-09-05_12-31-52_1.xdf';

IN.IN_PREPROCESSED_PATH = 'C:\Users\suhas\Go Platypus Dropbox\Science And Research\Data Aquisition\Fujitsu Study Data\09052018\31950218\preprocessed_data\';
IN.IN_PREPROCESSED_FILENAME = '31950218_dana_tasks_2018-09-05_12-31-52_1.CSS.xdf.preprocessed.xdf';


% Load eeglab and preprocessed file
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadxdf([IN.IN_PREPROCESSED_PATH IN.IN_PREPROCESSED_FILENAME], 'streamtype', 'EEG', 'exclude_markerstreams', {});
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 0,'setname','CSS','gui','off'); 
%EEG = eeg_checkset( EEG );
pop_eegplot( EEG, 1, 1, 1);

EEG = pop_loadxdf('C:\Users\suhas\Go Platypus Dropbox\Science And Research\Data Aquisition\Fujitsu Study Data\09052018\31950218\31950218_dana_tasks_2018-09-05_12-31-52_1.xdf' , 'streamtype', 'EEG', 'exclude_markerstreams', {});
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'setname','CSS_orig','saveold','C:\\Users\\suhas\\Go Platypus Dropbox\\Science And Research\\Data Aquisition\\Fujitsu Study Data\\09052018\\31950218\\preprocessed_data\\foo.set','gui','off'); 
pop_eegplot( EEG, 1, 1, 1);

% plot more than one: eegplot([ALLEEG(2).data], 'data2', [ALLEEG(1).data], 'color','off') % https://sccn.ucsd.edu/pipermail/eeglablist/2017/012787.html

% Obtain all unique event types
uniqueEventTypes = unique({EEG.event.type}');

% Obtain event indices whose 'type' is 'Probe'
allEventTypes = {EEG.event.type}';
task_begin_training_event_idx = find(strcmp(allEventTypes, 'task-begin-CSS-training')); % 165
task_end_training_event_idx = find(strcmp(allEventTypes, 'task-end-CSS-training')); % 166
task_begin_event_idx = find(strcmp(allEventTypes, 'task-begin-CSS')); % 167
task_end_event_idx = find(strcmp(allEventTypes, 'task-end-CSS')); % 312

% @error/warn !!1 sez there are no timestamps on the markers....