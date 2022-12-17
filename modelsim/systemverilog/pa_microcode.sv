package pa_microcode;
  parameter CONTROL_WORD_WIDTH = 8 * 14;
  
  parameter CPU_STATUS_DMA_ACK_POS = 0;
  parameter CPU_STATUS_IRQ_EN_POS = 1;
  parameter CPU_STATUS_MODE_POS = 2;
  parameter CPU_STATUS_PAGING_EN_POS = 3;
  parameter CPU_STATUS_HALT_POS = 4;
  parameter CPU_STATUS_DISPLAYREG_LOAD_POS = 5;
  // POS 6 UNDEFINED FOR NOW
  parameter CPU_STATUS_DIR_POS = 7;
  
  
  parameter U_ROM0 = 0 * 8;
  parameter U_ROM1 = 1 * 8;
  parameter U_ROM2 = 2 * 8;
  parameter U_ROM3 = 3 * 8;
  parameter U_ROM4 = 4 * 8;
  parameter U_ROM5 = 5 * 8;
  parameter U_ROM6 = 6 * 8;
  parameter U_ROM7 = 7 * 8;
  parameter U_ROM8 = 8 * 8;
  parameter U_ROM9 = 9 * 8;
  parameter U_ROM10 = 10 * 8;
  parameter U_ROM11 = 11 * 8;
  parameter U_ROM12 = 12 * 8;
  parameter U_ROM13 = 13 * 8;  
  
  parameter typ0 = U_ROM0 + 0;
  parameter typ1 = U_ROM0 + 1;
  parameter u_offset_0 = U_ROM0 + 2;
  parameter u_offset_1 = U_ROM0 + 3;
  parameter u_offset_2 = U_ROM0 + 4;
  parameter u_offset_3 = U_ROM0 + 5;
  parameter u_offset_4 = U_ROM0 + 6;
  parameter u_offset_5 = U_ROM0 + 7;

  parameter u_offset_6 = U_ROM1 + 0;
  parameter cond_invert = U_ROM1 + 1;
  parameter cond_flag_src = U_ROM1 + 2;
  parameter cond_sel_0 = U_ROM1 + 3;
  parameter cond_sel_1 = U_ROM1 + 4;
  parameter cond_sel_2 = U_ROM1 + 5;
  parameter cond_sel_3 = U_ROM1 + 6;
  parameter ESCAPE = U_ROM1 + 7;

  parameter U_ZF_IN_SRC_0 = U_ROM2 + 0;
  parameter U_ZF_IN_SRC_1 = U_ROM2 + 1;
  parameter U_CF_IN_SRC_0 = U_ROM2 + 2;
  parameter U_CF_IN_SRC_1 = U_ROM2 + 3;
  parameter U_SF_IN_SRC = U_ROM2 + 4;
  parameter U_OF_IN_SRC = U_ROM2 + 5;
  parameter IR_WRT = U_ROM2 + 6;
  parameter STATUS_FLAGS_WRT = U_ROM2 + 7;

  parameter SHIFT_MSB_SRC_0 = U_ROM3 + 0;
  parameter SHIFT_MSB_SRC_1 = U_ROM3 + 1;
  parameter SHIFT_MSB_SRC_2 = U_ROM3 + 2;
  parameter ZBUS_IN_SRC_0 = U_ROM3 + 3;
  parameter ZBUS_IN_SRC_1 = U_ROM3 + 4;
  parameter ALU_A_SRC_0	= U_ROM3 + 5;	
  parameter ALU_A_SRC_1	= U_ROM3 + 6;	
  parameter ALU_A_SRC_2 = U_ROM3 + 7; 

  parameter ALU_A_SRC_3 = U_ROM4 + 0;
  parameter ALU_A_SRC_4 = U_ROM4 + 1;
  parameter ALU_A_SRC_5 = U_ROM4 + 2;
  parameter ALU_OP_0 = U_ROM4 + 3;
  parameter ALU_OP_1 = U_ROM4 + 4;
  parameter ALU_OP_2 = U_ROM4 + 5;
  parameter ALU_OP_3 = U_ROM4 + 6;
  parameter ALU_MODE = U_ROM4 + 7;

  parameter ALU_CF_IN_SRC0 = U_ROM5 + 0;
  parameter ALU_CF_IN_SRC1 = U_ROM5 + 1;
  parameter ALU_CF_IN_INVERT = U_ROM5 + 2;
  parameter ZF_IN_SRC_0 = U_ROM5 + 3;
  parameter ZF_IN_SRC_1 = U_ROM5 + 4;
  parameter ALU_CF_OUT_INVERT = U_ROM5 + 5;
  parameter CF_IN_SRC_0 = U_ROM5 + 6;
  parameter CF_IN_SRC_1 = U_ROM5 + 7;

  parameter CF_IN_SRC_2 = U_ROM6 + 0;
  parameter SF_IN_SRC_0 = U_ROM6 + 1;
  parameter SF_IN_SRC_1 = U_ROM6 + 2;
  parameter OF_IN_SRC_0 = U_ROM6 + 3;
  parameter OF_IN_SRC_1 = U_ROM6 + 4;
  parameter OF_IN_SRC_2 = U_ROM6 + 5;
  parameter RD = U_ROM6 + 6;
  parameter WR = U_ROM6 + 7;

  parameter ALU_B_SRC_0 = U_ROM7 + 0;
  parameter ALU_B_SRC_1 = U_ROM7 + 1;
  parameter ALU_B_SRC_2 = U_ROM7 + 2;
  parameter DISPLAY_REG_LOAD = U_ROM7 + 3; // used during fetch to select and load register display
  parameter DL_WRT = U_ROM7 + 4;
  parameter DH_WRT = U_ROM7 + 5;
  parameter CL_WRT = U_ROM7 + 6;
  parameter CH_WRT = U_ROM7 + 7;

  parameter BL_WRT = U_ROM8 + 0;
  parameter BH_WRT = U_ROM8 + 1;
  parameter AL_WRT = U_ROM8 + 2;
  parameter AH_WRT = U_ROM8 + 3;
  parameter MDR_IN_SRC = U_ROM8 + 4;
  parameter MDR_OUT_SRC = U_ROM8 + 5;
  parameter MDR_OUT_EN = U_ROM8 + 6;			// must invert before sending
  parameter MDR_L_WRT = U_ROM8 + 7;			

  parameter MDR_H_WRT = U_ROM9 + 0;
  parameter TDR_L_WRT = U_ROM9 + 1;
  parameter TDR_H_WRT = U_ROM9 + 2;
  parameter DI_L_WRT = U_ROM9 + 3;
  parameter DI_H_WRT = U_ROM9 + 4;
  parameter SI_L_WRT = U_ROM9 + 5;
  parameter SI_H_WRT = U_ROM9 + 6;
  parameter MAR_L_WRT = U_ROM9 + 7;

  parameter MAR_H_WRT = U_ROM10 + 0;
  parameter BP_L_WRT = U_ROM10 + 1;
  parameter BP_H_WRT = U_ROM10 + 2;
  parameter PC_L_WRT = U_ROM10 + 3;
  parameter PC_H_WRT = U_ROM10 + 4;
  parameter SP_L_WRT = U_ROM10 + 5;
  parameter SP_H_WRT = U_ROM10 + 6;
  //parameter UNUSED = U_ROM10 + 7;

  //parameter UNUSED = U_ROM11 + 0;
  parameter INT_VECTOR_WRT = U_ROM11 + 1;
  parameter MASK_FLAGS_WRT = U_ROM11 + 2;		// << WRT signals are also active low, 	
  parameter MAR_IN_SRC = U_ROM11 + 3;
  parameter INT_ACK = U_ROM11 + 4;		//--- active high
  parameter CLEAR_ALL_INTS = U_ROM11 + 5;
  parameter PTB_WRT = U_ROM11 + 6;
  parameter PAGE_TABLE_WE = U_ROM11 + 7; 

  parameter MDR_TO_PAGETABLE_DATA_BUFFER = U_ROM12 + 0;
  parameter FORCE_USER_PTB = U_ROM12 + 1; // --->>> goes to board as PAGE_TABLE_ADDR_SOURCE via OR gate
  //parameter unused = U_ROM12 + 2;
  //parameter unused = U_ROM12 + 3;
  //parameter unused = U_ROM12 + 4;
  //parameter unused = U_ROM12 + 5;
  parameter gl_wrt = U_ROM12 + 6;
  parameter gh_wrt = U_ROM12 + 7;

  parameter IMMY_0 = U_ROM13 + 0;
  parameter IMMY_1 = U_ROM13 + 1;
  parameter IMMY_2 = U_ROM13 + 2;
  parameter IMMY_3 = U_ROM13 + 3;
  parameter IMMY_4 = U_ROM13 + 4;
  parameter IMMY_5 = U_ROM13 + 5;
  parameter IMMY_6 = U_ROM13 + 6;
  parameter IMMY_7 = U_ROM13 + 7;
  
  
  
  parameter CF_IN_SRC = {CF_IN_SRC_2, CF_IN_SRC_1, CF_IN_SRC_0};

endpackage
