# Synopsys TetraMAX ATPG Script for Hardware Trojan Rare-Event Activation
# Target Technology: SAED 90nm EDK / Generic Library
# Usage: tmax -shell < scripts/run_tetramax.tcl

if {[info exists env(TOP_MODULE)]} {
    set TOP $env(TOP_MODULE)
} else {
    set TOP "c2670"
}

set_messages -log results/${TOP}_tetramax.log -replace
set_commands noabort

# 1. Read library and synthesized gate-level netlist
# (In lab environment, set search_path to your PDK library directory)
read_netlist benchmarks/${TOP}/${TOP}_golden.v -library
run_build_model $TOP

# 2. DRC Verification
run_drc

# 3. Stuck-At Fault Injection from generated rare-nodes script
set_faults -model stuck
remove_faults -all

if {[file exists results/${TOP}_faults.tcl]} {
    source results/${TOP}_faults.tcl
} else {
    puts "[-] Fault script results/${TOP}_faults.tcl not found."
    exit 1
}

# 4. N-Detect ATPG Configuration (N=10)
set_atpg -ndetect 10 -abort_limit 100 -merge high -auto_compression on
run_atpg -auto_compression

# 5. Fault Coverage Reporting & Export
report_faults -summary
write_patterns results/${TOP}_atpg.patterns -format stil -replace

puts "ATPG completed for $TOP."
exit
