addpath( '../.' );

IN_PATH = './data/'
IN_MARKERS_FILENAME = 'markers.csv'

[marker, times] = read_neuropype_markers( [IN_PATH IN_MARKERS_FILENAME] );