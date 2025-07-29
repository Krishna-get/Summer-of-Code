VHDL Neural Network Accelerator
This project is a hardware accelerator for a small neural network, built entirely in VHDL. It's a complete, learning-capable processor designed to be run on an FPGA.

This design demonstrates how machine learning algorithms can be implemented directly in hardware, which can lead to significant gains in performance and efficiency compared to running them on a standard CPU.

🚀 Key Features
Complete Neural Network: Implements a 3-4-2 fully connected network (3 inputs, a hidden layer with 4 neurons, and 2 outputs).

Forward Propagation: Can take an input and make a prediction (inference) using its current weights.

Backward Propagation: Can learn from its mistakes. It has a full training cycle that calculates the error and updates its weights using gradient descent.

Modular Hardware Design: The project is built from clean, reusable VHDL modules for each part of the neural network.

FSM Control: A central Finite-State Machine acts as the "brain," managing the complex, multi-step calculations for both making predictions and learning.

🛠️ The Hardware Modules
The accelerator is built from several specialized VHDL components that work together.

1. nn_controller.vhd
This is the main controller and the most important part of the design. It contains the state machine that tells all the other modules what to do and when to do it, coordinating the entire forward and backward propagation process.

2. mac_unit.vhd
This is the math core of the project. The Multiply-Accumulate unit does the heavy lifting, performing the (input * weight) + bias calculations that are fundamental to how neurons work.

3. relu_activation.vhd
This module applies the ReLU (Rectified Linear Unit) activation function. After the mac_unit calculates a result, this module applies the non-linear max(0, input) function. This step is essential for allowing the network to learn complex, non-linear patterns.

4. error_calculator.vhd
This is the first step of the learning process. It figures out how "wrong" a neuron's prediction was by comparing the actual output to the correct (target) output. It also cleverly uses the derivative of the activation function, a key part of the backpropagation algorithm.

5. weight_updater.vhd
This is where the learning actually happens. It takes the error calculated by the error_calculator and uses it to make a small adjustment to the neuron's weight, following the gradient descent rule: new_weight = old_weight - (error * learning_rate).

🏗️ How It Works: The Dataflow
The controller's state machine is designed to handle the step-by-step calculations needed for the neural network.

Forward Pass (Making a Prediction)
S_IDLE: Waits for the start signal.

S_FETCH_X: Grabs the input data.

S_MAC_H_LOOP: Loops for 3 clock cycles to calculate the results for the hidden layer's 4 neurons.

S_ACT_H: Applies the ReLU function to the hidden layer.

S_MAC_Y_LOOP: Loops for 4 clock cycles to calculate the results for the output layer's 2 neurons.

S_ACT_Y: Applies the final ReLU function.

S_WRITE_Y: Puts the final prediction on the output_data bus and signals that it's valid.

Backward Pass (Learning)
If the train_mode signal is active, the controller doesn't stop. It seamlessly continues to:

S_CALC_ERROR: Activates the error_calculator modules to figure out the error for the output neurons.

S_UPDATE_WEIGHTS: Activates the weight_updater modules. They use the calculated error to compute the new, slightly improved weights. The controller then updates its internal weights and signals that the training cycle is complete.

The FSM then goes back to S_IDLE, ready for the next task.

💡 How to Simulate
Set Top-Level Entity: In Quartus, make sure your top-level entity for synthesis is nn_controller.

Set Testbench: For simulation, use the nn_controller_tb.vhd testbench. It's already set up to run a full training cycle.

Run Simulation:

First, clean the project (Project -> Clean).

Then, run Analysis & Synthesis.

Finally, launch the simulation (Tools -> Run Simulation Tool -> RTL Simulation).

Check the Waveform: In Modelsim, add the internal signals from the uut to the wave window. You'll want to see:

current_state: To watch the FSM move through all the states.

h_mac_counter & y_mac_counter: To make sure the loops are working.

output_data: To see the network's final prediction.

W2: To see the weight values physically change after the S_UPDATE_WEIGHTS state, which is the ultimate proof that your network is learning!
