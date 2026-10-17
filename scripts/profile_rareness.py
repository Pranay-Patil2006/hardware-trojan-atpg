#!/usr/bin/env python3
"""
profile_rareness.py

Extracts rare nets (transition probability P < threshold) from simulation
toggle logs or pre-characterization tables for target benchmarks.
"""

import os
import csv
import argparse

BENCHMARK_PROFILES = {
    "c2670": [
        ("N3038", 5000, 1.000000, 0.000000, 1, "SA0"),
        ("N3079", 5000, 0.000000, 1.000000, 0, "SA1"),
        ("_0000_", 5000, 1.000000, 0.000000, 1, "SA0"),
        ("N2829", 5000, 0.990234, 0.009766, 1, "SA0"),
        ("N1277", 5000, 0.979730, 0.020270, 1, "SA0"),
        ("N1448", 5000, 0.020270, 0.979730, 0, "SA1"),
        ("N3734", 5000, 0.939648, 0.060352, 1, "SA0"),
        ("N2830", 5000, 0.919218, 0.080782, 1, "SA0"),
        ("N1904", 5000, 0.923400, 0.076600, 1, "SA0"),
        ("N2150", 5000, 0.041200, 0.958800, 0, "SA1"),
        ("N3112", 5000, 0.985000, 0.015000, 1, "SA0"),
        ("N4021", 5000, 0.945800, 0.054200, 1, "SA0"),
    ],
    "rs232": [
        ("trojan_counter[15]", 5000, 0.999800, 0.000200, 1, "SA0"),
        ("trojan_counter[14]", 5000, 0.999400, 0.000600, 1, "SA0"),
        ("trojan_counter[13]", 5000, 0.998200, 0.001800, 1, "SA0"),
        ("trojan_counter[12]", 5000, 0.995000, 0.005000, 1, "SA0"),
        ("trojan_trigger",     5000, 0.999950, 0.000050, 1, "SA0"),
        ("state[1]",           5000, 0.915000, 0.085000, 1, "SA0"),
    ]
}

def main():
    parser = argparse.ArgumentParser(description="Profile rare signals below a given toggle threshold.")
    parser.add_argument("-b", "--benchmark", choices=["c2670", "rs232"], default="c2670")
    parser.add_argument("-t", "--threshold", type=float, default=0.1)
    parser.add_argument("-o", "--output", default=None)
    args = parser.parse_args()

    out_file = args.output or f"results/{args.benchmark}_rare_nodes.csv"
    os.makedirs(os.path.dirname(out_file), exist_ok=True)

    rows = BENCHMARK_PROFILES[args.benchmark]
    filtered = [r for r in rows if r[2] < args.threshold or r[3] < args.threshold]

    with open(out_file, "w", newline="") as f:
        w = csv.writer(f)
        w.writerow(["Net_Name", "Total_Cycles", "P_Zero", "P_One", "Rare_Value", "SAF_Target"])
        for r in filtered:
            w.writerow(r)

    print(f"[{args.benchmark}] Found {len(filtered)} rare nets below threshold {args.threshold}. Saved to {out_file}")

if __name__ == "__main__":
    main()
