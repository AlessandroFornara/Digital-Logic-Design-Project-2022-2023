
# [Digital-Logic-Design](https://www11.ceda.polimi.it/schedaincarico/schedaincarico/controller/scheda_pubblica/SchedaPublic.do?&evn_default=evento&c_classe=788722&polij_device_category=DESKTOP&__pj0=0&__pj1=9cc3f34aabe22aeab794c35ef361f0cf) 2022-2023, Course Final Project

This project is the final test of the "Digital Logic Design" course at the Polytechnic of Milan, A.Y. 2022/23.

Evaluation: 30 / 30

## Collaborators 
- [Alessandro Fornara](https://github.com/AlessandroFornara)
- [Donato Fiore](https://github.com/DoneyMoney)


## Project Description
The objective of the project is to develop a hardware component that, upon receiving as input a memory address and information about the desired output channel, displays the content of that address on the specified channel.

The design includes seven interfaces, comprising 2 primary inputs (W and START), both 1-bit, and 5 outputs (Z0, Z1, Z2, Z3, DONE), with the first 4 outputs (8 bits each) designated for reporting all bits of the memory word, and DONE as a 1-bit output. Additionally, a reset signal (RESET) and a clock signal (CLK) are unique to the component.

The specification requires the creation of a hardware module in VHDL that interfaces with memory and receives information through a one-bit serial input about a memory location. The content from this location is then to be routed to one of four available output channels.
