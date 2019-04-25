a_mean = (1:40)
a_sem = .2*a_mean;

b_mean = a_mean .* (2/3);
b_sem = a_sem;

fig_num = 1;
h = plot_spectra( fig_num, a_mean, a_sem );

fig_num = fig_num+1;
A_mean = [a_mean; b_mean];
A_sem = [a_sem; b_sem];
h = plot_spectra( fig_num, A_mean, A_sem );


