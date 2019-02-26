pre = rand(5,12);
post = rand(5,12);
bands = {'delta','theta','alpha','beta','gamma'};
for i = 1:12
   anat_label{i} = intheon_index_to_name( i );
end

figure(1);
make_matrix_diff_plot_bars( pre, post, bands, anat_label );