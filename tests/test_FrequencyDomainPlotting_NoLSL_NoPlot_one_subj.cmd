@echo off
rem set path and run a NeuroPype script
rem
rem derived from C:\Program Files\Intheon\NeuroPype Enterprise Suite (64-bit)\Extras\motorimag_calibrate.cmd
set PYTHONHOME=
set "PATH=C:\Program Files\Intheon\NeuroPype Enterprise Suite (64-bit)\NeuroPype Enterprise\python;%PATH%"
rem python "C:\Users\suhas\Desktop\prjs\cognitive_measures\support\FrequencyDomainPlotting_NoLSL_NoPlot_one_subj.py" -i "C:/Data/fujitsu_flanker_data/09052018/09050118/09050118Wtsou_flanker_arrows_2018-09-05_10-40-20_1.xdf" -f "C:/Users/suhas/Desktop/prjs/golf_processing/src/untitled2.csv" -m "C:/Users/suhas/Desktop/prjs/golf_processing/src/untitled2_makers.csv"
python "C:\Users\suhas\Desktop\prjs\cognitive_measures\support\FrequencyDomainPlotting_NoLSL_NoPlot_one_subj.py" ^
--i "C:/Data/fujitsu_flanker_data/09052018/09050118/09050118Wtsou_flanker_arrows_2018-09-05_10-40-20_1.xdf" ^
--m "C:/Users/suhas/Desktop/prjs/golf_processing/src/untitled2_markers.csv" ^
--f "C:/Users/suhas/Desktop/prjs/golf_processing/src/untitled2.csv" ^
--s 0 ^
--e 20
