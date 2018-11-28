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

tier1_rt = tier1.rt_avg;
tier2_rt = tier2.rt_avg;
%%%}}} eo-load data

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ calculate
disp( 'calculate data' );

mean_tier1_corr = mean( tier1_corr )
mean_tier2_corr = mean( tier2_corr )

mean_tier1_rt = mean( tier1_rt )
mean_tier2_rt = mean( tier2_rt )

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

% could make plots here
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