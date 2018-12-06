rem @brief get all flanker reports

rem xcopy won't allow things in the same directory, so go up one directory
mkdir ..\fujitsu_FlankerBefore_reports
xcopy Z:\uxtnup9qwjkmsa2c5umfab\Studies\flanker_FlankerBefore_dir\*.html /s ..\fujitsu_FlankerBefore_reports
