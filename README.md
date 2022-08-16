# iiitb_sd1010-->Sequence detector(1010) using mealy finate state machine


## Sequence Detector Using Mealy
In this design, I am going to detect the 
sequence “1010” using Mealy finite state machine. 
Mealy finite state machine is used for faster generation 
of output, Mealy will be faster, in the sense that output 
will change as soon as an input transition occurs

## Description
A sequence detector is a sequential state machine. 
It produces a pulse output whenever it detects a 
predefined sequence. In case of Mealy machine, 
output is a function of not only the present inputs 
but also past inputs. In other words, we can say; 
in Mealy, both output and the next state depends 
on the present input and the present state.
Here I have implemented the Mealy finite state 
machine sequence detector “1010”.

A sequence 
detector accepts as input a string of bits: either 0 
or 1. Its output goes to 1 when a target sequence 
has been detected.In a sequence detector that allows 
overlap, the final bits of one sequence can be the 
start of another sequence.
In Mealy, both output and the next state depends 
on the present input and the present state. For
present state S0, if the input is ‘1’ then the next 
state is S1 and if input ‘0’ then the next state is the 
current state. It is similar for present state S1. In 
present state S2 if there is a false bit, the next state 
is S0 and in present state S3 if there is a false bit, 
the next state is S1. It can be said that if there is a 
false input, the next state will be the nearest 
similar state
## Application of Sequence detector
 Mealy 
machines provide a rudimentary mathematical model 
for cipher machines and Sequence detection is used in 
lot of applications like number classification, barcode
scanners etc.
### Mealy machine Block daigram
![image](https://user-images.githubusercontent.com/110395336/183128339-c2252e4d-a990-4cc5-a953-b88688f6ac59.png)
### State transition graph for "1010"
![image](https://user-images.githubusercontent.com/110395336/183129321-bf0ad943-4591-40b9-a64f-8a256db93ed9.png)
## Functional Simulation
### Softwares used
### - iverilog
### - gtkwave
### 1) Installing necessary softwares:
 ```
$ sudo apt-get install git
$ sudo apt-get install iverilog 
$ sudo apt-get install gtkwave 
```
### 2) Executing the Project:
``` 
$ git clone https://github.com/AjayKumar-Gandi/iiitb_sd1010
$ cd iiitb_sd1010
$ iverilog iiitb_SDM.v iiitb_SDM_tb.v -o iiitb_SD
$ ./iiitb_SD
$ gtkwave sqnsdet_tb.vcd
```
## Functional Characteristics
![image](https://user-images.githubusercontent.com/110395336/184929814-e6369e1f-e2fc-41d0-9fd1-713cfa97f267.png)
# Synthesizing Verilog Code
## About Yosys
#### This is a framework for RTL synthesis tools. It currently has extensive Verilog-2005 support and provides a basic set of synthesis algorithms for various application domains.
The software used to run gate level synthesis is Yosys. Yosys is a framework for Verilog RTL synthesis. It currently has extensive Verilog-2005 support and provides a basic set of synthesis algorithms for various application domains. Yosys can be adapted to perform any synthesis job by combining the existing passes (algorithms) using synthesis scripts and adding additional passes as needed by extending the Yosys C++ code base.
## Yosys Installing Commands
```
git clone https://github.com/YosysHQ/yosys.git
make
sudo make install make test
```
## Commands for Synthesizig the verilog code
```
# read design
read_verilog iiitb_SDM.v
# generic synthesis
synth -top iiitb_SDM
# mapping to mycells.lib
read_liberty -lib //home/ajaykumar/iiitb_SD_1010/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
dfflibmap -liberty /home/ajaykumar/iiitb_SD_1010/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
abc -liberty /home/ajaykumar/iiitb_SD_1010/lib/sky130_fd_sc_hd__tt_025C_1v80.lib #-script +strash;scorr;ifraig;retime,{D};strash;dch,-f;map,-M,1,{D}
opt
clean
flatten
# write synthesized design
write_verilog -noattr iiitb_SDM_synth.v
stat
show
```
On running the yosys script, we get the following output:
### Synthesized Model
![image](https://user-images.githubusercontent.com/110395336/184931699-79da0b71-fc41-4036-9859-938eaa1ff0a4.png)
### Statistics
![image](https://user-images.githubusercontent.com/110395336/184932241-fa07b4a9-4e6e-4906-9a2e-c2a13ca6613d.png)
## Gate Level Simulation GLS
GLS stands for gate level simulation. When we write the RTL code, we test it by giving it some stimulus through the testbench and check it for the desired specifications. Similarly, we run the netlist as the design under test (dut) with the same testbench. Gate level simulation is done to verify the logical correctness of the design after synthesis. Also, it ensures the timing of the design.
##### Commands to run the GLS are given below.
```
iverilog -DFUNCTIONAL -DUNIT_DELAY=#0 verilog_model/primitives.v verilog_model/sky130_fd_sc_hd.v iiitb_SDM_synth.v iiitb_SDM_tb.v
```
### Gate level Simulation Waveform
![image](https://user-images.githubusercontent.com/110395336/184933297-39b5e02a-8e7c-4b67-9cc0-ee86989c5890.png)
### Observation
Pre level simulation and post level simulation waverforms are matched.
## Contributors
- Gandi Ajay Kumar
- Kunal Ghosh

## Acknowledgments
Kunal Ghosh, Director, VSD Corp. Pvt. Ltd.
## Contact Information
Gandi Ajay Kumar, Postgraduate Student, International Institute of Information Technology, Bangalore ajaykumar.gandi@iiitb.ac.in

Kunal Ghosh, Director, VSD Corp. Pvt. Ltd. kunalghosh@gmail.com
## References:
1.	http://www.vlsifacts.com/mealy-vs-moore-machine/
2.	https://www.researchgate.net/figure/1010-Detector-a-state-transition-graph-b-state-transition-table-c-state_fig10_220285908
3.	https://digitalsystemdesign.in/fsm-design/


  


