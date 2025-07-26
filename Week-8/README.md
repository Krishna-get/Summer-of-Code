Architectural Report: A Deep Dive into Google's TPU v1
Overview
This report provides a comprehensive architectural analysis of Google's first-generation Tensor Processing Unit (TPU v1), a pioneering domain-specific accelerator (ASIC) designed for neural network inference. It explores the fundamental design choices that allow the TPU v1 to deliver exceptional performance and energy efficiency for deep-learning workloads in datacenters compared to contemporary CPUs and GPUs.


Project Context
This report was prepared to fulfill the assignment outlined in "Study of Publicly Available TPU Architectures". The goal was to analyze a real-world TPU and document its key architectural and performance metrics, contrasting its capabilities with simpler, student-designed hardware. This analysis moves beyond a basic FSM-controlled accelerator to explore how a unified hardware architecture can support diverse network types like CNNs and RNNs.



Key Architectural Specifications & Findings
The report details the following key features of the TPU v1:


Compute Core: The heart of the TPU is a 256x256 systolic array Matrix Multiply Unit (MXU).


It contains 

65,536 8-bit Multiply-Accumulate (MAC) units.




Performance: It achieves a peak performance of 92 TOPS (trillion operations per second).



This is calculated from its 65,536 MACs, each performing 2 operations (multiply and add), running at a 700 MHz clock speed.


Memory Hierarchy: The architecture minimizes memory bottlenecks with a deep, software-managed memory system.


On-Chip: A 24 MiB Unified Buffer acts as a scratchpad for activations, and a 4 MiB SRAM buffer holds accumulator results.


Off-Chip: 8 GiB of DDR3 DRAM is dedicated to storing model weights.


Parameter Capacity: The 8 GiB of weight memory can handle models with up to approximately 100 million 8-bit weights.

Power and Efficiency:

Typical power consumption is just 

40 W.


It delivers 30–80 times better performance per watt than contemporary CPUs and GPUs.


Network Support: The TPU v1's programmable nature and large on-chip buffer allow it to function as a unified accelerator for various models without reconfiguration.

It efficiently runs 

Fully Connected (MLP), Convolutional (CNN), and Recurrent (RNN) networks.



Report Structure
The document is organized into the following sections:

Why Domain-Specific Silicon?: The motivation behind creating a custom chip for AI.

Architectural Fundamentals: A top-level block diagram and description of key components.

Systolic Array Operation: An explanation of the core computational engine.

Quantitative Specifications: A comparative table of TPU v1, CPU, and GPU metrics.

Energy Efficiency Comparison: A chart and analysis of performance per watt.

Parameter & Memory Analysis: Details on model capacity and the memory hierarchy.

Support for Diverse Neural Networks: A breakdown of how MLPs, CNNs, and RNNs are supported.

Performance Bottlenecks & Design Lessons: A summary of limitations and subsequent improvements.

FPGA Implementation Advice: High-level guidance for designing a similar architecture.
