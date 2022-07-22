`timescale 1ns / 1ps

//`begin_keywords "1800-2012"

module testbench
    import isa_package::*;
    (output yongatek_instruction_t instruction
      );
    
    reg clk;
    reg rst;
    
    reg write_ctrl;
    
    
//    wire [7:0] rs1_d;
//    wire [7:0] rs2_d;
    
//     ALU DUT (.rs1_d(rs1_d), .rs2_d(rs2_d), .clk(clk), .rst(rst), .instruction(instruction) );
     
      // ALU DUT (.clk(clk), .rst(rst), .instruction(instruction) );
       
       //register_file dut (.write_ctrl(write_ctrl),.clk(clk), .rst(rst), .instruction(instruction)); 
       
//    assign rs1_d = 8'b00010000;
//    assign rs2_d = 8'b00100000;
    
    
    processor dut (.instruction(instruction), .clk(clk), .rst(rst) , .write_ctrl(write_ctrl)); 
    initial begin
    
    write_ctrl = 0; 
    clk=1;
    rst=1;
    #20;
    
    rst=0;
    
    instruction.opcode = ADD;
    
    instruction.rd = 4'b0001;
    instruction.rs1= 4'b0000;
    instruction.rs2= 4'b0100;
    
    instruction.imm = 8'b01010101;
    
    instruction.empty = 9'b0; 
    
    end 
    
    always  #10 clk=  ~clk;
   
    
endmodule
