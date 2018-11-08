<?xml version='1.0' encoding='utf-8'?>
<scheme description="This pipeline can be used to show the spectrum of the EEG data.&#10; &#10;Nodes Description:&#10; &#10;- LSL Input: is used to input the streamed data into the pipeline.&#10; &#10;- Dejitter Timestamps: is used to correct timestamps of the data stream, this prevents unwanted behavior in the proceeding nodes.&#10; &#10;- IIR Filter: is used to highpass filter data to remove the DC component.&#10; &#10;- Moving Window Multitaper Spectrum: is used to calculate the spectrum of the signal using Multitaper method.&#10; &#10;Spectrum plot: is used to plot the spectral content of the signal. This node has an option to compensate for the 1/f fall off inherent in natural signals. This option has been activated for this example." title="Frequency Domain Plotting" version="2.0">
	<nodes>
		<node id="0" name="IIR Filter" position="(-300, 100)" project_name="NeuroPype" qualified_name="widgets.signal_processing.owiirfilter.OWIIRFilter" title="IIR Filter" uuid="1ba0703c-b8d7-409a-9bc3-1cba4b0dddb0" version="1.1.0" />
		<node id="1" name="Spectrum Plot" position="(0, 100)" project_name="NeuroPype" qualified_name="widgets.visualization.owspectrumplot.OWSpectrumPlot" title="Spectrum Plot" uuid="6e938fb8-6233-4940-9af6-607d333f1d7e" version="1.0.0" />
		<node id="2" name="Dejitter Timestamps" position="(-400, 100)" project_name="NeuroPype" qualified_name="widgets.utilities.owdejittertimestamps.OWDejitterTimestamps" title="Dejitter Timestamps" uuid="118c8bb2-7d4c-48a0-bbe4-7ae58c7b33db" version="1.0.0" />
		<node id="3" name="Moving Window" position="(-200, 100)" project_name="NeuroPype" qualified_name="widgets.signal_processing.owmovingwindow.OWMovingWindow" title="Moving Window" uuid="d0de1f4e-ea40-456e-8e9e-540fb754f8b9" version="1.0.0" />
		<node id="4" name="Power Spectrum (Multitaper)" position="(-100, 100)" project_name="NeuroPype" qualified_name="widgets.spectral.owmultitaperspectrum.OWMultitaperSpectrum" title="Power Spectrum (Multitaper)" uuid="b9b1cce3-5615-414f-b2f7-14fbf3326601" version="1.0.0" />
		<node id="5" name="Time Series Plot" position="(-384.0, 211.0)" project_name="NeuroPype" qualified_name="widgets.visualization.owtimeseriesplot.OWTimeSeriesPlot" title="Time Series Plot" uuid="e38a9815-afef-480e-8223-1f209b2c2de8" version="1.0.0" />
		<node id="6" name="Record to CSV" position="(-15.0, 180.0)" project_name="NeuroPype" qualified_name="widgets.file_system.owrecordtocsv.OWRecordToCSV" title="Record to CSV" uuid="ef63c0b7-610c-44ed-85c2-a15bb5bf2c29" version="1.0.0" />
		<node id="7" name="Select Range" position="(-293.0, 197.0)" project_name="NeuroPype" qualified_name="widgets.tensor_math.owselectrange.OWSelectRange" title="Select Range" uuid="20052cea-8e5a-4076-a8ff-ee64d91f218f" version="1.0.0" />
		<node id="8" name="Select Range" position="(-280.0, 351.0)" project_name="NeuroPype" qualified_name="widgets.tensor_math.owselectrange.OWSelectRange" title="Select Range (1)" uuid="883f8f71-310f-4ed7-bd4c-3bc78720ed42" version="1.0.0" />
		<node id="9" name="Import XDF" position="(-475.0, 351.0)" project_name="NeuroPype" qualified_name="widgets.file_system.owimportxdf.OWImportXDF" title="Import XDF" uuid="b4c335cf-ba03-42a8-b7cb-1cac90441568" version="1.0.0" />
		<node id="10" name="Stream Data" position="(-377.0, 351.0)" project_name="NeuroPype" qualified_name="widgets.formatting.owstreamdata.OWStreamData" title="Stream Data" uuid="52549a46-445d-4588-9cb2-e1b8d1b71d95" version="1.1.0" />
		<node id="11" name="Export Markers to CSV" position="(-18.0, 448.0)" project_name="NeuroPype" qualified_name="widgets.file_system.owexportmarkers.OWExportMarkers" title="Export Markers to CSV" uuid="de1ae17a-4112-4e17-8ba6-cf7936327b0b" version="1.0.0" />
	</nodes>
	<links>
		<link enabled="true" id="0" sink_channel="Data" sink_node_id="3" source_channel="Data" source_node_id="0" />
		<link enabled="true" id="1" sink_channel="Data" sink_node_id="4" source_channel="Data" source_node_id="3" />
		<link enabled="true" id="2" sink_channel="Data" sink_node_id="1" source_channel="Data" source_node_id="4" />
		<link enabled="true" id="3" sink_channel="Data" sink_node_id="6" source_channel="Data" source_node_id="4" />
		<link enabled="true" id="4" sink_channel="Data" sink_node_id="7" source_channel="Data" source_node_id="2" />
		<link enabled="true" id="5" sink_channel="Data" sink_node_id="0" source_channel="Data" source_node_id="7" />
		<link enabled="true" id="6" sink_channel="Data" sink_node_id="2" source_channel="Data" source_node_id="8" />
		<link enabled="true" id="7" sink_channel="Data" sink_node_id="5" source_channel="Data" source_node_id="8" />
		<link enabled="true" id="8" sink_channel="Data" sink_node_id="10" source_channel="Data" source_node_id="9" />
		<link enabled="true" id="9" sink_channel="Data" sink_node_id="8" source_channel="Data" source_node_id="10" />
		<link enabled="true" id="10" sink_channel="Data" sink_node_id="11" source_channel="Data" source_node_id="9" />
	</links>
	<annotations />
	<thumbnail />
	<node_properties>
		<properties format="pickle" node_id="0">gAN9cQAoWAQAAABheGlzcQFYBAAAAHRpbWVxAlgGAAAAZGVzaWducQNYBgAAAGJ1dHRlcnEEWAsA
