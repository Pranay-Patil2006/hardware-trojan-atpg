# Synopsys TetraMAX Fault Ingestion Script for rs232_golden
# Generated from rs232_rare_nodes.csv

set_faults -model stuck
remove_faults -all

add_faults -stuck 0 trojan_counter[15]
add_faults -stuck 0 trojan_counter[14]
add_faults -stuck 0 trojan_counter[13]
add_faults -stuck 0 trojan_counter[12]
add_faults -stuck 0 trojan_trigger
add_faults -stuck 0 state[1]

report_faults -all
