% @brief check data quality

% 1	F7	20.84
% 2	Fp1	-0.86
% 3	Fp2	2.12
% 4	F8	1.63
% 5	F3	-1.61
% 6	Fz	-0.74
% 7	F4	0.16
% 8	C3	-1.26
% 9	Cz	3.13
% 10	P8	1.57
% 11	P7	-0.58
% 12	Pz	-0.34
% 13	P4	0.36
% 14	T3	0.14
% 15	P3	-1.19
% 16	O1	-0.50
% 17	O2	-0.27
% 18	C4	-0.51
% 19	T4	-0.52
% 20	A2	0.78

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ handle include paths
addpath( './support' );
%%%}}} eo-handle include paths

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ params (IN & ALGO)
disp( 'params' );
IN.IN_PATH = 'C:\Data\Training Data\';
IN.IN_FZ = ["12052018001\12052018001_visual_arrest_2018-12-05_16-20-57_1.xdf"];

IN.SAVE_PATH = IN.IN_PATH;
IN.SAVE_FZ = strrep( IN.IN_FZ, '.xdf', '_data_quality.mat' );


IN.IN_PATH = 'C:\Data\Training Data\';
IN.IN_FZ = ["12052018001\12052018001_visual_arrest_2018-12-05_16-20-57_1.xdf",...
            "12052018001\12052018001_visual_arrest_2018-12-05_16-23-39_1.xdf",...
            "12052018001\12052018001_visual_arrest_2018-12-05_16-27-15_1.xdf",...
            "12052018001\12052018001_flanker_arrows_2018-12-05_16-29-28_1.xdf",...
            "12052018001\12052018001_dana_tasks_2018-12-05_16-42-02_1.xdf",...
            "1205201802\1205201802_flanker_arrows_2018-12-05_18-43-09_2.xdf",...
            "1205201802\1205201802_visual_arrest_2018-12-05_18-40-58_2.xdf"];
IN.IN_FZ = ["12052018001\12052018001_visual_arrest_2018-12-05_16-20-57_1.xdf",...
            "12052018001\12052018001_visual_arrest_2018-12-05_16-23-39_1.xdf",...
            "12052018001\12052018001_visual_arrest_2018-12-05_16-27-15_1.xdf",...
            "1205201802\1205201802_visual_arrest_2018-12-05_18-40-58_2.xdf"];
%IN.IN_FZ = ["1205201802\1205201802_visual_arrest_2018-12-05_18-40-58_2.xdf"];
%IN.IN_FZ = ["slmH212062018001\slmH212062018001_visual_arrest_2018-12-06_17-38-51_1.xdf"];

IN.TASKS = ["eyes-closed-end", "eyes-open-end"];
%IN.TASKS = ["eyes-open-end"];


IN.SAVE_PATH = IN.IN_PATH;
IN.SAVE_FZ = strrep( IN.IN_FZ, '.xdf', '_data_quality.mat' );

ALGO.SAVE = 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ trace param's
IN
ALGO
%%%}}}

%%%}}} eo-params (IN & ALGO)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ load data
%%%}}} eo-load data

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ calculate
disp( 'calculate data' );
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
OUT.idx_bad_elec = cell( size(IN.IN_FZ,2), size(IN.TASKS,2) );
OUT.idx_bad_epoch = cell( size(IN.IN_FZ,2), size(IN.TASKS,2) );


for f = 1:size(IN.IN_FZ,2)
  % load
  fname = strcat( IN.IN_PATH, IN.IN_FZ(f) )
  if (~isfile( fname ))
      disp( 'check filename' ); keyboard;
  end
  EEG = eeg_load_xdf( fname, 'streamtype', 'EEG', 'exclude_markerstreams', {} );
  
  % remove non EEG
  EEG = pop_select( EEG, 'channel',{'F7' 'Fp1' 'Fp2' 'F8' 'F3' 'Fz' 'F4' 'C3' 'Cz' 'P8' 'P7' 'Pz' 'P4' 'T3' 'P3' 'O1' 'O2' 'C4' 'T4' 'A2'});
  [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'overwrite','on','gui','off'); 

  % bandpass at 45 Hz
  EEG = pop_eegfilt( EEG, 0, 45, [], [0], 1, 0, 'fir1', 0); % w/o signal processing toolbox
  %EEG = pop_eegfilt( EEG, 0, 45, [], [0], 0, 0, 'fir1', 0); 
  [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'overwrite','on','gui','off');   
  EEG_orig = EEG;
  
  for t = 1:size(IN.TASKS,2)
     EEG = EEG_orig;
     
     % extract epochs 
     if ( t == 1 )
        EEG = pop_epoch( EEG, {  'eyes-closed-end'  }, [-10   0], 'epochinfo', 'yes');
     else
        EEG = pop_epoch( EEG, {  'eyes-open-end'  }, [-10   0], 'epochinfo', 'yes');        
     end
     [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'overwrite','on','gui','off');   
     
     % re-baseline
     EEG = pop_rmbase( EEG, [] ,[],[]);  
     [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'overwrite','on','gui','off');   

     % remove channels
     [EEG,idx_bad_elec,meas_bad_elec] = pop_rejchan(EEG, 'elec',[1:20] ,'threshold',5,'norm','on','measure','kurt');  
     OUT.idx_bad_elec{f,t} = idx_bad_elec;
     
     % remove epochs
     [EEG,idx_bad_epochs] = pop_autorej(EEG, 'nogui','on','eegplot','on');
     OUT.idx_bad_epochs{f,t} = idx_bad_epochs;
  end
  
  eeglab redraw;
  %keyboard;
  
  % display
  disp( 'removed electrodes' );
  OUT.idx_bad_elec
  disp( 'removed epochs' );
  OUT.idx_bad_epochs
  
  % save
  if ( ALGO.SAVE )
     fname = strcat( IN.SAVE_PATH, IN.SAVE_FZ(f) );
     disp( strcat( 'saving ', fname ) );
     save( fname );
  else
     disp( 'ALGO.SAVE off; not saving' );
  end
  
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ display
%%%}}} eo-display

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ save
%%%}}} % eo-save   