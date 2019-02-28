% @brief test of intheon_to_xlsx_connectivity

mat = reshape( 1:12*12*5*4, 12,12,5,4 );
col_hdr = {'Tier_1_After', 'Tier_1_Before', 'Tier_2_After', 'Tier_2_Before'};
col_hdr2 = {'_delta', '_theta', '_alpha', '_beta', '_gamma'};

% make col headers
combined_col_hdr = {};
ctr = 1;
for j = 1:size(col_hdr2,2)
   for i = 1:size(col_hdr,2)
      combined_col_hdr{ctr} = strcat( col_hdr{i}, col_hdr2{j} );
      ctr = ctr+1;
   end
end

% make row headers
anat_label{1} = 'ant_cin_l';
anat_label{3} = 'dorlat_pf_l'
anat_label{5} = 'inf_par_l';
anat_label{7} = 'lat_ocp_l';
anat_label{9} = 'orb_pf_l';
anat_label{11} = 'pre_cent_l';
for i = 2:2:12
   anat_label{i} = strrep( anat_label{ i-1 }, '_l', '_r' );
end

ctr = 1;
for i = 1:12
   for j = 1:12
      from_to_label{ctr} = ['From__', anat_label{i}, '__To__', anat_label{j}];
      ctr = ctr+1;
   end
end

% load the data
IN.IN_PATH = 'C:\Users\suhas\Go Platypus Dropbox\Science And Research\Fujitsu\Dec. 2018 Reports\v10\';
IN.IN_FILEZ = ["tpi_fuj_SRT1_group_analysis_ttest_db_conn_2-15.mat"];

f = 1;
fname = strcat( IN.IN_PATH, IN.IN_FILEZ{f} )
mt_check_filename( fname );
disp( sprintf( 'loading file %s', fname ) );
tmp_data = load( fname );
data{f} = tmp_data.data;
tier1_conn = data{f}.connectivity.tier1.values.chunks.eeg_dDTF08.block.data;
mat = tier1_conn;
mat = mat(:,:,:,:,1); % get means

% write it out
T = intheon_to_xlsx_connectivity( './test_connectivity.xlsx', mat, combined_col_hdr, from_to_label );