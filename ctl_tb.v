`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.10.2019 13:59:38
// Design Name: 
// Module Name: ctl_tb
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


module ctl_tb(
    input din_ack,
    input write,
    input read,
    input dout_valid,
    output reg rst,
    output reg din_valid,
    output reg mem_done,
    output reg dout_ack,
    output reg wen,
    output reg [3:0]test_state
    );


localparam 
    //writting states
    W_START            = 4'b0000,
    WRITTING           = 4'b0001,
    STOP_WRITTING      = 4'b0011,
    W_ACKNOWLEDGE      = 4'b0010,
    W_ACKNOWLEDGE_STOP = 4'b0110,
    //reading states
    R_SET_MEM_DONE    = 4'b0111,
    R_CLEAR_VALID     = 4'b0101,
    R_SET_DOUT_ACK    = 4'b0100,
    R_CLEAR_DOUT_ACK  = 4'b1100,
    R_CLEAR_MEM_DONE  = 4'b1101;
     
    

//reg test_state;
    
initial
begin
    rst = 1'b1;
    #20;
    rst = 1'b0;
    #10;
    
    $display( "INITIALIZE ALL OUTPUTS WITH 0" );   
    din_valid = 0;
    wen = 0;
    mem_done = 0;
    dout_ack = 0;
    test_state = W_START;
    #10;
    $display( "SET wen 1" );
    din_valid = 0;
    wen = 1;
    mem_done = 0;
    dout_ack = 0;
    
    #10;
    $display( "SET din_valid 1" );
    din_valid = 1;
    wen = 1;
    mem_done = 0;
    dout_ack = 0;
    test_state = WRITTING;

end

always @*

    case(test_state)
    WRITTING:
    begin
        if( write == 1'b1 ) begin
            #10 mem_done = 1'b1;
            test_state = STOP_WRITTING;
        end
     else 
        begin
            test_state = WRITTING;
        end
    end
    STOP_WRITTING:
    begin
        if( write == 1'b0 ) begin
            #10 mem_done = 1'b0;
            test_state = W_ACKNOWLEDGE;
            end
        else 
        begin
            test_state = STOP_WRITTING;
        end
    end
    W_ACKNOWLEDGE:
    begin
        if( din_ack == 1'b1 ) begin
            #10 din_valid = 1'b0;
            test_state = W_ACKNOWLEDGE_STOP;
        end
        else
        begin
            test_state = W_ACKNOWLEDGE;
        end
    end
    W_ACKNOWLEDGE_STOP:
    begin
        if( din_ack == 1'b0 ) begin
            #10 wen = 1'b0;
             $display("WRITTING STOP");
            #10 din_valid = 1'b1;
            #10 test_state = R_SET_MEM_DONE;       
        end
        else
        begin
            test_state = W_ACKNOWLEDGE_STOP;
        end
    end
    
    R_SET_MEM_DONE:
    begin
        $display("START READING");
        if( read == 1'b1 ) begin
            #10 mem_done = 1'b1;
            test_state = R_CLEAR_VALID;
        end
        else
        begin
            test_state = R_SET_MEM_DONE;
        end
    end
    
    R_CLEAR_VALID:
    begin
        if( din_ack == 1'b1 ) begin
            #10 din_valid = 1'b0;
            test_state = R_SET_DOUT_ACK;
        end
        else
        begin
            test_state = R_CLEAR_VALID;
        end
    end
    
    R_SET_DOUT_ACK:
    begin
        if( dout_valid == 1'b1 ) begin
            #10 dout_ack = 1'b1;
            test_state = R_CLEAR_DOUT_ACK;
        end
        else
        begin
            test_state = R_SET_DOUT_ACK;
        end
    end
    
    R_CLEAR_DOUT_ACK:
    begin
        if( dout_valid == 1'b0 ) begin
            #10 dout_ack = 1'b0;
            test_state = R_CLEAR_MEM_DONE;
        end
        else
        begin
            test_state = R_CLEAR_DOUT_ACK;
        end
    end
    
    R_CLEAR_MEM_DONE:
    begin
        if( read == 1'b0 ) begin
            #10 mem_done = 1'b0;
            #10 $finish;
        end
        else
        begin
            test_state =  R_CLEAR_MEM_DONE;
        end
    end
    
    endcase
endmodule