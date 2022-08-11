# read design

read_verilog iiitb_SDM.v

# generic synthesis
synth -top iiitb_SDM

# mapping to mycells.lib
dfflibmap -liberty /home/ajaykumar/iiitb_SD_1010/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
abc -liberty /home/ajaykumar/iiitb_SD_1010/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
clean
flatten
# write synthesized design
write_verilog -assert synth_ripple_carry_adder.v
