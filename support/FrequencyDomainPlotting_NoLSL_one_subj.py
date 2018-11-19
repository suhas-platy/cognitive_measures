"""This file was auto-generated by NeuroPype."""

import sys
sys.path.append( 'C:\\Program Files\\Intheon\\NeuroPype Enterprise Suite (64-bit)\\NeuroPype Enterprise\\' )

from neuropype.nodes import *
from neuropype.engine import Graph, CPE

#def FrequencyDomainPlotting_NoLSL_one_subj( xdf_filename, out_freq_out_filename, out_markers_filename ) 

# create nodes
node1 = ImportXDF(filename='C:/Data/fujitsu_flanker_data/09052018/09050118/09050118Wtsou_flanker_arrows_2018-09-05_10-40-20_1.xdf')
node2 = ExportMarkers(filename='C:/Users/suhas/Desktop/prjs/golf_processing/src/untitled2_makers.csv')
node3 = StreamData(timing='deterministic', looping=False, update_interval=1, jitter_percent=0)
node4 = SelectRange(axis='space', selection='1')
node5 = TimeSeriesPlot()
node6 = DejitterTimestamps()
node7 = SelectRange(axis='axis', selection='1')
node8 = IIRFilter(order=0, frequencies=[1, 2], mode='highpass', stop_atten=40.0)
node9 = MovingWindow(window_length=3)
node10 = MultitaperSpectrum()
node11 = RecordToCSV(filename='C:/Users/suhas/Desktop/prjs/golf_processing/src/untitled2.csv')
node12 = SpectrumPlot(stream_name='', initial_dims=[], one_over_f_correction=True, always_on_top=True)

# create flow graph
patch = Graph()
patch.connect((node1, 'data'), (node2, 'data'))
patch.connect((node1, 'data'), (node3, 'data'))
patch.connect((node3, 'data'), (node4, 'data'))
patch.connect((node4, 'data'), (node5, 'data'))
patch.connect((node4, 'data'), (node6, 'data'))
patch.connect((node6, 'data'), (node7, 'data'))
patch.connect((node7, 'data'), (node8, 'data'))
patch.connect((node8, 'data'), (node9, 'data'))
patch.connect((node9, 'data'), (node10, 'data'))
patch.connect((node10, 'data'), (node11, 'data'))
patch.connect((node10, 'data'), (node12, 'data'))

# create CPE instance and run it
cpe = CPE(graph=patch)
cpe.loop_run()