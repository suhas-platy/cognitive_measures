pre = rand(5,12*12);
post = rand(5,12*12);
bands = {'delta','theta','alpha','beta','gamma'};

from_to_labels = intheon_connection_labels();

figure(1);
make_matrix_diff_plot_bars( pre, post, bands, from_to_labels );