AABmcmVxdWVuY2llc3EFXXEGKEsBSwJlWAsAAABpZ25vcmVfbmFuc3EHiVgEAAAAbW9kZXEIWAgA
AABoaWdocGFzc3EJWBAAAABvZmZsaW5lX2ZpbHRmaWx0cQqJWAUAAABvcmRlcnELSwBYCQAAAHBh
c3NfbG9zc3EMR0AIAAAAAAAAWBMAAABzYXZlZFdpZGdldEdlb21ldHJ5cQ1jc2lwCl91bnBpY2ts
ZV90eXBlCnEOWAwAAABQeVF0NC5RdENvcmVxD1gKAAAAUUJ5dGVBcnJheXEQQy4B2dDLAAEAAAAA
AwIAAAFyAAAEewAAArYAAAMLAAABmAAABHIAAAKtAAAAAAAAcRGFcRKHcRNScRRYCgAAAHN0b3Bf
YXR0ZW5xFUdARAAAAAAAAHUu
</properties>
		<properties format="pickle" node_id="1">gAN9cQAoWAoAAABsaW5lX2NvbG9ycQFYBwAAACMwMDAwMDBxAlgFAAAAdGl0bGVxA1gNAAAAU3Bl
Y3RydW0gdmlld3EEWAoAAAB6ZXJvX2NvbG9ycQVYCQAAACM3RjdGN0Y3RnEGWBUAAABvbmVfb3Zl
cl9mX2NvcnJlY3Rpb25xB4hYCwAAAHN0cmVhbV9uYW1lcQhYAAAAAHEJWAwAAABpbml0aWFsX2Rp
bXNxCl1xC1gJAAAAYXV0b3NjYWxlcQyIWAcAAABzdGFja2VkcQ2IWA0AAABhbHdheXNfb25fdG9w
cQ6IWBAAAABiYWNrZ3JvdW5kX2NvbG9ycQ9YBwAAACNGRkZGRkZxEFgTAAAAc2F2ZWRXaWRnZXRH
ZW9tZXRyeXERY3NpcApfdW5waWNrbGVfdHlwZQpxElgMAAAAUHlRdDQuUXRDb3JlcRNYCgAAAFFC
eXRlQXJyYXlxFEMuAdnQywABAAAAAAUBAAAB6wAABnoAAAOvAAAFCgAAAhEAAAZxAAADpgAAAAAA
AHEVhXEWh3EXUnEYWAsAAABhbnRpYWxpYXNlZHEZiVgFAAAAc2NhbGVxGkc/8AAAAAAAAFgLAAAA
ZG93bnNhbXBsZWRxG4l1Lg==
</properties>
		<properties format="literal" node_id="2">{'max_updaterate': 500, 'savedWidgetGeometry': None, 'warmup_samples': -1, 'forget_halftime': 90, 'force_monotonic': True}</properties>
		<properties format="pickle" node_id="3">gAN9cQAoWBMAAABzYXZlZFdpZGdldEdlb21ldHJ5cQFjc2lwCl91bnBpY2tsZV90eXBlCnECWAwA
