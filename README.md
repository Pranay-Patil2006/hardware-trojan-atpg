# Hardware Trojan Detection via Rare-Event ATPG Activation

Implementation of an automated test pattern generation (ATPG) flow to detect stealthy Hardware Trojans (HTs) in gate-level netlists. Based on the rare-event activation methodology described by Jayasena & Mishra (IEEE TCAD 2023).

---

## Overview

Hardware Trojans are designed to stay inactive during standard verification by attaching their triggers to **rare events**—signals or states with very low transition probabilities ($P < 0.1$). Random testing often requires hundreds of thousands of cycles and still fails to activate these triggers.

Instead of relying on heuristic search (e.g., MERO) or exponential SAT formulations (e.g., TARMAC), this project maps the rare-event activation problem into standard manufacturing test:
1. **Stuck-at Fault (SAF) Mapping:** If an internal net $X$ rarely takes value `1`, an artificial **Stuck-at-0 (SA0)** fault is placed on $X$. To detect SA0, the ATPG engine is mathematically required to find an input vector that drives $X = 1$. Similarly, rare-0 nets are mapped to **SA1**.
2. **N-Detect Diversity:** An $N$-detect policy ($N=10$) forces the ATPG solver to excite each rare net under multiple diverse circuit states, activating complex multi-signal trigger conjunctions.
3. **Differential Detection:** The generated test suite is applied to both the Golden Netlist and the suspected netlist. Any output discrepancy flags the activation of a malicious payload.

---

## Flow Diagram

```
+-------------------------------------------------------------+
| 1. Rareness Profiling (Python / VCS)                        |
|    Identify nets with toggle probability P < 0.1             |
+------------------------------+------------------------------+
                               |
                               v
+-------------------------------------------------------------+
| 2. Fault List Generation (gen_faults.py)                    |
|    Rare-1 -> Stuck-at-0 (SA0) | Rare-0 -> Stuck-at-1 (SA1)  |
+------------------------------+------------------------------+
                               |
                               v
+-------------------------------------------------------------+
| 3. ATPG Test Generation (Synopsys TetraMAX, N=10)           |
|    Synthesize compact, high-diversity test vector suite      |
+------------------------------+------------------------------+
                               |
                               v
+-------------------------------------------------------------+
| 4. Differential Verification (Icarus Verilog / VCS)          |
|    Compare Golden vs. Trojan output -> Flag mismatches       |
+-------------------------------------------------------------+
```

---

## Experimental Results

Evaluated on combinational logic (**ISCAS'85 `c2670`**) and a sequential UART core (**Trust-HUB `RS232-T100`**):

| Metric | ISCAS'85 `c2670` (ALU) | Trust-HUB `RS232-T100` (UART) |
|---|---|---|
| **Gate Count** | 1,193 gates | 1,480 gates / 38 DFFs |
| **Identified Rare Nets ($P < 0.1$)** | 12 nets (166 fault locations) | 6 condition signals (54 fault locations) |
| **TetraMAX Test Coverage** | **97.59%** | **98.15%** |
| **N-Detect Setting ($N$)** | 10 | 10 |
| **Generated Test Patterns** | **48 patterns** | **62 patterns** |
| **ATPG Runtime** | 1.42 s | 2.15 s |
| **Random Vectors Needed** | > 50,000 *(Missed trigger)* | > 100,000 *(Missed trigger)* |
| **Vector Count Reduction** | **> 99.0%** | **> 99.9%** |
| **Trojan Detection** | **100% (Vector #23)** | **100% (Vector #35)** |

### Sample Output Log (`c2670`):
```text
[MISMATCH DETECTED] Vector #23 | Golden N196_O = 0, Trojan N196_O = 1
  >>> HARDWARE TROJAN TRIGGER CONDITION ACTIVATED (N1448=0, N2830=1, N3734=1)!
>>> VERIFICATION RESULT: MALICIOUS IMPLANT DETECTED <<<
```

---

## Repository Structure

```text
.
|-- README.md
|-- run.sh                          # Master execution script
|-- benchmarks/
|   |-- c2670/                      # ISCAS'85 ALU benchmark
|   |   |-- c2670_golden.v          # Clean gate-level netlist
|   |   |-- c2670_trojan.v          # Netlist with rare trigger implant
|   |   `-- c2670_tb.v              # Verification testbench
|   `-- rs232/                      # Trust-HUB UART benchmark
|       |-- rs232_golden.v          # Clean UART transmitter
|       |-- rs232_t100.v            # UART with rare counter payload
|       `-- rs232_tb.v              # Verification testbench
|-- scripts/
|   |-- profile_rareness.py         # Extracts nets with P < threshold
|   |-- gen_faults.py               # Generates TetraMAX fault script
|   |-- run_tetramax.tcl            # Synopsys TetraMAX batch script
|   `-- verify_trojan.py            # Runs differential simulation (iverilog/VCS)
`-- results/
    |-- c2670_rare_nodes.csv        # Identified rare nets and toggle probabilities
    |-- c2670_faults.tcl            # Generated TetraMAX fault injection script
    |-- c2670_tetramax.log          # TetraMAX ATPG run log (97.59% coverage)
    |-- c2670_diff.log              # Cycle-accurate differential simulation log
    |-- rs232_diff.log              # RS232 differential simulation log
    `-- summary_table.md            # Detailed comparative metrics
```

---

## Requirements & Execution

### Prerequisites
- Python 3.8+
- Icarus Verilog (`iverilog`) for local simulation regression
- Synopsys TetraMAX and Design Compiler (for commercial ATPG run)

### Running the Flow
```bash
chmod +x run.sh scripts/*.py
./run.sh
```

If Synopsys TetraMAX is not available in the execution environment, the script runs local Icarus Verilog simulation and verifies against the pre-characterized ATPG logs in `results/`.

---

## References

- A. Jayasena and P. Mishra, *"Scalable Detection of Hardware Trojans Using ATPG-Based Activation of Rare Events,"* in IEEE Transactions on Computer-Aided Design of Integrated Circuits and Systems (TCAD), vol. 42, no. 12, pp. 4450-4462, Dec. 2023.
- Reference repository: [Archfx/TrojanWars](https://github.com/Archfx/TrojanWars).
- Hardware Trojan benchmarks from [Trust-HUB](https://trust-hub.org/benchmarks).
