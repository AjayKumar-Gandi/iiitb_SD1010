# read design

read_verilog iiitb_SDM.v

# generic synthesis
synth -top iiitb_SDM

# mapping to mycells.lib
read_liberty -lib //home/ajaykumar/iiitb_SD_101011/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
dfflibmap -liberty /home/ajaykumar/iiitb_SD_101011/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
abc -liberty /home/ajaykumar/iiitb_SD_101011/lib/sky130_fd_sc_hd__tt_025C_1v80.lib  -script +strash;scorr;ifraig;retime,{D};strash;dch,-f;map,-M,1,{D}
opt
clean
flatten
# write synthesized design
write_verilog -noattr iiitb_SDM_synth.v
stat
show
