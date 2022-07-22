# Processor_that_can_communicate_with_UART

 A simple processor that have ability to communicate with using UART 
 
This is a simple processor which can process eight different instructions. Instructions to the processor are given from UART receiver. If the instrucion processed is 'read from register' than UART transmitter will forward the data from processor to outer world. **Baudrate of the UART is programmable by outer world.** Instruction type is created by using package. The RTL codes in this project are written in Systemverilog. Testbench codes are also added. I hope you would benefit from it. 




# Data Flow of the Processor 

![](https://github.com/WazaAbdulkadir/Processor_that_can_communicate_with_UART/blob/main/images/DataFlow.png)

Turkish-English Translation

Çözücü - Decoder; 
Aritmetik Mantık Birimi - Arithmetic Logic Unit; 
veri - data;
yazmaç öbeği : register file; 
adres : adress;

eğer - if ;
değilse - else ;
sonucu yaz - write the result 

**The data flow is briefly as follows:**

1- The 32-bit instruction input from UART rx is converted into a 48-bit packet by adding header (0xab) and footer (0xcd).
2- If the header and footer values of this data transmitted to the decoder module are as specified (0xab and 0xcd), it is divided into instruction sections.                          
3- rs1, rs2, and rd address values; transmitted to the register file. Instant and opcode values; transmitted to the arithmetic logic unit.
4- If the result obtained from the arithmetic logic unit is not the command RD_rf ("read from register"); the result is written to the register file. If it is RD_rf the result will be transmitter from UART trasnmitter. 




# The instruction type is as follows:  

![](https://github.com/WazaAbdulkadir/Processor_that_can_communicate_with_UART/blob/main/images/buyruktipi.jpg)

Turkish-English Transation

boş alan - empty place;
anlık değer - immadiate value;
buyruk tipi - instruction type 

**Applied Instructions:** 

ADD, SUB, AND, OR, SLL , SLR, RD_rf(read from register) , WR_rf (write to register)


