`timescale 1ns / 1ps

module tb
    import isa_package::*;(
         );
 
  
    
    
  //  yongatek_instruction_t instruction ;
    
    logic clk;
    logic rst;
    logic rx_i;
    logic [15:0] clock_per_bit; 
    
    
    parameter [9:0] hex43 = {1'b1, 8'h43 , 1'b0} ;  
    parameter [9:0] hexA2 = {1'b1, 8'hA2 , 1'b0} ;  
    parameter [9:0] hexD1 = {1'b1, 8'hD1 , 1'b0} ;  
    parameter [9:0] hex1F = {1'b1, 8'h1F , 1'b0} ; 
    
   parameter [9:0] hexFF = {1'b1, 8'hFF , 1'b0} ;
    
    //SLL test
    parameter [9:0] hex24 =  {1'b1, 8'h24 , 1'b0} ; 
    
    //SLR test
    parameter [9:0] hex35 =  {1'b1, 8'h35 , 1'b0} ; 
     parameter [9:0] hex25 =  {1'b1, 8'h25 , 1'b0} ; 
     parameter [9:0] hexAD =  {1'b1, 8'hAD , 1'b0}; 
       parameter [9:0] hexDD =  {1'b1, 8'hAD , 1'b0}; 
     parameter [9:0] hexAF =  {1'b1, 8'hAF, 1'b0}; 
    //WR_rf test
    parameter [9:0] hex76 =  {1'b1, 8'h76 , 1'b0} ; 
    
    //RD_rf test
    parameter [9:0] hex27 =  {1'b1, 8'h27 , 1'b0} ; 
    parameter [9:0] hex11 =  {1'b1, 8'h11 , 1'b0} ;
    
    initial begin
    
    //write_ctrl = 0; 
    clk=1;
    rst=1;
    
    
    #20;
    
    rst=0;
    #20;
    
    clock_per_bit = 16'b0000_0000_0000_1010; 
    
    
// clock_per_bit = 16'b0000_0000_0000_1010;


//----------- 1.instruction ----------------------------// 
// AND 
for (int i = 0; i <10; i++) begin
    rx_i <= hex43[i];
    //#8680;
    #100;
 end    
    
# 100;

for (int i = 0; i <10; i++) begin
    rx_i <= hexA2[i];
    //#8680;
    #100; 
 end    

#100; 

for (int i = 0; i <10; i++) begin
    rx_i <= hexD1[i];
    //#8680;
    #100; 
 end    

#100; 

for (int i = 0; i <10; i++) begin
    rx_i <= hex1F[i];
    //#8680;
    #100; 
 end    

#1000; 

//----------- 1.instruction ----------------------------//  



rst= 1;
#20;
rst=0;
#10; 


//----------- 2.instruction ----------------------------// 
// OR 


for (int i = 0; i <10; i++) begin
    rx_i <= hexD1[i];
    //#8680;
    #100; 
 end 
    
for (int i = 0; i <10; i++) begin
    rx_i <= hexD1[i];
    //#8680;
    #100; 
 end 
 
 for (int i = 0; i <10; i++) begin
    rx_i <= hex43[i];
    //#8680;
    #100;
 end    
    
# 100;

for (int i = 0; i <10; i++) begin
    rx_i <= hex43[i];
    //#8680;
    #100;
 end    
    
# 1000;

//----------- 2.instruction ----------------------------//  
     
rst= 1;
#20;
rst=0;
#10; 




//----------- 3.instruction ----------------------------// 
// SUB 

for (int i = 0; i <10; i++) begin
    rx_i <= hexA2[i];
    //#8680;
    #100; 
 end    

#100; 
for (int i = 0; i <10; i++) begin
    rx_i <= hexA2[i];
    //#8680;
    #100; 
 end    

#100; 

for (int i = 0; i <10; i++) begin
    rx_i <= hex43[i];
    //#8680;
    #100;
 end    
    
# 100;

for (int i = 0; i <10; i++) begin
    rx_i <= hexA2[i];
    //#8680;
    #100; 
 end    

#1000; 


//----------- 3.instruction ----------------------------// 
        
rst= 1;
#20;
rst=0;
#10; 


//----------- 4.instruction ----------------------------// 
// SLL 

for (int i = 0; i <10; i++) begin
    rx_i <= hex24[i];
    //#8680;
    #100; 
 end    

#100; 
for (int i = 0; i <10; i++) begin
    rx_i <= hexFF[i];
    //#8680;
    #100; 
 end    

#100; 

for (int i = 0; i <10; i++) begin
    rx_i <= hex43[i];
    //#8680;
    #100;
 end    
    
# 100;

for (int i = 0; i <10; i++) begin
    rx_i <= hex24[i];
    //#8680;
    #100; 
 end    

#1000; 



//----------- 4.instruction ----------------------------// 



//----------- 5.instruction ----------------------------// 
//SLR


for (int i = 0; i <10; i++) begin
    rx_i <= hex25[i];
    //#8680;
    #100; 
 end    

#100; 
for (int i = 0; i <10; i++) begin
    rx_i <= hexFF[i];
    //#8680;
    #100; 
 end    

#100; 

for (int i = 0; i <10; i++) begin
    rx_i <= hexAD[i];
    //#8680;
    #100; 
 end    
    
# 100;

for (int i = 0; i <10; i++) begin
    rx_i <= hexA2[i];
    //#8680;
    #100; 
 end    

#1000; 


//----------- 5.instruction ----------------------------// 



//----------- 6.instruction ----------------------------// 

// WR_rf
for (int i = 0; i <10; i++) begin
    rx_i <= hex76[i];
    //#8680;
    #100; 
 end 
    
for (int i = 0; i <10; i++) begin
    rx_i <= hexD1[i];
    //#8680;
    #100; 
 end 
 
for (int i = 0; i <10; i++) begin
    rx_i <= hex76[i];
    //#8680;
    #100; 
 end  
    
# 100;

for (int i = 0; i <10; i++) begin
    rx_i <= hex43[i];
    //#8680;
    #100;
 end    
    
# 1000;

//----------- 6.instruction ----------------------------// 


//----------- 7.instruction ----------------------------// 
//RD_rf test



for (int i = 0; i <10; i++) begin
    rx_i <= hex27[i];
    //#8680;
    #100;
 end    
    
# 1000;

for (int i = 0; i <10; i++) begin
    rx_i <= hex11[i];
    //#8680;
    #100;
 end    
    
# 1000;

for (int i = 0; i <10; i++) begin
    rx_i <= hex43[i];
    //#8680;
    #100;
 end    
    
# 1000;

for (int i = 0; i <10; i++) begin
    rx_i <= hexFF[i];
    //#8680;
    #100;
 end    
    
# 1000;

//----------- 7.instruction ----------------------------// 


// SLR test

for (int i = 0; i <10; i++) begin
    rx_i <= hex25[i];
    //#8680;
    #100; 
 end    

#100; 
for (int i = 0; i <10; i++) begin
    rx_i <= hexFF[i];
    //#8680;
    #100; 
 end    

#100; 

for (int i = 0; i <10; i++) begin
    rx_i <= hexAD[i];
    //#8680;
    #100; 
 end    
    
# 100;

for (int i = 0; i <10; i++) begin
    rx_i <= hexA2[i];
    //#8680;
    #100; 
 end    

#1000; 


// RD TEKRAR

for (int i = 0; i <10; i++) begin
    rx_i <= hex27[i];
    //#8680;
    #100;
 end    
    
# 1000;


for (int i = 0; i <10; i++) begin
    rx_i <= hexD1[i];
    //#8680;
    #100;
 end 
 
 
for (int i = 0; i <10; i++) begin
    rx_i <= hexFF[i];
    //#8680;
    #100;
 end 
 
 
 for (int i = 0; i <10; i++) begin
    rx_i <= hexFF[i];
    //#8680;
    #100;
 end 
 


   
    end 
    
    always  #5 clk=  ~clk;
   
     
     processor dut ( .clk(clk), .rst(rst),.rx_i(rx_i), .clock_per_bit(clock_per_bit));
     
     
endmodule
