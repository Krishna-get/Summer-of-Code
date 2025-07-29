# ⚡ VHDL Neural Network Accelerator (Inference-Only)

This project is a hardware accelerator for performing high-speed inference (forward propagation) with a small, fully connected neural network. The design is implemented entirely in VHDL and is optimized for synthesis on an FPGA.

The core purpose of this design is to take a pre-trained neural network with fixed weights and biases and use it to make predictions as quickly and efficiently as possible in hardware. This version does not include any training or learning capabilities.

---

## 🚀 Features

- **High-Speed Inference**: Designed specifically for the forward pass, making it fast and efficient.
- **Fully Connected Network**: Implements a 3-4-2 network structure (3 inputs, 1 hidden layer with 4 neurons, 2 outputs).
- **Fixed Weights**: Uses constant weights and biases, representing a model that has already been trained offline.
- **Modular Design**: Built from clean, reusable VHDL modules for core hardware operations.
- **Architecturally Correct FSM**: A robust Finite-State Machine correctly orchestrates the multi-cycle dot product calculations required for each layer.

---

## 🛠️ Hardware Modules

This inference accelerator is built using three key components:

### 1. `nn_controller.vhd`
The main controller and the "brain" of the design. It contains the Finite-State Machine (FSM) that sequences all operations, manages the data flow, and controls the other modules.

### 2. `mac_unit.vhd`
The mathematical core of the accelerator. The Multiply-Accumulate unit performs the essential `(input * weight) + bias` calculations needed for the dot product operations within each neuron.

### 3. `relu_activation.vhd`
This module applies the non-linear ReLU (Rectified Linear Unit) activation function (`output = max(0, input)`). This is a critical step that allows the network to model complex relationships in the data.

---

## 🏗️ Architecture and Dataflow

The controller's FSM is designed to correctly handle the multi-step process of calculating a neuron's output:

- `S_IDLE`: Waits for the start signal to begin a new prediction.
- `S_FETCH_X`: Latches the 3-byte input vector from the `input_data` port.
- `S_MAC_H_LOOP`: Loops for 3 clock cycles. On each cycle, it uses the `mac_units` to perform one step of the dot product calculation for all 4 hidden layer neurons.
- `S_ACT_H`: Applies the ReLU activation to the final results of the hidden layer.
- `S_MAC_Y_LOOP`: Loops for 4 clock cycles. It uses the `mac_units` to calculate the dot product for the 2 output neurons, using the results from the hidden layer as its input.
- `S_ACT_Y`: Applies the final ReLU activation to the output layer.
- `S_WRITE_Y`: Places the final 2-byte prediction onto the `output_data` bus and pulses the `valid_out` signal high for one cycle to indicate the result is ready.

The FSM then returns to `S_IDLE`.

---

## 💡 How to Simulate

### 1. Set Top-Level Entity
In **Quartus**, ensure the top-level entity for synthesis is:
nn_controller


### 2. Set Testbench
For simulation, use a testbench that provides the following signals:

- `clk`
- `rst`
- `start`
- `input_data`

The original `nn_controller_tb.vhd` is suitable for this purpose.

### 3. Run Simulation

Follow these steps to simulate in **ModelSim**:

- **Clean the project**  
  `Project → Clean`

- **Run Analysis & Synthesis**  
  `Processing → Start Compilation`

- **Launch RTL Simulation**  
  `Tools → Run Simulation Tool → RTL Simulation`

- **Analyze Waveform**  
  In ModelSim, add the internal signals of the `uut` instance to the waveform window. Key signals to observe:

  - `current_state`: To see the FSM correctly stepping through the states.
  - `h_mac_counter` and `y_mac_counter`: To verify that the loops are executing for the correct number of cycles.
  - `output_data` and `valid_out`: To see the final prediction and the signal indicating it is ready.

---

## 📂 Project File Structure

├── nn_controller.vhd # Main FSM and data controller
├── mac_unit.vhd # Multiply-Accumulate logic
├── relu_activation.vhd # ReLU activation logic
├── nn_controller_tb.vhd # Testbench for simulation
