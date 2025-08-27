-- project     : venera_cpu_1
-- data        : 27.08.2025
-- author      : siarhei baldzenka
-- e-mail      : venera.electronica@gmail.com
-- description : .do-file with waves list for questasim/modelsim.

add wave -noupdate -divider testbench
add wave -noupdate -format Logic -radix HEXADECIMAL -group {testbench} /venera_cpu_1_tb/*

add wave -noupdate -divider reset_module
add wave -noupdate -format Logic -radix HEXADECIMAL -group {reset_module} /venera_cpu_1_tb/reset_module_inst/*

add wave -noupdate -divider instruction_memory
add wave -noupdate -format Logic -radix HEXADECIMAL -group {instruction_memory} /venera_cpu_1_tb/instruction_memory_inst/*

add wave -noupdate -divider data_memory
add wave -noupdate -format Logic -radix HEXADECIMAL -group {data_memory} /venera_cpu_1_tb/data_memory_inst/*

add wave -noupdate -divider top
add wave -noupdate -format Logic -radix HEXADECIMAL -group {top} /venera_cpu_1_tb/venera_cpu_1_inst/*

add wave -noupdate -divider address_counter
add wave -noupdate -format Logic -radix HEXADECIMAL -group {address_counter} /venera_cpu_1_tb/venera_cpu_1_inst/address_counter_inst/*

add wave -noupdate -divider controller
add wave -noupdate -format Logic -radix HEXADECIMAL -group {controller} /venera_cpu_1_tb/venera_cpu_1_inst/controller_inst/*

add wave -noupdate -divider accumulator
add wave -noupdate -format Logic -radix HEXADECIMAL -group {accumulator} /venera_cpu_1_tb/venera_cpu_1_inst/accumulator_inst/*

add wave -noupdate -divider alu
add wave -noupdate -format Logic -radix HEXADECIMAL -group {alu} /venera_cpu_1_tb/venera_cpu_1_inst/alu_inst/*



configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps 