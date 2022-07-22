`timescale 1ns / 1ps


module decoder
    import isa_package::*;
         ( input logic [47:0] data_package,
           input clk,
           input rst, 
           
           output  yongatek_instruction_t instruction);


logic [31:0] uart_data; 

logic [2:0] opcode_;
//logic [10:3] imm_;
//logic [14:11] rs1_;
//logic [18:15] rs2_;
//logic [22:19] rd_; 

logic [31:23] empty_;

// case statement ta çözümlenecek. 
//assign opcode_ = uart_data [2:0];  

//assign instruction.imm = uart_data[10:3];
//assign instruction.rs1 = uart_data[14:11];
//assign instruction.rs2 = uart_data[18:15];
//assign instruction.rd = uart_data[22:19];
//assign instruction.empty = uart_data[31:23]; 

//assign imm_ = uart_data[10:3];
//assign rs1_ = uart_data[14:11];
//assign rs2_ = uart_data[18:15];
//assign rd_ = uart_data[22:19];

//assign empty_ = uart_data[31:23]; 


always_ff@ (posedge clk) begin
    
   // if(rst)begin  
    //end  
  //  else begin
  
        if (rst) 
            uart_data<= 32'b0;
        
        
        
        else if (data_package[47:40] == 8'hab && data_package[7:0] == 8'hcd) begin
                        
                uart_data[31:0] <= data_package[39:8];
                    
                opcode_ <= uart_data [2:0];
                instruction.imm <= uart_data [10:3];
                instruction.rs1 <= uart_data [14:11];
                instruction.rs2 <= uart_data [18:15];
                instruction.rd <= uart_data [22:19];
                instruction.empty <= uart_data [31:23];
                    
                    
       
        
        
        case (opcode_)  
                
              3'b000: instruction.opcode <= ADD;
              3'b001: instruction.opcode <= OR_;  
              3'b010: instruction.opcode <= SUB;
              3'b011: instruction.opcode <= AND_;
              3'b100: instruction.opcode <= SLL;
              3'b101: instruction.opcode <= SLR;
              3'b110: instruction.opcode <= WR_rf;
              3'b111: instruction.opcode <= RD_rf;  
              
//              default: begin 
//              end           
        endcase 
             
         end      // 
      //  instruction.opcode <= uart_data[2:0];    
  //  end  
        
end 

endmodule
