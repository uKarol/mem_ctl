`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.11.2019 13:51:54
// Design Name: 
// Module Name: mem_ctl_rst_delay
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


module mem_ctl_rst_delay(
    input rst,
    input din_ack_nxt,
    input mem_write_nxt,
    input mem_read_nxt,
    input dout_valid_nxt,
    input anti_glitch_nxt,    
    
    output reg din_ack,
    output reg mem_write,
    output reg mem_read,
    output reg dout_valid,
    output reg anti_glitch
    );
    
    always @*    
    begin
    if( rst == 1)         
        begin     
            din_ack     <= #10 1'b0;
            dout_valid  <= #10 1'b0;
            mem_write   <= #10 1'b0;
            mem_read    <= #10 1'b0;   
            anti_glitch <= #10 1'b0;  
        end
    else      
        begin     
            din_ack     <= #10 din_ack_nxt;
            dout_valid  <= #10 dout_valid_nxt;
            mem_write   <= #10 mem_write_nxt;
            mem_read    <= #10 mem_read_nxt;   
            anti_glitch <= #10 anti_glitch_nxt;  
        end
    end
endmodule
