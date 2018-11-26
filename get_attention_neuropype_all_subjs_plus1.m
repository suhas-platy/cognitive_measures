% @brief process MAT files; summary across subjs

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ handle include paths
addpath( './support' );
addpath( './support/Enhanced_rdir' );

%%%}}} eo-handle include paths

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ params (IN & ALGO)
IN.PATH = 'C:\Data\fujitsu_flanker_data\';
IN.FILE_FILTER = '\**\*.xdf'

IN.SAVE_PATH = './';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ trace param's
IN
%%%}}}

%%%}}} eo-params (IN & ALGO)

fig_num = 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ calculate
files = rdir( [IN.PATH, IN.FILE_FILTER] );

% work on MAT files
for f = 1:size( files ) % for each subject (1 file per subject)
   if ( f > 20 )
      break;
   end
   
   curr_fname = files(f).name;
   [filepath,filename,fileext] = fileparts( curr_fname );
   disp( sprintf( 'filepath = %s', filepath ) );
   
   foo = [filepath filesep filename '.mat'];
   disp( foo )
   load( foo );
   
   corr(f) = sum( OUT.corr );
   block_corr(f,:) = OUT.block_corr;
   block_corr_pdiff(f,:) = 100*(block_corr(f,:)-block_corr(f,1))./block_corr(f,1);
   
   block_avg_freq(f,:,:,:) = OUT.block_avg_freq; % 20x5x10
   block_avg_attn(f,:,:) = OUT.block_avg_attn; % 20x10
   for c = 1:20
     block_avg_attn_pdiff(f,c,:) = 100.*(block_avg_attn(f,c,:)-block_avg_attn(f,c,1))./block_avg_attn(f,c,1);
     avg_attn(f,c) = mean( block_avg_attn(f,c,:) );
   end
end

% find high and low performer
[min_corr,min_corr_idx] = min( corr );
[max_corr,max_corr_idx] = max( corr );

[sorted_corr,sorted_corr_idx] = sort( corr );
min_corr_idx = sorted_corr_idx(1)
max_corr_idx = sorted_corr_idx(end-1) % problem w/ end's data
max_corr_idx = 2
figure(fig_num); fig_num = fig_num +1;
hist( corr );

colors = jet( 20 );
for f = 1:size( files )
   if ( f > 20 )
      break;
   end
   
   if ( f == min_corr_idx )
      i = 1
   end
   %if ( f == max_corr_idx )
   if ( f == max_corr_idx )
      i = 2
   end
   if ( f == min_corr_idx || f == max_corr_idx )
   %c = 1;
   tmp = squeeze( mean( block_avg_attn(f,c,:),2 ) ); % 1x20x10->1x10
   figure((i-1)*4+2); plot( tmp ); hold on;
   title( ['Block attention (x is block, y is attention) for subject ' num2str(f)]);
   
   tmp = squeeze( mean( block_avg_attn_pdiff(f,c,:),2 ) );
   figure((i-1)*4+3); plot( tmp' ); hold on;
   title( ['Block percent changes in attention (x is block, y is change in attention) for subject ' num2str(f)]);
   %figure((i-1)*4+4); plot( block_corr(f,:), 'Color', colors(f,:), 'LineStyle', '--' ); hold on;

   figure((i-1)*4+4); plot( block_corr(f,:), 'LineStyle', '--' ); hold on;
   title( ['Block correct (x is block, y is # correct) for subject ' num2str(f)]);

   %figure((i-1)*4+5); plot( block_corr_pdiff(f,:), 'Color', colors(f,:), 'LineStyle', ':' ); hold on;
   figure((i-1)*4+5); plot( block_corr_pdiff(f,:), 'LineStyle', ':' ); hold on;
   title( ['Block percent changes in correct correct (x is block, y is change in # correct) for subject ' num2str(f)]);
   end
end

for f = 1:size( files )
   if ( f > 20 )
      break;
   end
   
   for c = 1:20
      [R_tmp,P_tmp] = corrcoef( squeeze(block_avg_attn(f,c,:))', block_corr(f,:) );
      R(f,c) = R_tmp(1,2);
      P(f,c) = P_tmp(1,2);
   
      [R_tmp,P_tmp] = corrcoef( squeeze(block_avg_attn_pdiff(f,c,:))', block_corr(f,:) );
      R_pdiff(f,c) = R_tmp(1,2);
      P_pdiff(f,c) = P_tmp(1,2);   
   
      [R_tmp,P_tmp] = corrcoef( squeeze(block_avg_attn_pdiff(f,c,:))', block_corr_pdiff(f,:) );
      R_pdiff2(f,c) = R_tmp(1,2);
      P_pdiff2(f,c) = P_tmp(1,2);
   end
end

F = sum( block_avg_attn, 3 )
F2 = squeeze( F );
F2 = sum( F2, 2 );

figure;
plotyy( 1:20, F2', 1:20, corr );
title( 'Average attention (blue) vs. average correct (red) (x is subject)' );

% figure;
% for f = 1:3
%    if ( f==1 )
%       ff = 5;
%    elseif ( f==2 )
%       ff = 7;
%    else
%       ff = 14;
%    end
   
%    plot( 1:10, squeeze( block_avg_attn_pdiff(ff,:) ), 'Color', colors(f,:) ); hold on;
%    %plot( 1:10, squeeze( block_corr_pdiff(ff,:) ), 'Color', colors(f,:), '--' ); hold on;
% end
