module d_ff(rst,d,clk,q);
parameter width=16;

input rst,clk;
input [15:0]d;
output reg [15:0]q;
always@(posedge clk,rst) begin
	q<=(rst)?16'b0:d;
end
endmodule


module ha(input a,b,output sum,cout);
assign sum=a^b;
assign cout=a&b;
endmodule

module fa(input a,b,cin,output sum,cout);
assign sum=a^b^cin;
assign cout=(a&b)|(b&cin)|(a&cin);
endmodule


module rca_4(input [3:0]a,b,input cin,output [3:0]sum,output cout);
wire w1,w2,w3;
fa uut1(a[0],b[0],cin,sum[0],w1);
fa uut2(a[1],b[1],w1,sum[1],w2);
fa uut3(a[2],b[2],w2,sum[2],w3);
fa uut4(a[3],b[3],w3,sum[3],cout);
endmodule


module rca_8(input [7:0]a,b,input cin,output [7:0]sum,output cout);
wire w1,w2,w3;
rca_4 dut1(a[3:0],b[3:0],cin,sum[3:0],w1);
rca_4 dut2(a[7:4],b[7:4],w1,sum[7:4],cout);

endmodule


module rca_16(input [15:0]a,b,input cin,output [15:0]sum,output cout);
wire w1,w2,w3;
rca_4 dut1(a[3:0],b[3:0],cin,sum[3:0],w1);
rca_4 dut2(a[7:4],b[7:4],w1,sum[7:4],w2);
rca_4 dut3(a[11:8],b[11:8],w2,sum[11:8],w3);
rca_4 dut4(a[15:12],b[15:12],w3,sum[15:12],cout);
endmodule

module rca_32(input [31:0]a,b,input cin,output [31:0]sum,output cout);
wire w1;
rca_16 dut1(a[15:0],b[15:0],cin,sum[15:0],w1);
rca_16 dut2(a[31:16],b[31:16],w1,sum[31:16],cout);

endmodule

//#################################################################################
 // ##############------MULTIPLIERS--------###############
//#################################################################################
module mul4x4(input [3:0]a,b,output [7:0]p);

wire [3:0]w1,w2,w3,w4;
wire s0,s1,s2,s3,s4,s5,s6;
wire c0,c1,c2,c3,c4,c5,c6;
wire t1,t2,t3,t4,t5;
//stage 1
assign w1={4{a[0]}}&b;
assign w2={4{a[1]}}&b;
assign w3={4{a[2]}}&b;
assign w4={4{a[3]}}&b;

//satge 2
ha uut1(w3[1],w4[0],s0,c0);
ha uut2(w3[2],w4[1],s1,c1);

//stage 3
ha uut3(w2[1],w3[0],s3,c3);
fa uut4(w1[3],w2[2],s0,s4,c4);
fa uut5(w2[3],s1,c0,s5,c5);
fa uut6(w3[3],w4[2],c1,s6,c6);