AABQeVF0NC5RdENvcmVxA1gKAAAAUUJ5dGVBcnJheXEEQy4B2dDLAAEAAAAABEMAAAIpAAAFvAAA
AvMAAARMAAACTwAABbMAAALqAAAAAAAAcQWFcQaHcQdScQhYBAAAAHVuaXRxCVgHAAAAc2Vjb25k
c3EKWAcAAAB2ZXJib3NlcQuJWA0AAAB3aW5kb3dfbGVuZ3RocQxLA3Uu
</properties>
		<properties format="pickle" node_id="4">gAN9cQAoWBgAAABhdmVyYWdlX292ZXJfdGltZV93aW5kb3dxAYlYDgAAAGhhbGZfYmFuZHdpZHRo
cQJHQAQAAAAAAABYBAAAAG5mZnRxA1gNAAAAKHVzZSBkZWZhdWx0KXEEWAoAAABudW1fdGFwZXJz
cQVYDQAAACh1c2UgZGVmYXVsdClxBlgIAAAAb25lc2lkZWRxB4hYEwAAAHNhdmVkV2lkZ2V0R2Vv
bWV0cnlxCGNzaXAKX3VucGlja2xlX3R5cGUKcQlYDAAAAFB5UXQ0LlF0Q29yZXEKWAoAAABRQnl0
ZUFycmF5cQtDLgHZ0MsAAQAAAAAEQwAAAhAAAAW8AAAC2gAABEwAAAI2AAAFswAAAtEAAAAAAABx
DIVxDYdxDlJxD3Uu
</properties>
		<properties format="pickle" node_id="5">gAN9cQAoWA0AAABhYnNvbHV0ZV90aW1lcQGJWA0AAABhbHdheXNfb25fdG9wcQKJWAsAAABhbnRp
YWxpYXNlZHEDiVgJAAAAYXV0b3NjYWxlcQSIWBAAAABiYWNrZ3JvdW5kX2NvbG9ycQVYBwAAACNG
RkZGRkZxBlgLAAAAZG93bnNhbXBsZWRxB4lYDAAAAGluaXRpYWxfZGltc3EIXXEJKEsySzJNvAJN
9AFlWAoAAABsaW5lX2NvbG9ycQpYBwAAACMwMDAwMDBxC1gMAAAAbWFya2VyX2NvbG9ycQxYBwAA
ACNGRjAwRkZxDVgMAAAAbmFuc19hc196ZXJvcQ6JWA4AAABvdmVycmlkZV9zcmF0ZXEPWA0AAAAo
dXNlIGRlZmF1bHQpcRBYEwAAAHNhdmVkV2lkZ2V0R2VvbWV0cnlxEWNzaXAKX3VucGlja2xlX3R5
cGUKcRJYDAAAAFB5UXQ0LlF0Q29yZXETWAoAAABRQnl0ZUFycmF5cRRDLgHZ0MsAAQAAAAADAwAA
AUUAAAR8AAACowAAAwwAAAFrAAAEcwAAApoAAAAAAABxFYVxFodxF1JxGFgFAAAAc2NhbGVxGUc/
8AAAAAAAAFgLAAAAc3RyZWFtX25hbWVxGlgNAAAAKHVzZSBkZWZhdWx0KXEbWAoAAAB0aW1lX3Jh
bmdlcRxHQBQAAAAAAABYBQAAAHRpdGxlcR1YEAAAAFRpbWUgc2VyaWVzIHZpZXdxHlgKAAAAemVy
b19jb2xvcnEfWAkAAAAjN0Y3RjdGN0ZxIFgIAAAAemVyb21lYW5xIYh1Lg==
</properties>
		<properties format="pickle" node_id="6">gAN9cQAoWBcAAABhYnNvbHV0ZV9pbnN0YW5jZV90aW1lc3EBiFgNAAAAY2xvdWRfYWNjb3VudHEC
