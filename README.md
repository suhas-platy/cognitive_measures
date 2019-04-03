# What this is

## Extracting attention and other cognitive measures in Fujitsu data.  

1. Get CSV files from XDF files  
  * Run get_attention_neuropype_all_subjs_minus1.m.  This will create ./make_csv_files.cmd.
  * Run ./make_csv_files.cmd.  This will call NeuroPype to open the files and do an FFT
    Each CSV file conversion takes about 30 seconds to do.
1. Process CSV files  
  * Run get_attention_neuropype_all_subjs.m.  This will create .mat files where the original data files are.  
1. Process MAT files
  * Run get_attention_neuropype_all_subjs_plus1.m.

## Eyes open/eyes closed data

1. many_subj2.m  

## Flanker

1. get_flanker_marker_neuropype.m - this reads in XDF files and makes CSV marker files  
1. get_flanker_info_neuropype.m - this reads in CSV marker files and extracts stat's  
1. get_flanker_info2.m - this compares across conditions  

## Viewing Intheon Reports

1. view_neuroscale_datastructure.m - plots data; check_report_plots is more checking HTML v MAT files for correct values on the command line

### view_neuroscale_multiple_grp_report.m

view data in neuroscale .mat files; group DANA files

#### Run first to check if data is being parsed correct (compare Matlab and HTML files)
view_intheon_individual_report.m - checks data; calls check_report_plots (text display)
view_neuroscale_group_report.m - checks data; calls check_report_plots (text display)

#### Run second to aggregate over >1 file
view_neuroscale_multiple_individual_report.m - 
view_neuroscale_multiple_group_report.m - 

## Viewing Intheon EEG

h5_to_xdf.pyp - use absolute paths

view_hd5_eeg - 

## ./ file listing
````
get_attention_neuropype_all_subjs.m - process CSV files; creates MAT files (calls get_attention_neuropype_one_subj)

get_attention_neuropype_all_subjs_minus1.m - make CMD file which gets freq out and markers from Neuropype; run make_csv_files.cmd when done; uses support\FrequencyDomainPlotting_NoLSL_NoPlot_one_subj.py

get_attention_neuropype_one_subj.m - get band power estimates from Neuropype output (test stub exists)

get_band_power.m - get band power estimates from EEG

load_xdf_wrapper.m - load XDF file and put it in EEGLab format  

read_neuropype_freq_output.m - read Neuropype frequency output CSV file 

read_neuropype_markers.m - read Neuropype markers CSV file  

test_attention.m - load XDF and get band power estimates  

test_attention_neuropype.m - get band power estimates from Neuropype output
````

### conf
Configuration files  
````
flanker/ - files to run flanker analysis on
bands - EEG bands
cognionics_q20 - electrode labels
flanker_before_all_... - can't remember...
sources_v1 - 12 sources from Intheon
````

### data
Data files  
````
See ./data/ReadMe.txt
````

### doc
Documentation re: Intheon reports
OLD sample reports are from Z:\Studies\Testing  
````
See ./doc/README.md
````

### for_dropbox
Files to upload and download data from dropbox to the Intheon S3 bucket.  
````
````

### for_intheon
Test of loading data in EEGLAB (there was an issue w/ loading XDF files with an older version of the plugin).  
````
````

### html
Not always present.  Filled in when m2html is called.
````
````

### support
Files to support main scripts  
````
````

### tests
Files to test support scripts  
````
````

# Markers
````
write-begin , 353697.55
write-end , 353700.560101
instructions-end , 353700.560174
task-begin-flanker , 353700.560183
write-begin , 353700.561814
write-end , 353705.559219
block-begin , 353706.551855
trial-begin , 353706.551898
response-window-begin , 353706.552019
right-flanker , 353706.552036
picture-begin , 353706.552406
picture-end , 353706.663136
congruent-stimulus , 353706.663199
picture-begin , 353706.663457
picture-end , 353706.801879
fixation-cross , 353706.801939
crosshair-begin , 353706.802167
arrow_right pressed , 353707.081179
response-received-arrow_right , 353707.086823
crosshair-end , 353708.21136
response-window-end , 353708.21145
response-was-correct , 353708.211462
trial-end , 353708.211479
....
write-begin , 353775.859223
write-end , 353780.857345
block-end , 353780.857417
````
