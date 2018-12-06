<?xml version='1.0' encoding='utf-8'?>
<scheme description="This pipeline can be used to show the spectrum of the EEG data.&#10; &#10;Nodes Description:&#10; &#10;- LSL Input: is used to input the streamed data into the pipeline.&#10; &#10;- Dejitter Timestamps: is used to correct timestamps of the data stream, this prevents unwanted behavior in the proceeding nodes.&#10; &#10;- IIR Filter: is used to highpass filter data to remove the DC component.&#10; &#10;- Moving Window Multitaper Spectrum: is used to calculate the spectrum of the signal using Multitaper method.&#10; &#10;Spectrum plot: is used to plot the spectral content of the signal. This node has an option to compensate for the 1/f fall off inherent in natural signals. This option has been activated for this example." title="Frequency Domain Plotting" version="2.0">
	<nodes>
		<node id="0" name="IIR Filter" position="(-300, 100)" project_name="NeuroPype" qualified_name="widgets.signal_processing.owiirfilter.OWIIRFilter" title="IIR Filter" uuid="192d4b0d-6032-48ac-a81a-5b8d5ce4d42b" version="1.1.0" />
		<node id="1" name="Dejitter Timestamps" position="(-400, 100)" project_name="NeuroPype" qualified_name="widgets.utilities.owdejittertimestamps.OWDejitterTimestamps" title="Dejitter Timestamps" uuid="f36b8737-937c-454d-a4d4-17f219f97d2b" version="1.0.0" />
		<node id="2" name="Moving Window" position="(-200, 100)" project_name="NeuroPype" qualified_name="widgets.signal_processing.owmovingwindow.OWMovingWindow" title="Moving Window" uuid="1c8306d1-aebb-4f26-9f9b-b99de7e3ddd5" version="1.0.0" />
		<node id="3" name="Power Spectrum (Multitaper)" position="(-100, 100)" project_name="NeuroPype" qualified_name="widgets.spectral.owmultitaperspectrum.OWMultitaperSpectrum" title="Power Spectrum (Multitaper)" uuid="a0174914-02c2-4bb9-bd23-62e8c8cf7abd" version="1.0.0" />
		<node id="4" name="Record to CSV" position="(-15.0, 180.0)" project_name="NeuroPype" qualified_name="widgets.file_system.owrecordtocsv.OWRecordToCSV" title="Record to CSV" uuid="4e36dfb8-537f-4f7f-a4d5-df6b1e026e72" version="1.0.0" />
		<node id="5" name="Select Range" position="(-293.0, 197.0)" project_name="NeuroPype" qualified_name="widgets.tensor_math.owselectrange.OWSelectRange" title="Select Range" uuid="529336eb-7eab-4b53-a09e-01daa917e58d" version="1.0.0" />
		<node id="6" name="Select Range" position="(-280.0, 350.0)" project_name="NeuroPype" qualified_name="widgets.tensor_math.owselectrange.OWSelectRange" title="Select Range (1)" uuid="82087418-57b2-48d8-9af5-f6257591fba5" version="1.0.0" />
		<node id="7" name="Import XDF" position="(-475.0, 351.0)" project_name="NeuroPype" qualified_name="widgets.file_system.owimportxdf.OWImportXDF" title="Import XDF" uuid="babf1894-7398-41af-9f77-bfb5e4e945e7" version="1.0.0" />
		<node id="8" name="Export Markers to CSV" position="(-18.0, 448.0)" project_name="NeuroPype" qualified_name="widgets.file_system.owexportmarkers.OWExportMarkers" title="Export Markers to CSV" uuid="d673dbdc-059b-4999-9f54-088903f1ab6d" version="1.0.0" />
	</nodes>
	<links>
		<link enabled="true" id="0" sink_channel="Data" sink_node_id="2" source_channel="Data" source_node_id="0" />
		<link enabled="true" id="1" sink_channel="Data" sink_node_id="3" source_channel="Data" source_node_id="2" />
		<link enabled="true" id="2" sink_channel="Data" sink_node_id="4" source_channel="Data" source_node_id="3" />
		<link enabled="true" id="3" sink_channel="Data" sink_node_id="5" source_channel="Data" source_node_id="1" />
		<link enabled="true" id="4" sink_channel="Data" sink_node_id="0" source_channel="Data" source_node_id="5" />
		<link enabled="true" id="5" sink_channel="Data" sink_node_id="1" source_channel="Data" source_node_id="6" />
		<link enabled="true" id="6" sink_channel="Data" sink_node_id="8" source_channel="Data" source_node_id="7" />
		<link enabled="true" id="7" sink_channel="Data" sink_node_id="6" source_channel="Data" source_node_id="7" />
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
		<properties format="literal" node_id="1">{'max_updaterate': 500, 'savedWidgetGeometry': None, 'warmup_samples': -1, 'forget_halftime': 90, 'force_monotonic': True}</properties>
		<properties format="pickle" node_id="2">gAN9cQAoWBMAAABzYXZlZFdpZGdldEdlb21ldHJ5cQFjc2lwCl91bnBpY2tsZV90eXBlCnECWAwA
