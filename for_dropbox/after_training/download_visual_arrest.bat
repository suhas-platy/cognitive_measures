rem @brief get all flanker reports

rem xcopy won't allow things in the same directory, so go up one directory
mkdir ..\fujitsu_VisualArrestAfter_reports
xcopy Z:\uxtnup9qwjkmsa2c5umfab\Studies\fujitsu_VisualArrestAfter_data\*.html /s ..\fujitsu_VisualArrestAfter_reports
