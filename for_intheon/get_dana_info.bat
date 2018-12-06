@echo off
set PYTHONHOME=
set "PATH=C:\Program Files\Intheon\NeuroPype Enterprise Suite (64-bit)\NeuroPype Enterprise\python;%PATH%"
python ..\support\FrequencyDomainPlotting_NoLSL_NoPlot_one_subj.py ^
--i "C:\Users\suhas\Desktop\prjs\cognitive_measures\for_intheon\32960218_flanker_arrows_2018-11-06_10-41-17_2.xdf" ^
--f "C:\Users\suhas\Desktop\prjs\cognitive_measures\for_intheon\32960218_flanker_arrows_2018-11-06_10-41-17_2_freq_out.csv" ^
--m "C:\Users\suhas\Desktop\prjs\cognitive_measures\for_intheon\32960218_flanker_arrows_2018-11-06_10-41-17_2_markers.csv" ^
--s 1 ^
--e 1
