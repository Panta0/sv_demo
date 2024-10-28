`include "uvm_pkg.sv"
`include "uvm.sv"
module force_model();
    import uvm_pkg::*;


    initial begin
        uvm_hdl_deposit("tb_top.u_top.c_tmp[0]", 'haa);
        uvm_hdl_deposit("tb_top.u_top.wire_a", 'haa);
        uvm_hdl_deposit("tb_top.u_top.wire_b[0]", 'haa);
        #1;
        $deposit(tb_top.u_top.c_tmp[0], 'hbb);
        $deposit(tb_top.u_top.wire_a, 'hbb);
        uvm_hdl_deposit("tb_top.u_top.wire_b[0]", 'hbb);
    end 
endmodule

bind tb_top  force_model u_force();
