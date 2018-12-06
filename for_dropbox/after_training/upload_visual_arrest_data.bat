rem @brief get all visual arrest (eyes open, eyes closed) files in a directory for uploading

rem xcopy won't allow things in the same directory, so go up one directory
mkdir ..\fujitsu_VisualArrestAfter_data
xcopy *visual_arrest_2018-11*.xdf /s ..\fujitsu_VisualArrestAfter_data
cd ..\fujitsu_VisualArrestAfter_data
