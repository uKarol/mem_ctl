`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.10.2019 21:56:16
// Design Name: 
// Module Name: mem_ctl
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mem_ctl(
    input din_valid,
    input wen,
    input dout_ack,
    input mem_done,
    output reg din_ack,
    output reg dout_valid,
    output reg mem_write,
    output reg mem_read
    );
    
    localparam 
        IDLE = 5'b00000,
        W0  = 5'b00001,
        W1  = 5'b00011,
        W2  = 5'b00010,
        W3  = 5'b00110, 
        W4  = 5'b00111,
        W5  = 5'b00101, 
        W6  = 5'b00100,
        W7  = 5'b01100,
        W8  = 5'b01101,
        W9  = 5'b01110,
        R0  = 5'b10000,
        R1  = 5'b10011,
        R2  = 5'b10010,
        R3  = 5'b10110,
        R4  = 5'b10111,
        R5  = 5'b10101,
        R6  = 5'b10100,
        R7  = 5'b11100,
        R8  = 5'b11101,
        R9  = 5'b11110,
        R10 = 5'b11111;
    
    reg [5:0] state = IDLE;
    reg [5:0] state_nxt =IDLE; 
    
    
    // asynch
    always@*
    begin
        state <= #10 state_nxt;
    end
    // next state
    always@*
    begin
        
        case(state)
        IDLE:
            begin
                if(wen == 1'b1) state_nxt = W1;
                else if(din_valid == 1'b1) state_nxt = R1;
                else state_nxt = IDLE;
            end
        W0:
            begin
                if(din_valid == 1'b1) state_nxt = W1;
                else state_nxt = W0;
            end
        W1: //transient
            begin
               state_nxt = W2;
            end
        W2:
            begin
                   if(mem_done == 1'b1) state_nxt = W3;
                    else state_nxt = W2;
            end
        W3: //transient
            begin
               state_nxt = W4;
            end
        W4:
            begin
               if(mem_done == 1'b0) state_nxt = W5;
               else state_nxt = W4;
            end
        W5: //transient
            begin
               state_nxt = W6;
            end
        W6:
            begin
               if(din_valid == 1'b0) state_nxt = W7;
               else state_nxt = W6;
            end
        W7:
            begin
               if(din_valid == 1'b0) state_nxt = W8;
               else state_nxt = W7;
            end             
        W8:
            begin
                if(wen == 1'b0) state_nxt = IDLE;
                else state_nxt = W8;
            end     
         R0: //transient
            begin
                state_nxt = R1;
            end           
         R1: 
            begin
                if(mem_done == 1'b1) state_nxt = R2;
                else state_nxt = R1;
            end
         R2: //transient
            begin
                state_nxt = R3;
            end
         R3: 
            begin
                if(din_valid == 1'b0) state_nxt = R4;
                else state_nxt = R3;
            end
         R4: //transient
            begin
                state_nxt = R5;
            end        
         R5: //transient
            begin
                state_nxt = R6;
            end
         R6: 
            begin
                if(dout_ack == 1'b1) state_nxt = R7;
                else state_nxt = R6;
            end
         R7: //transient
            begin
                state_nxt = R8;
            end
         R8: 
            begin
                if(dout_ack == 1'b0) state_nxt = R9;
                else state_nxt = R8;
            end 
         R9: //transient
            begin
                state_nxt = R10;
            end
         R10: 
            begin
                if(mem_done == 1'b0) state_nxt = IDLE;
                else state_nxt = R10;
            end          
        endcase
        
    end
    //output
    always@*
    begin
        case (state)
        IDLE:
            begin
                din_ack = 0;
                dout_valid = 0;
                mem_write = 0;
                mem_read = 0;
            end
        W0:
            begin
                din_ack = 0;
                dout_valid = 0;
                mem_write = 0;
                mem_read = 0;
            end
        W1:
            begin
                din_ack = 0;
                dout_valid = 0;
                mem_write = 0;
                mem_read = 0;
            end            
        W2:
            begin
                din_ack = 0;
                dout_valid = 0;
                mem_write = 1;
                mem_read = 0;
            end             
        W3:
            begin
                din_ack = 0;
                dout_valid = 0;
                mem_write = 1;
                mem_read = 0;
            end            
        W4:
            begin
                din_ack = 0;
                dout_valid = 0;
                mem_write = 0;
                mem_read = 0;
            end            
        W5:
            begin
                din_ack = 0;
                dout_valid = 0;
                mem_write = 0;
                mem_read = 0;
            end            
        W6:
            begin
                din_ack = 1;
                dout_valid = 0;
                mem_write = 0;
                mem_read = 0;
            end                    
        W7:
            begin
                din_ack = 1; 
                dout_valid = 0;
                mem_write = 0;
                mem_read = 0;
            end      
        W8:
            begin
               din_ack = 0; 
               dout_valid = 0;
               mem_write = 0;
               mem_read = 0;
            end    
        W9:
            begin
               din_ack = 0; 
               dout_valid = 0;
               mem_write = 0;
               mem_read = 0;
            end   
            
        R0:
        begin
            din_ack = 0;
            dout_valid = 0;
            mem_write = 0;
            mem_read = 0;
        end
        
        R1:
        begin
            din_ack = 0;
            dout_valid = 0;
            mem_write = 0;
            mem_read = 1;
        end
        
        R2:
        begin
            din_ack = 0;
            dout_valid = 0;
            mem_write = 0;
            mem_read = 1;
        end
        
        R3:
        begin
            din_ack = 1;
            dout_valid = 0;
            mem_write = 0;
            mem_read = 1;
        end
        
        R4:
        begin
            din_ack = 1;
            dout_valid = 0;
            mem_write = 0;
            mem_read = 1;
        end
        
        R5:
        begin
            din_ack = 0;
            dout_valid = 0;
            mem_write = 0;
            mem_read = 1;
        end
        
        R6:
        begin
            din_ack = 0;
            dout_valid = 1;
            mem_write = 0;
            mem_read = 1;
        end
        
        R7:
        begin
            din_ack = 0;
            dout_valid = 1;
            mem_write = 0;
            mem_read = 1;
        end
        
        R8:
        begin
            din_ack = 0;
            dout_valid = 0;
            mem_write = 0;
            mem_read = 1;
        end
        
        R9:
        begin
            din_ack = 0;
            dout_valid = 0;
            mem_write = 0;
            mem_read = 1;
        end
             
        R10:
        begin
            din_ack = 0;
            dout_valid = 0;
            mem_write = 0;
            mem_read = 0;
        end          
               
        endcase
    end
    
endmodule
