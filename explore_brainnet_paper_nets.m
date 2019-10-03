% @brief call brainnet - just control net

% control
IN.SURF_FILE = 'C:\Users\suhas\Desktop\prjs\BrainNetViewer_20181219\Data\SurfTemplate\BrainMesh_Ch2.nv';
IN.NODE_FILE = '.\conf\rois_posn_withLRdistinction_control_net_paper.node';
IN.EDGE_FILE = '.\conf\edge_withLRdistinction_control_net.edge';
IN.SAVE_FNAME = 'control_net_paper.jpg';

% attention
IN.SURF_FILE = 'C:\Users\suhas\Desktop\prjs\BrainNetViewer_20181219\Data\SurfTemplate\BrainMesh_Ch2.nv';
IN.NODE_FILE = '.\conf\rois_posn_withLRdistinction_attention_net_paper.node';
IN.EDGE_FILE = '.\conf\edge_withLRdistinction_attention_net.edge';
IN.SAVE_FNAME = 'attention_net_paper.jpg';

% attention
IN.SURF_FILE = 'C:\Users\suhas\Desktop\prjs\BrainNetViewer_20181219\Data\SurfTemplate\BrainMesh_Ch2.nv';
IN.NODE_FILE = '.\conf\rois_posn_withLRdistinction_default_net_paper.node';
IN.EDGE_FILE = '.\conf\edge_withLRdistinction_default_net.edge';
IN.SAVE_FNAME = 'default_net_paper.jpg';


IN.CONFIG_FILE = '.\conf\BrainNet_FullView.mat';
IN.CONFIG_FILE = '.\conf\BrainNet_RotView.mat';
IN.CONFIG_FILE = '.\conf\BrainNet_TopView_ForNet.mat';

IN.SAVE_PATH = './data_out/';

ALGO.SAVE = 1;

% draw and save
disp( sprintf( 'loading %s', IN.EDGE_FILE ) );
tval = load( IN.EDGE_FILE );

disp( 'close all BrainNet windows to continue' );
if ( ALGO.SAVE )
   save_fname = [IN.SAVE_PATH, IN.SAVE_FNAME];
   disp( sprintf( 'saving to %s', save_fname ) );

   BrainNet_MapCfg( IN.SURF_FILE, IN.NODE_FILE, IN.EDGE_FILE, IN.CONFIG_FILE, save_fname );
else
   BrainNet_MapCfg( IN.SURF_FILE, IN.NODE_FILE, IN.EDGE_FILE, IN.CONFIG_FILE );
end