

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


module regfile
   import isa_package::*;
                    (
                     input logic clk,
                     input logic rst,
                     input logic [7:0] write_d, // ALU çýkýþýndan gelecek: ALU_o
                     input  logic write_ctrl,
                     output wire logic [7:0] rs1_d,
                     output wire logic [7:0] rs2_d,
                     input yongatek_instruction_t instruction
                    
                     //output logic [7:0] reg_file [15:0]
                      );
    
      
    // adres size 4 (bit) olduðu için block ram oluþturmuyor. Dolayýsýyla reg_file flip floplardan oluþuyor.  
    (* ram_style = "block" *) logic [7:0]reg_file [15:0];
    
   // logic [7:0]reg_file [15:0];
    
    assign rs1_d = reg_file[instruction.rs1];
    assign rs2_d = reg_file[instruction.rs2];
    
//    logic control_buffer; 
    
//    assign control_buffer =  write_ctrl;
     
    // simulasyon için 
    initial begin
         
         
         reg_file[1] = 8'b00100001;
         reg_file[3] = 8'b00100010;
         reg_file[4] = 8'b00100100;
         reg_file[6] = 8'b00101000;
         reg_file[9] = 8'b00110000;
         
         reg_file[11] = 8'b01100000;
         reg_file[13] = 8'b01110000;
         reg_file[15] = 8'b01111000;
         
         
        reg_file[4] = 8'b00100000; // ADD
        reg_file[0] = 8'b00000011; // 3 + 32 = 35; 
    
    
        reg_file[10] = 8'b01010000;  // OR 
        reg_file[14] = 8'b00111001;  // 
        
        
        reg_file[12] = 8'b00111000;  // SUB 
        // reg_file[4] array 0010_0000 sayýsýyla dolu 
        
        reg_file[8] = 8'b01010001; // AND 
        reg_file[7] = 8'b01001101;
        
        reg_file[2] = 8'b00010001; // SLL
         // 5 bit sola shift 
         
         reg_file[6] = 8'b00010000; // SLR
         // 2 bir saða shift  
         
         
    end 
    
   // ALU ALU_intantiation (.clk(clk),.rst(rst),.ALU_o(write_d));
    
    
    always_ff @(posedge clk)  begin
        
        if(rst) begin
            //instruction <= 32'b0; 
          // reg_file <= '{default:0}; 
           //reg_file[1] <= 8'b0; 
           //reg_file[2] <= 8'b0; 
           //reg_file[3] <= 8'b0; 
           //reg_file[1] <= 8'b0; 
           //reg_file[5] <= 8'b0; 
           //reg_file[6] <= 8'b0; 
//           reg_file[7] <= 8'b0; 
//           reg_file[8] <= 8'b0; 
//           reg_file[9] <= 8'b0; 
           //reg_file[10] <= 8'b0; 
//           reg_file[11] <= 8'b0;
//           reg_file[12] <= 8'b0;
//           reg_file[13] <= 8'b0;
           //reg_file[14] <= 8'b0;
//           reg_file[15] <= 8'b0;
        end  
        
        
        
        else if(write_ctrl == 1) begin:register_file_write
         // rd_reg haricinde diðer instructionlar için 1 olacak.           
         reg_file[instruction.rd] <= write_d;
       
        
        end:register_file_write
        
        
        
        // data outlarý wire olarak tanýmaladým. Assign ile continuous hale getirdim. 
//        else begin: register_read 
            
//            rs1_d <= reg_file[instruction.rs1];
//            rs2_d <= reg_file[instruction.rs2];
            
//        end: register_read
        
             
    end
    
endmodule