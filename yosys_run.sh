# read design

read_verilog iiitb_SDM.v

# generic synthesis
synth -top iiitb_SDM
# mapping to mycells.lib
dfflibmap -liberty /home/ajaykumar/iiitb_SD_1010/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
abc -liberty /home/ajaykumar/iiitb_SD_1010/lib/sky130_fd_sc_hd__tt_025C_1v80.lib -script +strash;scorr;ifraig;retime,{D};strash;dch,-f;map,-M,1,{D}
clean
flatten
# write synthesized design
write_verilog -noattr iiitb_SDM_synth.v
