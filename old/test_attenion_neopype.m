% @brief plot output of NeuroPype freq.'s

BAND(1,:) = [1 4]; % >= and <
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

CAP = 250;

IN_PATH = 'C:\Users\suhas\Desktop\prjs\golf_processing\src\'
IN_FILENAME = 'untitled2.csv'

IN_MARKERS_FILENAME = 'untitled2_makers.csv'

FREQ_STEP = 1/3;

% load
[freq = read_neopype_freq_output( [IN_PATH, IN_FILENAME] );
num_t = size(freq,1);
t0 = freq(1,end);
tf = freq(end,end);
num_chnls = size(freq,2) - 1; % last col. is a timestamp

[marker, marker_time] = read_neopype_markers( [IN_PATH, IN_MARKERS_FILENAME] );

% get bands
for i = 1:N_BANDS
   tmp_band = BAND(i,:);
   band_idx(i,:) = [tmp_band(1)/FREQ_STEP, tmp_band(2)/FREQ_STEP];
end

% get averages
for i = 1:N_BANDS
  tmp_idx = band_idx(i,:);
  tmp_avg = mean( freq(:, tmp_idx(1):tmp_idx(2) ), 2 );
  avg_freq(i,:) = tmp_avg'; % transpose so it's 1 x t
  
  % clip large values
  avg_freq(i,:) = min( avg_freq(i,:), CAP ); 
end

% attention
attn = avg_freq(4,:) ./ avg_freq(2,:);


% plot
colors = jet( N_BANDS + 1 );
figure;
hax=axes;
for i = 1:N_BANDS
   plot( avg_freq(i,:), 'Color', colors(i,:) ); hold on;
end
title( 


figure;
plot( attn, 'Color', colors(N_BANDS+1,:) ); hold on;
title( 'Attention (x-axis is seconds)' );

% plot markers
%ylim = get(hax,'YLim' );
%for i = 1:size( marker, 2 )
%   if ( isempty( marker_time{i} ) )
%      continue;
%   end
%   
%   t = marker_time{i} - t0;
%   line( [t t], [0 ylim(2)], 'Color', [0 0 0] ); hold on;
%end

