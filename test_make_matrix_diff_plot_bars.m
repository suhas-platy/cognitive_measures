pre = rand(5,12);
post = rand(5,12);
bands = {'delta','theta','alpha','beta','gamma'};

figure(1);
make_matrix_diff_plot_bars( pre, post, bands );