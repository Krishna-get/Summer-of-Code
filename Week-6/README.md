# 🤖 VHDL Neural Network Accelerator (Training + Inference)

This project is a **hardware accelerator for a small neural network**, built entirely in **VHDL**. It's a complete, **learning-capable processor** designed to be run on an **FPGA**.

It demonstrates how machine learning algorithms can be implemented **directly in hardware**, offering significant gains in performance and efficiency over traditional CPU-based execution.

---

## 🚀 Key Features

- **Complete Neural Network**  
  Implements a **3-4-2 fully connected network**:  
  - 3 input neurons  
  - 1 hidden layer with 4 neurons  
  - 2 output neurons

- **Forward Propagation**  
  Accepts input and produces a prediction (inference) using current weights.

- **Backward Propagation (Learning)**  
  Fully supports **training** using **error calculation** and **gradient descent** to update weights.

- **Modular Hardware Design**  
  Composed of **clean, reusable VHDL modules** for each function of the neural network.

- **FSM Control**  
  A centralized **Finite-State Machine** (FSM) coordinates all steps in both inference and learning phases.

---

## 🛠️ Hardware Modules

The accelerator is composed of several specialized VHDL components working together:

### 1. `nn_controller.vhd`
- The **main controller** and central processing unit.
- Contains the **FSM** that orchestrates both the **forward** and **backward** passes.
- Manages signals, data movement, and activation of submodules.

### 2. `mac_unit.vhd`
- The **math core** of the neural network.
- Performs the Multiply-Accumulate operation:  
  \[(input × weight) + bias\]  
  which is fundamental to each neuron's computation.

### 3. `relu_activation.vhd`
- Applies the **ReLU activation function**:  
  \[output = max(0, input)\]
- Introduces non-linearity, allowing the network to model complex relationships.

### 4. `error_calculator.vhd`
- Computes the error between the predicted output and the target (actual) output.
- Also calculates the **derivative of the activation function**, which is crucial for gradient-based learning.

### 5. `weight_updater.vhd`
- Responsible for **adjusting weights** using the gradient descent formula:  
  \[new\_weight = old\_weight - (error × learning\_rate)\]
- Receives error signals and updates weights accordingly.

---

## 🏗️ Architecture and Dataflow

The system is governed by an FSM in the `nn_controller` that follows these phases:

### 🔁 Forward Pass (Inference)

| State        | Description |
|--------------|-------------|
| `S_IDLE`     | Waits for the `start` signal. |
| `S_FETCH_X`  | Fetches the 3-byte input vector. |
| `S_MAC_H_LOOP` | Loops for 3 cycles to compute the hidden layer neuron values. |
| `S_ACT_H`    | Applies the ReLU function to hidden layer results. |
| `S_MAC_Y_LOOP` | Loops for 4 cycles to compute output neuron values. |
| `S_ACT_Y`    | Applies ReLU to output layer. |
| `S_WRITE_Y`  | Outputs the 2-byte prediction on `output_data` and signals `valid_out`. |

### 🧠 Backward Pass (Learning)

If `train_mode` is enabled, the FSM continues into training mode:

| State            | Description |
|------------------|-------------|
| `S_CALC_ERROR`   | Invokes `error_calculator` to compute output error. |
| `S_UPDATE_WEIGHTS` | Activates `weight_updater` to adjust weights based on error and learning rate. |
| _Return to_ `S_IDLE` | Training cycle complete; ready for next operation. |

---

## 💡 How to Simulate

### ✅ Set Top-Level Entity

In **Intel Quartus**, ensure your top-level synthesis entity is:  

### 🧪 Set Testbench

Use the provided `nn_controller_tb.vhd` testbench, which is already configured to:

- Stimulate a **full training cycle**
- Provide:
  - `clk` (clock)
  - `rst` (reset)
  - `start`
  - `input_data`
  - `target_output`
  - `train_mode` flag

### ▶️ Run Simulation

1. **Clean the project**  
   `Project → Clean`

2. **Run Analysis & Synthesis**  
   `Processing → Start Compilation`

3. **Launch Simulation**  
   `Tools → Run Simulation Tool → RTL Simulation`

4. **Check Waveform in ModelSim**  
   Add internal signals from the `uut` instance to the wave window. Important signals to observe:

   - `current_state`: Track FSM progression through all forward and backward states.
   - `h_mac_counter` and `y_mac_counter`: Ensure MAC loops execute correctly.
   - `output_data`: See final predictions after each forward pass.
   - `W2`: Watch weights change in real time during `S_UPDATE_WEIGHTS` — proof of **hardware learning**.

---

## 📂 Project File Structure

├── nn_controller.vhd # Main FSM and orchestrator
├── mac_unit.vhd # Multiply-Accumulate logic
├── relu_activation.vhd # ReLU non-linearity
├── error_calculator.vhd # Error and gradient calculation
├── weight_updater.vhd # Weight update via gradient descent
├── nn_controller_tb.vhd # Testbench for simulation and training
