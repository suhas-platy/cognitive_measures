% @brief test of intheon_to_xlsx

mat = reshape( 1:8*19*4, 8,19,4 );
col_hdr = {'Tier_1_After', 'Tier_1_Before', 'Tier_2_After', 'Tier_2_Before'};
col_hdr2 = {'_delta', '_theta', '_alpha', '_beta', '_gamma',...
            '_attention', '_workload', '_memory'};
%col_hdr2 = {'delta_', 'theta_', 'alpha_', 'beta_', 'gamma_',...
%            'attention_', 'workload_', 'memory_'};

% make col headers
combined_col_hdr = {};
ctr = 1;
for j = 1:8
   for i = 1:4
      combined_col_hdr{ctr} = strcat( col_hdr{i}, col_hdr2{j} );
      ctr = ctr+1;
   end
end


% make row headers
for i = 1:19
   electrode_label{i} = cognionics_index_to_name( i );
end

% load the data
IN.IN_PATH = 'C:\Users\suhas\Go Platypus Dropbox\Science And Research\Fujitsu\Dec. 2018 Reports\v8\';
IN.IN_FILEZ = ["tpi_fuj_SRT2_group_analysis__1-30_db_ttest.mat"];

f = 1;
fname = strcat( IN.IN_PATH, IN.IN_FILEZ{f} )
mt_check_filename( fname );
disp( sprintf( 'loading file %s', fname ) );
tmp_data = load( fname );
data{f} = tmp_data.data;
channels_band_power_data{f} = data{f}.channels.bands_power_db.chunks.eeg.block.data
mat = channels_band_power_data{f};
mat = mat(:,:,:,1); % get means

% write it out
T = intheon_to_xlsx( './test.xlsx', mat, combined_col_hdr, electrode_label );