`timescale 1ns / 1ps

module uart_tx(
            input logic clk,
            input logic rst,
           
            //input logic tx_start_i, // start biti aludan alýnacak
            
            input logic [15:0] clock_per_bit, 
            
            input logic read_data_en,
            input logic [7:0] ALU_data,
            
            output logic tx_done_tick_o,
           // output logic transmission_ended,
            output logic tx_o      
            );
            
//logic [7:0] d_in;            

// DEÐÝÞÝKLÝKÝER:
    // clock_per_bit eklendi
    // baud_rate : assign ile hesaplanýyor. 
    // bit_timer_lim askýya alýndý yerine clock_per_bit yazýldý. 
          

parameter clock_freq = 100000000; 
//parameter baud_rate = 115_200;
//parameter baud_rate = 10_000_000;
parameter stop_bit = 1; 

logic [61:0] baud_rate;
//wire bit_timer_lim;
logic [61:0] stop_bit_lim;

assign baud_rate = clock_freq / clock_per_bit; 

//assign bit_timer_lim = clock_freq / baud_rate;
assign stop_bit_lim =  clock_freq / baud_rate;
//localparam bit_timer_lim = $clog2(clock_freq / baud_rate) ; 
//localparam bit_timer_lim = clock_freq / baud_rate; 
//localparam stop_bit_lim  = clock_freq / baud_rate; 


logic [15: 0] bit_timer ;

logic [7:0] shreg ;  
logic [2:0] bit_counter; 

logic transmission_start ;

typedef enum logic [1:0]{IDLE=2'b00,
                         START=2'b01,
                         DATA=2'b10,
                         STOP=2'b11 } states_t;

states_t state;

always_ff @(posedge clk) begin
    
    
    if (rst) begin
            bit_timer <= 0;
            shreg <= 8'b0;
            bit_counter <= 3'b0; 
            tx_done_tick_o <= 1'b0;
            //transmission_ended <= 1'b0;
            transmission_start<=1'b0;
            
    end 
    
    else begin 
        transmission_start <= read_data_en;
    
        case (state) 
        
        default: begin
            state <= IDLE;   
            bit_timer <= 0;
            shreg <= 8'b0;
            bit_counter <= 3'b0; 
            tx_done_tick_o <= 1'b0;
            //transmission_ended <= read_data_en;
        end 
        
        IDLE: begin : case_idle
            
            tx_o <= 1'b1;
           // transmission_ended <= 1'b0; 
           // if (read_data_en)
          //  transmission_start <= read_data_en;
            
            if (transmission_start == 1 ) begin 
                state<=START;
                tx_o <= 1'b0; 
                shreg <= ALU_data; 
                
               //transmission_ended <= read_data_en;
            end 
            
          
               
           
        end : case_idle
                
        
        START: begin: case_start
            
           // tx_o <= 1'b0; 
            if (bit_timer == clock_per_bit-1) begin
                state<= DATA; 
                tx_o <= shreg[0];
                shreg[7] <= shreg[0];
                shreg [6:0] <= shreg [7:1] ;
                
                bit_timer <= 0;
                
            end 
            
            
            else 
                bit_timer <= bit_timer + 1; 
                
        end : case_start 
            
            
        
        DATA: begin : case_data
                
                if (bit_counter == 3'b111) begin : bit_cnt
                        
                        if (bit_timer == clock_per_bit -1 ) begin 
                            bit_counter <= 3'b0;
                            state <= STOP; 
                            tx_o <= 1'b1; // stop bit 1 
                            bit_timer <= 0; 
                        
                        end 
                       
                       
                       
                       else 
                         bit_timer <= bit_timer + 1; 
                end :bit_cnt 
                
                else begin 
                    
                     if (bit_timer == clock_per_bit-1) begin
                           shreg[7] <= shreg[0];
                           shreg [6:0] <= shreg [7:1] ;
                           tx_o <= shreg[0];  
                        
                         bit_counter <= bit_counter + 1'b1; 
                         bit_timer <= 0; 
                     end 
                       
                     else 
                         bit_timer <= bit_timer + 1; 
                end 
                
        
        end: case_data
        
        
        STOP: begin : case_stop  
        
               if (bit_timer == stop_bit_lim-1) begin
                state<= IDLE;
                tx_done_tick_o <= 1'b1; 
                 bit_timer <= 1'b0; 
                transmission_start <= 1'b0;
            end 
               else 
                  bit_timer <= bit_timer + 1'b1; 


            end: case_stop 
    endcase 
    
    
//    if (tx_done_tick_o == 1) begin
            
            
            
//    end 
        
end

end 

endmodule
