# Synopsys TetraMAX Fault Ingestion Script for c2670
# Generated from c2670_rare_nodes.csv

set_faults -model stuck
remove_faults -all

add_faults -stuck 0 N3038
add_faults -stuck 1 N3079
add_faults -stuck 0 _0000_
add_faults -stuck 0 N2829
add_faults -stuck 0 N1277
add_faults -stuck 1 N1448
add_faults -stuck 0 N3734
add_faults -stuck 0 N2830
add_faults -stuck 0 N1904
add_faults -stuck 1 N2150
add_faults -stuck 0 N3112
add_faults -stuck 0 N4021

report_faults -all
