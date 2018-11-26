% @brief get band power estimates from Neuropype output

function [OUT, varargout] = get_attention_neuropype_one_subj( IN, ALGO, varargin )

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ handle include paths
addpath( './support' );
%%%}}} eo-handle include paths

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ params (IN & ALGO)
disp( 'params' );

% check inputs
opts = cell2struct(varargin(2:2:end),varargin(1:2:end),2);

BAND(1,:) = [1 4]; % >= and < % todo make a param
BAND(2,:) = [4 8];
BAND(3,:) = [8 13];
BAND(4,:) = [13 30];
BAND(5,:)  = [30 80];
N_BANDS = size(BAND,1);

BAND_NAME{1} = 'Delta';
BAND_NAME{2} = 'Theta';
BAND_NAME{3} = 'Alpha';
BAND_NAME{4} = 'Beta';
BAND_NAME{5} = 'Gamma';

N_CHNLS = IN.N_CHNLS;

MAX_DB = 250;
FREQ_STEP = 1/3;

BLOCKS = 10;
TRIALS_PER_BLOCK = 42;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ trace param's
%IN
%ALGO
%%%}}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ derived "constants" or "internal" var's
fig_num = 1;
%%%}}}

%%%}}} eo-params (IN & ALGO)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ load data
disp( 'load data' );

[freq,timestamp,t0,tf,delta_t,num_t] = read_neuropype_freq_output( [IN.IN_PATH, IN.FREQ_OUT_FILENAME] );
% freq will be n_times x n_freq_bins+1
% n_freq_bins is n_chnls * 750
N_FREQS_PER_CHNL = size( freq, 2 )/N_CHNLS;
[marker, marker_time] = read_neuropype_markers( [IN.IN_PATH, IN.MARKERS_FILENAME] );
%%%}}} eo-load data

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ calculate
disp( 'calculate' );

% markers
block_start_marker_idx = find( marker == 'block-begin' );
block_start_t = marker_time( block_start_marker_idx );

block_end_marker_idx = find( marker == 'block-end' );
block_end_t = marker_time( block_end_marker_idx );

trial_idx = find( marker == 'trial-end' );
resp_idx = trial_idx-1;

OUT.block_start_t = block_start_t;
OUT.block_end_t = block_end_t;

% define bands
for i = 1:N_BANDS
   tmp_band = BAND(i,:);
   band_idx(i,:) = [tmp_band(1)/FREQ_STEP, tmp_band(2)/FREQ_STEP];
end

% get averages for bands
for i = 1:N_BANDS
  tmp_idx = band_idx(i,:);
  for c = 1:N_CHNLS
    s_tmp_idx = (c-1)*N_FREQS_PER_CHNL+tmp_idx(1); % todo check this indexing
    e_tmp_idx = (c-1)*N_FREQS_PER_CHNL+tmp_idx(2);
    tmp_avg = mean( freq(:, s_tmp_idx:e_tmp_idx ), 2 ); % avg. over the bins
    avg_freq(c,i,:) = tmp_avg'; % transpose so it's 1 x T
  
    % clip large values
    avg_freq(c,i,:) = min( avg_freq(c,i,:), MAX_DB );
  end
end
OUT.avg_freq = avg_freq;

% get attention (beta/theta)
for c = 1:N_CHNLS
  attn(c,:) = avg_freq(c,2,:) ./ avg_freq(c,4,:);
end
OUT.attn = attn;

% block averages for bands and attention
for i = 1:size( block_start_marker_idx, 2 )
   s = round( block_start_t(i)-t0 );
   e = round( block_end_t(i)-t0 );
   block_len = e-s+1;
   
   for c = 1:N_CHNLS
     tmp = mean( avg_freq(c,:,s:e), 3 ); % 1 x N_BANDS
     %if ( size(tmp,2) > block_len )
     %    tmp = tmp(:,1:block_len);
     %end
     block_avg_freq(c,:,i) = squeeze( tmp ); % chnl x band x block
     
     tmp = mean( attn(c,s:e), 2 );
     block_avg_attn(c,i) = squeeze( tmp ); % chnl x block
   end
end
OUT.block_avg_freq = block_avg_freq;
OUT.block_avg_attn = block_avg_attn;

% # correct
for i = 1:size( resp_idx, 2 )
   if ( marker( resp_idx(i) ) == 'response-was-correct' )
      corr(i) = 1;
   else
      corr(i) = 0;
   end
end
OUT.corr = corr;

% block # correct
for i = 1:size( block_start_marker_idx, 2 );
   s = (i-1)*TRIALS_PER_BLOCK+1;
   e = i*TRIALS_PER_BLOCK;
   block_corr(i) = sum( corr(s:e) );
end
OUT.block_corr = block_corr;
%%%}}} eo-calculate

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ display
disp( 'display' );

% bands
colors = jet( N_BANDS ); % these colors are fairly similar but the 2nd best
                         % colormap (hsv) is a bit of an eyesore

if ( ALGO.TRACE )
figure(fig_num);
legend_str = [];
for i = 1:N_BANDS
   for c = 1:N_CHNLS
     plot( squeeze(avg_freq(c,i,:)), 'Color', colors(i,:) ); hold on;
   end
   legend_array(i) = string( BAND_NAME{i} ); % use new "string arrays" in Matlab
end
title( 'Bands' );
legend( legend_array );

% attention
fig_num = fig_num + 1;
figure(fig_num);
for c = 1:N_CHNLS
  plot( attn(c,:) ); hold on;
end
title( 'Attention (theta/beta)' );

for i = 1:size(block_end_marker_idx,2)
   t = marker_time(block_end_marker_idx(i)) - t0;
   mt_vline( t );
end

end % fi ALGO.TRACE
%%%}}} eo-display

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ save
disp( 'save' );

if ( ALGO.SAVE )
  fname = [IN.SAVE_PATH IN.SAVE_FNAME]; % can also do fname = sprintf( '%s%d.mat', INPUT.SAVE_FNAME, parameterOrRunNumber );
  disp( ['fname ' fname] );
  save( fname, 'OUT' );
else
  disp( 'ALGO.SAVE off; not saving' );
end
%%%}}} % eo-save