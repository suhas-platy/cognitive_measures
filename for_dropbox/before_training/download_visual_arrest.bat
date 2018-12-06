rem @brief get all flanker reports

rem xcopy won't allow things in the same directory, so go up one directory
mkdir ..\fujitsu_VisualArrestBefore_reports
xcopy Z:\uxtnup9qwjkmsa2c5umfab\Studies\fujitsu_VisualArrestBefore_data\*.html /s ..\fujitsu_VisualArrestBefore_reports