WAAAAABxA1gMAAAAY2xvdWRfYnVja2V0cQRoA1gRAAAAY2xvdWRfY3JlZGVudGlhbHNxBWgDWAoA
AABjbG91ZF9ob3N0cQZYBwAAAERlZmF1bHRxB1gNAAAAY29sdW1uX2hlYWRlcnEIiFgMAAAAZGVs
ZXRlX3BhcnRzcQmIWAgAAABmaWxlbmFtZXEKWD0AAABDOi9Vc2Vycy9zdWhhcy9EZXNrdG9wL3By
anMvZ29sZl9wcm9jZXNzaW5nL3NyYy91bnRpdGxlZDIuY3N2cQtYCwAAAG91dHB1dF9yb290cQxo
A1gLAAAAcmV0cmlldmFibGVxDYlYEwAAAHNhdmVkV2lkZ2V0R2VvbWV0cnlxDmNzaXAKX3VucGlj
a2xlX3R5cGUKcQ9YDAAAAFB5UXQ0LlF0Q29yZXEQWAoAAABRQnl0ZUFycmF5cRFDLgHZ0MsAAQAA
AAADAwAAAU8AAAR8AAACmQAAAwwAAAF1AAAEcwAAApAAAAAAAABxEoVxE4dxFFJxFVgLAAAAdGlt
ZV9zdGFtcHNxFohYDwAAAHRpbWVzdGFtcF9sYWJlbHEXWAkAAAB0aW1lc3RhbXBxGHUu
</properties>
		<properties format="pickle" node_id="7">gAN9cQAoWBMAAABhcHBseV9tdWx0aXBsZV9heGVzcQGJWAQAAABheGlzcQJYBAAAAGF4aXNxA1gT
AAAAc2F2ZWRXaWRnZXRHZW9tZXRyeXEEY3NpcApfdW5waWNrbGVfdHlwZQpxBVgMAAAAUHlRdDQu
UXRDb3JlcQZYCgAAAFFCeXRlQXJyYXlxB0MuAdnQywABAAAAAAMDAAABggAABHwAAAJmAAADDAAA
AagAAARzAAACXQAAAAAAAHEIhXEJh3EKUnELWAkAAABzZWxlY3Rpb25xDFgDAAAAMTozcQ1YBAAA
AHVuaXRxDlgHAAAAaW5kaWNlc3EPdS4=
</properties>
		<properties format="pickle" node_id="8">gAN9cQAoWBMAAABhcHBseV9tdWx0aXBsZV9heGVzcQGJWAQAAABheGlzcQJYBQAAAHNwYWNlcQNY
EwAAAHNhdmVkV2lkZ2V0R2VvbWV0cnlxBGNzaXAKX3VucGlja2xlX3R5cGUKcQVYDAAAAFB5UXQ0
LlF0Q29yZXEGWAoAAABRQnl0ZUFycmF5cQdDLgHZ0MsAAQAAAAADAwAAAYIAAAR8AAACZgAAAwwA
AAGoAAAEcwAAAl0AAAAAAABxCIVxCYdxClJxC1gJAAAAc2VsZWN0aW9ucQxYAwAAADE6M3ENWAQA
AAB1bml0cQ5YBwAAAGluZGljZXNxD3Uu
</properties>
		<properties format="pickle" node_id="9">gAN9cQAoWA0AAABjbG91ZF9hY2NvdW50cQFYAAAAAHECWAwAAABjbG91ZF9idWNrZXRxA2gCWBEA
