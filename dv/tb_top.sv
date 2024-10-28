
`timescale 1ns/1ps

`include "uvm_pkg.sv"
`include "uvm.sv"
module tb_top;
    import uvm_pkg::*

    `include "uvm_macros.svh";
    //----------------------------------------
    reg             clk         ;
    reg             rst_n       ;
    //----------------------------------------

    reg [1:0] aa, bb;
    reg cc, dd;
    reg [31:0] ee;

    //----------------------------------------
    initial clk = 1'b1;
    always begin
         #10 clk = ~clk;
        dd = $urandom;
        ee = ee + 1;
    end
     
    initial begin
        rst_n = 0; #11 rst_n = 1;
    end
    //----------------------------------------

    initial begin
        uvm_hdl_deposit("tb_top.u_top.c_tmp", 'haa);
    end

    initial begin
        //aa = 2'b1;
        dd <= 1;
        aa <= $urandom_range(0,3);
        bb = $urandom_range(0,3);
        //force t.a = 2'b1;
        #10000;
        $finish;
	end

    initial begin
        //if ($test$plusargs("dump_wave"))  begin
            $fsdbDumpfile("debug.fsdb");
	        $fsdbDumpvars(0);
            $fsdbDumpMDA(0); 
        //end
    end

    //assign aa = 2'b1;
    top u_top(.clk(clk), .rst_n(rst_n), .a(aa), .b(bb));
endmodule


