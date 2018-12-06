rem @brief for group analysis, get all DANA files, without training files, in a directory for uploading

rem xcopy won't allow things in the same directory, so go up one directory
mkdir ..\fujitsu_NeuroScale\fujitsu_DANABefore_tier1_data
xcopy 32960218_dana_tasks_2018-09*.xdf /s ..\fujitsu_DANABefore_tier1_data
xcopy 31970318_dana_tasks_2018-09*.xdf /s ..\fujitsu_DANABefore_tier1_data
xcopy 32950518_dana_tasks_2018-09*.xdf /s ..\fujitsu_DANABefore_tier1_data
xcopy 32950318_dana_tasks_2018-09*.xdf /s ..\fujitsu_DANABefore_tier1_data
xcopy 31960118_dana_tasks_2018-09*.xdf /s ..\fujitsu_DANABefore_tier1_data
xcopy 31970218_dana_tasks_2018-09*.xdf /s ..\fujitsu_DANABefore_tier1_data
xcopy 319100118_dana_tasks_2018-09*.xdf /s ..\fujitsu_DANABefore_tier1_data
xcopy B-319110218_dana_tasks_2018-09*.xdf /s ..\fujitsu_DANABefore_tier1_data
xcopy 32960418_dana_tasks_2018-09*.xdf /s ..\fujitsu_DANABefore_tier1_data
xcopy 319110118_dana_tasks_2018-09*.xdf /s ..\fujitsu_DANABefore_tier1_data

cd ..\fujitsu_NeuroScale\fujitsu_DANABefore_tier1_data
del *training*.xdf /s

cd "..\..\Fujitsu Study Data"
mkdir ..\fujitsu_NeuroScale\fujitsu_DANABefore_tier2_data
xcopy 31950418_dana_tasks_2018-09*.xdf /s ..\fujitsu_DANABefore_tier2_data 
xcopy 310910318_dana_tasks_2018-09*.xdf /s ..\fujitsu_DANABefore_tier2_data
xcopy 32960318_dana_tasks_2018-09*.xdf /s ..\fujitsu_DANABefore_tier2_data
xcopy 32970418_dana_tasks_2018-09*.xdf /s ..\fujitsu_DANABefore_tier2_data
xcopy 3209110318_dana_tasks_2018-09*.xdf /s ..\fujitsu_DANABefore_tier2_data
xcopy 3209120218_dana_tasks_2018-09*.xdf /s ..\fujitsu_DANABefore_tier2_data
xcopy 319100418_dana_tasks_2018-09*.xdf /s ..\fujitsu_DANABefore_tier2_data
xcopy 31970118_dana_tasks_2018-09*.xdf /s ..\fujitsu_DANABefore_tier2_data
xcopy 32050118_dana_tasks_2018-09*.xdf /s ..\fujitsu_DANABefore_tier2_data
xcopy 31950218_dana_tasks_2018-09*.xdf /s ..\fujitsu_DANABefore_tier2_data
xcopy 3109120318_dana_tasks_2018-09*.xdf /s ..\fujitsu_DANABefore_tier2_data

cd ..\fujitsu_NeuroScale\fujitsu_DANABefore_tier2_data
del *training*.xdf /s
