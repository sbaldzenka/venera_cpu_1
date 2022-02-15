vlib work
vmap work work

vlog ../hdl/venera_cpu_1.v
vlog ../hdl/address_counter.v
vlog ../hdl/reset_module.v
vlog ../hdl/controller.v
vlog ../hdl/accumulator.v
vlog ../hdl/alu.v

vlog instruction_memory.v
vlog data_memory.v
vlog venera_cpu_1_tb.v

vsim -t 1ps -novopt -lib work -L work venera_cpu_1_tb

do wave_test.do 
view wave
run 1 us