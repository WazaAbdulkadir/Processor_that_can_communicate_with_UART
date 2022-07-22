`timescale 1ns / 1ps

//`begin_keywords "1800-2012"
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

module ALU
    import isa_package::*;
           (input logic clk,
           input logic rst,
           input  yongatek_instruction_t instruction,
           output logic [7:0] ALU_o,
           input  logic [7:0] rs1_d,
           input logic [7:0] rs2_d,  
           
         //  input logic transmission_ended,
           
           output logic write_ctrl,
           output logic read_data_en );


//register_file regfile_instantiation (.clk(clk), .rs1_d(rs1_d), .rs2_d(rs2_d), .rst(rst), .write_d(ALU_o));

// ALU_o, write_d ye baðlanmalý. O da sadece reg_file a data yazýlacaðý (WR_rf opcode u okununca)zaman . 
//register_file regfile_instantiation (.clk(clk), .rs1_d(rs1_d), .rs2_d(rs2_d), .rst(rst));

always_ff@ (posedge clk) begin


    if(rst) begin
        read_data_en <= 1'b0;
        ALU_o <= 8'b0;
        write_ctrl <= 1'b0; 
        //instruction <= 32'b0; 
       end  
       
    else begin: ALU_operations
        case(instruction.opcode)
            
            ADD: begin
                ALU_o <= rs1_d + rs2_d;
                write_ctrl <= 1'b1;    
                read_data_en <= 0;
            end 
            
            SUB: begin 
                 ALU_o <= rs1_d - rs2_d;
                 write_ctrl <= 1'b1;    
                 read_data_en <= 0;
            end    
            
           
            AND_: begin
                 ALU_o <= rs1_d & rs2_d;
                 write_ctrl <= 1'b1;  
                 read_data_en <= 0;
            end 
            
            OR_: begin
                ALU_o <= rs1_d | rs2_d;
                write_ctrl <= 1'b1;
                read_data_en <= 0;
                 
            end 
            
            
            SLL: begin
                 ALU_o <= rs1_d << instruction.imm[2:0];
                 write_ctrl <= 1'b1;
                 read_data_en <= 0; 
            end 
            
            SLR: begin
                 ALU_o <= rs1_d >> instruction.imm[2:0];
                 write_ctrl <= 1'b1;
                 read_data_en <= 0;
            end 
           
            WR_rf: begin 
                 ALU_o <= instruction.imm;
                 write_ctrl <= 1; 
                 read_data_en <= 0;
            end                 
             
            RD_rf: begin
                ALU_o <= rs1_d; 
                write_ctrl <= 0;  
                read_data_en <= 1;
//                if () 
//                read_data_en <= 1;   
              //  transmission_ended <= 0;
                    
//                if(transmission_ended == 1) begin
//                    read_data_en <= 0; 
//                end
                
//                else if (transmission_ended == 0) begin
//                     read_data_en <= 1;
//                end    
                
            end 
                
              
              
        endcase


end:ALU_operations 
end
endmodule
