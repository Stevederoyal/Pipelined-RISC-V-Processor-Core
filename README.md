# Pipelined RISC-V Processor Core

A 5-stage pipelined RISC-V processor core implemented in Verilog, with a hazard detection and forwarding unit to resolve data and control hazards across the pipeline.

## Overview

The processor implements the classic 5-stage RISC pipeline:

- **Fetch (IF)** — fetches the next instruction from instruction memory
- **Decode (ID)** — decodes the instruction and reads source registers
- **Execute (EX)** — performs ALU operations and resolves branch targets
- **Memory Access (MEM)** — reads/writes data memory
- **WriteBack (WB)** — writes results back to the register file

Pipeline registers between each stage carry control and data signals forward, and a dedicated hazard unit resolves both data hazards (via forwarding) and control hazards (via branch/PC-redirect logic).

## Architecture

![Pipeline Architecture](docs/architecture.png)

```
pipelined_processor_top
├── Fetch_Cycle           (IF stage)
├── Decode_Cycle          (ID stage)
│   └── Fetch_Decode_Top
│       ├── control_unit_top_mod
│       │   └── main_decoder_mod
│       └── mux3by1 (mux4by1)
├── Execute_Cycle         (EX stage)
├── Memory_Cycle          (MEM stage)
├── WriteBack_Cycle       (WB stage)
└── hazard_unit           (forwarding + hazard detection)
```

### Key components

| Module | Responsibility |
|---|---|
| **Fetch_Cycle** | Fetches instructions from instruction memory; handles PC update and branch redirection |
| **Decode_Cycle** | Decodes instructions, reads the register file, generates control signals |
| **control_unit_top_mod / main_decoder_mod** | Generates control signals (RegWrite, ALUSrc, MemWrite, Branch, etc.) based on opcode/funct fields |
| **Execute_Cycle** | Performs ALU operations, evaluates branch conditions, computes branch target address |
| **Memory_Cycle** | Performs data memory reads/writes |
| **WriteBack_Cycle** | Selects and writes the final result back to the register file |
| **hazard_unit** | Detects data hazards and generates forwarding selects (ForwardAE/ForwardBE); detects control hazards from taken branches |

## Hazard Handling

- **Data hazards**: Resolved via ALU operand forwarding from the EX/MEM and MEM/WB pipeline stages, selected using 2-bit forwarding control signals (`ForwardAE`, `ForwardBE`).
- **Control hazards**: Resolved via branch/PC-redirect logic — when a branch is taken in the Execute stage (`PCSrcE`), the Fetch stage is redirected to the computed branch target (`PCTargetE`).

## Verification

Functional correctness was verified by loading RISC-V programs into instruction memory and executing them in simulation, analyzing waveforms in Vivado to confirm correct pipeline behavior (register writes, memory accesses, and branch redirection) across all five stages.

## Tools

- **Simulator / Synthesis:** Xilinx Vivado
- **Language:** Verilog

## Repository Structure

```
├── rtl/
│   ├── pipelined_processor_top.v
│   ├── Fetch_Cycle.v
│   ├── Decode_Cycle.v
│   ├── Fetch_Decode_Top.v
│   ├── control_unit_top_mod.v
│   ├── main_decoder_mod.v
│   ├── mux3by1.v
│   ├── Execute_Cycle.v
│   ├── Memory_Cycle.v
│   ├── WriteBack_Cycle.v
│   └── hazard_unit.v
├── docs/
│   └── architecture.png
└── README.md
```

## Author

**Stephen Tagoe**
[GitHub](https://github.com/Stevederoyal) | [LinkedIn](https://linkedin.com/in/stephen-tagoe-7588a61b7/)
