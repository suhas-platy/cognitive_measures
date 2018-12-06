rem @brief get all flanker files, without training files, in a directory for uploading

rem xcopy won't allow things in the same directory, so go up one directory
mkdir ..\fujitsu_FlankerAfter_data
xcopy *flanker_arrows_2018-11*.xdf /s ..\fujitsu_FlankerAfter_data
cd ..\fujitsu_FlankerAfter_data
del *training*.xdf /s
