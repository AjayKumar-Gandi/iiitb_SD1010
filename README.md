# iiitb_sd101011-->Sequence detector(101011) using mealy finate state machine


## Sequence Detector Using Mealy
In this design, I am going to detect the 
sequence “101011” using Mealy finite state machine. 
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
### State transition graph for "101011"
![image](https://user-images.githubusercontent.com/110395336/187689661-d409cba3-f458-49a1-a3f5-aaf9908d57a1.png)
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
$ git clone https://github.com/AjayKumar-Gandi/iiitb_sd101011
$ cd iiitb_sd101011
$ iverilog iiitb_SDM.v iiitb_SDM_tb.v -o iiitb_SD
$ ./iiitb_SD
$ gtkwave sqnsdet_tb.vcd
```
## Functional Characteristics
![image](https://user-images.githubusercontent.com/110395336/187692358-8cf1b616-3e29-406f-9bf5-56748395c829.png)

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
read_liberty -lib //home/ajaykumar/iiitb_sd101011/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
dfflibmap -liberty /home/ajaykumar/iiitb_sd101011/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
abc -liberty /home/ajaykumar/iiitb_sd101011/lib/sky130_fd_sc_hd__tt_025C_1v80.lib -script +strash;scorr;ifraig;retime,{D};strash;dch,-f;map,-M,1,{D}
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
![image](https://user-images.githubusercontent.com/110395336/187693991-33a369e2-9784-46ed-b50f-cf767f10a000.png)

### Statistics
![image](https://user-images.githubusercontent.com/110395336/187694147-c9da9ca6-74a2-404d-82a1-f8ac0d7c242f.png)

## Gate Level Simulation GLS
GLS stands for gate level simulation. When we write the RTL code, we test it by giving it some stimulus through the testbench and check it for the desired specifications. Similarly, we run the netlist as the design under test (dut) with the same testbench. Gate level simulation is done to verify the logical correctness of the design after synthesis. Also, it ensures the timing of the design.
##### Commands to run the GLS are given below.
```
iverilog -DFUNCTIONAL -DUNIT_DELAY=#0 verilog_model/primitives.v verilog_model/sky130_fd_sc_hd.v iiitb_SDM_synth.v iiitb_SDM_tb.v
```
### Gate level Simulation Waveform
![image](https://user-images.githubusercontent.com/110395336/187694326-9b2cfdf5-75ee-4483-8109-3fb02ff9b548.png)

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

 ### Magic
 
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
  $   wget https://raw.githubusercontent.com/AjayKumar-Gandi/iiitb_sd101011/main/iiitb_SDM.v
  $   cd ../../../
  $   sudo make mount
  $   ./flow.tcl -design iiitb_sd101011
  ```
 ![image](https://user-images.githubusercontent.com/110395336/187527305-b1f34321-1e31-4650-9282-1ca677da744b.png)

- To see the layout we use a tool called magic which we installed earlier.Type the following command in the terminal opened in the path to your design/runs/latest run folder/final/def/
 
  ```
  $   magic -T /home/ajaykumar/OpenLane/pdks/sky130A/libs.tech/magic/sky130A.tech lef read ../../../tmp/merged.max.lef def read iiitb_SDM.def &
  ```

- The final layout obtained after the completion of the flow in non-interactive mode is shown below:
![image](https://user-images.githubusercontent.com/110395336/187527441-f453c064-b983-4f86-97e5-d1d9ec135960.png)


### Customizing the layout

Here we are going to customise our layout by including our custom made **sky130_vsdinv cell** into our layout.

- ***1 . CREATING THE SKY130_VSDINV CELL LEF FILE***
   - You need to first get the git repository of the **vsdstdccelldesign**.To get the repository type the following command:

     ``` git clone https://github.com/nickson-jose/vsdstdcelldesign.git ```
    ![image](https://user-images.githubusercontent.com/110395336/187530592-148973b9-3eff-4e77-82e7-c359b6103052.png)
    ![image](https://user-images.githubusercontent.com/110395336/187530930-f391a10b-0b6c-4fde-aa4e-c205c0909e68.png)

   - Now you need to copy your tech file **sky130A.tech** to this folder.
   - Next run the magic command to open the **sky130_vsdinv.mag** file.Use the following command:
     
     ``` magic -T sky130A.tech sky130_vsdinv.mag& ```
     
     * One can zoom into Magic layout by selecting an area with left and right mouse click followed by pressing "z" key. 
     * Various components can be identified by using the ```what``` command in tkcon window after making a selection on the component.
     
   - The image showing the invoked magic tool using the above command:
     
      ![image](https://user-images.githubusercontent.com/110395336/187684779-727b5dc5-f00a-4ad5-af5a-eef4872c6a6a.png)

     
   - The next step is setting `port class` and `port use` attributes. The "class" and "use" properties of the port have no internal meaning to magic but are used by the LEF and DEF format read and write routines, and match the LEF/DEF CLASS and USE properties for macro cell pins. These attributes are set in tkcon window (after selecting each port on layout window. A keyboard shortcut would be,repeatedly pressing **s** till that port gets highlighed).
   - The tkcon command window of the port classification is shown in the image below:
          
     ![port_define](https://user-images.githubusercontent.com/110079631/187438423-d08803fb-2375-495b-9de7-c46a2aadda00.JPG)
    
   - In the next step, use `lef write` command to write the LEF file with the same nomenclature as that of the layout `.mag` file. This will create a **sky130_vsdinv.lef** file in the same folder.
   
      ![lef_write](https://user-images.githubusercontent.com/110079631/187439794-340e3c4d-65fc-48ad-8c2b-12ee5054e69f.PNG)
               
- ***2 .INCLUDING THE SKY130_VSDINV CELL***


   Move the ```sky130_fd_sc_hd__fast.lib```,```sky130_fd_sc_hd__slow.lib```,```sky130_fd_sc_hd__typical.lib```,```sky130_vsdinv.lef``` files to your          design ```src``` folder.


  ![image](https://user-images.githubusercontent.com/110395336/187533590-2dda38de-cb10-4c9e-8d37-dbd700242aad.png)

  - Next , Modify the json file by including the following lines:

    ```
    "GLB_RESIZER_TIMING_OPTIMIZATIONS": true,
    "CLOCK_PERIOD": 65,
    "PL_RANDOM_GLB_PLACEMENT": 1,
    "PL_TARGET_DENSITY": 0.5,
    "FP_SIZING" : "relative",    
    "LIB_SYNTH": "dir::src/sky130_fd_sc_hd__typical.lib",
    "LIB_FASTEST": "dir::src/sky130_fd_sc_hd__fast.lib",
    "LIB_SLOWEST": "dir::src/sky130_fd_sc_hd__slow.lib",
    "LIB_TYPICAL": "dir::src/sky130_fd_sc_hd__typical.lib",
    "TEST_EXTERNAL_GLOB": "dir::../iiitb_sd101011/src/*",
    
    ```

  Invoking openlane by following command.
 
   ```
   sudo make mount
   ```
   ![image](https://user-images.githubusercontent.com/110395336/187534485-5cb0153a-70f5-467f-a73b-6df3e15e2f07.png)

- ***3 . INTERACTIVE MODE:***

    We need to run the openlane now in the interactive mode to include our custom made lef file before synthesis.Such that the openlane recognises our lef      files during the flow for mapping.
    - **1. Running openlane in interactive mode:**
        The command to the run the flow in interactive mode is given below:
        ```
        ./flow.tcl -interactive        
        ```
        ![image](https://user-images.githubusercontent.com/110395336/187535565-631382e7-1b25-4171-b06a-881aa1c887d8.png)


    - **2. Preparing the design and including the lef files:**
      
        The commands to prepare the design and overwite in a existing run folder the reports and results along with the command to include the lef files is          given below:
          ```
        prep -design iiitb_sd101011 -tag run -overwrite
        set lefs [glob $::env(DESIGN_DIR)/src/*.lef]
        add_lefs -src $lefs
          ```
        ![image](https://user-images.githubusercontent.com/110395336/187536600-a3178173-33cd-4934-8c48-e4a3e1e954ef.png)


     - ***3 . SYNTHESIS:***
        * **1. To Invoke synthesis** type ```run_synthesis```.This runs the synthesis where yosys translates RTL into circuit using generic components and abc maps the circuit to Standard Cells.
           ![image](https://user-images.githubusercontent.com/110395336/187537403-dfe23aa9-7dca-4ac7-b285-0f968e814320.png)


        * **2. The Pre synthesized netlist** 
      
           ![image](https://user-images.githubusercontent.com/110395336/187537991-99e2aba9-5e8d-4687-be4a-41df09ce4d2c.png)

        * **3. The synthesized netlist** 
      
           ![image](https://user-images.githubusercontent.com/110395336/187538256-f8a5f450-5efd-4f6d-a79f-4fc01342f8ce.png)

        * **4. Calcuation of Flop Ratio:**
  
          ```
          Flop ratio = Number of D Flip flops 
                     ______________________
                     Total Number of cells
            ```
              
   - ***4. FLOORPLAN***
      
      * **1. Importance of files in increasing priority order:**

        1. ```floorplan.tcl``` - System default envrionment variables
        2. ```conifg.tcl```
        3. ```sky130A_sky130_fd_sc_hd_config.tcl```
        
      * **2. Floorplan envrionment variables or switches:**

        1. ```FP_CORE_UTIL``` - floorplan core utilisation
        2. ```FP_ASPECT_RATIO``` - floorplan aspect ratio
        3. ```FP_CORE_MARGIN``` - Core to die margin area
        4. ```FP_IO_MODE``` - defines pin configurations (1 = equidistant/0 = not equidistant)
        5. ```FP_CORE_VMETAL``` - vertical metal layer
        6. ```FP_CORE_HMETAL``` - horizontal metal layer
           
        ```Note: Usually, vertical metal layer and horizontal metal layer values will be 1 more than that specified in the file```
        
      * **3.Use the command:** `run_floorplan`.
      
         ![image](https://user-images.githubusercontent.com/110395336/187539212-80e6fba2-2dd6-4d4a-89e8-4b290884b728.png)

            
      * **4. To view the floorplan:** Magic is invoked after moving to the ```results/floorplan``` directory,then use the floowing command:
        ```
        magic -T /home/ajaykumar/OpenLane/pdks/sky130A/libs.tech/magic/sky130A.tech lef read ../../tmp/merged.nom.lef def read iiitb_SDM.def &
        ```
         ![image](https://user-images.githubusercontent.com/110395336/187540061-e1b29ed5-bbfe-4b18-9835-78759aaad1a1.png)

      * **5. Die Area post floorplan:**
      
        ![image](https://user-images.githubusercontent.com/110395336/187540262-e4fef3ac-b546-4daf-9765-c6a0e30a1d68.png)

   - ***5. PLACEMENT***

      **1. The next step in the OpenLANE ASIC flow is** placement. The synthesized netlist is to be placed on the floorplan. Placement is perfomed in 2                stages:
        1. Global Placement: It finds optimal position for all cells which may not be legal and cells may overlap. Optimization is done through reduction              of half parameter wire length.
        2. Detailed Placement: It alters the position of cells post global placement so as to legalise them.
      
        Type the following command to run placement
      
        ```
        run_placement
        ```
        ![image](https://user-images.githubusercontent.com/110395336/187541198-b4d4d532-3c57-4fb5-941f-39ddc285aa4f.png)
      
      **2. Post placement:** the design can be viewed on magic within ```results/placement``` directory.    
      Run the follwing command in that directory:         
      ```
      magic -T /home/ajaykumar/OpenLane/pdks/sky130A/libs.tech/magic/sky130A.tech lef read ../../tmp/merged.nom.lef def read iiitb_SDM.def &
      ```
      ![image](https://user-images.githubusercontent.com/110395336/187542348-dba3ac86-8da2-49f3-ba9a-9a585f1ca04a.png)

      **3. sky130_vsdinv cell post placement:**
     
      ![image](https://user-images.githubusercontent.com/110395336/187543023-77fb46ec-0bb5-4695-9e10-02f5b9986829.png)

      **4. Area report post placement_resizing:**
     
      ![image](https://user-images.githubusercontent.com/110395336/187543993-37608979-f777-49c9-9a9e-bd2a1ba5f10c.png)


   - ***6 . CLOCK TREE SYNTHESIS***
         
      * **1. The purpose** of building a clock tree is enable the clock input to reach every element and to ensure a zero clock skew. H-tree is a common methodology followed in CTS.
        Before attempting a CTS run in TritonCTS tool, if the slack was attempted to be reduced in previous run, the netlist may have gotten modified by cell replacement techniques. Therefore, the verilog file needs to be modified using the ```write_verilog``` command. Then, the synthesis, floorplan and placement is run again. 
      * **2. To run CTS use the below command:**
         ```
         run_cts
         ```
          ![image](https://user-images.githubusercontent.com/110395336/187544847-d7c79423-9836-4832-b02e-edb361989f11.png)


      * **3. Slack report post_cts:**
![image](https://user-images.githubusercontent.com/110395336/187545611-c59dcf31-c226-45e1-ace0-1ebcc13ad9f8.png)


      * **4. Power report post_cts:**
![image](https://user-images.githubusercontent.com/110395336/187545734-7e461a1d-2b0f-4015-805d-071a83c3611a.png)


      


  - ***7 . ROUTING***
          
      * **1. OpenLANE uses the TritonRoute tool for routing. There are 2 stages of routing:**
        1. Global routing: Routing region is divided into rectangle grids which are represented as course 3D routes (Fastroute tool).
        2. Detailed routing: Finer grids and routing guides used to implement physical wiring (TritonRoute tool). 
      * **2. Features of TritonRoute:**
        1. Honouring pre-processed route guides
        2. Assumes that each net satisfies inter guide connectivity
        3. Uses MILP based panel routing scheme
        4. Intra-layer parallel and inter-layer sequential routing framework

#### Type the following command to run placement
```
     run_routing
```
![image](https://user-images.githubusercontent.com/110395336/187546087-ab3df917-3070-4f6c-bba4-04ccb1a1e9fb.png)

### 1. Routing 

  * **1. Layout in magic tool post routing:** the design can be viewed on magic within ```results/routing``` directory.
       
       Run the follwing command in that directory:
       ```
         magic -T /home/ajaykumar/OpenLane/pdks/sky130A/libs.tech/magic/sky130A.tech lef read ../../tmp/merged.nom.lef def read iiitb_.def &
       ```

![image](https://user-images.githubusercontent.com/110395336/187546774-eccd912a-cd79-460b-9d9f-e17e79a8fc65.png)

In tkcon terminal type the following command to know whether the cell is present or not
```
getcell sky130_vsdinv
```
![image](https://user-images.githubusercontent.com/110395336/187546972-9a1efed8-e138-4e71-9e1c-a62d470007df.png)
***One sky130_vsdinv cell is present in the design***


**Expanded version of sky130_vsdinv cell**

![image](https://user-images.githubusercontent.com/110395336/187547167-1b37776b-571f-4bee-8f67-a7bd1887321e.png)



## Reports
![image](https://user-images.githubusercontent.com/110395336/187548000-66856f9b-295b-4f26-8755-bd8bc2580a21.png)
![image](https://user-images.githubusercontent.com/110395336/187548021-25f07c76-3f6b-4930-9ff4-66a2ae2835d5.png)
![image](https://user-images.githubusercontent.com/110395336/187548050-e7c0bf85-1531-490d-8726-9faf8cb88777.png)


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


  


