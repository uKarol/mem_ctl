`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.10.2019 19:29:14
// Design Name: 
// Module Name: mem_ctl_io
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


module mem_ctl_io(
    input rst,
    input din_valid,
    input wen,
    input dout_ack,
    input mem_done,
    
    output din_ack,
    output dout_valid,
    output mem_write,
    output mem_read
);
    
    wire din_ack_nxt;
    wire dout_valid_nxt;
    wire mem_write_nxt;
    wire mem_read_nxt;
    wire anti_glitch;
    wire anti_glitch_nxt;
    
    mem_ctl_rst_delay feedback(
        .rst(rst),
        .din_ack_nxt(din_ack_nxt),
        .mem_write_nxt(mem_write_nxt),
        .mem_read_nxt(mem_read_nxt),
        .dout_valid_nxt(dout_valid_nxt),
        .anti_glitch_nxt(anti_glitch_nxt),    
    
        .din_ack(din_ack),
        .mem_write(mem_write),
        .mem_read(mem_read),
        .dout_valid(dout_valid),
        .anti_glitch(anti_glitch)
    );
    
    mem_ctl_next_state logic(
        .din_valid(din_valid),
        .wen(wen),
        .dout_ack(dout_ack),
        .mem_done(mem_done),
        
        .din_ack(din_ack),
        .dout_valid(dout_valid),
        .mem_write(mem_write),
        .mem_read(mem_read),
        .anti_glitch(anti_glitch),
        
        .din_ack_nxt(din_ack_nxt),
        .dout_valid_nxt(dout_valid_nxt),
        .mem_write_nxt(mem_write_nxt),
        .mem_read_nxt(mem_read_nxt),
        .anti_glitch_nxt(anti_glitch_nxt)
    );

endmodule
