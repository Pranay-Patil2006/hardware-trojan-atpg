#!/usr/bin/env bash
# Hardware Trojan Detection via ATPG Rare-Event Activation
# Run Script for ISCAS c2670 and Trust-HUB RS232-T100

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd "$DIR"

echo "=== Step 1: Profiling Rare Internal Nets (P < 0.1) ==="
python3 scripts/profile_rareness.py -b c2670 -t 0.1
python3 scripts/profile_rareness.py -b rs232 -t 0.1

echo ""
echo "=== Step 2: Generating Stuck-At Fault (SAF) Targets ==="
python3 scripts/gen_faults.py -i results/c2670_rare_nodes.csv -t c2670
python3 scripts/gen_faults.py -i results/rs232_rare_nodes.csv -t rs232_golden -o results/rs232_faults.tcl

echo ""
echo "=== Step 3: ATPG Generation ==="
if command -v tmax &> /dev/null; then
    echo "[*] Found Synopsys TetraMAX. Running live ATPG..."
    export TOP_MODULE=c2670
    tmax -shell < scripts/run_tetramax.tcl
else
    echo "[*] Synopsys TetraMAX not in PATH. Reference ATPG execution logs preserved in results/."
fi

echo ""
echo "=== Step 4: Differential Simulation & Trojan Verification (Icarus Verilog) ==="
python3 scripts/verify_trojan.py -b all

echo ""
echo "=== Done. All outputs saved to results/ ==="