AABQeVF0NC5RdENvcmVxA1gKAAAAUUJ5dGVBcnJheXEEQy4B2dDLAAEAAAAABEMAAAIpAAAFvAAA
AvMAAARMAAACTwAABbMAAALqAAAAAAAAcQWFcQaHcQdScQhYBAAAAHVuaXRxCVgHAAAAc2Vjb25k
c3EKWAcAAAB2ZXJib3NlcQuJWA0AAAB3aW5kb3dfbGVuZ3RocQxLA3Uu
</properties>
		<properties format="pickle" node_id="3">gAN9cQAoWBgAAABhdmVyYWdlX292ZXJfdGltZV93aW5kb3dxAYlYDgAAAGhhbGZfYmFuZHdpZHRo
cQJHQAQAAAAAAABYBAAAAG5mZnRxA1gNAAAAKHVzZSBkZWZhdWx0KXEEWAoAAABudW1fdGFwZXJz
cQVYDQAAACh1c2UgZGVmYXVsdClxBlgIAAAAb25lc2lkZWRxB4hYEwAAAHNhdmVkV2lkZ2V0R2Vv
bWV0cnlxCGNzaXAKX3VucGlja2xlX3R5cGUKcQlYDAAAAFB5UXQ0LlF0Q29yZXEKWAoAAABRQnl0
ZUFycmF5cQtDLgHZ0MsAAQAAAAAEQwAAAhAAAAW8AAAC2gAABEwAAAI2AAAFswAAAtEAAAAAAABx
DIVxDYdxDlJxD3Uu
</properties>
		<properties format="pickle" node_id="4">gAN9cQAoWBcAAABhYnNvbHV0ZV9pbnN0YW5jZV90aW1lc3EBiFgNAAAAY2xvdWRfYWNjb3VudHEC
WAAAAABxA1gMAAAAY2xvdWRfYnVja2V0cQRoA1gRAAAAY2xvdWRfY3JlZGVudGlhbHNxBWgDWAoA
AABjbG91ZF9ob3N0cQZYBwAAAERlZmF1bHRxB1gNAAAAY29sdW1uX2hlYWRlcnEIiFgMAAAAZGVs
ZXRlX3BhcnRzcQmIWAgAAABmaWxlbmFtZXEKWD0AAABDOi9Vc2Vycy9zdWhhcy9EZXNrdG9wL3By
anMvZ29sZl9wcm9jZXNzaW5nL3NyYy91bnRpdGxlZDIuY3N2cQtYCwAAAG91dHB1dF9yb290cQxo
A1gLAAAAcmV0cmlldmFibGVxDYlYEwAAAHNhdmVkV2lkZ2V0R2VvbWV0cnlxDmNzaXAKX3VucGlj
a2xlX3R5cGUKcQ9YDAAAAFB5UXQ0LlF0Q29yZXEQWAoAAABRQnl0ZUFycmF5cRFDLgHZ0MsAAQAA
AAADAwAAAU8AAAR8AAACmQAAAwwAAAF1AAAEcwAAApAAAAAAAABxEoVxE4dxFFJxFVgLAAAAdGlt
ZV9zdGFtcHNxFohYDwAAAHRpbWVzdGFtcF9sYWJlbHEXWAkAAAB0aW1lc3RhbXBxGHUu
</properties>
		<properties format="pickle" node_id="5">gAN9cQAoWBMAAABhcHBseV9tdWx0aXBsZV9heGVzcQGJWAQAAABheGlzcQJYBAAAAGF4aXNxA1gT
AAAAc2F2ZWRXaWRnZXRHZW9tZXRyeXEEY3NpcApfdW5waWNrbGVfdHlwZQpxBVgMAAAAUHlRdDQu
UXRDb3JlcQZYCgAAAFFCeXRlQXJyYXlxB0MuAdnQywABAAAAAAMDAAABggAABHwAAAJmAAADDAAA
AagAAARzAAACXQAAAAAAAHEIhXEJh3EKUnELWAkAAABzZWxlY3Rpb25xDFgEAAAAMDoyMHENWAQA
AAB1bml0cQ5YBwAAAGluZGljZXNxD3Uu
</properties>
		<properties format="pickle" node_id="6">gAN9cQAoWBMAAABhcHBseV9tdWx0aXBsZV9heGVzcQGJWAQAAABheGlzcQJYBQAAAHNwYWNlcQNY
