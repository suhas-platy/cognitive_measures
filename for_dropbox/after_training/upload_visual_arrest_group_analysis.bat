rem @brief for group analysis, get all visual arrest, without training files, in a directory for uploading

rem xcopy won't allow things in the same directory, so go up one directory
mkdir ..\fujitsu_VisualArrestAfter_tier1_data
xcopy 32960218_visual_arrest_2018-11*.xdf /s ..\fujitsu_VisualArrestAfter_tier1_data
xcopy 31970318_visual_arrest_2018-11*.xdf /s ..\fujitsu_VisualArrestAfter_tier1_data
xcopy 32950518_visual_arrest_2018-11*.xdf /s ..\fujitsu_VisualArrestAfter_tier1_data
xcopy 32950318_visual_arrest_2018-11*.xdf /s ..\fujitsu_VisualArrestAfter_tier1_data
xcopy 31960118_visual_arrest_2018-11*.xdf /s ..\fujitsu_VisualArrestAfter_tier1_data
xcopy 31970218_visual_arrest_2018-11*.xdf /s ..\fujitsu_VisualArrestAfter_tier1_data
xcopy 319100118_visual_arrest_2018-11*.xdf /s ..\fujitsu_VisualArrestAfter_tier1_data
xcopy 319110218_visual_arrest_2018-11*.xdf /s ..\fujitsu_VisualArrestAfter_tier1_data
xcopy 32960418_visual_arrest_2018-11*.xdf /s ..\fujitsu_VisualArrestAfter_tier1_data
xcopy 319110118_visual_arrest_2018-11*.xdf /s ..\fujitsu_VisualArrestAfter_tier1_data

cd ..\fujitsu_VisualArrestAfter_tier1_data
del *training*.xdf /s

cd "..\Fujitsu Data Post-Testing"
mkdir ..\fujitsu_VisualArrestAfter_tier2_data
xcopy 31950418_visual_arrest_2018-11*.xdf /s ..\fujitsu_VisualArrestAfter_tier2_data 
xcopy 310910318_visual_arrest_2018-11*.xdf /s ..\fujitsu_VisualArrestAfter_tier2_data
xcopy 32960318_visual_arrest_2018-11*.xdf /s ..\fujitsu_VisualArrestAfter_tier2_data
xcopy 32970418_visual_arrest_2018-11*.xdf /s ..\fujitsu_VisualArrestAfter_tier2_data
xcopy 3209110318_visual_arrest_2018-11*.xdf /s ..\fujitsu_VisualArrestAfter_tier2_data
xcopy 3209120218_visual_arrest_2018-11*.xdf /s ..\fujitsu_VisualArrestAfter_tier2_data
xcopy 319100418_visual_arrest_2018-11*.xdf /s ..\fujitsu_VisualArrestAfter_tier2_data
xcopy 31970118_visual_arrest_2018-11*.xdf /s ..\fujitsu_VisualArrestAfter_tier2_data
xcopy 32050118_visual_arrest_2018-11*.xdf /s ..\fujitsu_VisualArrestAfter_tier2_data
xcopy 31950218_visual_arrest_2018-11*.xdf /s ..\fujitsu_VisualArrestAfter_tier2_data
xcopy 3109120318_visual_arrest_2018-11*.xdf /s ..\fujitsu_VisualArrestAfter_tier2_data

cd ..\fujitsu_VisualArrestAfter_tier2_data
del *training*.xdf /s