AABjbG91ZF9jcmVkZW50aWFsc3EEaAJYCgAAAGNsb3VkX2hvc3RxBVgHAAAARGVmYXVsdHEGWAgA
AABmaWxlbmFtZXEHWGUAAABDOi9EYXRhL2Z1aml0c3VfZmxhbmtlcl9kYXRhLzA5MDUyMDE4LzA5
MDUwMTE4LzA5MDUwMTE4V3Rzb3VfZmxhbmtlcl9hcnJvd3NfMjAxOC0wOS0wNV8xMC00MC0yMF8x
LnhkZnEIWBMAAABoYW5kbGVfY2xvY2tfcmVzZXRzcQmIWBEAAABoYW5kbGVfY2xvY2tfc3luY3EK
iFgVAAAAaGFuZGxlX2ppdHRlcl9yZW1vdmFscQuIWA4AAAByZXRhaW5fc3RyZWFtc3EMWA0AAAAo
dXNlIGRlZmF1bHQpcQ1YEwAAAHNhdmVkV2lkZ2V0R2VvbWV0cnlxDmNzaXAKX3VucGlja2xlX3R5
cGUKcQ9YDAAAAFB5UXQ0LlF0Q29yZXEQWAoAAABRQnl0ZUFycmF5cRFDLgHZ0MsAAQAAAAADAwAA
AVsAAAR8AAACjQAAAwwAAAGBAAAEcwAAAoQAAAAAAABxEoVxE4dxFFJxFVgHAAAAdmVyYm9zZXEW
iXUu
</properties>
		<properties format="pickle" node_id="10">gAN9cQAoWBEAAABoaXRjaF9wcm9iYWJpbGl0eXEBRwAAAAAAAAAAWA4AAABqaXR0ZXJfcGVyY2Vu
dHECSwBYBwAAAGxvb3BpbmdxA4lYCAAAAHJhbmRzZWVkcQRN54ZYEwAAAHNhdmVkV2lkZ2V0R2Vv
bWV0cnlxBWNzaXAKX3VucGlja2xlX3R5cGUKcQZYDAAAAFB5UXQ0LlF0Q29yZXEHWAoAAABRQnl0
ZUFycmF5cQhDLgHZ0MsAAQAAAAAC7gAAAVsAAASRAAACrAAAAvcAAAGBAAAEiAAAAqMAAAAAAABx
CYVxCodxC1JxDFgHAAAAc3BlZWR1cHENRz/wAAAAAAAAWAkAAABzdGFydF9wb3NxDkcAAAAAAAAA
AFgGAAAAdGltaW5ncQ9YDQAAAGRldGVybWluaXN0aWNxEFgPAAAAdXBkYXRlX2ludGVydmFscRFL
AXUu
</properties>
		<properties format="pickle" node_id="11">gAN9cQAoWAgAAABmaWxlbmFtZXEBWEQAAABDOi9Vc2Vycy9zdWhhcy9EZXNrdG9wL3ByanMvZ29s
