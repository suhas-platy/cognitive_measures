% @brief load XDF and get band power estimates

IN_PATH = 'C:\Data\fujitsu_flanker_data\09052018\09050118\'
COGNIONICS_SRATE = 500;
COGNIONICS_SCALE = 1;
COGNIONICS_ELECTRODE_LABELS = {'F7', 'Fp1', 'Fp2', 'F8', 'F3',...
                               'Fz', 'F4', 'C3', 'Cz', 'P8',...
                               'P7', 'Pz', 'P4', 'T3', 'P3',...
                               'O1', 'O2', 'C4', 'T4', 'A2',...
                               'ACC20', 'ACC21', 'ACC22', 'PacketCounter', 'Trigger'};
COGNIONICS_KEEP_IDX = 1:20;
COGNIONICS_KEEP_IDX_NO_GROUND = 1:19;

ATTN_ELECTRODE = 15
FRAMES = 500

% load
xdf_files = dir( [IN_PATH filesep '*.xdf'] );
curr_xdf_file = [IN_PATH filesep xdf_files(1).name]

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = load_xdf_wrapper( curr_xdf_file );

% get channel locn's; it seems you have to redo this (Edit->Channel Locn's; to check it's set, do Plot->Channel Locn's->By Name)
EEG=pop_chanedit(EEG, 'lookup','C:\\Program Files\\eeglab_current\\eeglab14_1_2b\\plugins\\dipfit2.3\\standard_BESA\\standard-10-5-cap385.elp');
[ALLEEG, EEG, CURRENTSET] = eeg_store(ALLEEG, EEG, 0);
EEG = eeg_checkset( EEG );

% remove baseline from each channel
%EEG = eeg_checkset( EEG );
%EEG = pop_rmbase( EEG, [0           EEG.pnts]);
%[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);

% save and plot
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
EEG = eeg_checkset( EEG );
pop_eegplot( EEG, 1, 1, 1);


% calcuate 
nSec = (EEG.xmax-EEG.xmin) / EEG.srate
floor_nSec = floor( nSec );
%[spectra,freqs] = spectopo(EEG.data(ATTN_ELECTRODE,1:floor_nSec*EEG.srate),
%FRAMES, EEG.srate);
d = [];
t = [];
a = [];
b = [];
g = [];
for s = 1:(floor_nSec*4)-1
   s_t = (s-1)*(EEG.srate/4)+1;
   e_t = (s)*(EEG.srate/4);

   [d_tmp,t_tmp,a_tmp,b_tmp,g_tmp] = freq_measures( EEG.data(ATTN_ELECTRODE, s_t:e_t),...
                                                    'FRAMES', FRAMES/4, 'SRATE', EEG.srate)
   %[d(s), t(s), a(s), b(s), g(s)] = deal( [d_tmp,t_tmp,a_tmp,b_tmp,g_tmp] );
   d = [d d_tmp];
   t = [t t_tmp];
   a = [a a_tmp];
   b = [b b_tmp];
   g = [g g_tmp];
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% always end w/ redraw
eeglab redraw