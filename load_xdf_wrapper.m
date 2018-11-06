function [EEG, EEG_orig, MARKERS_orig] = load_xdf_wrapper( filename, varargin )
% @brief load XDF file and put it in EEGLab format

% Cognionics info
COGNIONICS_SRATE = 500;
COGNIONICS_SCALE = 1;
COGNIONICS_ELECTRODE_LABELS = {'F7', 'Fp1', 'Fp2', 'F8', 'F3',...
                               'Fz', 'F4', 'C3', 'Cz', 'P8',...
                               'P7', 'Pz', 'P4', 'T3', 'P3',...
                               'O1', 'O2', 'C4', 'T4', 'A2',...
                               'ACC20', 'ACC21', 'ACC22', 'PacketCounter', 'Trigger'};
COGNIONICS_KEEP_IDX = 1:20;
COGNIONICS_KEEP_IDX_NO_GROUND = 1:19;


% check inputs
opts = cell2struct(varargin(2:2:end),varargin(1:2:end),2);
HANDLE_CLOCK_SYNCHRONIZATION = false;
if isfield(opts,'HANDLE_CLOCK_SYNCHRONIZATION')
   HANDLE_CLOCK_SYNCHRONIZATION = opts.HANDLE_CLOCK_SYNCHRONIZATION;
end
SRATE = COGNIONICS_SRATE;
if isfield(opts,'SRATE')
   SRATE = opts.SRATE;
end
SCALE = COGNIONICS_SCALE;
if isfield(opts,'SCALE')
   SCALE = opts.SCALE;
end
ELECTRODE_LABELS = COGNIONICS_ELECTRODE_LABELS;
if isfield(opts,'ELECTRODE_LABELS')
   ELECTRODE_LABELS = opts.ELECTORDE_LABELS;
end
KEEP_IDX = COGNIONICS_KEEP_IDX;
if isfield(opts,'KEEP_IDX')
   KEEP_IDX = opts.KEEP_IDX;
end
KEEP_IDX_NO_GROUND = COGNIONICS_KEEP_IDX_NO_GROUND;
if isfield(opts,'KEEP_IDX_NO_GROUND')
   KEEP_IDX_NO_GROUND = opts.KEEP_IDX_NO_GROUND;
end
   
% EEG = eeg_load_xdf( curr_xdf_file ); % can't pass in HandleClockSynchronization so have to do it the hard way
streams = load_xdf( filename, 'HandleClockSynchronization', HANDLE_CLOCK_SYNCHRONIZATION );
EEG_orig = streams{1};
MARKERS_orig = streams{2};

% keep EEGLab happy (https://sccn.ucsd.edu/wiki/Makoto's_useful_EEGLAB_code#How_to_build_EEG_structure_.2807.2F13.2F2018_updated.29)
% EEG = eeg_emptyset();
% EEG.data = EEG_orig.time_series(KEEP_IDX,:) .* SCALE;
% EEG.times = EEG_orig.time_stamps;
% EEG.xmin = EEG_orig.time_stamps(1);
% EEG.xmax = EEG_orig.time_stamps(end);
% EEG.srate  = round(1/((EEG.xmax-EEG.xmin)/length(EEG.times))); % Rounded actual sampling rate. Note that the unit of the time must be in second.
% EEG.nbchan = size(EEG.data,1);
% EEG.pnts   = size(EEG.data,2);

EEG.trials = 1;
EEG.epoch = [];
EEG.event = [];
EEG.urevent = [];
EEG.chanlocs = [];
EEG.times = EEG_orig.time_stamps;
EEG.data = EEG_orig.time_series;
EEG.setname = 'XDF file';
EEG.icawinv = [];
EEG.icaweights = [];
EEG.icasphere = [];
EEG.nbchan = size( EEG_orig.time_series, 1 );
EEG.pnts = size( EEG_orig.time_series, 2 );
EEG.srate = SRATE;
EEG.xmin = EEG_orig.time_stamps(1);
EEG.xmax = EEG_orig.time_stamps(end);
EEG.icaact = [];
EEG.filepath = filename;
EEG.filename = 'xdf.set'

% drop non-EEG channels and set their labels
EEG.data = EEG.data( KEEP_IDX(1):KEEP_IDX(end), : );
EEG.nbcan = size( EEG.data, 1 );
for i = KEEP_IDX(1):KEEP_IDX(end)
  % if ( i == KEEP_IDX(1) )
  %    disp( 'first' );
  % end
  % if ( i == KEEP_IDX(end) )
  %    disp( 'last' );
  % end
  
  EEG.chanlocs(i).labels = ELECTRODE_LABELS{ i };
end

% events
MARKERS_remap = MARKERS_orig.time_stamps*EEG.srate;

eventStructure = struct('type', [], 'latency', []);
latencyValues  = num2cell(MARKERS_remap*EEG.srate);
[eventStructure(1:length(MARKERS_remap)).latency] = latencyValues{:};
eventTypes     = MARKERS_orig.time_series;
[eventStructure(1:length(MARKERS_remap)).type] = eventTypes{:};
EEG.event = eventStructure;
EEG = eeg_checkset(EEG, 'eventconsistency');
EEG = eeg_checkset(EEG, 'makeur');