`timescale 1ns / 1ps



module uart_rx (
                input logic clk,
                input logic rst,
                input logic rx_i,
                input logic [15:0] clock_per_bit,
                
//                output wire logic [7:0] dout_o,
                output logic rx_done_tick_o,
                
                //output logic [31:0] uart_data //instruction 
                output logic [47:0] data_package                
                
                );
    
    
    logic [7:0] dout_o;
    //logic rx_done_tick_o;
    //Deðiþiklikler
        // clock_per_bit eklendi
        // baud_rate : assign ile hesaplanýyor. 
        // bit_timer_lim askýya alýndý yerine clock_per_bit yazýldý. 
    
    parameter clock_freq = 100_000_000;
    //parameter baud_rate = 115_200;
    wire [61:0] baud_rate;
    assign baud_rate = clock_freq/ clock_per_bit;
    
    typedef enum logic [1:0]{IDLE=2'b00,
                         START=2'b01,
                         DATA=2'b10,
                         STOP=2'b11 } states_t;

    states_t state;
   
    //localparam bit_timer_lim = clock_freq / baud_rate; 
    
    logic [31:0] uart_data; 
    
    logic [15 : 0] bit_timer ;
    logic [7:0] shreg ;  
    logic [2:0] bit_counter ;    
    
    logic [2:0] uart_counter; 
    logic rx_load_data; 
    logic uart_data_done_tick;
    
    always @(posedge clk) begin
            
            if (rst) begin
                uart_counter <= 0;
                uart_data_done_tick<=0;
                uart_data <= 0; 
                data_package <= 0; 
            end 
            
            else begin  
            case(state) 
                    
               default: begin
                 state <= IDLE;   
                 bit_timer <= 0;
                 shreg <= 8'b0;
                 bit_counter <= 3'b0; 
                 rx_load_data <= 0; 
                end
                
                IDLE : begin : case_idle
                    rx_done_tick_o <= 0;
                    bit_timer <= 0; 
                    
                    if(rx_i == 0) begin
                        state<= START; 
                    end 
                    
                end : case_idle 
                
                
                START: begin: case_start  // bit_timer / 2  kadar bekleyeceðim. 
                        if(bit_timer == clock_per_bit/2 -1) begin
                            state<= DATA; 
                            bit_timer <= 0; 
                        end 
                        
                        else 
                            bit_timer <= bit_timer +1;
                
                
                end : case_start  
                
                DATA: begin : case_data // bir süre bekleyip data örnekleyeceðiz. 
                        
                        if (bit_timer == clock_per_bit -1) begin
                          
                          
                            if (bit_counter == 7) begin 
                                  state <= STOP; 
                                  bit_counter <= 0; 
                            end 
                            
                            else begin 
                                bit_counter <= bit_counter +1; 
                            end  
                            
                            shreg <= { rx_i , shreg[7:1] } ; // bu iþlem 8 kere yapýlmalý. 
                            bit_timer <= 0;                         
                         
                          end 
                        
                          
                        else 
                            bit_timer <= bit_timer +1;
                            
                     
                end: case_data 
                
                STOP: begin : case_stop
                    if(bit_timer == clock_per_bit -1) begin
                            state<= IDLE; 
                            bit_timer <= 0; 
                            rx_done_tick_o <= 1;
                            
                            rx_load_data <= 1; 
                            
                            uart_counter <= uart_counter + 1; 
                            
                            //if (rx_done_tick_o == 1) begin
                            //dout_o <= shreg;
                           // end 
                        end 
                        
                        else 
                            bit_timer <= bit_timer +1;
            
            end : case_stop 
            
            endcase 
        end 
        
            if (rx_load_data == 1) begin 
            
                uart_data_done_tick<= 0;
                
                if (uart_counter == 1) begin
                    uart_data[7:0] <= dout_o;
                    rx_load_data <= 0;
                   // uart_counter <= uart_counter + 1;
                end 
                
                else  if (uart_counter == 2) begin
                    uart_data[15:8] <= dout_o;
                    rx_load_data <= 0;
                    //uart_counter <= uart_counter + 1;
                end 
                
                 else  if (uart_counter == 3) begin
                    uart_data[23:16] <= dout_o;
                    rx_load_data <= 0;
                    //uart_counter <= uart_counter + 1;
                end 
                
                 else  if (uart_counter == 4) begin
                    uart_data[31:24] <= dout_o;
                    uart_counter <= 0;
                    rx_load_data <= 0;
                    uart_data_done_tick <= 1; // bu sinyal 1 olunca decoder da uart data yý çek. 
                end 
                
            end 
            
            
            
            if (uart_data_done_tick == 1) begin
                data_package <= {8'hab, uart_data, 8'hcd };
            end 
    end 
    
// dout_o <= shreg;
assign dout_o = shreg;

endmodule 