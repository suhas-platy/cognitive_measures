% @brief Shell template for Matlab programs (use this when creating new shell scripts)

% function [OUT, varargout] = shell_template( IN, ALGO, varargin ) % can easily convert into a function

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ handle include paths
addpath( './support' );
%%%}}} eo-handle include paths

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ handle function parameters or command line arg's
%%%}}} eo-handle varargin or command line arg's

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ params (IN & ALGO)
disp( 'params' );

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ IN: input files, model parameters, etc.
IN.IN_PATH = './data/';
IN.IN_FILENAME = '31950218_dana_tasks_2018-09-05_12-31-52_1.SRT_0.h5.preprocessed.h5';
%%%}}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ ALGO: what do w/ IN and model
ALGO.TRACE_LEVEL = 1; % level of verbosity
ALGO.SAVE = 0;% whether or not to save results (sometimes can take a long
                     % time or don't want to overwrite existing saved files)
%%%}}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ with a JSON file
%%%}}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ trace param's
IN
ALGO
%%%}}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ derived "constants" or "internal" var's
fig_num = 1;
%%%}}}

%%%}}} eo-params (IN & ALGO)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ load data
disp( 'load data' );

fname = [IN.IN_PATH IN.IN_FILENAME];
mt_check_filename( fname );
disp( sprintf( 'loading file %s', fname ) );



%%%}}} eo-load data

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ calculate
disp( 'calculate' );

% minimal info and the structure seems to loop...
%info = h5info( fname )

disp = h5disp( fname ) % lots of detail
% /chunks/eeg/block has the data
% /chunks/eeg/block/axes has the axes
% /chunks/makers has the markers

%%%}}} eo-calculate

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ display
disp( 'display' );

%%%}}} eo-dispaly

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ save
disp( 'save' );

%%%}}} % eo-save