module MultS4Bits(
    input [3:0] x,
    input [3:0] y,
    output [7:0] prod
);


wire [3:0] Sx={x[3],1'b0,1'b0,1'b0};
wire [3:0] Sy={y[3],1'b0,1'b0,1'b0};







wire [3:0] offsetx= {~(x[3]),~(x[2]),~(x[1]),~(x[0])};
wire [3:0] offsety= {~(y[3]),~(y[2]),~(y[1]),~(y[0])};

wire [7:0] sxy;
wire [7:0] offxsy;
wire [7:0] offysx;
wire [7:0] offxy;
wire [7:0] secondT= offxy << 2;

MultU4Bits test1(Sx,Sy,sxy);
MultU4Bits test2(offsetx+1,Sy,offxsy);
MultU4Bits test3(Sx,offsety+1,offysx);
MultU4Bits test4(offsetx+1,offsety+1,offxy);

assign prod = (sxy + offxsy + offysx + offxy +secondT);







endmodule

module MultU4Bits (
    input [3:0] x,
    input [3:0] y,
    output [7:0] prod
);
    wire [3:0] pp[0:3];

    genvar i;
    generate
        for (i = 0; i < 4; i = i+1)
        begin
          assign pp[i] = {4{y[i]}} & x;
        end
    endgenerate

    wire [5:0] sum0;
    wire [5:0] sum1;
    
    assign sum0 = {1'b0, pp[0]} + {pp[1], 1'b0};
    assign sum1 = {1'b0, pp[2]} + {pp[3], 1'b0};

    assign prod = {2'b00, sum0} + {sum1, 2'b00};
endmodule
