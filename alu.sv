`include "Opcode.vh"

module alu(        
    input [2:0] fnc3, 
    input fnc1,
    input [31:0] rs1, 
    input [31:0] rs2, 
    output [31:0] rd  
);

reg [31:0] out;
assign rd = out;

always @(*) begin
    case(fnc3)
    `FNC_ADD_SUB: begin
        out <= fnc1 ? (rs1 - rs2) : (rs1 + rs2);
    end 
    `FNC_SLL: begin 
		  out <= rs1 << rs2[4:0];
    end
    `FNC_SLT: begin
        out <= {31'b0, $signed(rs1) < $signed(rs2)};
    end
    `FNC_SLTU: begin
        out <= {31'b0, rs1 < rs2};
    end
    `FNC_XOR: begin
        out <= rs1 ^ rs2;
    end
    `FNC_SRL_SRA: begin
        out <= fnc1 ? (rs1 >>> rs2[4:0]) : (rs1 >> rs2[4:0]);
    end
    `FNC_OR: begin
        out <= rs1 | rs2;
    end
    `FNC_AND: begin
        out <= rs1 & rs2;
    end
	 default: out = 0;
    endcase
end
endmodule
