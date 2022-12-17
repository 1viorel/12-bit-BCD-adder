module BCD_Adder(
input [11:0]in_1,
input [11:0]in_2,
output [15:0]out_1);
//x y z transmit valorile lui cin si cout, cin initial e 0 si devine cout la cifra a doua
wire cout, x, y, z;
	
	BCD_2 f1(in_1[3:0],in_2[3:0],out_1[3:0],0,cout);
	BCD_2 f2(in_1[7:4],in_2[7:4],out_1[7:4],cout,x);
	BCD_2 f3(in_1[11:8],in_2[11:8],out_1[11:8],x,y);
	BCD_2 fS(0,0,out_1[15:12],y,z); //bitul 12, daca nu punem 0,0 si [15:12] primii 3 msb vor fi nedefiniti
endmodule

module BCD_2 (a, b, sum, cin, cout); //4 biti + corectie
input [3:0] a,b;
input cin;
output [3:0] sum;
output cout;
wire [3:0]corrout; wire [3:0]z; wire and1,and2,c_up,c_down;

RCA fa0(a, b, cin, z, c_up);

assign and1=z[3]&z[1];
assign and2=z[3]&z[2];
assign cout=c_up|and1|and2;
assign corrout[0]=0;            //daca carryout e 1, corrout e 0110, adica 1 pe pozitia 1 si 2, adica 6, adica corectie
assign corrout[1]=cout;
assign corrout[2]=cout;
assign corrout[3]=0;

RCA fa1(z, corrout, 0, sum, c_down); //aplicarea corectiei

endmodule

module RCA(a, b, cin, sum, cout); //full adder cell bitwise x 4, adica 4 biti, adica o cifra in bcd
input [3:0] a,b;
input cin;
output [3:0] sum;
output cout;
wire c1,c2,c3; //acestea transmit carry in si carry out in bitii urmatori

FAC fa0(a[0], b[0],cin, sum[0],c1);
FAC fa1(a[1], b[1], c1, sum[1],c2);
FAC fa2(a[2], b[2], c2, sum[2],c3);
FAC fa3(a[3], b[3], c3, sum[3],cout);

endmodule

module FAC(a,b,cin,sum, cout); //adunare bitwise, care determina si carry out
input a,b,cin;
output sum,cout;
assign sum=(a^b)^cin;
assign cout=((a^b)&cin)|(a&b);
endmodule


