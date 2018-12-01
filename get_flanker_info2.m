% @brief check # correct and RT for flanker data across groups

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ handle include paths
addpath( 'C:\Program Files\eeglab_current\eeglab15rc1\plugins\xdfimport1.13' );
addpath( './support' );
%%%}}} eo-handle include paths

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ params (IN & ALGO)
disp( 'params' );

IN.IN_PATH = '.\';
IN.TIER1_FNAME = '1after.mat';
IN.TIER2_FNAME = '2after.mat';

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

tier1_corr = tier1.corr;
tier2_corr = tier2.corr;

tier1_incorr = tier1.incorr;
tier2_incorr = tier2.incorr;

tier1_missed = tier1.missed;
tier2_missed = tier2.missed;

tier1_rt = tier1.rt_avg;
tier2_rt = tier2.rt_avg;
%%%}}} eo-load data

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ calculate
disp( 'calculate data' );

mean_tier1_corr = mean( tier1_corr )
mean_tier2_corr = mean( tier2_corr )
std_tier1_corr = std( tier1_corr );
std_tier2_corr = std( tier2_corr );

mean_tier1_incorr = mean( tier1_incorr )
mean_tier2_incorr = mean( tier2_incorr )
std_tier1_incorr = std( tier1_incorr );
std_tier2_incorr = std( tier2_incorr );

mean_tier1_missed = mean( tier1_missed )
mean_tier2_missed = mean( tier2_missed )
std_tier1_missed = std( tier1_missed );
std_tier2_missed = std( tier2_missed );

mean_tier1_rt = mean( tier1_rt )
mean_tier2_rt = mean( tier2_rt )
std_tier1_rt = std( tier1_rt );
std_tier2_rt = std( tier2_rt );

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

mean_grp_corr = [mean_tier1_corr; mean_tier2_corr];
std_grp_corr = [std_tier1_corr; std_tier2_corr];

mean_grp_incorr = [mean_tier1_incorr; mean_tier2_incorr];
std_grp_incorr = [std_tier1_incorr; std_tier2_incorr];

mean_grp_missed = [mean_tier1_missed; mean_tier2_missed];
std_grp_missed = [std_tier1_missed; std_tier2_missed];

mean_grp_rt = [mean_tier1_rt; mean_tier2_rt];
std_grp_rt = [std_tier1_rt; std_tier2_rt];

mean_grp_corr_etc = [mean_grp_corr'; mean_grp_incorr'; mean_grp_missed'];
std_grp_corr_etc = [std_grp_corr'; std_grp_incorr'; std_grp_missed'];

figure(1);
%bar(corr_mean_grp); hold on;
%errorbar( corr_mean_grp, corr_std_grp, 's' );
h = barweb( mean_grp_corr_etc, std_grp_corr_etc ); hold on;
set(h.bars(1), 'FaceColor', [1 0 0] );
set(h.bars(2), 'FaceColor', [0 1 0] );
title( 'Correct, incorrect and missed by group' );

figure(2);
bar( mean_grp_rt ); hold on;
errorbar( mean_grp_rt, std_grp_rt, 's' );
keyboard;
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