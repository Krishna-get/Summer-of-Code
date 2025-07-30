#  VHDL Hardware Acceleration for AI  
### A Summer of Science Project at IIT Bombay

This repository documents the complete journey of designing, implementing, and verifying a **learning‑capable neural network accelerator** in **VHDL**. From foundational digital logic to a full training+inference engine, and capped with an architectural study of Google’s TPU v1, this project bridges academic design and industry‑grade AI hardware.

---

## 📖 Project Journey & Timeline

**Duration:** 8 weeks  
**Tools:** Intel Quartus Prime (synthesis), ModelSim (simulation)

| Weeks       | Focus Area                                            |
|-------------|-------------------------------------------------------|
| **1–2**     | VHDL Fundamentals & Combinational Logic               |
| **3–4**     | Sequential Logic & Finite‑State Machines (FSMs)       |
| **5–7**     | Building the Neural Network Accelerator (Inference + Training) |
| **8**       | Research & Industry Context (TPU v1 Architectural Study)       |

### Weeks 1–2: VHDL Fundamentals & Combinational Logic
- **Environment Setup**  
  – Installed Intel Quartus Prime & ModelSim.  
- **Core Philosophy**  
  – Built a universal NAND gate (`NAND_pkg.vhd`), then derived AND, OR, XOR, NOT.  
- **Combinational Circuits**  
  – Full Adders/Subtractors → 4‑bit Ripple‑Carry Adders/Subtractors.  
  – Multiplexers: 2‑to‑1, 4‑to‑1, 8‑to‑1 MUXes.  
- **Verification**  
  – Testbenches for each component; RTL schematic checks; waveform validation in ModelSim.

### Weeks 3–4: Sequential Logic & FSMs
- **Memory Elements**  
  – D Flip‑Flops → 8‑bit registers.  
- **FSM Design**  
  – Studied Mealy vs. Moore; chose Mealy for speed.  
  – Implemented a sequence detector to reinforce state‑machine concepts.  
- **Verification**  
  – Comprehensive testbenches; waveform analysis for state transitions and timing.

### Weeks 5–7: Building the Neural Network Accelerator
- **Phase 1 – Forward Propagation (Inference)**  
  – Designed `nn_controller` FSM with looping states (`S_MAC_H_LOOP`, `S_MAC_Y_LOOP`) and internal counters to handle multi‑cycle dot‑product calculations.
- **Phase 2 – Backward Propagation (Training)**  
  – Integrated `error_calculator` & `weight_updater`.  
  – Extended FSM with `S_CALC_ERROR` and `S_UPDATE_WEIGHTS` states under a `train_mode` input.
- **Debugging Challenges**  
  – Resolved VHDL syntax/type mismatches (SIGNED vs. STD_LOGIC_VECTOR).  
  – Eliminated inferred‑latch warnings by proper reset initialization.  
  – Fixed simulation errors (“index out of bounds”, “not globally static”) by refactoring generate loops into explicit instantiations.

### Week 8: Research & Industry Context
- **Architectural Study of Google TPU v1**  
  – Explored systolic arrays, quantization strategies, and specialized memory hierarchies.  
  – Compared performance/efficiency trade‑offs between academic design and TPU architecture.

---

## 🚀 Final Accelerator: Features & Architecture

- **Topology**: 3 inputs → 4 hidden neurons → 2 outputs  
- **Dual‑Mode Operation**:  
  - **Inference** (fast forward pass)  
  - **Training** (full backpropagation & weight updates via gradient descent)  
- **Backpropagation Engine**: Hardware implementation of gradient descent  
- **Modular & Hierarchical**: Independently verified VHDL modules  
- **Mealy FSM**: Coordinates multi‑cycle MAC and weight‑update loops  

---

## 🛠️ Hardware Modules

| Module                  | Function                                                                 |
|-------------------------|--------------------------------------------------------------------------|
| **nn_controller.vhd**   | Top‑level FSM controller for inference & training                       |
| **mac_unit.vhd**        | Multiply‑Accumulate: `(input × weight) + bias`                           |
| **relu_activation.vhd** | ReLU non‑linearity: `max(0, input)`                                      |
| **error_calculator.vhd**| Computes output error & activation derivative for backpropagation       |
| **weight_updater.vhd**  | Updates weights: `new_weight = old_weight − (error × learning_rate)`    |

---

## 💡 How to Simulate the Final Design

1. **Set Top‑Level Entity**  
   In Quartus: `nn_controller`

2. **Configure Testbench**  
   Use **`nn_controller_tb.vhd`**, which drives:  
clk, rst, start, input_data, target_output, train_mode

3. **Simulation Steps**  
- **Compile**: `Processing → Start Compilation` (0 errors/warnings)  
- **Launch RTL Simulation**: `Tools → Run Simulation Tool → RTL Simulation`

4. **Waveform Verification** (ModelSim)  
Add the following signals from the `uut` instance:  
- `current_state` (observe inference → backpropagation → idle)  
- `h_mac_counter`, `y_mac_counter` (loop iteration counts)  
- `output_data` (inference result)  
- `W2`, `W2_new` (weight values before/after update)  
- `training_complete` (pulse indicating end of training cycle)

---
