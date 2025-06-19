# Four-State Finite State Machine (FSM) in VHDL

## 📌 Project Overview
This project implements a synchronous four-state Finite State Machine (FSM) using VHDL, targeting simulation and synthesis in Intel Quartus Prime. The FSM has states A, B, C, and D, and transitions based on a single-bit input signal.

## 🧠 FSM Description
- **States**: A, B, C, D
- **Inputs**:
  - `clk` (Clock)
  - `reset` (Asynchronous Reset)
  - `input` (1-bit input)
- **Outputs**:
  - `output` (1-bit output based on current state and input)

### 🗺️ State Transitions

| Current State | Input | Next State | Output |
|---------------|-------|------------|--------|
| A             | 0     | C          | 1      |
| A             | 1     | B          | 0      |
| B             | 0     | D          | 0      |
| B             | 1     | B          | 1      |
| C             | 0     | D          | 1      |
| C             | 1     | C          | 1      |
| D             | 0     | A          | 1      |
| D             | 1     | D          | 0      |

## 🏗️ Files Included
- `fsm.vhdl` — Top-level VHDL file with FSM implementation.
- `fsm_tb.vhdl` *(optional)* — Testbench for simulating FSM behavior.

## ⚙️ How to Run (in Quartus)
1. Open **Quartus Prime**.
2. Create a new project and name it something like `fsm_project`.
3. Set `fsm.vhdl` as the top-level design entity.
4. Compile the project.
5. Use **ModelSim (if available)** to simulate with the testbench.

## ✅ Features
- Fully synchronous state transitions.
- Asynchronous reset to default state A.
- Clean, modular structure for ease of extension.

## 📸 Future Additions (Optional)
- Add waveform screenshots.
- Create a testbench with different stimulus patterns.
- Add a block diagram to visualize FSM transitions.

---

Feel free to customize this to match your own additions or specific course requirements.
