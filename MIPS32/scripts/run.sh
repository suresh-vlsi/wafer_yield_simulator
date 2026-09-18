#!/bin/bash

set -e

echo "=========================================="
echo "       MIPS32 CPU BUILD & SIMULATION"
echo "=========================================="

iverilog -o sim/mips32_cpu_test.vvp \
rtl/mips32_cpu.v \
rtl/mips32_datapath.v \
rtl/mips32_alu.v \
rtl/mips32_decoder.v \
rtl/mips32_pc.v \
rtl/mips32_register_file.v \
rtl/mips32_sign_extend.v \
rtl/mips32_instruction_memory.v \
rtl/mips32_data_memory.v \
tb/mips32_cpu_tb.v

echo ""
echo "Compilation successful."
echo ""
echo "Running simulation..."
echo ""

vvp sim/mips32_cpu_test.vvp

echo ""
echo "=========================================="
echo "       SIMULATION FINISHED"
echo "=========================================="
