`ifndef OPCODE
`define OPCODE

`define FNC_ADD_SUB     3'b000 
`define FNC_SLL         3'b001 // Shift Left Logic
`define FNC_SLT         3'b010 // Signed compare,   rd=1 if rs1 < rs2 else rd=0
`define FNC_SLTU        3'b011 // Unsigned compare, rd=1 if rs1 < rs2 else rd=0
`define FNC_XOR         3'b100
`define FNC_SRL_SRA     3'b101  
`define FNC_OR          3'b110
`define FNC_AND         3'b111 

`define FNC2_ADD        1'b0 // Addition
`define FNC2_SUB        1'b1 // Substract 
`define FNC2_SRL        1'b0 // Shift Right Logic
`define FNC2_SRA        1'b1 // Shift Right Arithmetic

`endif //OPCODE
