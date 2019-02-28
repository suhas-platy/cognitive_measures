pre = rand(5,12*12);
post = rand(5,12*12);
sig_inc = (pre-post) > .1;
sig_dec = (pre-post) < .1;
bands = {'delta','theta','alpha','beta','gamma'};

from_to_labels = intheon_connection_labels();

figure(1);
make_matrix_diff_plot_images( pre, post, sig_inc, sig_dec, bands, from_to_labels );