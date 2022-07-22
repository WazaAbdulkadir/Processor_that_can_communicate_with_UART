`timescale 1ns / 1ps


//package isa_package; 
//typedef enum logic [2:0] {ADD = 3'b000,
//                          SUB = 3'b001,
//                          AND_ = 3'b010,
//                          OR_  = 3'b011,
//                          SLL = 3'b100,
//                          SLR = 3'b101,
//                          WR_rf = 3'b110,
//                          RD_rf = 3'b111 } opcode_e; 
                          

////typedef struct { logic [7:0] regfile [15:0];
////                        }reg_file;
//typedef struct packed { 
//                        logic [8:0] empty;
//                        logic [3:0] rd;
//                        logic [3:0] rs2;
//                        logic [3:0] rs1;
//                       // struct içinde int tanýmlanamýyor. 
//                        logic [7:0]imm; 
//                        opcode_e opcode ; 
//                } yongatek_instruction_t;                       
                          
//endpackage: isa_package 


 
module processor
   import isa_package::*;
                    ( input logic rst,
                      input logic clk,
                      
                    //  output yongatek_instruction_t instruction_t,
                      
                      // uart_rx ports 
                      input logic rx_i,
                      input logic [15:0] clock_per_bit, 
                      output logic rx_done_tick_o,
                      // uart_rx
                      output logic tx_o,
                      output logic tx_done_tick_o
                    //  output logic [47:0] data_package,
                    
                     // output logic read_data_en,
                      
//                      output logic [7:0] rs1_d_,
//                      output logic [7:0] rs2_d_,
//                      output logic [7:0] ALU_o_
                      
                     // input logic [7:0] write_d_
                      //input logic [7:0] reg_file [15:0]
                  );
yongatek_instruction_t instruction_t;
 //yongatek_instruction_t instruction_t; // nasýl tanýmlamak lazým 
 logic write_ctrl_; // wire dan logice çevirdim. 
 logic [47:0] data_package_;
 //logic transmission_ended; 
 logic read_data_en;
 logic [7:0] write_d_;
 
  logic [7:0] rs1_d_;
  logic [7:0] rs2_d_;
  logic [7:0] ALU_o_;
                      

uart_rx uart_rx_instantiation (.clk(clk),.rst(rst),.rx_i(rx_i), .rx_done_tick_o(rx_done_tick_o), .clock_per_bit(clock_per_bit), .data_package(data_package_) );
decoder decoder_instantiation (.clk(clk),.rst(rst), .data_package(data_package_) ,.instruction(instruction_t)); 

regfile reg1 (.write_ctrl(write_ctrl_),.rs1_d(rs1_d_), .rs2_d(rs2_d_), .clk(clk), .rst(rst), .instruction(instruction_t),.write_d(ALU_o_) );    
ALU aludef (.rs1_d(rs1_d_), .rs2_d(rs2_d_), .instruction(instruction_t),.ALU_o(ALU_o_), .rst(rst), .clk(clk),.write_ctrl(write_ctrl_), .read_data_en(read_data_en));    

uart_tx uart_tx_instantiation(.tx_done_tick_o(tx_done_tick_o),.tx_o(tx_o),.ALU_data(ALU_o_),.clk(clk) ,.rst(rst), .read_data_en(read_data_en), .clock_per_bit(clock_per_bit));

//regfile reg2 (.write_d(ALU_o_)); 
//regfile reg1 (.reg_file(reg_file),.write_ctrl(write_ctrl),.rs1_d(rs1_d_), .rs2_d(rs2_d_), .clk(clk), .rst(rst), .instruction(instruction) );    

endmodule