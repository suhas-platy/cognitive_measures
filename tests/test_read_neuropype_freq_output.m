addpath( '../.' );

IN_PATH = './data/'
IN_FILENAME = 'freq_out.csv'

[freq,timestamps,t0,tf,delta,num_t] = read_neuropype_freq_output( [IN_PATH IN_FILENAME] );