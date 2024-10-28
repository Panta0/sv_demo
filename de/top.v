module top(input clk, input rst_n, input logic[1:0] a, input logic[1:0] b);
    reg [31:0] cnt;
    reg [2:0] c, d, e, f;
    wire [7:0] wire_a;
    reg [7:0] wire_b[1:0];

    integer seed;
    integer seed_tmp;
    real random_number;
    integer mean_selected;
    integer deviation_selected;
    reg [31:0] D_int;
    reg  D_reg, D_final, D;
    reg   en;
    reg [31:0] a_tmp, c_tmp;


    always @* begin
     	random_number <= ($dist_normal(seed, mean_selected , deviation_selected)/1000);
        D_reg <= #(random_number)D_final;
    end

    assign wire_a= a_tmp;
    assign wire_b[0] = a_tmp;
    assign wire_b[1] = a_tmp;
    assign D = ~(en & D_reg);
    assign D_final = D;

    always @* begin
        D_int = $urandom_range(1000, 2000);
        #D_int;
        en <= ~en;
    end

    always @* begin
         if(a_tmp<6)
            c_tmp <= #10ps a_tmp;
         else
            c_tmp <= #5ps a_tmp;
    end

    always #1ps if(a_tmp<=100) a_tmp = a_tmp+1;

    

    initial begin
        a_tmp = 0;
        seed = 26483593;
        D_reg = 0;
        en = 0;
        deviation_selected = 526;
        mean_selected = 172852;
    end

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)
            cnt <= 0;
        else if(cnt == 9)
            cnt <= 0;
        else
            cnt <= cnt + 1;
    end

    always@(a) begin
        case(a)
            0: d = 7;
            1: d = 6;
            2: d = 5;
            3: d = 4;
            default: d ='bx;
        endcase
    end

     always@(b) begin
        case(b)
            0: e = 7;
            1: e = 6;
            2: e = 5;
            3: e = 4;
            default: e ='bx;
        endcase
    end

    initial begin
        case(a)
            0: c = 7;
            1: c = 6;
            2: c = 5;
            3: c = 4;
            default: c='bx;
        endcase
    end

    initial begin
        case(b)
            0: f = 7;
            1: f = 6;
            2: f = 5;
            3: f = 4;
            default: f='bx;
        endcase
    end
endmodule