EwAAAHNhdmVkV2lkZ2V0R2VvbWV0cnlxBGNzaXAKX3VucGlja2xlX3R5cGUKcQVYDAAAAFB5UXQ0
LlF0Q29yZXEGWAoAAABRQnl0ZUFycmF5cQdDLgHZ0MsAAQAAAAADAwAAAYIAAAR8AAACZgAAAwwA
AAGoAAAEcwAAAl0AAAAAAABxCIVxCYdxClJxC1gJAAAAc2VsZWN0aW9ucQxYBAAAADA6MjBxDVgE
AAAAdW5pdHEOWAcAAABpbmRpY2VzcQ91Lg==
</properties>
		<properties format="pickle" node_id="7">gAN9cQAoWA0AAABjbG91ZF9hY2NvdW50cQFYAAAAAHECWAwAAABjbG91ZF9idWNrZXRxA2gCWBEA
AABjbG91ZF9jcmVkZW50aWFsc3EEaAJYCgAAAGNsb3VkX2hvc3RxBVgHAAAARGVmYXVsdHEGWAgA
AABmaWxlbmFtZXEHWGUAAABDOi9EYXRhL0Z1aml0c3UgRGF0YSBQb3N0LVRlc3RpbmcvMTEwMTIw
MTgvMzIwOTEyMDIxOC8zMjA5MTIwMjE4X2RhbmFfdGFza3NfMjAxOC0xMS0wMV8xNS0yOS0wMF8y
LnhkZnEIWBMAAABoYW5kbGVfY2xvY2tfcmVzZXRzcQmIWBEAAABoYW5kbGVfY2xvY2tfc3luY3EK
iFgVAAAAaGFuZGxlX2ppdHRlcl9yZW1vdmFscQuIWA4AAAByZXRhaW5fc3RyZWFtc3EMWA0AAAAo
dXNlIGRlZmF1bHQpcQ1YEwAAAHNhdmVkV2lkZ2V0R2VvbWV0cnlxDmNzaXAKX3VucGlja2xlX3R5
cGUKcQ9YDAAAAFB5UXQ0LlF0Q29yZXEQWAoAAABRQnl0ZUFycmF5cRFDLgHZ0MsAAQAAAAADAwAA
AVsAAAR8AAACjQAAAwwAAAGBAAAEcwAAAoQAAAAAAABxEoVxE4dxFFJxFVgHAAAAdmVyYm9zZXEW
iXUu
</properties>
		<properties format="pickle" node_id="8">gAN9cQAoWAgAAABmaWxlbmFtZXEBWEQAAABDOi9Vc2Vycy9zdWhhcy9EZXNrdG9wL3ByanMvZ29s
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
            "node3",
            "data"
        ],
        [
            "node3",
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
            "node2",
            "data",
            "node6",
            "data"
        ],
        [
            "node6",
            "data",
            "node1",
            "data"
        ],
        [
            "node7",
            "data",
            "node2",
            "data"
        ],
        [
            "node8",
            "data",
            "node9",
            "data"
        ],
        [
            "node8",
            "data",
            "node7",
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
            "uuid": "192d4b0d-6032-48ac-a81a-5b8d5ce4d42b"
        },
        "node2": {
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
            "uuid": "f36b8737-937c-454d-a4d4-17f219f97d2b"
        },
        "node3": {
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
            "uuid": "1c8306d1-aebb-4f26-9f9b-b99de7e3ddd5"
        },
        "node4": {
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
            "uuid": "a0174914-02c2-4bb9-bd23-62e8c8cf7abd"
        },
        "node5": {
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
            "uuid": "4e36dfb8-537f-4f7f-a4d5-df6b1e026e72"
        },
        "node6": {
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
                    "value": "0:20"
                },
                "unit": {
                    "customized": false,
                    "type": "EnumPort",
                    "value": "indices"
                }
            },
            "uuid": "529336eb-7eab-4b53-a09e-01daa917e58d"
        },
        "node7": {
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
                    "value": "0:20"
                },
                "unit": {
                    "customized": false,
                    "type": "EnumPort",
                    "value": "indices"
                }
            },
            "uuid": "82087418-57b2-48d8-9af5-f6257591fba5"
        },
        "node8": {
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
                    "value": "C:/Data/Fujitsu Data Post-Testing/11012018/3209120218/3209120218_dana_tasks_2018-11-01_15-29-00_2.xdf"
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
            "uuid": "babf1894-7398-41af-9f77-bfb5e4e945e7"
        },
        "node9": {
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
            "uuid": "d673dbdc-059b-4999-9f54-088903f1ab6d"
        }
    },
    "version": 1.1
}</patch>
</scheme>
