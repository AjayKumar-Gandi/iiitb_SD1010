# iiitb_sd101011-->Sequence detector(101011) using mealy finate state machine


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
machine sequence detector “101011”.

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

### Physical Design from Netlist to GDSII

Physical design is process of transforming netlist into layout which is manufacture-able [GDS]. Physical design process is often referred as PnR (Place and Route). Main steps in physical design are placement of all logical cells, clock tree synthesis & routing. During this process of physical design timing, power, design & technology constraints have to be met. Further design might require being optimized w.r.t power, performance and area.

Below are the stages and the respective tools that are called by openlane for the functionalities as described:
- Synthesis
  - Generating gate-level netlist ([yosys](https://github.com/YosysHQ/yosys)).
  - Performing cell mapping ([abc](https://github.com/YosysHQ/yosys)).
  - Performing pre-layout STA ([OpenSTA](https://github.com/The-OpenROAD-Project/OpenSTA)).
- Floorplanning
  - Defining the core area for the macro as well as the cell sites and the tracks ([init_fp](https://github.com/The-OpenROAD-Project/OpenROAD/tree/master/src/init_fp)).
  - Placing the macro input and output ports ([ioplacer](https://github.com/The-OpenROAD-Project/ioPlacer/)).
  - Generating the power distribution network ([pdn](https://github.com/The-OpenROAD-Project/pdn/)).
- Placement
  - Performing global placement ([RePLace](https://github.com/The-OpenROAD-Project/RePlAce)).
  - Perfroming detailed placement to legalize the globally placed components ([OpenDP](https://github.com/The-OpenROAD-Project/OpenDP)).
- Clock Tree Synthesis (CTS)
  - Synthesizing the clock tree ([TritonCTS](https://github.com/The-OpenROAD-Project/OpenROAD/tree/master/src/TritonCTS)).
- Routing
  - Performing global routing to generate a guide file for the detailed router ([FastRoute](https://github.com/The-OpenROAD-Project/FastRoute/tree/openroad)).
  - Performing detailed routing ([TritonRoute](https://github.com/The-OpenROAD-Project/TritonRoute))
- GDSII Generation
  - Streaming out the final GDSII layout file from the routed def ([Magic](https://github.com/RTimothyEdwards/magic)).
 
### Openlane
OpenLane is an automated RTL to GDSII flow based on several components including OpenROAD, Yosys, Magic, Netgen, CVC, SPEF-Extractor, CU-GR, Klayout and a number of custom scripts for design exploration and optimization. The flow performs full ASIC implementation steps from RTL all the way down to GDSII.

### Installation instructions 
```
$   apt install -y build-essential python3 python3-venv python3-pip
```
Docker installation process: https://docs.docker.com/engine/install/ubuntu/

goto home directory->
```
$   git clone https://github.com/The-OpenROAD-Project/OpenLane.git
$   cd OpenLane/
$   sudo make
```
To test the open lane
```
$ sudo make test
```
It takes approximate time of 5min to complete. After 43 steps, if it ended with saying **Basic test passed** then open lane installed succesfully.

 ### 7.3. Magic
 
   - Magic is a venerable VLSI layout tool, written in the 1980's at Berkeley by John Ousterhout, now famous primarily for writing the scripting interpreter language Tcl. Due largely in part to its liberal Berkeley open-source license, magic has remained popular with universities and small companies. The open-source license has allowed VLSI engineers with a bent toward programming to implement clever ideas and help magic stay abreast of fabrication technology. However, it is the well thought-out core algorithms which lend to magic the greatest part of its popularity. Magic is widely cited as being the easiest tool to use for circuit layout, even for people who ultimately rely on commercial tools for their product design flow.

       -More about magic at http://opencircuitdesign.com/magic/index.html

Run following commands one by one to fulfill the system requirement.

```
$   sudo apt-get install m4
$   sudo apt-get install tcsh
$   sudo apt-get install csh
$   sudo apt-get install libx11-dev
$   sudo apt-get install tcl-dev tk-dev
$   sudo apt-get install libcairo2-dev
$   sudo apt-get install mesa-common-dev libglu1-mesa-dev
$   sudo apt-get install libncurses-dev
```
**To install magic**
goto home directory

```
$   git clone https://github.com/RTimothyEdwards/magic
$   cd magic/
$   ./configure
$   sudo make
$   sudo make install
```
type **magic** terminal to check whether it installed succesfully or not. type **exit** to exit magic.

**Generating Layout without including sky130_vsdinv cell**
**NON-INTERACTIVE MODE**
Here we are generating the layout in the non-interactive mode or the automatic mode. In this we cant interact with the flow in the middle of each stage of the flow.The flow completes all the stages starting from synthesis until you obtain the final layout and the reports of various stages which specify the violations and problems if present during the flow.

- Open terminal in home directory
  ```
  $   cd OpenLane/
  $   cd designs/
  $   mkdir iiitb_sd101011
  $   cd iiitb_sd101011/
  $   wget https://raw.githubusercontent.com/AjayKumar-Gandi/iiitb_sd101011/main/config.json
  $   mkdir src
  $   cd src/
  $   wget https://raw.githubusercontent.com/AjayKumar-Gandi/iiitb_sd101011/main/iiitb_sd101011.v
  $   cd ../../../
  $   sudo make mount
  $   ./flow.tcl -design iiitb_sd101011
  ```
 ![image](https://user-images.githubusercontent.com/110395336/187527305-b1f34321-1e31-4650-9282-1ca677da744b.png)

- To see the layout we use a tool called magic which we installed earlier.Type the following command in the terminal opened in the path to your design/runs/latest run folder/final/def/
 
  ```
  $   magic -T /home/ajaykumar/OpenLane/pdks/sky130A/libs.tech/magic/sky130A.tech lef read ../../../tmp/merged.max.lef def read iiitb_sd101011.def &
  ```

- The final layout obtained after the completion of the flow in non-interactive mode is shown below:
file:///home/ajaykumar/Pictures/Screenshots/Screenshot%20from%202022-08-31%2000-32-04.png![image](https://user-images.githubusercontent.com/110395336/187527441-f453c064-b983-4f86-97e5-d1d9ec135960.png)






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


  


