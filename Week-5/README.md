# Neural Network Hardware Accelerator

## Project Overview
This repository implements a simple fully connected neural network inference engine in VHDL. It supports a 3-input → 4-hidden → 2-output architecture using 8-bit signed data. All weights and biases are preloaded as constants; only forward-propagation (inference) is implemented.

## Directory Structure

## Prerequisites
- Intel Quartus Prime Lite Edition 20.1 or later  
- ModelSim Intel FPGA Edition  
- Basic familiarity with VHDL, FSM design, and FPGA toolflows

## Building & Synthesizing
1. **Create Quartus Project**  
   - Directory: `neural_network_project/syn/`  
   - Project Name: `neural_network_fpga`  
   - Top-Level Entity: `nn_controller`  
2. **Add RTL Sources** (use relative paths from `syn/`):  
3. **(Optional)** Speed up builds by adding to `.qsf`:  
4. Run **Processing → Start Analysis & Synthesis** in Quartus.

## Running Simulation
1. In Quartus, select **Tools → Run Simulation Tool → RTL Simulation**.  
2. Compile in this order:  
3. In ModelSim, add key signals to the waveform:  
4. Apply reset, wait for `ready = '1'`, pulse `start`, and verify that `output_data` updates to non-zero values when `valid_out` asserts.

## Customizing Weights & Biases
Replace the example constant arrays in `nn_controller.vhd` with your trained network’s weight/bias values. Ensure all inputs, weights, and biases are non-zero to avoid synthesis optimizations that tie signals to GND.

## Best Practices
- Drive `start` only when `ready = '1'` to avoid missed triggers.  
- Verify per-module functionality via component-level testbenches (MAC and ReLU) before system-level tests.  
- After synthesis, use the RTL and Technology Map viewers in Quartus to confirm that weight/bias constants and input bits appear in the netlist.

## Contact & Support
For questions or issues, please reach out to your project mentor or open an issue in this repository.
