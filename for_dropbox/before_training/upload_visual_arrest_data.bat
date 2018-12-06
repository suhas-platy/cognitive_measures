rem @brief get all visual arrest (eyes open, eyes closed) files in a directory for uploading

rem xcopy won't allow things in the same directory, so go up one directory
mkdir ..\fujitsu_VisualArrestBefore_data
xcopy *visual_arrest*.xdf /s ..\fujitsu_VisualArrestBefore_data
cd ..\fujitsu_VisualArrestBefore_data
