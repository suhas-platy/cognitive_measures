load( 'EEG_sample.mat' ); % EEG struct after running one_subj2.m

%figure;pop_topoplot(EEG, 1, -10000,'',[1 1] ,0,'electrodes','on'); % this will work; says the valid indices are -10000 to -2
%    SIGTMP = reshape(EEG.data, EEG.nbchan, EEG.pnts,
%    EEG.trials);
% 20        5000           3: ...
% 20: 20
% 1     1: 5000
% 1     1: 3

newEEGdata_data = rand(20,1);
newEEGdata_times = [1];
newEEGdata = make_eeg_struct( newEEGdata_data, newEEGdata_times );
newEEGdata = eeg_checkset( newEEGdata ); % minor fixes

newEEGdata = EEG;
%newEEGdata.data = rand(20,1,1);

%ptr = newEEGdata.data;
%ptr(:,1,1) = 1:20;

newEEGdata.times = [1];
newEEGdata.xmin = 1;
newEEGdata.xmax = 1;
newEEG.pnts = 1;
newEEG.trials = 1;
newEEGdata = eeg_checkset( newEEGdata ); % minor fixes; hit cancel in the dialog box


newEEGdata = EEG;
my_data = rand(20,1);
my_data = (1:20)'./20;
newEEGdata.data = repmat( my_data, 1, 5000, 3 );
%newEEGdata = eeg_checkset( newEEGdata );

%figure;pop_topoplot(newEEGdata);
figure;pop_topoplot(newEEGdata, 1, -10000,'',[1 1] ,0,'electrodes','on');
