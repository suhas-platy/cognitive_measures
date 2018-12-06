rem @brief for group analysis, get all flanker files, without training files, in a directory for uploading

rem xcopy won't allow things in the same directory, so go up one directory
mkdir ..\fujitsu_FlankerBefore_tier1_data
xcopy 32960218_flanker_arrows_2018-09*.xdf /s ..\fujitsu_FlankerBefore_tier1_data
xcopy 31970318_flanker_arrows_2018-09*.xdf /s ..\fujitsu_FlankerBefore_tier1_data
xcopy 32950518_flanker_arrows_2018-09*.xdf /s ..\fujitsu_FlankerBefore_tier1_data
xcopy 32950318_flanker_arrows_2018-09*.xdf /s ..\fujitsu_FlankerBefore_tier1_data
xcopy 31960118_flanker_arrows_2018-09*.xdf /s ..\fujitsu_FlankerBefore_tier1_data
xcopy 31970218_flanker_arrows_2018-09*.xdf /s ..\fujitsu_FlankerBefore_tier1_data
xcopy 319100118_flanker_arrows_2018-09*.xdf /s ..\fujitsu_FlankerBefore_tier1_data
xcopy 319110218_flanker_arrows_2018-09*.xdf /s ..\fujitsu_FlankerBefore_tier1_data
xcopy 32960418_flanker_arrows_2018-09*.xdf /s ..\fujitsu_FlankerBefore_tier1_data
xcopy 319110118_flanker_arrows_2018-09*.xdf /s ..\fujitsu_FlankerBefore_tier1_data

cd ..\fujitsu_FlankerBefore_tier1_data
del *training*.xdf /s

cd "..\Fujitsu Study Data"
mkdir ..\fujitsu_FlankerBefore_tier2_data
xcopy 31950418_flanker_arrows_2018-09*.xdf /s ..\fujitsu_FlankerBefore_tier2_data 
xcopy 310910318_flanker_arrows_2018-09*.xdf /s ..\fujitsu_FlankerBefore_tier2_data
xcopy 32960318_flanker_arrows_2018-09*.xdf /s ..\fujitsu_FlankerBefore_tier2_data
xcopy 32970418_flanker_arrows_2018-09*.xdf /s ..\fujitsu_FlankerBefore_tier2_data
xcopy 3209110318_flanker_arrows_2018-09*.xdf /s ..\fujitsu_FlankerBefore_tier2_data
xcopy 3209120218_flanker_arrows_2018-09*.xdf /s ..\fujitsu_FlankerBefore_tier2_data
xcopy 319100418_flanker_arrows_2018-09*.xdf /s ..\fujitsu_FlankerBefore_tier2_data
xcopy 31970118_flanker_arrows_2018-09*.xdf /s ..\fujitsu_FlankerBefore_tier2_data
xcopy 32050118_flanker_arrows_2018-09*.xdf /s ..\fujitsu_FlankerBefore_tier2_data
xcopy 31950218_flanker_arrows_2018-09*.xdf /s ..\fujitsu_FlankerBefore_tier2_data
xcopy 3109120318_flanker_arrows_2018-09*.xdf /s ..\fujitsu_FlankerBefore_tier2_data

cd ..\fujitsu_FlankerBefore_tier2_data
del *training*.xdf /s
