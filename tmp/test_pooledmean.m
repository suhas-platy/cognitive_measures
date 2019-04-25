mean_mat = [  8  9  8  8 7;
             12 11 10 10 9;
             10 12 12 13 14];
std_mat = [ 4  4  3  3  4;
            5  4  3  3  4;
            3  2  2  2 3];
mean( mean_mat )
std( mean_mat )

for i = 1:5
   [a,b,c] = pooledmeanstd_loop( [1;1;1], mean_mat(:,i), std_mat(:,i) )
end
