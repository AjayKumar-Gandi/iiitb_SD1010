# iiitb_SD_1010-->Sequence detector(1010) using mealy finate state machine


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
### State transition graph
![image](https://user-images.githubusercontent.com/110395336/183129321-bf0ad943-4591-40b9-a64f-8a256db93ed9.png)
## Functional Characteristics
![Screenshot from 2022-08-03 14-23-02](https://user-images.githubusercontent.com/110395336/183131489-6e15d9db-0a0f-4fc7-81df-1d065e419c87.png)
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
$ git clone 
$ cd iiitb_SDM
$ iverilog iiitb_SDM.v iiitb_SDM_tb.v -o iiitb_SD
$ ./iitb_SD
$ gtkwave seqnsdet_tb.vcd
```
## Contributors
Gandi Ajay Kumar

Kunal Ghosh
## Acknowledgments
Kunal Ghosh, Director, VSD Corp. Pvt. Ltd.
## Contact Information
Gandi Ajay Kumar, Postgraduate Student, International Institute of Information Technology, Bangalore ajaykumar.gandi@iiitb.ac.in

Kunal Ghosh, Director, VSD Corp. Pvt. Ltd. kunalghosh@gmail.com
## References:
1.	http://www.vlsifacts.com/mealy-vs-moore-machine/
2.	https://www.researchgate.net/figure/1010-Detector-a-state-transition-graph-b-state-transition-table-c-state_fig10_220285908
3.	https://digitalsystemdesign.in/fsm-design/


  