//stage 4
assign p[0]=w1[0];
fa uut7(w1[1],w2[0],1'b0,p[1],t1);
fa uut8(w1[2],s3,t1,p[2],t2);
fa uut9(c3,s4,t2,p[3],t3);

fa uut10(c4,s5,t3,p[4],t4);
fa uut11(c5,s6,t4,p[5],t5);
fa uut12(c6,w4[3],t5,p[6],p[7]);




endmodule



module wtm8x8(a,b,p);
input [7:0]a,b;
output [15:0]p;

wire [7:0]w0,w1,w2,w3,w4,w5;
wire c1,c2,c3,h1,h2;
wire [7:0]e1,e2;
//stage1
mul4x4 uut1(a[3:0],b[3:0],w0);
mul4x4 uut2(a[3:0],b[7:4],w1);
mul4x4 uut3(a[7:4],b[3:0],w2);
mul4x4 uut4(a[7:4],b[7:4],w3);

//stage2
rca_8 uut5(w1,w2,1'b0,w4,c1);

//stage3
assign e1={4'b0000,w0[7:4]};
rca_8 uut6(w4,e1,1'b0,w5,c2);
ha uut7(c1,c2,h1,h2);


//stage4
assign e2={2'b00,h2,h1,w5[7:4]};
rca_8 uut8(w3,e2,1'b0,p[15:8],c3);
assign p[7:4]=w5[3:0];
assign p[3:0]=w0[3:0];

endmodule



module wtm16x16(a1,b1,p1);


input [15:0]a1,b1;
output [31:0]p1;
wire [15:0]a,b;
wire [31:0]p;
assign a=(a1[15])?((~a1)+1'b1):a1;
assign b=(b1[15])?((~b1)+1'b1):b1;


wire [15:0]w0,w1,w2,w3,w4,w5;
wire c1,c2,c3,h1,h2;
wire [15:0]e1,e2;
//stage1
wtm8x8 uut1(a[7:0],b[7:0],w0);
wtm8x8 uut2(a[7:0],b[15:8],w1);
wtm8x8 uut3(a[15:8],b[7:0],w2);
wtm8x8 uut4(a[15:8],b[15:8],w3);

//stage2
rca_16 uut5(w1,w2,1'b0,w4,c1);

//stage3
assign e1={8'b0000,w0[15:8]};
rca_16 uut6(w4,e1,1'b0,w5,c2);
ha uut7(c1,c2,h1,h2);


//stage4
assign e2={6'b00,h2,h1,w5[15:8]};
rca_16 uut8(w3,e2,1'b0,p[31:16],c3);
assign p[15:8]=w5[7:0];
assign p[7:0]=w0[7:0];


assign p1=(a1[15]^b1[15])?((~p)+1'b1):p;



endmodule

//fir filter 64th order

module filter_64(ce,rst,x,clk,y);
input [15:0]x;
input ce,rst,clk;
output [31:0]y;

wire [15:0]x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,x16,x17,x18,x19,x20,x21,x22,x23,x24,x25,x26,x27,x28,x29,x30,x31,x32;
wire [15:0]x33,x34,x35,x36,x37,x38,x39,x40,x41,x42,x43,x44,x45,x46,x47,x48,x49,x50,x51,x52,x53,x54,x55,x56,x57,x58,x59,x60,x61,x62,x63,x64;

wire [15:0]m1,m2,m3,m4,m5,m6,m7,m8,m9,m10,m11,m12,m13,m14,m15,m16,m17,m18,m19,m20,m21,m22,m23,m24,m25,m26,m27,m28,m29,m30,m31,m32;
wire [31:0]c,cd;
wire [31:0]hc1,hc2,hc3,hc4,hc5,hc6,hc7,hc8,hc9,hc10,hc11,hc12,hc13,hc14,hc15,hc16,hc17,hc18,hc19,hc20,hc21,hc22,hc23,hc24,hc25,hc26,hc27,hc28,hc29,hc30,hc31,hc32,hc33;
wire [31:0]t1,t2,t3,t4,t5,t6,t7,t8,t9,t10,t11,t12,t13,t14,t15,t16,t17,t18,t19,t20,t21,t22,t23,t24,t25,t26,t27,t28,t29,t30,t31,t32;

//stage 1
d_ff uut1(rst,x,clk,x1);
d_ff uut2(rst,x1,clk,x2);
d_ff uut3(rst,x2,clk,x3);
d_ff uut4(rst,x3,clk,x4);
d_ff uut5(rst,x4,clk,x5);
d_ff uut6(rst,x5,clk,x6);
d_ff uut7(rst,x6,clk,x7);
d_ff uut8(rst,x7,clk,x8);
d_ff uut9(rst,x8,clk,x9);
d_ff uut10(rst,x9,clk,x10);

d_ff uut11(rst,x10,clk,x11);
d_ff uut12(rst,x11,clk,x12);
d_ff uut13(rst,x12,clk,x13);
d_ff uut14(rst,x13,clk,x14);
d_ff uut15(rst,x14,clk,x15);
d_ff uut16(rst,x15,clk,x16);
d_ff uut17(rst,x16,clk,x17);
d_ff uut18(rst,x17,clk,x18);
d_ff uut19(rst,x18,clk,x19);
d_ff uut20(rst,x19,clk,x20);

d_ff uut21(rst,x20,clk,x21);
d_ff uut22(rst,x21,clk,x22);
d_ff uut23(rst,x22,clk,x23);
d_ff uut24(rst,x23,clk,x24);
d_ff uut25(rst,x24,clk,x25);
d_ff uut26(rst,x25,clk,x26);
d_ff uut27(rst,x26,clk,x27);
d_ff uut28(rst,x27,clk,x28);
d_ff uut29(rst,x28,clk,x29);
d_ff uut30(rst,x29,clk,x30);

d_ff uut31(rst,x30,clk,x31);
d_ff uut32(rst,x31,clk,x32);
d_ff uut33(rst,x32,clk,x33);
d_ff uut34(rst,x33,clk,x34);
d_ff uut35(rst,x34,clk,x35);
d_ff uut36(rst,x35,clk,x36);
d_ff uut37(rst,x36,clk,x37);
d_ff uut38(rst,x37,clk,x38);
d_ff uut39(rst,x38,clk,x39);
d_ff uut40(rst,x39,clk,x40);

d_ff uut41(rst,x40,clk,x41);
d_ff uut42(rst,x41,clk,x42);
d_ff uut43(rst,x42,clk,x43);
d_ff uut44(rst,x43,clk,x44);
d_ff uut45(rst,x44,clk,x45);
d_ff uut46(rst,x45,clk,x46);
d_ff uut47(rst,x46,clk,x47);
d_ff uut48(rst,x47,clk,x48);
d_ff uut49(rst,x48,clk,x49);
d_ff uut50(rst,x49,clk,x50);

d_ff uut51(rst,x50,clk,x51);
d_ff uut52(rst,x51,clk,x52);
d_ff uut53(rst,x52,clk,x53);
d_ff uut54(rst,x53,clk,x54);
d_ff uut55(rst,x54,clk,x55);
d_ff uut56(rst,x55,clk,x56);
d_ff uut57(rst,x56,clk,x57);
d_ff uut58(rst,x57,clk,x58);
d_ff uut59(rst,x58,clk,x59);
d_ff uut60(rst,x59,clk,x60);

d_ff uut61(rst,x60,clk,x61);
d_ff uut62(rst,x61,clk,x62);
d_ff uut63(rst,x62,clk,x63);
d_ff uut64(rst,x63,clk,x64);

//stage2
rca_16 aut1(x,x64,1'b0,m1,c[0]);
rca_16 aut2(x1,x63,1'b0,m2,c[1]);
rca_16 aut3(x2,x62,1'b0,m3,c[2]);
rca_16 aut4(x3,x61,1'b0,m4,c[3]);
rca_16 aut5(x4,x60,1'b0,m5,c[4]);
rca_16 aut6(x5,x59,1'b0,m6,c[5]);
rca_16 aut7(x6,x58,1'b0,m7,c[6]);
rca_16 aut8(x7,x57,1'b0,m8,c[7]);
rca_16 aut9(x8,x56,1'b0,m9,c[8]);
rca_16 aut10(x9,x55,1'b0,m10,c[9]);

rca_16 aut11(x10,x54,1'b0,m11,c[10]);
rca_16 aut12(x11,x53,1'b0,m12,c[11]);
rca_16 aut13(x12,x52,1'b0,m13,c[12]);
rca_16 aut14(x13,x51,1'b0,m14,c[13]);
rca_16 aut15(x14,x50,1'b0,m15,c[14]);
rca_16 aut16(x15,x49,1'b0,m16,c[15]);
rca_16 aut17(x16,x48,1'b0,m17,c[16]);
rca_16 aut18(x17,x47,1'b0,m18,c[17]);
rca_16 aut19(x18,x46,1'b0,m19,c[18]);
rca_16 aut20(x19,x45,1'b0,m20,c[19]);

rca_16 aut21(x20,x44,1'b0,m21,c[20]);
rca_16 aut22(x21,x43,1'b0,m22,c[21]);
rca_16 aut23(x22,x42,1'b0,m23,c[22]);
rca_16 aut24(x23,x41,1'b0,m24,c[23]);
rca_16 aut25(x24,x40,1'b0,m25,c[24]);
rca_16 aut26(x25,x39,1'b0,m26,c[25]);
rca_16 aut27(x26,x38,1'b0,m27,c[26]);
rca_16 aut28(x27,x37,1'b0,m28,c[27]);
rca_16 aut29(x28,x36,1'b0,m29,c[28]);
rca_16 aut30(x29,x35,1'b0,m30,c[29]);

rca_16 aut31(x30,x34,1'b0,m31,c[30]);
rca_16 aut32(x31,x33,1'b0,m32,c[31]);

//stage3

wtm16x16 mut1(m1,16'b0,hc1);
wtm16x16 mut2(m2,16'b0,hc2);
wtm16x16 mut3(m3,16'b0,hc3);
wtm16x16 mut4(m4,16'hfffd,hc4);
wtm16x16 mut5(m5,16'hfff6,hc5);
wtm16x16 mut6(m6,16'hffef,hc6);
wtm16x16 mut7(m7,16'hfff0,hc7);
wtm16x16 mut8(m8,16'b0,hc8);
wtm16x16 mut9(m9,16'h0022,hc9);
wtm16x16 mut10(m10,16'h004B,hc10);

wtm16x16 mut11(m11,16'h0065,hc11);
wtm16x16 mut12(m12,16'h0052,hc12);
wtm16x16 mut13(m13,16'b0,hc13);
wtm16x16 mut14(m14,16'hff7c,hc14);
wtm16x16 mut15(m15,16'hfeee,hc15);
wtm16x16 mut16(m16,16'hfeab,hc16);

wtm16x16 mut17(m17,16'hfefb,hc17);
wtm16x16 mut18(m18,16'b0,hc18);
wtm16x16 mut19(m19,16'h0184,hc19);
wtm16x16 mut20(m20,16'h02f9,hc20);
wtm16x16 mut21(m21,16'h0395,hc21);
wtm16x16 mut22(m22,16'h02aa,hc22);
wtm16x16 mut23(m23,16'b0,hc23);
wtm16x16 mut24(m24,16'hfc08,hc24);

wtm16x16 mut25(m25,16'hf882,hc25);
wtm16x16 mut26(m26,16'hf6e6,hc26);
wtm16x16 mut27(m27,16'hf916,hc27);
wtm16x16 mut28(m28,16'b0,hc28);
wtm16x16 mut29(m29,16'h0b3c,hc29);
wtm16x16 mut30(m30,16'h18ed,hc30);
wtm16x16 mut31(m31,16'h261e,hc31);
wtm16x16 mut32(m32,16'h2fb1,hc32);

wtm16x16 mut33(x33,16'h332d,hc33);

//stage 4
rca_32 dut1(hc1,hc2,1'b0,t1,cd[0]);
rca_32 dut2(hc3,t1,1'b0,t2,cd[1]);
rca_32 dut3(hc4,t2,1'b0,t3,cd[2]);
rca_32 dut4(hc5,t3,1'b0,t4,cd[3]);
rca_32 dut5(hc6,t4,1'b0,t5,cd[4]);
rca_32 dut6(hc7,t5,1'b0,t6,cd[5]);
rca_32 dut7(hc8,t6,1'b0,t7,cd[6]);
rca_32 dut8(hc9,t7,1'b0,t8,cd[7]);
rca_32 dut9(hc10,t8,1'b0,t9,cd[8]);
rca_32 dut10(hc11,t9,1'b0,t10,cd[9]);


rca_32 dut11(hc12,t10,1'b0,t11,cd[10]);
rca_32 dut12(hc13,t11,1'b0,t12,cd[11]);
rca_32 dut13(hc14,t12,1'b0,t13,cd[12]);
rca_32 dut14(hc15,t13,1'b0,t14,cd[13]);
rca_32 dut15(hc16,t14,1'b0,t15,cd[14]);
rca_32 dut16(hc17,t15,1'b0,t16,cd[15]);
rca_32 dut17(hc18,t16,1'b0,t17,cd[16]);
rca_32 dut18(hc19,t17,1'b0,t18,cd[17]);
rca_32 dut19(hc20,t18,1'b0,t19,cd[18]);
rca_32 dut20(hc21,t19,1'b0,t20,cd[19]);


rca_32 dut21(hc22,t20,1'b0,t21,cd[20]);
rca_32 dut22(hc23,t21,1'b0,t22,cd[21]);
rca_32 dut23(hc24,t22,1'b0,t23,cd[22]);
rca_32 dut24(hc25,t23,1'b0,t24,cd[23]);
rca_32 dut25(hc26,t24,1'b0,t25,cd[24]);
rca_32 dut26(hc27,t25,1'b0,t26,cd[25]);
rca_32 dut27(hc28,t26,1'b0,t27,cd[26]);
rca_32 dut28(hc29,t27,1'b0,t28,cd[27]);
rca_32 dut29(hc30,t28,1'b0,t29,cd[28]);
rca_32 dut30(hc31,t29,1'b0,t30,cd[29]);

rca_32 dut31(hc32,t30,1'b0,t31,cd[30]);
rca_32 dut32(hc33,t31,1'b0,y,cd[31]);



endmodule

