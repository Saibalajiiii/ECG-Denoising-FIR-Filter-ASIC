set PDK_PATH ./../ref

create_lib -ref_lib $PDK_PATH/lib/ndm/saed32rvt_c.ndm filter_64_LIB

read_verilog {./../DC/results/filter_64.mapped.v} -library filter_64_LIB -design filter_64 -top filter_64

#open the lib and block after saving
#open_lib FULL_ADDER_LIB
#open_block FULL_ADD


# FloorPlan settings
#
#scenario1:
##
initialize_floorplan
set_individual_pin_constraints -ports [get_ports {x}] -sides 1
place_pins -self
set_individual_pin_constraints -ports [get_ports {clk}] -sides 1
place_pins -self
set_individual_pin_constraints -ports [get_ports {y}] -sides 3
place_pins -self

create_placement -floorplan
#
save_block -as filter_64
save_lib

#scenario2:
###
#initialize_floorplan -shape R -core_offset 1
#set_individual_pin_constraints -ports [get_ports A] -sides 2
#place_pins -self
#create_placement -floorplan -effort very_low 

#

