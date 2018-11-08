addpath( '../' );

%%%{{{ IN: input files, model parameters, etc.
IN.PATH = 'C:\Users\suhas\Desktop\prjs\cognitive_measures\tests\data\';
IN.FREQ_OUT_FILENAME = 'freq_out.csv';
IN.MARKERS_FILENAME = 'markers.csv';

IN.SAVE_PATH = 'C:\Users\suhas\Desktop\prjs\cognitive_measures\tests\data\';
IN.SAVE_FNAME = 'save.mat';
%%%}}}

%%%{{{ ALGO: what do w/ IN and model
ALGO.TRACE = 0;
ALGO.SAVE = 1;
%%%}}}

[OUT] = test_attention_neuropype( IN, ALGO );