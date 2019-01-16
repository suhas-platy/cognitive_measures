% @brief check # correct and RT for flanker data across groups

% first run with "before" in params, then with "after"

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ handle include paths
addpath( './support' );
%%%}}} eo-handle include paths

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ params (IN & ALGO)
disp( 'params' );

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% before
IN.IN_PATH = '.\data\flanker\';
IN.TIER1_FNAME = 'flanker_after_tier1.mat';
IN.TIER2_FNAME = 'flanker_after_tier2.mat';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% after
IN.IN_PATH = '.\data\flanker\';
IN.TIER1_FNAME = 'flanker_before_tier1.mat';
IN.TIER2_FNAME = 'flanker_before_tier2.mat';

IN.TIER1_CLR = [68 114 196]./255;
IN.TIER2_CLR = [237 125 49]./255;

ALGO.SAVE = 0
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ trace param's
IN
ALGO
%%%}}}

%%%}}} eo-params (IN & ALGO)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ load data
disp( 'load data' );
tier1 = load( [IN.IN_PATH IN.TIER1_FNAME] );
tier2 = load( [IN.IN_PATH IN.TIER2_FNAME] );
keyboard; % examine

% these are all 1 x number of subjects
tier1_corr = tier1.corr;
tier2_corr = tier2.corr;

tier1_incorr = tier1.incorr;
tier2_incorr = tier2.incorr;

tier1_missed = tier1.missed;
tier2_missed = tier2.missed;

tier1_num_trial = tier1.num_trial;
tier2_num_trial = tier2.num_trial;

%tier1_rt = tier1.rt_avg;
%tier2_rt = tier2.rt_avg;
%%%}}} eo-load data

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ calculate
disp( 'calculate data' );

% means are all 1x1
mean_tier1_corr = mean( tier1_corr )
mean_tier2_corr = mean( tier2_corr )
std_tier1_corr = std( tier1_corr );
std_tier2_corr = std( tier2_corr );
stderr_tier1_corr = mt_stderr( tier1_corr );
stderr_tier2_corr = mt_stderr( tier2_corr );

mean_tier1_incorr = mean( tier1_incorr )
mean_tier2_incorr = mean( tier2_incorr )
std_tier1_incorr = std( tier1_incorr );
std_tier2_incorr = std( tier2_incorr );
stderr_tier1_incorr = mt_stderr( tier1_incorr );
stderr_tier2_incorr = mt_stderr( tier2_incorr );

mean_tier1_missed = mean( tier1_missed )
mean_tier2_missed = mean( tier2_missed )
std_tier1_missed = std( tier1_missed );
std_tier2_missed = std( tier2_missed );
stderr_tier1_missed = mt_stderr( tier1_missed );
stderr_tier2_missed = mt_stderr( tier2_missed );

percorr_tier1 = tier1_corr;
percorr_tier1 = 100.*(percorr_tier1 ./ (tier1_corr+tier1_incorr+tier1_missed));
percorr_tier2 = tier2_corr;
percorr_tier2 = 100.*percorr_tier2 ./ (tier2_corr+tier2_incorr+tier2_missed);
mean_tier1_percorr = mean( percorr_tier1 );
mean_tier2_percorr = mean( percorr_tier2 );
std_tier1_percorr = std( percorr_tier1 );
std_tier2_percorr = std( percorr_tier2 );
stderr_tier1_percorr = mt_stderr( percorr_tier1 );
stderr_tier2_percorr = mt_stderr( percorr_tier2 );

mean_tier1_rt = mean( tier1_rt )
mean_tier2_rt = mean( tier2_rt )
std_tier1_rt = std( tier1_rt );
std_tier2_rt = std( tier2_rt );
stderr_tier1_rt = mt_stderr( tier1_rt );
stderr_tier2_rt = mt_stderr( tier2_rt );

