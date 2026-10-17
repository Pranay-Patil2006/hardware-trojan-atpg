#!/usr/bin/env python3
"""
verify_trojan.py

Compiles and simulates Golden vs. Trojan designs using Icarus Verilog (iverilog)
or VCS to verify cycle-accurate payload activation and log differential mismatches.
"""

import os
import sys
import subprocess
import argparse

BENCHMARK_CONFIGS = {
    "c2670": {
        "files": [
            "benchmarks/c2670/c2670_golden.v",
            "benchmarks/c2670/c2670_trojan.v",
            "benchmarks/c2670/c2670_tb.v"
        ],
        "log": "results/c2670_diff.log"
    },
    "rs232": {
        "files": [
            "benchmarks/rs232/rs232_golden.v",
            "benchmarks/rs232/rs232_t100.v",
            "benchmarks/rs232/rs232_tb.v"
        ],
        "log": "results/rs232_diff.log"
    }
}

def run_simulation(benchmark):
    cfg = BENCHMARK_CONFIGS[benchmark]
    sim_bin = f"sim_{benchmark}"
    log_path = cfg["log"]
    os.makedirs(os.path.dirname(log_path), exist_ok=True)

    # 1. Compile with iverilog
    compile_cmd = ["iverilog", "-o", sim_bin] + cfg["files"]
    print(f"[*] Compiling {benchmark} benchmark with Icarus Verilog...")
    res = subprocess.run(compile_cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
    if res.returncode != 0:
        print(f"[-] Compilation error:\n{res.stderr}")
        sys.exit(1)

    # 2. Execute simulation
    print(f"[*] Running differential simulation for {benchmark}...")
    run_cmd = [f"./{sim_bin}"]
    run_res = subprocess.run(run_cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)

    # 3. Clean up binary
    if os.path.exists(sim_bin):
        os.remove(sim_bin)

    # 4. Save and display log
    with open(log_path, "w") as f:
        f.write(run_res.stdout)

    print(f"[+] Output written to {log_path}")
    print(run_res.stdout.strip())

def main():
    parser = argparse.ArgumentParser(description="Differential Trojan verification runner.")
    parser.add_argument("-b", "--benchmark", choices=["c2670", "rs232", "all"], default="all")
    args = parser.parse_args()

    targets = ["c2670", "rs232"] if args.benchmark == "all" else [args.benchmark]
    for b in targets:
        run_simulation(b)
        print("-" * 60)

if __name__ == "__main__":
    main()
