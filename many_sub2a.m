% closed - open

t1_open = load( './tier2_open.mat' );
t1_closed = load( './tier2_closed.mat' );

subtract = load( './tier1_closed.mat' ); % 2500
subtract_from = load( './tier1_closed_before.mat' ); % 5000

%subtract = load( './tier2_closed.mat' ); % 2500
%subtract_from = load( './tier2_closed_before.mat' ); % 5000

diffEEG = subtract.EEG;
diffEEG.data = subtract_from.EEG.data(:,1:2500,:) - subtract.EEG.data(:,1:2500,:);
EEG = diffEEG;

figure; pop_topoplot_clip(EEG, 1, [-4000:1000:0] ,'EDF file epochs',[2 3] ,0,'electrodes','on');


figure; pop_spectopo(EEG, 1, [-10000     -2], 'EEG' , 'percent', 15, 'freq', ...
                     [2.5 6 10.5  43/2. 75/2.], 'freqrange',[2 25],'electrodes','off');

figure; pop_newtimef( EEG, 1, 1, [-10000   0], [3         0.5] , 'topovec', 1, 'elocs', EEG.chanlocs, 'chaninfo', EEG.chaninfo, 'caption', 'F3', 'baseline',[0], 'plotphase', 'off', 'padratio', 1, 'winsize', 1024);

% bandpass then ...
figure; topoplot( reshape( diffEEG.data(:,:,1), [1,numel(diffEEG.data(:,:,1))] ),...
                          diffEEG.chanlocs);