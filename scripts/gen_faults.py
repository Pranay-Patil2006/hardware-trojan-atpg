#!/usr/bin/env python3
"""
gen_faults.py

Maps rare nodes into Stuck-At Fault (SAF) commands for Synopsys TetraMAX:
  - If node is rarely 1: define Stuck-at-0 (forces ATPG to drive node to 1).
  - If node is rarely 0: define Stuck-at-1 (forces ATPG to drive node to 0).
"""

import os
import csv
import argparse

def main():
    parser = argparse.ArgumentParser(description="Generate TetraMAX fault injection script.")
    parser.add_argument("-i", "--input", required=True, help="Path to rare nodes CSV")
    parser.add_argument("-t", "--top", default="c2670", help="Top module name")
    parser.add_argument("-o", "--output", default=None, help="Output TCL script path")
    args = parser.parse_args()

    out_file = args.output or f"results/{args.top}_faults.tcl"
    os.makedirs(os.path.dirname(out_file), exist_ok=True)

    fault_count = 0
    with open(args.input, "r") as infile, open(out_file, "w") as outfile:
        reader = csv.DictReader(infile)
        outfile.write(f"# Synopsys TetraMAX Fault Ingestion Script for {args.top}\n")
        outfile.write(f"# Generated from {os.path.basename(args.input)}\n\n")
        outfile.write("set_faults -model stuck\n")
        outfile.write("remove_faults -all\n\n")

        for row in reader:
            net = row["Net_Name"]
            rare_val = int(row["Rare_Value"])
            stuck_val = "0" if rare_val == 1 else "1"
            # Format matching standard TetraMAX batch syntax
            outfile.write(f"add_faults -stuck {stuck_val} {net}\n")
            fault_count += 1

        outfile.write("\nreport_faults -all\n")

    print(f"[{args.top}] Generated {fault_count} Stuck-At Fault targets -> {out_file}")

if __name__ == "__main__":
    main()