% stat's test
[h_corr,p_corr,ci_corr,stats_corr] = ttest2( tier1_corr, tier2_corr );
h_corr
p_corr
[h_rt,p_rt,ci_rt,stats_rt] = ttest2( tier1_rt, tier2_rt );
h_rt
p_rt

%%%}}} eo-calculate

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ display
disp( 'display' );

% grp means are 2x1
mean_grp_corr = [mean_tier1_corr; mean_tier2_corr];
std_grp_corr = [std_tier1_corr; std_tier2_corr];
stderr_grp_corr = [stderr_tier1_corr; stderr_tier2_corr];

mean_grp_incorr = [mean_tier1_incorr; mean_tier2_incorr];
std_grp_incorr = [std_tier1_incorr; std_tier2_incorr];
stderr_grp_incorr = [stderr_tier1_incorr; stderr_tier2_incorr];

mean_grp_missed = [mean_tier1_missed; mean_tier2_missed];
std_grp_missed = [std_tier1_missed; std_tier2_missed];
stderr_grp_missed = [stderr_tier1_missed; stderr_tier2_missed];

mean_grp_percorr = [mean_tier1_percorr; mean_tier2_percorr];
std_grp_percorr = [std_tier1_percorr; std_tier2_percorr];
stderr_grp_percorr = [stderr_tier1_percorr; stderr_tier2_percorr];

mean_grp_rt = [mean_tier1_rt; mean_tier2_rt];
std_grp_rt = [std_tier1_rt; std_tier2_rt];
stderr_grp_rt = [stderr_tier1_rt; stderr_tier2_rt];

% for plotting
mean_grp_corr_etc = [mean_grp_corr'; mean_grp_incorr'; mean_grp_missed'];
std_grp_corr_etc = [std_grp_corr'; std_grp_incorr'; std_grp_missed'];
stderr_grp_corr_etc = [stderr_grp_corr'; stderr_grp_incorr'; stderr_grp_missed'];

mean_grp_percorr_etc = [mean_grp_percorr'];
stderr_grp_percorr_etc = [stderr_grp_percorr'];

mean_grp_rt_etc = [mean_grp_rt'];
stderr_grp_rt_etc = [stderr_grp_rt'];

figure(1);
%bar(corr_mean_grp); hold on;
%errorbar( corr_mean_grp, corr_std_grp, 's' );
h = barweb( mean_grp_corr_etc, stderr_grp_corr_etc ); hold on;
set(h.bars(1), 'FaceColor', IN.TIER1_CLR );
set(h.bars(2), 'FaceColor', IN.TIER2_CLR );
title( 'Trial responses by group' );
xlabel( 'Trial types' ); 
set( gca, 'XTickLabel', ["Correct"; "Incorrect"; "Missed"] );
ylabel( 'Trials' );

figure(2);
h = barweb( mean_grp_percorr_etc, stderr_grp_percorr_etc ); hold on;
set(h.bars(1), 'FaceColor', IN.TIER1_CLR );
set(h.bars(2), 'FaceColor', IN.TIER2_CLR );
title( 'Percent correct by group' );
set( gca, 'XTickLabel', [""] );
xlabel( 'Group' );
ylabel( 'Percent Correct' );

figure(3);
h = barweb( mean_grp_rt_etc, stderr_grp_rt_etc ); hold on; 
set(h.bars(1), 'FaceColor', IN.TIER1_CLR );
set(h.bars(2), 'FaceColor', IN.TIER2_CLR );
title( 'Reaction time by group' );
set( gca, 'XTickLabel', [""] );
xlabel( 'Group' );
ylabel( 'Reaction time' );

%keyboard;
%%%}}} eo-display

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ save
disp( 'save' );

if ( ALGO.SAVE )
   disp( ['saving ', IN.SAVE_FILENAME] );
   save( IN.SAVE_FILENAME );
else
  disp( 'ALGO.SAVE off; not saving' );
end
%%%}}} % eo-save