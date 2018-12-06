rem @brief get all flanker files, without flanker training files, in a directory for uploading

rem xcopy won't allow things in the same directory, so go up one directory
mkdir ..\fujitsu_FlanerBefore_data
xcopy *visual_arrest*.xdf /s ..\fujitsu_FlankerBefore_data
cd ..\fujitsu_FlankerBefore_data
