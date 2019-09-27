% @brief call brainnet

IN.SURF_FILE = 'C:\Users\suhas\Desktop\prjs\BrainNetViewer_20181219\Data\SurfTemplate\BrainMesh_Ch2.nv';
IN.NODE_FILE = '.\conf\rois_posn_withLRdistinction.node';
IN.EDGE_FILE = '.\data_out\CSS_tier1_changes_delta.edge';
IN.CONFIG_FILE = '.\conf\BrainNet.mat';

IN.SAVE_PATH = './data_out/';
IN.SAVE_FNAME = 'view.jpg';

IN

% draw and save
fname = [IN.SAVE_PATH, IN.SAVE_FNAME];
BrainNet_MapCfg( IN.SURF_FILE, IN.NODE_FILE, IN.EDGE_FILE, IN.CONFIG_FILE, fname );