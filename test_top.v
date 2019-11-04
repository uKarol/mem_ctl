`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.10.2019 11:49:13
// Design Name: 
// Module Name: test_top
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


module test_top(    );
    
    wire din_valid;
    wire wen;
    wire dout_ack;
    wire mem_done;
    wire din_ack;
    wire dout_valid;
    wire mem_write;
    wire mem_read;
    wire [3:0]test_state;
    wire anti_glitch;
    wire rst;

     /*   mem_ctl DUT(
            .din_valid(din_valid),
            .wen(wen),
            .dout_ack(dout_ack),
            .mem_done(mem_done),
            .din_ack(din_ack),
            .dout_valid(dout_valid),
            .mem_write(mem_write),
            .mem_read(mem_read)
        );*/
        
        ctl_tb testbanch(
            .din_ack(din_ack),
            .write(mem_write),
            .read(mem_read),
            .dout_valid(dout_valid),
            .rst(rst),
            .din_valid(din_valid),
            .mem_done(mem_done),
            .dout_ack(dout_ack),
            .wen(wen),
            .test_state(test_state)
        );
        
       mem_ctl_io DUT_2(
            .rst(rst),
            .din_valid(din_valid),
            .wen(wen),
            .dout_ack(dout_ack),
            .mem_done(mem_done),
            .din_ack(din_ack),
            .dout_valid(dout_valid),
            .mem_write(mem_write),
            .mem_read(mem_read)
        );
    

endmodule
