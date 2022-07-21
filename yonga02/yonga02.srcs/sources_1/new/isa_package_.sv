package isa_package; 
typedef enum  logic  [2:0] {ADD = 3'b000,
                          SUB = 3'b001,
                          AND_ = 3'b010,
                          OR_  = 3'b011,
                          SLL = 3'b100,
                          SLR = 3'b101,
                          WR_rf = 3'b110,
                          RD_rf = 3'b111 } opcode_e; 
                          

//typedef struct { logic [7:0] regfile [15:0];
//                        }reg_file;
typedef struct packed { 
                        logic [8:0] empty;
                        logic [3:0] rd;
                        logic [3:0] rs2;
                        logic [3:0] rs1;
                       // struct içinde int tanýmlanamýyor. 
                        logic [7:0]imm; 
                        opcode_e opcode ; 
                } yongatek_instruction_t;                       
                          
endpackage: isa_package 