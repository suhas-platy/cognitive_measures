mat = rand(19,4);
col_hdr = {'T1A', 'T1B', 'T2A', 'T2B'};
for i = 1:19
   electrode_label{i} = cognionics_index_to_name( i );
end

electrode_label

T = intheon_to_csv( './test.csv', mat, col_hdr, electrode_label );