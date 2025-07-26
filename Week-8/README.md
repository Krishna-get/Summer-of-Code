# Architectural Report: A Deep Dive into Google's TPU v1

## Overview

[cite_start]This report provides a comprehensive architectural analysis of Google's first-generation Tensor Processing Unit (TPU v1), a pioneering domain-specific accelerator (ASIC) designed for neural network inference[cite: 33, 38]. [cite_start]It explores the fundamental design choices that allow the TPU v1 to deliver exceptional performance and energy efficiency for deep-learning workloads in datacenters compared to contemporary CPUs and GPUs[cite: 37, 41].

The document serves as a case study in hardware design for neural networks, covering everything from the top-level block diagram to the underlying systolic array computation model.

## Project Context

[cite_start]This report was prepared to fulfill the assignment outlined in "Study of Publicly Available TPU Architectures" (SoC_Final_week.pdf)[cite: 1, 14]. [cite_start]The goal was to analyze a real-world TPU and document its key architectural and performance metrics, contrasting its capabilities with simpler, student-designed hardware[cite: 14, 22]. [cite_start]This analysis moves beyond a basic FSM-controlled accelerator to explore how a unified hardware architecture can support diverse network types like CNNs and RNNs[cite: 21, 22].

## Key Architectural Specifications & Findings

The report details the following key features of the TPU v1:

* [cite_start]**Compute Core**: The heart of the TPU is a 256x256 systolic array Matrix Multiply Unit (MXU)[cite: 49].
    * [cite_start]It contains **65,536** 8-bit Multiply-Accumulate (MAC) units[cite: 49, 95].
* [cite_start]**Performance**: It achieves a peak performance of **92 TOPS** (trillion operations per second)[cite: 49, 83].
    * [cite_start]This is calculated from its 65,536 MACs, each performing 2 operations (multiply and add), running at a 700 MHz clock speed[cite: 83].
* [cite_start]**Memory Hierarchy**: The architecture minimizes memory bottlenecks with a deep, software-managed memory system[cite: 36, 85].
    * [cite_start]**On-Chip**: A **24 MiB Unified Buffer** acts as a scratchpad for activations, and a 4 MiB SRAM buffer holds accumulator results[cite: 50, 51].
    * [cite_start]**Off-Chip**: **8 GiB of DDR3 DRAM** is dedicated to storing model weights (parameters)[cite: 47].
* [cite_start]**Parameter Capacity**: The 8 GiB of weight memory can handle models with up to approximately **100 million** 8-bit weights[cite: 80].
* **Power and Efficiency**:
    * [cite_start]Typical power consumption is just **40 W**[cite: 74, 90].
    * [cite_start]It delivers 30–80 times better performance per watt than contemporary CPUs and GPUs[cite: 62]. [cite_start]In a direct comparison, it achieves 2.3 TOPS/W, while a Haswell CPU offers 0.009 and an NVIDIA K80 GPU offers 0.029[cite: 74].
* [cite_start]**Network Support**: The TPU v1's programmable nature and large on-chip buffer allow it to function as a unified accelerator for various models without reconfiguration[cite: 108].
    * [cite_start]It efficiently runs **Fully Connected (MLP)** networks, where matrix-vector operations map directly to the systolic array[cite: 99].
    * [cite_start]It handles **Convolutional Neural Networks (CNNs)** by transforming convolutions into matrix multiplications (`im2col`)[cite: 102].
    * [cite_start]It accelerates **Recurrent Neural Networks (RNNs)** through temporal unrolling and batched timesteps[cite: 105].

## Report Structure

The document is organized into the following sections:

1.  **Why Domain-Specific Silicon?**: The motivation behind creating a custom chip for AI.
2.  **Architectural Fundamentals**: A top-level block diagram and description of key components.
3.  **Systolic Array Operation**: An explanation of the core computational engine.
4.  **Quantitative Specifications**: A comparative table of TPU v1, CPU, and GPU metrics.
5.  **Energy Efficiency Comparison**: A chart and analysis of performance per watt.
6.  **Parameter & Memory Analysis**: Details on model capacity and the memory hierarchy.
7.  **Support for Diverse Neural Networks**: A breakdown of how MLPs, CNNs, and RNNs are supported.
8.  **Performance Bottlenecks & Design Lessons**: A summary of limitations and subsequent improvements in later TPU versions.
9.  **FPGA Implementation Advice**: High-level guidance for designing a similar architecture in an FPGA.

[cite_start]This structure is designed to satisfy every requirement listed in the `SoC_Final_week.pdf` assignment[cite: 34].
