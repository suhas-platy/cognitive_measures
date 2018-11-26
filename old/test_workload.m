%% --- load and curate the data (runs once) ---
% this is the directory where the competition data has been extracted
studypath = '/data/cta/users/christian/CSAC/'; 

for s=1:32
    % load .mat file
    load(sprintf('%sCSAC2011_DataSet_%i/CSAC2011_TrainingSet_%i.mat',studypath,s,s));
    % create data set
    set = exp_eval(set_new('data',[train.low train.high],'chanlocs',train.features','srate',256));
    % insert markers in low / high section
    cut = length(train.low)/(length(train.low)+length(train.high));
    xmax = set.xmax;
    set = set_insert_markers(set, 'SegmentSpec',{0 cut*xmax}, 'Count',1,'Counting','persecond','Event','low','Placement','equidistant');
    set = set_insert_markers(set, 'SegmentSpec',{cut*xmax xmax}, 'Count',1,'Counting','persecond','Event','high','Placement','equidistant');
    % save to disk
    pop_saveset(exp_eval(set),'filename',sprintf('CSAC2011_TrainingSet_%i.set',s),'filepath',studypath);
end

%% --- run a batch analysis ---
studypath = '/data/cta/users/christian/CSAC/';
epoch = [-6 6];
freqwnds = [0.5 3; 4 7; 8 12; 13 30; 31 42];
approaches = [];

% --- original analyses for EMBC paper [1] ---
% Note: this script is a rewrite of the original analysis script for use with more recent versions of BCILAB
% [1] Kothe, Christian A., and Scott Makeig. "Estimation of task workload from EEG data: new and current tools and perspectives." Engineering in Medicine and Biology Society, EMBC, 2011 Annual International Conference of the IEEE. IEEE, 2011.

% Overcomplete Spectral Regression (OSR)
approaches.OSR = {'DataflowSimplified', 'SignalProcessing',{'IIRFilter',{[0.1 2],'highpass'}, 'EpochExtraction',epoch, 'Projection','on', 'SpectralTransform', {{'multitaper',8},true,true}, 'EpochPCA',20, ...
    'ICA',{{'amica','version','stable11', 'num_models',3, 'useqsub','on', 'numprocs',32, 'max_iter',500, 'max_init_waiting',2000, 'max_restarts',20, 'fallback_reduce',0.3}}}, ...
    'Prediction',{'MachineLearning',{'Learner',{'logreg','variant','lars'}}}}; 
% OSR with EOG removal
approaches.OSReog = {'DataflowSimplified', 'SignalProcessing',{'EOGRemoval','on', 'IIRFilter',{[0.1 2],'highpass'}, 'EpochExtraction',epoch, 'Projection','on', 'SpectralTransform',{{'multitaper',8},true,true}, 'EpochPCA',20, ...
    'ICA',{{'amica','version','stable11', 'num_models',3, 'useqsub','on', 'max_iter',500, 'max_init_waiting',2000, 'max_restarts',20, 'fallback_reduce',0.3}}}, ...
    'Prediction',{'MachineLearning',{'Learner',{'logreg','variant','lars'}}}}; 

% fixed-bands Log-Power with Least-Angle Regression on channels
approaches.MBLP_LARS = {'Spectralmeans', 'SignalProcessing',{'EOGRemoval','on','EpochExtraction',epoch,'WindowSelection','hann','SpectralTransform',{{'multitaper',8},true,true}}, 'Prediction',{'FeatureExtraction',{'FreqWindows',freqwnds}, ...
    'MachineLearning',{'Learner', {'logreg','variant','lars'}}}};
% fixed-bands Log-Power with Least-Angle Regression on surface Laplacian derivations
approaches.MBLP_LARS_SL = {'Spectralmeans', 'SignalProcessing',{'EOGRemoval','on','SurfaceLaplacian','on','EpochExtraction',epoch,'WindowSelection','hann','SpectralTransform',{{'multitaper',8},true,true}}, 'Prediction',{'FeatureExtraction',{'FreqWindows',freqwnds,'WindowFunction','hann'}, ...
    'MachineLearning',{'Learner', {'logreg','variant','lars'}}}};
% adaptive-bands Log-Power with Least-Angle Regression on channels
approaches.MTDC_LARS = {'DataflowSimplified', 'SignalProcessing',{'EOGRemoval','on', 'IIRFilter',{[0.1 2],'highpass'}, 'EpochExtraction',epoch, 'WindowSelection','hann', 'Projection','on', 'SpectralTransform',{{'multitaper',8},true,true}, 'EpochPCA',20}, ...
    'Prediction',{'MachineLearning',{'Learner',{'logreg','variant','lars'}}}}; 
% LARS on raw channels
approaches.MT_LARS = {'DataflowSimplified', 'SignalProcessing',{'EOGRemoval','on', 'IIRFilter',{[0.1 2],'highpass'}, 'EpochExtraction',epoch, 'WindowSelection','hann', 'Projection','on', 'SpectralTransform',{{'multitaper',8},true,true}, 'EpochPCA',20}, ...
    'Prediction',{'MachineLearning',{'Learner',{'logreg','variant','lars'}}}}; 
% Filter-Bank CSP using (shrinkage) LDA
approaches.FCSP_LDA = {'FBCSP' 'SignalProcessing',{'EOGRemoval','on', 'EpochExtraction',epoch}, ...
    'Prediction',{'FeatureExtraction',{'FreqWindows',freqwnds,'WindowFunction','hann'}}};
% Filter-Bank CSP using variational Bayesian logistic regression with automatic relevance determination
approaches.FCSP_VBARD = {'FBCSP' 'SignalProcessing',{'EOGRemoval','on', 'EpochExtraction',epoch}, ...
    'Prediction',{'FeatureExtraction',{'FreqWindows',freqwnds,'WindowFunction','hann'},'MachineLearning',{'Learner',{'logreg','variant','vb-ard'}}}}; 
% Filter-Bank CSP using hierarchical kernel learning
approaches.FCSP_HKL = {'FBCSP' 'SignalProcessing',{'EOGRemoval','on', 'EpochExtraction',epoch}, ...
    'Prediction',{'FeatureExtraction',{'FreqWindows',freqwnds,'WindowFunction','hann'},'MachineLearning',{'Learner','hkl'}}}; 
% Filter-Bank covariance-based rank-regularized logistic regression (dual-augmented Lagrangian)
approaches.FB_DAL = {'DAL', 'SignalProcessing',{'EOGRemoval','on', 'EpochExtraction',epoch}, ...
    'Prediction',{'FeatureExtraction',{'WindowFreqs',freqwnds, 'WindowFunction','hann'}}};
% Wide-band filtered Common Spatial Patterns
approaches.WB_CSP = {'CSP' 'SignalProcessing',{'EpochExtraction',epoch}};
% Wide-band filtered Spectrally weighted Common Spatial Patterns
approaches.WB_SpecCSP = {'SpecCSP' 'SignalProcessing',{'EpochExtraction',epoch}};

% --- newer approaches ---

% LARS with elastic net regulariation on raw multi-taper log-spectrum of stationary components
approaches.STATCOMP_LARSEN_SPEC = {'DataflowSimplified', 'SignalProcessing',{'EOGRemoval','on', 'IIRFilter',{[0.1 2],'highpass'}, 'EpochExtraction',epoch, 'SpectralTransform',{'multitaper',true,false,80}, 'Resampling',100, 'StationarySubspace',{'Operation','separate'}}, ...
    'Prediction','MachineLearning',{'Learner',{'logreg','variant',{'lars','ElasticMixing',search(0.1:1:1)}}}};
% LARS with elastic net regulariation on raw multi-taper log-spectrum of channels
approaches.STATCOMP_LARSEN_CHN = {'DataflowSimplified', 'SignalProcessing',{'EOGRemoval','on', 'IIRFilter',{[0.1 2],'highpass'}, 'EpochExtraction',epoch, 'SpectralTransform',{'multitaper',true,false,80}, 'Resampling',100}, ...
    'Prediction','MachineLearning',{'Learner',{'logreg','variant',{'lars','ElasticMixing',search(0.1:1:1)}}}};
% LARS with elastic net regulariation on raw multi-taper log-spectrum and coherence of stationary components
approaches.STATCOMP_LARSEN_COH = {'DataflowSimplified', 'SignalProcessing',{'EOGRemoval','on', 'IIRFilter',{[0.1 2],'highpass'}, 'EpochExtraction',epoch, 'StationarySubspace',{'Operation','separate'},'SpectralTransform','off','CoherenceTransform',{'LogTransform',true}},  ...
    'Prediction',{'FeatureExtraction',{'FreqWindows',[4 7; 8 15; 15 25; 7 30]},'MachineLearning',{'Learner',{'logreg','variant',{'lars','ElasticMixing',0.5}}}}};
% OSR updated to use Reconstruction ICA (experimental -- RICA may need some tuning of settings to converge properly)
approaches.OSRrica_test = {'DataflowSimplified', 'SignalProcessing',{'IIRFilter',{[0.1 2],'highpass'}, 'EpochExtraction',epoch, 'Projection','on', 'SpectralTransform', {{'multitaper',8},true,true}, 'EpochPCA',20, ...
    'ICA',{'Variant',{'rica','NumComponents',60}}},'Prediction',{'MachineLearning',{'Learner',{'logreg','variant','lars'}}}}; 

% --- run the analysis ---

results = bci_batchtrain('StudyTag','WorkloadCSAC','Data',[studypath '*.set'],'Approaches',approaches,'TargetMarkers',{'low','high'},'ReuseExisting',true, ...
    'TrainArguments',{'EvaluationScheme',{'subchron',2,5,15},'OptimizationScheme',{'subchron',2,5,15}});