Zl9wcm9jZXNzaW5nL3NyYy91bnRpdGxlZDJfbWFrZXJzLmNzdnECWAsAAABvdXRwdXRfcm9vdHED
WAAAAABxBFgTAAAAc2F2ZWRXaWRnZXRHZW9tZXRyeXEFY3NpcApfdW5waWNrbGVfdHlwZQpxBlgM
AAAAUHlRdDQuUXRDb3JlcQdYCgAAAFFCeXRlQXJyYXlxCEMuAdnQywABAAAAAAMDAAABjgAABHwA
AAJaAAADDAAAAbQAAARzAAACUQAAAAAAAHEJhXEKh3ELUnEMWAYAAABzdHJlYW1xDWgEdS4=
</properties>
	</node_properties>
	<patch>{
    "edges": [
        [
            "node1",
            "data",
            "node4",
            "data"
        ],
        [
            "node4",
            "data",
            "node5",
            "data"
        ],
        [
            "node5",
            "data",
            "node2",
            "data"
        ],
        [
            "node5",
            "data",
            "node7",
            "data"
        ],
        [
            "node3",
            "data",
            "node8",
            "data"
        ],
        [
            "node8",
            "data",
            "node1",
            "data"
        ],
        [
            "node9",
            "data",
            "node3",
            "data"
        ],
        [
            "node9",
            "data",
            "node6",
            "data"
        ],
        [
            "node10",
            "data",
            "node11",
            "data"
        ],
        [
            "node10",
            "data",
            "node12",
            "data"
        ],
        [
            "node11",
            "data",
            "node9",
            "data"
        ]
    ],
    "nodes": {
        "node1": {
            "class": "IIRFilter",
            "module": "neuropype.nodes.signal_processing.IIRFilter",
            "params": {
                "axis": {
                    "customized": false,
                    "type": "EnumPort",
                    "value": "time"
                },
                "design": {
                    "customized": false,
                    "type": "EnumPort",
                    "value": "butter"
                },
                "frequencies": {
                    "customized": true,
                    "type": "ListPort",
                    "value": [
                        1,
                        2
                    ]
                },
                "ignore_nans": {
                    "customized": false,
                    "type": "BoolPort",
                    "value": false
                },
                "mode": {
                    "customized": true,
                    "type": "EnumPort",
                    "value": "highpass"
                },
                "offline_filtfilt": {
                    "customized": false,
                    "type": "BoolPort",
                    "value": false
                },
                "order": {
                    "customized": true,
                    "type": "IntPort",
                    "value": 0
                },
                "pass_loss": {
                    "customized": false,
                    "type": "FloatPort",
                    "value": 3.0
                },
                "stop_atten": {
                    "customized": true,
                    "type": "FloatPort",
                    "value": 40.0
                }
            },
            "uuid": "1ba0703c-b8d7-409a-9bc3-1cba4b0dddb0"
        },
        "node10": {
            "class": "ImportXDF",
            "module": "neuropype.nodes.file_system.ImportXDF",
            "params": {
                "cloud_account": {
                    "customized": false,
                    "type": "StringPort",
                    "value": ""
                },
                "cloud_bucket": {
                    "customized": false,
                    "type": "StringPort",
                    "value": ""
                },
                "cloud_credentials": {
                    "customized": false,
                    "type": "StringPort",
                    "value": ""
                },
                "cloud_host": {
                    "customized": false,
                    "type": "EnumPort",
                    "value": "Default"
                },
                "filename": {
                    "customized": true,
                    "type": "StringPort",
                    "value": "C:/Data/fujitsu_flanker_data/09052018/09050118/09050118Wtsou_flanker_arrows_2018-09-05_10-40-20_1.xdf"
                },
                "handle_clock_resets": {
                    "customized": false,
                    "type": "BoolPort",
                    "value": true
                },
                "handle_clock_sync": {
                    "customized": false,
                    "type": "BoolPort",
                    "value": true
                },
                "handle_jitter_removal": {
                    "customized": false,
                    "type": "BoolPort",
                    "value": true
                },
                "retain_streams": {
                    "customized": false,
                    "type": "Port",
                    "value": null
                },
                "verbose": {
                    "customized": false,
                    "type": "BoolPort",
                    "value": false
                }
            },
            "uuid": "b4c335cf-ba03-42a8-b7cb-1cac90441568"
        },
        "node11": {
            "class": "StreamData",
            "module": "neuropype.nodes.formatting.StreamData",
            "params": {
                "hitch_probability": {
                    "customized": false,
                    "type": "FloatPort",
                    "value": 0.0
                },
                "jitter_percent": {
                    "customized": true,
                    "type": "FloatPort",
                    "value": 0
                },
                "looping": {
                    "customized": true,
                    "type": "BoolPort",
                    "value": false
                },
                "randseed": {
                    "customized": false,
                    "type": "IntPort",
                    "value": 34535
                },
                "speedup": {
                    "customized": false,
                    "type": "FloatPort",
                    "value": 1.0
                },
                "start_pos": {
                    "customized": false,
                    "type": "FloatPort",
                    "value": 0.0
                },
                "timing": {
                    "customized": true,
                    "type": "EnumPort",
                    "value": "deterministic"
                },
                "update_interval": {
                    "customized": true,
                    "type": "FloatPort",
                    "value": 1
                }
            },
            "uuid": "52549a46-445d-4588-9cb2-e1b8d1b71d95"
        },
        "node12": {
            "class": "ExportMarkers",
            "module": "neuropype.nodes.file_system.ExportMarkers",
            "params": {
                "filename": {
                    "customized": true,
                    "type": "StringPort",
                    "value": "C:/Users/suhas/Desktop/prjs/golf_processing/src/untitled2_makers.csv"
                },
                "output_root": {
                    "customized": false,
                    "type": "StringPort",
                    "value": ""
                },
                "stream": {
                    "customized": false,
                    "type": "StringPort",
                    "value": ""
                }
            },
            "uuid": "de1ae17a-4112-4e17-8ba6-cf7936327b0b"
        },
        "node2": {
            "class": "SpectrumPlot",
            "module": "neuropype.nodes.visualization.SpectrumPlot",
            "params": {
                "always_on_top": {
                    "customized": true,
                    "type": "BoolPort",
                    "value": true
                },
                "antialiased": {
                    "customized": false,
                    "type": "BoolPort",
                    "value": false
                },
                "autoscale": {
                    "customized": false,
                    "type": "BoolPort",
                    "value": true
                },
                "background_color": {
                    "customized": false,
                    "type": "StringPort",
                    "value": "#FFFFFF"
                },
                "downsampled": {
                    "customized": false,
                    "type": "BoolPort",
                    "value": false
                },
                "initial_dims": {
                    "customized": true,
                    "type": "ListPort",
                    "value": []
                },
                "line_color": {
                    "customized": false,
                    "type": "StringPort",
                    "value": "#000000"
                },
                "one_over_f_correction": {
                    "customized": true,
                    "type": "BoolPort",
                    "value": true
                },
                "scale": {
                    "customized": false,
                    "type": "FloatPort",
                    "value": 1.0
                },
                "stacked": {
                    "customized": false,
                    "type": "BoolPort",
                    "value": true
                },
                "stream_name": {
                    "customized": true,
                    "type": "StringPort",
                    "value": ""
                },
                "title": {
                    "customized": false,
                    "type": "StringPort",
                    "value": "Spectrum view"
                },
                "zero_color": {
                    "customized": false,
                    "type": "StringPort",
                    "value": "#7F7F7F7F"
                }
            },
            "uuid": "6e938fb8-6233-4940-9af6-607d333f1d7e"
        },
        "node3": {
            "class": "DejitterTimestamps",
            "module": "neuropype.nodes.utilities.DejitterTimestamps",
            "params": {
                "force_monotonic": {
                    "customized": false,
                    "type": "BoolPort",
                    "value": true
                },
                "forget_halftime": {
                    "customized": false,
                    "type": "FloatPort",
                    "value": 90
                },
                "max_updaterate": {
                    "customized": false,
                    "type": "IntPort",
                    "value": 500
                },
                "warmup_samples": {
                    "customized": false,
                    "type": "IntPort",
                    "value": -1
                }
            },
            "uuid": "118c8bb2-7d4c-48a0-bbe4-7ae58c7b33db"
        },
        "node4": {
            "class": "MovingWindow",
            "module": "neuropype.nodes.signal_processing.MovingWindow",
            "params": {
                "unit": {
                    "customized": false,
                    "type": "EnumPort",
                    "value": "seconds"
                },
                "verbose": {
                    "customized": false,
                    "type": "BoolPort",
                    "value": false
                },
                "window_length": {
                    "customized": true,
                    "type": "FloatPort",
                    "value": 3
                }
            },
            "uuid": "d0de1f4e-ea40-456e-8e9e-540fb754f8b9"
        },
        "node5": {
            "class": "MultitaperSpectrum",
            "module": "neuropype.nodes.spectral.MultitaperSpectrum",
            "params": {
                "average_over_time_window": {
                    "customized": false,
                    "type": "BoolPort",
                    "value": false
                },
                "half_bandwidth": {
                    "customized": false,
                    "type": "FloatPort",
                    "value": 2.5
                },
                "nfft": {
                    "customized": false,
                    "type": "IntPort",
                    "value": null
                },
                "num_tapers": {
                    "customized": false,
                    "type": "IntPort",
                    "value": null
                },
                "onesided": {
                    "customized": false,
                    "type": "BoolPort",
                    "value": true
                }
            },
            "uuid": "b9b1cce3-5615-414f-b2f7-14fbf3326601"
        },
        "node6": {
            "class": "TimeSeriesPlot",
            "module": "neuropype.nodes.visualization.TimeSeriesPlot",
            "params": {
                "absolute_time": {
                    "customized": false,
                    "type": "BoolPort",
                    "value": false
                },
                "always_on_top": {
                    "customized": false,
                    "type": "BoolPort",
                    "value": false
                },
                "antialiased": {
                    "customized": false,
                    "type": "BoolPort",
                    "value": false
                },
                "autoscale": {
                    "customized": false,
                    "type": "BoolPort",
                    "value": true
                },
                "background_color": {
                    "customized": false,
                    "type": "StringPort",
                    "value": "#FFFFFF"
                },
                "downsampled": {
                    "customized": false,
                    "type": "BoolPort",
                    "value": false
                },
                "initial_dims": {
                    "customized": false,
                    "type": "ListPort",
                    "value": [
                        50,
                        50,
                        700,
                        500
                    ]
                },
                "line_color": {
                    "customized": false,
                    "type": "StringPort",
                    "value": "#000000"
                },
                "marker_color": {
                    "customized": false,
                    "type": "StringPort",
                    "value": "#FF00FF"
                },
                "nans_as_zero": {
                    "customized": false,
                    "type": "BoolPort",
                    "value": false
                },
                "override_srate": {
                    "customized": false,
                    "type": "FloatPort",
                    "value": null
                },
                "scale": {
                    "customized": false,
                    "type": "FloatPort",
                    "value": 1.0
                },
                "stream_name": {
                    "customized": false,
                    "type": "StringPort",
                    "value": null
                },
                "time_range": {
                    "customized": false,
                    "type": "FloatPort",
                    "value": 5.0
                },
                "title": {
                    "customized": false,
                    "type": "StringPort",
                    "value": "Time series view"
                },
                "zero_color": {
                    "customized": false,
                    "type": "StringPort",
                    "value": "#7F7F7F7F"
                },
                "zeromean": {
                    "customized": false,
                    "type": "BoolPort",
                    "value": true
                }
            },
            "uuid": "e38a9815-afef-480e-8223-1f209b2c2de8"
        },
        "node7": {
            "class": "RecordToCSV",
            "module": "neuropype.nodes.file_system.RecordToCSV",
            "params": {
                "absolute_instance_times": {
                    "customized": false,
                    "type": "BoolPort",
                    "value": true
                },
                "cloud_account": {
                    "customized": false,
                    "type": "StringPort",
                    "value": ""
                },
                "cloud_bucket": {
                    "customized": false,
                    "type": "StringPort",
                    "value": ""
                },
                "cloud_credentials": {
                    "customized": false,
                    "type": "StringPort",
                    "value": ""
                },
                "cloud_host": {
                    "customized": false,
                    "type": "EnumPort",
                    "value": "Default"
                },
                "column_header": {
                    "customized": false,
                    "type": "BoolPort",
                    "value": true
                },
                "delete_parts": {
                    "customized": false,
                    "type": "BoolPort",
                    "value": true
                },
                "filename": {
                    "customized": true,
                    "type": "StringPort",
                    "value": "C:/Users/suhas/Desktop/prjs/golf_processing/src/untitled2.csv"
                },
                "output_root": {
                    "customized": false,
                    "type": "StringPort",
                    "value": ""
                },
                "retrievable": {
                    "customized": false,
                    "type": "BoolPort",
                    "value": false
                },
                "time_stamps": {
                    "customized": false,
                    "type": "BoolPort",
                    "value": true
                },
                "timestamp_label": {
                    "customized": false,
                    "type": "StringPort",
                    "value": "timestamp"
                }
            },
            "uuid": "ef63c0b7-610c-44ed-85c2-a15bb5bf2c29"
        },
        "node8": {
            "class": "SelectRange",
            "module": "neuropype.nodes.tensor_math.SelectRange",
            "params": {
                "apply_multiple_axes": {
                    "customized": false,
                    "type": "BoolPort",
                    "value": false
                },
                "axis": {
                    "customized": true,
                    "type": "EnumPort",
                    "value": "axis"
                },
                "selection": {
                    "customized": true,
                    "type": "Port",
                    "value": "1:3"
                },
                "unit": {
                    "customized": false,
                    "type": "EnumPort",
                    "value": "indices"
                }
            },
            "uuid": "20052cea-8e5a-4076-a8ff-ee64d91f218f"
        },
        "node9": {
            "class": "SelectRange",
            "module": "neuropype.nodes.tensor_math.SelectRange",
            "params": {
                "apply_multiple_axes": {
                    "customized": false,
                    "type": "BoolPort",
                    "value": false
                },
                "axis": {
                    "customized": true,
                    "type": "EnumPort",
                    "value": "space"
                },
                "selection": {
                    "customized": true,
                    "type": "Port",
                    "value": "1:3"
                },
                "unit": {
                    "customized": false,
                    "type": "EnumPort",
                    "value": "indices"
                }
            },
            "uuid": "883f8f71-310f-4ed7-bd4c-3bc78720ed42"
        }
    },
    "version": 1.1
}</patch>
</scheme>
