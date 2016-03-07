

// PC Source
localparam
	PC_N	= 0,	// normal
	PC_J	= 1,	// Jump
	PC_JR	= 2,	// Jump reg
	PC_B	= 3;	// Branch

// ALU Source
localparam
	ALU_A_RS	= 0,
	ALU_A_RT	= 1,
	ALU_A_S 	= 2,
	ALU_A_L		= 3;

localparam
	ALU_B_RT	= 0,
	ALU_B_IMM	= 1,
	ALU_B_L		= 2;

// ALU OP
localparam 
	ALU_ADD	= 0,
	ALU_SUB	= 1,
	ALU_AND = 2,
	ALU_OR	= 3,
	ALU_XOR	= 4,
	ALU_NOR	= 5,
	ALU_SLL	= 6,
	ALU_SRL	= 7,
	ALU_SRA	= 8,
	ALU_SLLV= 9,
	ALU_SRLV= 10,
	ALU_SLT = 11,
	ALU_LUI = 12;

// WB
localparam
	WB_DST_RD 	= 0,
	WB_DST_RT	= 1,
	WB_DST_L 	= 2;

localparam
	WB_SRC_ALU	= 0,
	WB_SRC_MEM	= 1,
	WB_SRC_L 	= 2;

// Inst
localparam
	Rtype	= 6'h0,
		R_sll	= 6'h0,
		R_srl	= 6'h2,
		R_sra   = 6'b000011,
		R_sllv  = 6'b000100,
		R_srlv  = 6'b000110,
		R_srav	= 6'b000111,

		R_jr	= 6'b001000,

		R_add	= 6'h20,
		R_addu	= 6'h21,
		R_sub	= 6'h22,
		R_subu	= 6'h23,
		R_and	= 6'h24,
		R_or	= 6'h25,
		R_xor	= 6'h26,
		R_nor	= 6'h27,
		R_slt	= 6'h2A,
		R_sltu	= 6'h2B,

	I_addi	= 6'h08,
	I_addiu	= 6'h09,
	I_slti	= 6'h0A,
	I_sltiu	= 6'h0B,
	I_andi	= 6'h0C,
	I_ori	= 6'h0D,
	I_xori	= 6'h0E,
	I_lui	= 6'h0F,
	I_lw	= 6'h23,
	I_sw	= 6'h2B,
	I_CP	= 6'h10,
		CP_MFC	= 5'h0,
		CP_MTC	= 5'h4,
		CP_eret	= 5'h10,
	I_beq	= 6'h04,
	I_bne	= 6'h05,

	I_j		= 6'h02,
	I_jal	= 6'h03;

// Mem
localparam
	MEM_WORD	= 0,
	MEM_HALF	= 1,
	MEM_BYTE	= 2;