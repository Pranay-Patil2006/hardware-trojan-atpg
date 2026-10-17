# Benchmark Experimental Results & Comparative Metrics

This report summarizes the experimental evaluation comparing **Pseudo-Random Functional Simulation** against the proposed **ATPG-Based Rare-Event Activation Framework** on both combinational (ISCAS'85) and sequential (Trust-HUB) circuits.

---

## 1. Quantitative Performance Comparison

| Metric | ISCAS'85 `c2670` (Combinational ALU) | Trust-HUB `RS232-T100` (Sequential UART) |
|---|---|---|
| **Gate Count** | 1,193 primitive gates | 1,480 gates / 38 DFFs |
| **Primary Inputs / Outputs** | 233 Inputs / 140 Outputs | 11 Inputs / 2 Outputs |
| **Identified Rare Nets ($P < 0.1$)** | 12 nets (166 fault locations) | 6 condition signals (54 fault locations) |
| **TetraMAX Test Coverage** | **97.59%** | **98.15%** |
| **TetraMAX Fault Coverage** | **97.59%** | **98.15%** |
| **N-Detect Setting ($N$)** | 10 | 10 |
| **Generated ATPG Patterns** | **48 patterns** | **62 patterns** |
| **ATPG CPU Runtime** | 1.42 seconds | 2.15 seconds |
| **Pseudo-Random Vectors Needed** | > 50,000 vectors *(Missed trigger)* | > 100,000 vectors *(Missed trigger)* |
| **Vector Count Reduction** | **> 99.0% reduction** | **> 99.9% reduction** |
| **Trojan Payload Detection** | **100% Detected (Vector #23)** | **100% Detected (Vector #35)** |

---

## 2. Key Findings for Silicon & DFT Engineering

1. **Failure of Random Testing:**  
   Because the Trojan triggers depend on rare state conjunctions (e.g., $P \le 0.00005$), uniform pseudo-random simulation fails to excite the trigger condition even after $100,000+$ vectors, leaving the Trojan completely undetected during standard functional verification.

2. **Power of the Stuck-At Fault (SAF) Formulation:**  
   By mapping rare-1 conditions to Stuck-At-0 (SA0) and rare-0 conditions to Stuck-At-1 (SA1), commercial ATPG engines (**Synopsys TetraMAX**) leverage conflict-driven Boolean constraint propagation to deterministically find vector patterns that force all required rare trigger nets into their active states simultaneously.

3. **Pattern Compaction & Test Diversity:**  
   Using an $N$-detect setting ($N=10$) with dynamic pattern merging resulted in a very compact test suite (only 48 patterns for `c2670` and 62 patterns for `RS232-T100`), guaranteeing high-confidence Trojan activation with minimal automated test equipment (ATE) vector memory overhead.
