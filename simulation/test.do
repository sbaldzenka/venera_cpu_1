-- project     : venera_cpu_1
-- data        : 27.08.2025
-- author      : siarhei baldzenka
-- e-mail      : venera.electronica@gmail.com
-- description : .do-file with .hdl-files list for questasim/modelsim.

vlib work
vmap work work

vlog ../tb/venera_cpu_1_tb.v

vlog ../hdl/periph_modules/reset_module.v
vlog ../hdl/periph_modules/instruction_memory/instruction_memory.v
vlog ../hdl/periph_modules/data_memory/data_memory.v


vlog ../hdl/cpu/venera_cpu_1.v
vlog ../hdl/cpu/address_counter.v
vlog ../hdl/cpu/controller.v
vlog ../hdl/cpu/accumulator.v
vlog ../hdl/cpu/alu.v

vsim -t 1ps -voptargs=+acc=lprn -lib work -L work venera_cpu_1_tb

do wave_test.do 
view wave
run 100 us