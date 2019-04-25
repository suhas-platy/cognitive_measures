function myEEG = make_eeg_struct(varargin)
if (nargin == 0)   
   timeSeriesDataYouHave = zeros(5,2,1); % 3 channels x 2 timeslices x 1 epoch 
   timeSeriesDataLatencyYouHave = [1 2];
   eventLatencyInSecYouHave = [1 2]./1000;
   eventTypesYouHave = {'start', 'end'};
end

if (nargin==2)
   timeSeriesDataYouHave = varargin{1};
   timeSeriesDataLatencyYouHave = varargin{2};   
end
   
% Create empty EEG structure.
EEG = eeg_emptyset;

% Define basic items of EEG structure.
EEG        = eeg_emptyset();
EEG.data   = timeSeriesDataYouHave;
EEG.times  = timeSeriesDataLatencyYouHave;
EEG.xmin   = EEG.times(1);
EEG.xmax   = EEG.times(end);
EEG.srate  = round(1/((EEG.xmax-EEG.xmin)/length(EEG.times))); % Rounded actual sampling rate. Note that the unit of the time must be in second.
EEG.nbchan = size(EEG.data,1);
EEG.pnts   = size(EEG.data,2);

% Define event information.
% eventStructure = struct('type', [], 'latency', []);
% latencyValues  = num2cell(eventLatencyInSecYouHave*EEG.srate);
% [eventStructure(1:length(eventLatencyInSecYouHave)).latency] = latencyValues{:};
% eventTypes     = eventTypesYouHave;
% [eventStructure(1:length(eventLatencyInSecYouHave)).type] = eventTypes{:};
% EEG.event = eventStructure;
% EEG = eeg_checkset(EEG, 'eventconsistency');
% EEG = eeg_checkset(EEG, 'makeur');

myEEG = EEG;