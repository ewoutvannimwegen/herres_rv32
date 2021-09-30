`include "../../Opcode.vh"

`timescale 1 ns/1 ps

module alu_testbench();

timeunit 1ns;
timeprecision 100ps;

parameter PERIOD = 20; // 20ns

reg clk;
initial clk = 1'b0;
always #(PERIOD/2) clk = ~clk;

reg [2:0] fnc3;
reg fnc1;
reg [31:0] rs1;
reg [31:0] rs2;

wire [31:0] rd;

alu i1(
    .fnc3(fnc3),
    .fnc1(fnc1),
    .rs1(rs1),
    .rs2(rs2),
    .rd(rd)
);

integer cnt; 

reg [30:0] rand_31;
reg [14:0] rand_15; 
reg [31:0] A, B;
reg [4*8:0] inst; // Instruction
reg [31:0] out;

task validate;
input reg[4*8:0] inst;
	if(rd == out) $display("PASS %s: \trs1: 0x%h, rs2: 0x%h, rd: 0x%h, out: 0x%h", inst, A, B, rd, out);
	else begin
		 $display("FAIL %s: \trs1: 0x%h, rs2: 0x%h, rd: 0x%h, out: 0x%h", inst, A, B, rd, out);
		 $finish();
	end
endtask

initial begin 
	fnc3 = 3'b0;
	fnc1 = 1'b0;
	rs1 = 32'b0;
	rs2 = 32'b0;
	
	for(cnt=0;cnt<=19;cnt++) begin
		$display("Round %d", cnt);
		#1;
		rand_31 = {$random} & 31'h7FFFFFFF;
		rand_15 = {$random} & 15'h7FFF;
		A = {1'b1, rand_31};
		B = {16'hFFFF, 1'b1, rand_15};
		rs1 = A;
		rs2 = B;
		
		inst = "ADD";
		fnc3 = `FNC_ADD_SUB;
		fnc1 = `FNC2_ADD;
		out = A + B;
		#1;
		validate(inst);
		
		inst = "SUB";
		fnc3 = `FNC_ADD_SUB;
		fnc1 = `FNC2_SUB;
		out = A - B;
		#1;
		validate(inst);
		
		inst = "SLL";
		fnc3 = `FNC_SLL;
		out = A << B[4:0];
		#1;
		validate(inst);
		
		inst = "SLT";
		fnc3 = `FNC_SLT;
		out = $signed(A) < $signed(B);
		#1;
		validate(inst);
		
		inst = "SLTU";
		fnc3 = `FNC_SLTU;
		out = A < B;
		#1;
		validate(inst);
		
		inst = "XOR";
		fnc3 = `FNC_XOR;
		out = A ^ B;
		#1;
		validate(inst);
		
		inst = "SRL";
		fnc3 = `FNC_SRL_SRA;
		fnc1 = `FNC2_SRL;
		out = A >> B[4:0];
		#1;
		validate(inst);
		
		inst = "SRA";
		fnc1 = `FNC2_SRA;
		out = (A >>> B[4:0]);
		#1;
		validate(inst);
		
		inst = "OR";
		fnc3 = `FNC_OR;
		out = A | B;
		#1;
		validate(inst);
		
		inst = "AND";
		fnc3 = `FNC_AND;
		out = A & B;
		#1;
		validate(inst);
	end	  
	$finish();
end
endmodule


