% @brief explore head model file

IN.ROI = 'rostralanteriorcingulate R'
IN.ROI = 'lateraloccipital L'

data = load( 'C:\Users\suhas\Go Platypus Dropbox\Projects\EPS Assesment\Subject Data Room\Corporate\Fujitsu\Dec. 2018 Reports\v11\tpi_fuj_CSS_group_analysis_ttest_db_conn_2-20.mat' );
data = data.data;
hm = load( 'C:\Program Files\Intheon\NeuroPype Enterprise Suite\NeuroPype\resources\headmodels\Colin-339ch-4495v-scalar-4shell-1.1.hm', '-mat' );

% units are mm; pos x is right; pos y is front; pos z is up
hm.meta.coordinates

% find where label is IN.ROI
idx = [];
for i = 1:length(hm.atlases.labels)
   curr_lbl = hm.atlases.labels{i};
   if ( ~isempty( strfind( curr_lbl, IN.ROI ) ) )
      idx = [idx i];
   end
end
idx
% from labels to vertex indices
idx = hm.atlases.labeling( idx )

% get locn's
hm_meshes = hm.meshes(1).vertices; % brain; get around akward indexing

locn = [];
for i = 1:length(idx)
  locn(i,:) = hm_meshes( idx(i),: );
end
locn

disp( 'min' );
min( locn )

disp( 'max' )
max( locn )

disp( 'check these locn''s w/ what''s in C:\Users\suhas\Desktop\prjs\BrainNetViewer_20181219\Data\ExampleFiles\Desikan-Killiany68\Desikan-Killinay68.csv or .node' );
