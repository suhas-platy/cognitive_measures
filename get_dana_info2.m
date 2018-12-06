% @brief get ISI info for DANA tasks

% example events

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SRT1
% 4	trial-begin	32365.525417
% 5	picture-begin	32804.964997
% 6	response	33071.968126
% 7	trial-end	33100.46846
% 8	trial-begin	33100.46846

% 20	trial-begin	36114.62729
% 21	picture-begin	36833.686771
% 22	response-was-missed	37283.692044
% 23	trial-end	37283.692044

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% GNG
% 532	trial-begin	276866.375939
% 533	stimulus-go-#3	277416.192701
% 534	response-was-missed	278166.687691
% 535	trial-end	278167.187697

% 540	trial-begin	279626.208699
% 541	stimulus-go-#0	280226.749702
% 542	response-was-correct	280676.254969
% 543	trial-end	280728.255578

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CSL (CSS in the events)

% 168	trial-begin	110743.799953
% 169	stimulus-nomatch-#8	111194.305232
% 170	response-was-incorrect	111670.810815
% 171	trial-end	111696.81112

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MS
% 758	trial-begin	458101.38148
% 759	stimulus-in-set-letter-Z	458551.985142
% 760	response-was-correct	459269.042566
% 761	trial-end	459319.043152
% 762	trial-begin	459319.043152

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ handle include paths
addpath( 'C:\Program Files\eeglab_current\eeglab15rc1\plugins\xdfimport1.13' );
addpath( './support' );
%%%}}} eo-handle include paths

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ params (IN & ALGO)
disp( 'params' );

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tier 1 after
IN.IN_PATH = './data/';
IN.FZ = ["dana_task.csv"];

IN.SAVE_PATH = './';
IN.SAVE_FNAME = 'dana_markers_analysis.mat';

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
disp( '(in calculate below)' );
%%%}}} eo-load data

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ calculate
disp( 'calculate data' );

for f = 1:size(IN.FZ,2)
  % load
  fname = strcat( IN.IN_PATH, IN.FZ(f) )
  if (~isfile( fname ))
      disp( 'check filename' ); keyboard;
  end

  events = readtable( fname );
  in_SRT1 = false;
  in_GNG = false;
  in_CSL = false;
  in_MS = false;
  in_SRT2 = false;

  srt1_isi = [];
  gng_isi = [];
  csl_isi = [];
  ms_isi = [];
  srt2_isi = [];
  
  for t = 1:size(events,1)
     label = events{t,1}{1};
     time = events{t,3}; 
      
     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     % SRT1
     if ( strcmp( label, 'task-begin-SRT' ) && t < 10 )
        in_SRT1 = true;
        start_srt1_flag = false;
        trial_ctr_srt1 = 1;
     end
     
     if ( strcmp( label, 'task-end-SRT' ) && t < 200 )
        in_SRT1 = false;
     end
     
     if ( in_SRT1 )
        if ( strcmp( label, 'trial-begin' ) )
           start_srt1 = time;
           start_srt1_flag = true;
        end
        
        if ( start_srt1_flag && strcmp( label, 'picture-begin' ) )
          end_srt1 = time;
          srt1_isi( trial_ctr_srt1 ) = end_srt1-start_srt1;
          trial_ctr_srt1 = trial_ctr_srt1 + 1;
        end
     end

     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     % GNG
     if ( strcmp( label, 'task-begin-GNG' ) )
        in_GNG = true;
        start_gng_flag = false;
        trial_ctr_gng = 1;
     end
     
     if ( strcmp( label, 'task-end-GNG' ) )
        in_GNG = false;
     end
     
     if ( in_GNG )
        if ( strcmp( label, 'trial-begin' ) ) 
           start_gng = time;
           start_gng_flag = true;
        end
        
        if ( start_gng_flag )
           go =  contains( label, 'stimulus-go' ) ;
           no_go =  contains( label, 'stimulus-nogo' ) ;
           if ( go || no_go )
             end_gng = time;
             gng_isi( trial_ctr_gng ) = end_gng-start_gng;
             trial_ctr_gng = trial_ctr_gng + 1;
           end
        end
     end
     
     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     % CSL
     if ( strcmp( label, 'task-begin-CSS' ) )
        in_CSL = true;
        start_csl_flag = false;
        trial_ctr_csl = 1;
     end
     
     if ( strcmp( label, 'task-end-CSS' ) )
        in_CSL = false;
     end
     
     if ( in_CSL )
        if ( strcmp( label, 'trial-begin' ) ) 
           start_csl = time;
           start_csl_flag = true;
        end
        
        if ( start_csl_flag )
           match =  contains( label, 'stimulus-match' ) ;
           no_match =  contains( label, 'stimulus-nomatch' ) ;
           if ( match || no_match )
             end_csl = time;
             csl_isi( trial_ctr_csl ) = end_csl-start_csl;
             trial_ctr_csl = trial_ctr_csl + 1;
           end
        end
     end
     
     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     % MS
     if ( strcmp( label, 'task-begin-MS' ) )
        in_MS = true;
        start_ms_flag = false;
        trial_ctr_ms = 1;
     end
     
     if ( strcmp( label, 'task-end-MS' ) )
        in_MS = false;
     end
     
     if ( in_MS )
        if ( strcmp( label, 'trial-begin' ) ) 
           start_ms = time;
           start_ms_flag = true;
        end
        
        if ( start_ms_flag )
           match =  contains( label, 'stimulus-in-set' ) ;
           no_match =  contains( label, 'stimulus-not-in-set' ) ;
           if ( match || no_match )
             end_ms = time;
             ms_isi( trial_ctr_ms ) = end_ms-start_ms;
             trial_ctr_ms = trial_ctr_ms + 1;
           end
        end
     end     

     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     % SRT2
     if ( strcmp( label, 'task-begin-SRT' ) && t > 800 )
        in_SRT2 = true;
        start_srt2_flag = false;
        trial_ctr_srt2 = 1;
     end
     
     if ( strcmp( label, 'task-end-SRT' ) && t > 800 )
        in_SRT2 = false;
     end
     
     if ( in_SRT2 )
        if ( strcmp( label, 'trial-begin' ) )
           start_srt2 = time;
           start_srt2_flag = true;
        end
        
        if ( start_srt2_flag && strcmp( label, 'picture-begin' ) )
          end_srt2 = time;
          srt2_isi( trial_ctr_srt2 ) = end_srt2-start_srt2;
          trial_ctr_srt2 = trial_ctr_srt2 + 1;
        end
     end
     
     
  end % rof t
  
end % rof f

%%%}}} eo-calculate

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ display
disp( 'min srt1_isi' );
min( srt1_isi )
figure(1); hist( srt1_isi )

disp( 'min gng_isi' );
min( gng_isi )
figure(2); hist( gng_isi )

disp( 'min csl_isi' );
min( csl_isi )
figure(3); hist( csl_isi )

disp( 'min ms_isi' );
min( ms_isi )
figure(4); hist( ms_isi )

disp( 'min srt2_isi' );
min( srt2_isi )
figure(5); hist( srt2_isi )


%%%}}} eo-display

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ save
disp( 'save' );

if ( ALGO.SAVE )
   fname = [IN.SAVE_PATH IN.SAVE_FNAME];
   disp( ['saving ', fname] );
   save( fname );
else
  disp( 'ALGO.SAVE off; not saving' );
end
%%%}}} % eo-save