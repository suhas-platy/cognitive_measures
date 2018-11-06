function [deltaPower, thetaPower, alphaPower, betaPower, gammaPower] = ...
       get_band_power( EEG, varargin )

% @brief get band power estimates from EEG
   
% check inputs
  opts = cell2struct(varargin(2:2:end),varargin(1:2:end),2);
  ELECTRODE = 1;
  if isfield(opts,'ELECTRODE')
    ELECTRODE = opts.ELECTRODE;
  end   
  
  % S_T = 1;
  % if isfield(opts,'S_T')
  %   S_T = opts.S_T;
  % end  

  % E_T = floor(EEG.data(ELECTRODE,2)/EEG.srate);
  % if isfield(opts,'E_T')
  %   E_T = opts.E_T;
  % end  
  
  FRAMES = -1;
  if isfield(opts,'FRAMES')
    FRAMES = opts.FRAMES;
  end  

  SRATE = -1;
  if isfield(opts,'SRATE')
    SRATE = opts.SRATE;
  end  
  
  [spectra,freqs] = spectopo(EEG, FRAMES, SRATE);
   
  % Set the following frequency bands: delta=1-4, theta=4-8, alpha=8-13, beta=13-30, gamma=30-80.
  deltaIdx = find(freqs>1 & freqs<4);
  thetaIdx = find(freqs>4 & freqs<8);
  alphaIdx = find(freqs>8 & freqs<13);
  betaIdx  = find(freqs>13 & freqs<30);
  gammaIdx = find(freqs>30 & freqs<80);

% Compute absolute power.
  deltaPower = mean(10.^(spectra(deltaIdx)/10));
  thetaPower = mean(10.^(spectra(thetaIdx)/10));
  alphaPower = mean(10.^(spectra(alphaIdx)/10));
  betaPower  = mean(10.^(spectra(betaIdx)/10));
  gammaPower = mean(10.^(spectra(gammaIdx)/10));   