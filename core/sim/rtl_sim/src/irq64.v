/*===========================================================================*/
/* Copyright (C) 2001 Authors                                                */
/*                                                                           */
/* This source file may be used and distributed without restriction provided */
/* that this copyright statement is not removed from the file and that any   */
/* derivative work contains the original copyright notice and the associated */
/* disclaimer.                                                               */
/*                                                                           */
/* This source file is free software; you can redistribute it and/or modify  */
/* it under the terms of the GNU Lesser General Public License as published  */
/* by the Free Software Foundation; either version 2.1 of the License, or    */
/* (at your option) any later version.                                       */
/*                                                                           */
/* This source is distributed in the hope that it will be useful, but WITHOUT*/
/* ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or     */
/* FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public       */
/* License for more details.                                                 */
/*                                                                           */
/* You should have received a copy of the GNU Lesser General Public License  */
/* along with this source; if not, write to the Free Software Foundation,    */
/* Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA        */
/*                                                                           */
/*===========================================================================*/
/*                 IRQ 1 to 32 FOR SYSTEM WITH 64 IRQs                       */
/*---------------------------------------------------------------------------*/
/* Test the some IRQs for RTL configuration with more than 16 IRQs:	     */
/*                                                                           */
/*           - for 16 IRQ configuration:  test is skipped.                   */
/*           - for 32 IRQ configuration:  test is skipped.                   */
/*           - for 64 IRQ configuration:  will test IRQ 1 to 32.             */
/*                                                                           */
/* Author(s):                                                                */
/*             - Olivier Girard,    olgirard@gmail.com                       */
/*                                                                           */
/*---------------------------------------------------------------------------*/
/* $Rev: 95 $                                                                */
/* $LastChangedBy: olivier.girard $                                          */
/* $LastChangedDate: 2011-02-24 21:37:57 +0100 (Thu, 24 Feb 2011) $          */
/*===========================================================================*/

integer    i;
reg [15:0] temp_val;

initial
   begin
      $display(" ===============================================");
      $display("|                 START SIMULATION              |");
      $display(" ===============================================");
`ifdef IRQ_64

      repeat(5) @(posedge mclk);
      stimulus_done = 0;

      // RETI Instruction test
      //--------------------------
      @(r15==16'h1000);
      if (r3    !==16'h0000) tb_error("====== RESET Vector: R3  value  =====");
      if (r4    !==16'h0000) tb_error("====== RESET Vector: R4  value  =====");
      if (r5    !==16'h0000) tb_error("====== RESET Vector: R5  value  =====");
      if (r6    !==16'h0000) tb_error("====== RESET Vector: R6  value  =====");
      if (r7    !==16'h0000) tb_error("====== RESET Vector: R7  value  =====");
      if (r8    !==16'h0000) tb_error("====== RESET Vector: R8  value  =====");
      if (r9    !==16'h0000) tb_error("====== RESET Vector: R9  value  =====");
      if (r10   !==16'h0000) tb_error("====== RESET Vector: R10 value  =====");
      if (r11   !==16'h0000) tb_error("====== RESET Vector: R11 value  =====");
      if (r12   !==16'h0000) tb_error("====== RESET Vector: R12 value  =====");
      if (r13   !==16'h0000) tb_error("====== RESET Vector: R13 value  =====");
      if (r14   !==16'h0000) tb_error("====== RESET Vector: R14 value  =====");


      // RETI Instruction test
      //--------------------------
      @(r15==16'h2000);
      if (r1    !==(`PER_SIZE+16'h0052)) tb_error("====== RETI: SP value      =====");
      if (r2    !==16'h010f)             tb_error("====== RETI: SR value      =====");
      if (r5    !==16'h1234)             tb_error("====== RETI: R5 value      =====");


      // Test interruption 0
      //--------------------------
      @(r15==16'h3000);
      repeat(2) @(posedge mclk);
      irq[`IRQ_NR-64:0] = {`IRQ_NR-64+1{1'b1}};
      repeat(15) @(posedge mclk);
      irq[`IRQ_NR-64:0] = {`IRQ_NR-64+1{1'b0}};

      @(r15==16'h3001);
      if (r1    !==(`PER_SIZE+16'h0052)) tb_error("====== IRQ  0: SP value      =====");
      if (r2[3] !==1'b1)                 tb_error("====== IRQ  0: GIE value     =====");
      if (r6    !==16'h5678)             tb_error("====== IRQ  0: R6 value      =====");
      if (r7    !==16'h0000)             tb_error("====== IRQ  0: R7 value      =====");
      if (r8    !==(`PER_SIZE+16'h004e)) tb_error("====== IRQ  0: R8 value      =====");


      // Test interruption 1
      //--------------------------
      @(r15==16'h4000);
      repeat(2) @(posedge mclk);
      irq[`IRQ_NR-63:0] = {`IRQ_NR-63+1{1'b1}};
      repeat(15) @(posedge mclk);
      irq[`IRQ_NR-63:0] = {`IRQ_NR-63+1{1'b0}};

      @(r15==16'h4001);
      if (r1    !==(`PER_SIZE+16'h0052)) tb_error("====== IRQ  1: SP value      =====");
      if (r2[3] !==1'b1)                 tb_error("====== IRQ  1: GIE value     =====");
      if (r6    !==16'h9abc)             tb_error("====== IRQ  1: R6 value      =====");
      if (r7    !==16'h0000)             tb_error("====== IRQ  1: R7 value      =====");
      if (r8    !==(`PER_SIZE+16'h004e)) tb_error("====== IRQ  1: R8 value      =====");


      // Test interruption 2
      //--------------------------
      @(r15==16'h5000);
      repeat(2) @(posedge mclk);
      irq[`IRQ_NR-62:0] = {`IRQ_NR-62+1{1'b1}};
      repeat(15) @(posedge mclk);
      irq[`IRQ_NR-62:0] = {`IRQ_NR-62+1{1'b0}};

      @(r15==16'h5001);
      if (r1    !==(`PER_SIZE+16'h0052)) tb_error("====== IRQ  2: SP value      =====");
      if (r2[3] !==1'b1)                 tb_error("====== IRQ  2: GIE value     =====");
      if (r6    !==16'hdef1)             tb_error("====== IRQ  2: R6 value      =====");
      if (r7    !==16'h0000)             tb_error("====== IRQ  2: R7 value      =====");
      if (r8    !==(`PER_SIZE+16'h004e)) tb_error("====== IRQ  2: R8 value      =====");


      // Test interruption 3
      //--------------------------
      @(r15==16'h6000);
      repeat(2) @(posedge mclk);
      irq[`IRQ_NR-61:0] = {`IRQ_NR-61+1{1'b1}};
      repeat(15) @(posedge mclk);
      irq[`IRQ_NR-61:0] = {`IRQ_NR-61+1{1'b0}};

      @(r15==16'h6001);
      if (r1    !==(`PER_SIZE+16'h0052)) tb_error("====== IRQ  3: SP value      =====");
      if (r2[3] !==1'b1)                 tb_error("====== IRQ  3: GIE value     =====");
      if (r6    !==16'h2345)             tb_error("====== IRQ  3: R6 value      =====");
      if (r7    !==16'h0000)             tb_error("====== IRQ  3: R7 value      =====");
      if (r8    !==(`PER_SIZE+16'h004e)) tb_error("====== IRQ  3: R8 value      =====");


      // Test interruption 4
      //--------------------------
      @(r15==16'h7000);
      repeat(2) @(posedge mclk);
      irq[`IRQ_NR-60:0] = {`IRQ_NR-60+1{1'b1}};
      repeat(15) @(posedge mclk);
      irq[`IRQ_NR-60:0] = {`IRQ_NR-60+1{1'b0}};

      @(r15==16'h7001);
      if (r1    !==(`PER_SIZE+16'h0052)) tb_error("====== IRQ  4: SP value      =====");
      if (r2[3] !==1'b1)                 tb_error("====== IRQ  4: GIE value     =====");
      if (r6    !==16'h6789)             tb_error("====== IRQ  4: R6 value      =====");
      if (r7    !==16'h0000)             tb_error("====== IRQ  4: R7 value      =====");
      if (r8    !==(`PER_SIZE+16'h004e)) tb_error("====== IRQ  4: R8 value      =====");


      // Test interruption 5
      //--------------------------
      @(r15==16'h8000);
      repeat(2) @(posedge mclk);
      irq[`IRQ_NR-59:0] = {`IRQ_NR-59+1{1'b1}};
      repeat(15) @(posedge mclk);
      irq[`IRQ_NR-59:0] = {`IRQ_NR-59+1{1'b0}};

      @(r15==16'h8001);
      if (r1    !==(`PER_SIZE+16'h0052)) tb_error("====== IRQ  5: SP value      =====");
      if (r2[3] !==1'b1)                 tb_error("====== IRQ  5: GIE value     =====");
      if (r6    !==16'habcd)             tb_error("====== IRQ  5: R6 value      =====");
      if (r7    !==16'h0000)             tb_error("====== IRQ  5: R7 value      =====");
      if (r8    !==(`PER_SIZE+16'h004e)) tb_error("====== IRQ  5: R8 value      =====");


      // Test interruption 6
      //--------------------------
      @(r15==16'h9000);
      repeat(2) @(posedge mclk);
      irq[`IRQ_NR-58:0] = {`IRQ_NR-58+1{1'b1}};
      repeat(15) @(posedge mclk);
      irq[`IRQ_NR-58:0] = {`IRQ_NR-58+1{1'b0}};

      @(r15==16'h9001);
      if (r1    !==(`PER_SIZE+16'h0052)) tb_error("====== IRQ  6: SP value      =====");
      if (r2[3] !==1'b1)                 tb_error("====== IRQ  6: GIE value     =====");
      if (r6    !==16'hef12)             tb_error("====== IRQ  6: R6 value      =====");
      if (r7    !==16'h0000)             tb_error("====== IRQ  6: R7 value      =====");
      if (r8    !==(`PER_SIZE+16'h004e)) tb_error("====== IRQ  6: R8 value      =====");


      // Test interruption 7
      //--------------------------
      @(r15==16'ha000);
      repeat(2) @(posedge mclk);
      irq[`IRQ_NR-57:0] = {`IRQ_NR-57+1{1'b1}};
      repeat(15) @(posedge mclk);
      irq[`IRQ_NR-57:0] = {`IRQ_NR-57+1{1'b0}};

      @(r15==16'ha001);
      if (r1    !==(`PER_SIZE+16'h0052)) tb_error("====== IRQ  7: SP value      =====");
      if (r2[3] !==1'b1)                 tb_error("====== IRQ  7: GIE value     =====");
      if (r6    !==16'h3456)             tb_error("====== IRQ  7: R6 value      =====");
      if (r7    !==16'h0000)             tb_error("====== IRQ  7: R7 value      =====");
      if (r8    !==(`PER_SIZE+16'h004e)) tb_error("====== IRQ  7: R8 value      =====");


      // Test interruption 8
      //--------------------------
      @(r15==16'hb000);
      repeat(2) @(posedge mclk);
      irq[`IRQ_NR-56:0] = {`IRQ_NR-56+1{1'b1}};
      repeat(15) @(posedge mclk);
      irq[`IRQ_NR-56:0] = {`IRQ_NR-56+1{1'b0}};

      @(r15==16'hb001);
      if (r1    !==(`PER_SIZE+16'h0052)) tb_error("====== IRQ  8: SP value      =====");
      if (r2[3] !==1'b1)                 tb_error("====== IRQ  8: GIE value     =====");
      if (r6    !==16'h789a)             tb_error("====== IRQ  8: R6 value      =====");
      if (r7    !==16'h0000)             tb_error("====== IRQ  8: R7 value      =====");
      if (r8    !==(`PER_SIZE+16'h004e)) tb_error("====== IRQ  8: R8 value      =====");


      // Test interruption 9
      //--------------------------
      @(r15==16'hc000);
      repeat(2) @(posedge mclk);
      irq[`IRQ_NR-55:0] = {`IRQ_NR-55+1{1'b1}};
      repeat(15) @(posedge mclk);
      irq[`IRQ_NR-55:0] = {`IRQ_NR-55+1{1'b0}};

      @(r15==16'hc001);
      if (r1    !==(`PER_SIZE+16'h0052)) tb_error("====== IRQ  9: SP value      =====");
      if (r2[3] !==1'b1)                 tb_error("====== IRQ  9: GIE value     =====");
      if (r6    !==16'hbcde)             tb_error("====== IRQ  9: R6 value      =====");
      if (r7    !==16'h0000)             tb_error("====== IRQ  9: R7 value      =====");
      if (r8    !==(`PER_SIZE+16'h004e)) tb_error("====== IRQ  9: R8 value      =====");


      // Test interruption 10
      //--------------------------
      @(r15==16'hd000);
      repeat(2) @(posedge mclk);
      irq[`IRQ_NR-54:0] = {`IRQ_NR-54+1{1'b1}};
      repeat(15) @(posedge mclk);
      irq[`IRQ_NR-54:0] = {`IRQ_NR-54+1{1'b0}};

      @(r15==16'hd001);
      if (r1    !==(`PER_SIZE+16'h0052)) tb_error("====== IRQ 10: SP value      =====");
      if (r2[3] !==1'b1)                 tb_error("====== IRQ 10: GIE value     =====");
      if (r6    !==16'hf123)             tb_error("====== IRQ 10: R6 value      =====");
      if (r7    !==16'h0000)             tb_error("====== IRQ 10: R7 value      =====");
      if (r8    !==(`PER_SIZE+16'h004e)) tb_error("====== IRQ 10: R8 value      =====");


      // Test interruption 11
      //--------------------------
      @(r15==16'he000);
      repeat(2) @(posedge mclk);
      irq[`IRQ_NR-53:0] = {`IRQ_NR-53+1{1'b1}};
      repeat(15) @(posedge mclk);
      irq[`IRQ_NR-53:0] = {`IRQ_NR-53+1{1'b0}};

      @(r15==16'he001);
      if (r1    !==(`PER_SIZE+16'h0052)) tb_error("====== IRQ 11: SP value      =====");
      if (r2[3] !==1'b1)                 tb_error("====== IRQ 11: GIE value     =====");
      if (r6    !==16'h4567)             tb_error("====== IRQ 11: R6 value      =====");
      if (r7    !==16'h0000)             tb_error("====== IRQ 11: R7 value      =====");
      if (r8    !==(`PER_SIZE+16'h004e)) tb_error("====== IRQ 11: R8 value      =====");


      // Test interruption 12
      //--------------------------
      @(r15==16'hf000);
      repeat(2) @(posedge mclk);
      irq[`IRQ_NR-52:0] = {`IRQ_NR-52+1{1'b1}};
      repeat(15) @(posedge mclk);
      irq[`IRQ_NR-52:0] = {`IRQ_NR-52+1{1'b0}};

      @(r15==16'hf001);
      if (r1    !==(`PER_SIZE+16'h0052)) tb_error("====== IRQ 12: SP value      =====");
      if (r2[3] !==1'b1)                 tb_error("====== IRQ 12: GIE value     =====");
      if (r6    !==16'h89ab)             tb_error("====== IRQ 12: R6 value      =====");
      if (r7    !==16'h0000)             tb_error("====== IRQ 12: R7 value      =====");
      if (r8    !==(`PER_SIZE+16'h004e)) tb_error("====== IRQ 12: R8 value      =====");


      // Test interruption 13
      //--------------------------
      @(r15==16'hf100);
      repeat(2) @(posedge mclk);
      irq[`IRQ_NR-51:0] = {`IRQ_NR-51+1{1'b1}};
      repeat(15) @(posedge mclk);
      irq[`IRQ_NR-51:0] = {`IRQ_NR-51+1{1'b0}};

      @(r15==16'hf101);
      if (r1    !==(`PER_SIZE+16'h0052)) tb_error("====== IRQ 13: SP value      =====");
      if (r2[3] !==1'b1)                 tb_error("====== IRQ 13: GIE value     =====");
      if (r6    !==16'hcdef)             tb_error("====== IRQ 13: R6 value      =====");
      if (r7    !==16'h0000)             tb_error("====== IRQ 13: R7 value      =====");
      if (r8    !==(`PER_SIZE+16'h004e)) tb_error("====== IRQ 13: R8 value      =====");


      // Test interruption 14
      //--------------------------
      @(r15==16'hf200);
      repeat(2) @(posedge mclk);
      irq[`IRQ_NR-50:0] = {`IRQ_NR-50+1{1'b1}};
      repeat(15) @(posedge mclk);
      irq[`IRQ_NR-50:0] = {`IRQ_NR-50+1{1'b0}};

      @(r15==16'hf201);
      if (r1    !==(`PER_SIZE+16'h0052)) tb_error("====== IRQ 14: SP value      =====");
      if (r2[3] !==1'b1)                 tb_error("====== IRQ 14: GIE value     =====");
      if (r6    !==16'hfedc)             tb_error("====== IRQ 14: R6 value      =====");
      if (r7    !==16'h0000)             tb_error("====== IRQ 14: R7 value      =====");
      if (r8    !==(`PER_SIZE+16'h004e)) tb_error("====== IRQ 14: R8 value      =====");


      // Test interruption 15
      //--------------------------
      @(r15==16'hf300);
      repeat(2) @(posedge mclk);
      irq[`IRQ_NR-49:0] = {`IRQ_NR-49+1{1'b1}};
      repeat(15) @(posedge mclk);
      irq[`IRQ_NR-49:0] = {`IRQ_NR-49+1{1'b0}};

      @(r15==16'hf301);
      if (r1    !==(`PER_SIZE+16'h0052)) tb_error("====== IRQ 15: SP value      =====");
      if (r2[3] !==1'b1)                 tb_error("====== IRQ 15: GIE value     =====");
      if (r6    !==16'hba98)             tb_error("====== IRQ 15: R6 value      =====");
      if (r7    !==16'h0000)             tb_error("====== IRQ 15: R7 value      =====");
      if (r8    !==(`PER_SIZE+16'h004e)) tb_error("====== IRQ 15: R8 value      =====");


      // Test interruption 16
      //--------------------------
      @(r15==16'hf400);
      repeat(2) @(posedge mclk);
      irq[`IRQ_NR-48:0] = {`IRQ_NR-48+1{1'b1}};
      repeat(15) @(posedge mclk);
      irq[`IRQ_NR-48:0] = {`IRQ_NR-48+1{1'b0}};

      @(r15==16'hf401);
      if (r1    !==(`PER_SIZE+16'h0052)) tb_error("====== IRQ 16: SP value      =====");
      if (r2[3] !==1'b1)                 tb_error("====== IRQ 16: GIE value     =====");
      if (r6    !==16'h7654)             tb_error("====== IRQ 16: R6 value      =====");
      if (r7    !==16'h0000)             tb_error("====== IRQ 16: R7 value      =====");
      if (r8    !==(`PER_SIZE+16'h004e)) tb_error("====== IRQ 16: R8 value      =====");


      // Test interruption 17
      //--------------------------
      @(r15==16'hf500);
      repeat(2) @(posedge mclk);
      irq[`IRQ_NR-47:0] = {`IRQ_NR-47+1{1'b1}};
      repeat(15) @(posedge mclk);
      irq[`IRQ_NR-47:0] = {`IRQ_NR-47+1{1'b0}};

      @(r15==16'hf501);
      if (r1    !==(`PER_SIZE+16'h0052)) tb_error("====== IRQ 17: SP value      =====");
      if (r2[3] !==1'b1)                 tb_error("====== IRQ 17: GIE value     =====");
      if (r6    !==16'h3210)             tb_error("====== IRQ 17: R6 value      =====");
      if (r7    !==16'h0000)             tb_error("====== IRQ 17: R7 value      =====");
      if (r8    !==(`PER_SIZE+16'h004e)) tb_error("====== IRQ 17: R8 value      =====");


      // Test interruption 18
      //--------------------------
      @(r15==16'hf600);
      repeat(2) @(posedge mclk);
      irq[`IRQ_NR-46:0] = {`IRQ_NR-46+1{1'b1}};
      repeat(15) @(posedge mclk);
      irq[`IRQ_NR-46:0] = {`IRQ_NR-46+1{1'b0}};

      @(r15==16'hf601);
      if (r1    !==(`PER_SIZE+16'h0052)) tb_error("====== IRQ 18: SP value      =====");
      if (r2[3] !==1'b1)                 tb_error("====== IRQ 18: GIE value     =====");
      if (r6    !==16'h0246)             tb_error("====== IRQ 18: R6 value      =====");
      if (r7    !==16'h0000)             tb_error("====== IRQ 18: R7 value      =====");
      if (r8    !==(`PER_SIZE+16'h004e)) tb_error("====== IRQ 18: R8 value      =====");


      // Test interruption 19
      //--------------------------
      @(r15==16'hf700);
      repeat(2) @(posedge mclk);
      irq[`IRQ_NR-45:0] = {`IRQ_NR-45+1{1'b1}};
      repeat(15) @(posedge mclk);
      irq[`IRQ_NR-45:0] = {`IRQ_NR-45+1{1'b0}};

      @(r15==16'hf701);
      if (r1    !==(`PER_SIZE+16'h0052)) tb_error("====== IRQ 19: SP value      =====");
      if (r2[3] !==1'b1)                 tb_error("====== IRQ 19: GIE value     =====");
      if (r6    !==16'h1357)             tb_error("====== IRQ 19: R6 value      =====");
      if (r7    !==16'h0000)             tb_error("====== IRQ 19: R7 value      =====");
      if (r8    !==(`PER_SIZE+16'h004e)) tb_error("====== IRQ 19: R8 value      =====");


      // Test interruption 20
      //--------------------------
      @(r15==16'hf800);
      repeat(2) @(posedge mclk);
      irq[`IRQ_NR-44:0] = {`IRQ_NR-44+1{1'b1}};
      repeat(15) @(posedge mclk);
      irq[`IRQ_NR-44:0] = {`IRQ_NR-44+1{1'b0}};

      @(r15==16'hf801);
      if (r1    !==(`PER_SIZE+16'h0052)) tb_error("====== IRQ 20: SP value      =====");
      if (r2[3] !==1'b1)                 tb_error("====== IRQ 20: GIE value     =====");
      if (r6    !==16'h8ace)             tb_error("====== IRQ 20: R6 value      =====");
      if (r7    !==16'h0000)             tb_error("====== IRQ 20: R7 value      =====");
      if (r8    !==(`PER_SIZE+16'h004e)) tb_error("====== IRQ 20: R8 value      =====");


      // Test interruption 21
      //--------------------------
      @(r15==16'hf900);
      repeat(2) @(posedge mclk);
      irq[`IRQ_NR-43:0] = {`IRQ_NR-43+1{1'b1}};
      repeat(15) @(posedge mclk);
      irq[`IRQ_NR-43:0] = {`IRQ_NR-43+1{1'b0}};

      @(r15==16'hf901);
      if (r1    !==(`PER_SIZE+16'h0052)) tb_error("====== IRQ 21: SP value      =====");
      if (r2[3] !==1'b1)                 tb_error("====== IRQ 21: GIE value     =====");
      if (r6    !==16'h9bdf)             tb_error("====== IRQ 21: R6 value      =====");
      if (r7    !==16'h0000)             tb_error("====== IRQ 21: R7 value      =====");
      if (r8    !==(`PER_SIZE+16'h004e)) tb_error("====== IRQ 21: R8 value      =====");


      // Test interruption 22
      //--------------------------
      @(r15==16'hfa00);
      repeat(2) @(posedge mclk);
      irq[`IRQ_NR-42:0] = {`IRQ_NR-42+1{1'b1}};
      repeat(15) @(posedge mclk);
      irq[`IRQ_NR-42:0] = {`IRQ_NR-42+1{1'b0}};

      @(r15==16'hfa01);
      if (r1    !==(`PER_SIZE+16'h0052)) tb_error("====== IRQ 22: SP value      =====");
      if (r2[3] !==1'b1)                 tb_error("====== IRQ 22: GIE value     =====");
      if (r6    !==16'hfdb9)             tb_error("====== IRQ 22: R6 value      =====");
      if (r7    !==16'h0000)             tb_error("====== IRQ 22: R7 value      =====");
      if (r8    !==(`PER_SIZE+16'h004e)) tb_error("====== IRQ 22: R8 value      =====");


      // Test interruption 23
      //--------------------------
      @(r15==16'hfb00);
      repeat(2) @(posedge mclk);
      irq[`IRQ_NR-41:0] = {`IRQ_NR-41+1{1'b1}};
      repeat(15) @(posedge mclk);
      irq[`IRQ_NR-41:0] = {`IRQ_NR-41+1{1'b0}};

      @(r15==16'hfb01);
      if (r1    !==(`PER_SIZE+16'h0052)) tb_error("====== IRQ 23: SP value      =====");
      if (r2[3] !==1'b1)                 tb_error("====== IRQ 23: GIE value     =====");
      if (r6    !==16'heca8)             tb_error("====== IRQ 23: R6 value      =====");
      if (r7    !==16'h0000)             tb_error("====== IRQ 23: R7 value      =====");
      if (r8    !==(`PER_SIZE+16'h004e)) tb_error("====== IRQ 23: R8 value      =====");


      // Test interruption 24
      //--------------------------
      @(r15==16'hfc00);
      repeat(2) @(posedge mclk);
      irq[`IRQ_NR-40:0] = {`IRQ_NR-40+1{1'b1}};
      repeat(15) @(posedge mclk);
      irq[`IRQ_NR-40:0] = {`IRQ_NR-40+1{1'b0}};

      @(r15==16'hfc01);
      if (r1    !==(`PER_SIZE+16'h0052)) tb_error("====== IRQ 24: SP value      =====");
      if (r2[3] !==1'b1)                 tb_error("====== IRQ 24: GIE value     =====");
      if (r6    !==16'h7531)             tb_error("====== IRQ 24: R6 value      =====");
      if (r7    !==16'h0000)             tb_error("====== IRQ 24: R7 value      =====");
      if (r8    !==(`PER_SIZE+16'h004e)) tb_error("====== IRQ 24: R8 value      =====");


      // Test interruption 25
      //--------------------------
      @(r15==16'hfd00);
      repeat(2) @(posedge mclk);
      irq[`IRQ_NR-39:0] = {`IRQ_NR-39+1{1'b1}};
      repeat(15) @(posedge mclk);
      irq[`IRQ_NR-39:0] = {`IRQ_NR-39+1{1'b0}};

      @(r15==16'hfd01);
      if (r1    !==(`PER_SIZE+16'h0052)) tb_error("====== IRQ 25: SP value      =====");
      if (r2[3] !==1'b1)                 tb_error("====== IRQ 25: GIE value     =====");
      if (r6    !==16'h6420)             tb_error("====== IRQ 25: R6 value      =====");
      if (r7    !==16'h0000)             tb_error("====== IRQ 25: R7 value      =====");
      if (r8    !==(`PER_SIZE+16'h004e)) tb_error("====== IRQ 25: R8 value      =====");


      // Test interruption 26
      //--------------------------
      @(r15==16'hfe00);
      repeat(2) @(posedge mclk);
      irq[`IRQ_NR-38:0] = {`IRQ_NR-38+1{1'b1}};
      repeat(15) @(posedge mclk);
      irq[`IRQ_NR-38:0] = {`IRQ_NR-38+1{1'b0}};

      @(r15==16'hfe01);
      if (r1    !==(`PER_SIZE+16'h0052)) tb_error("====== IRQ 26: SP value      =====");
      if (r2[3] !==1'b1)                 tb_error("====== IRQ 26: GIE value     =====");
      if (r6    !==16'h0134)             tb_error("====== IRQ 26: R6 value      =====");
      if (r7    !==16'h0000)             tb_error("====== IRQ 26: R7 value      =====");
      if (r8    !==(`PER_SIZE+16'h004e)) tb_error("====== IRQ 26: R8 value      =====");


      // Test interruption 27
      //--------------------------
      @(r15==16'hff00);
      repeat(2) @(posedge mclk);
      irq[`IRQ_NR-37:0] = {`IRQ_NR-37+1{1'b1}};
      repeat(15) @(posedge mclk);
      irq[`IRQ_NR-37:0] = {`IRQ_NR-37+1{1'b0}};

      @(r15==16'hff01);
      if (r1    !==(`PER_SIZE+16'h0052)) tb_error("====== IRQ 27: SP value      =====");
      if (r2[3] !==1'b1)                 tb_error("====== IRQ 27: GIE value     =====");
      if (r6    !==16'h1245)             tb_error("====== IRQ 27: R6 value      =====");
      if (r7    !==16'h0000)             tb_error("====== IRQ 27: R7 value      =====");
      if (r8    !==(`PER_SIZE+16'h004e)) tb_error("====== IRQ 27: R8 value      =====");


      // Test interruption 28
      //--------------------------
      @(r15==16'hff10);
      repeat(2) @(posedge mclk);
      irq[`IRQ_NR-36:0] = {`IRQ_NR-36+1{1'b1}};
      repeat(15) @(posedge mclk);
      irq[`IRQ_NR-36:0] = {`IRQ_NR-36+1{1'b0}};

      @(r15==16'hff11);
      if (r1    !==(`PER_SIZE+16'h0052)) tb_error("====== IRQ 28: SP value      =====");
      if (r2[3] !==1'b1)                 tb_error("====== IRQ 28: GIE value     =====");
      if (r6    !==16'h2356)             tb_error("====== IRQ 28: R6 value      =====");
      if (r7    !==16'h0000)             tb_error("====== IRQ 28: R7 value      =====");
      if (r8    !==(`PER_SIZE+16'h004e)) tb_error("====== IRQ 28: R8 value      =====");


      // Test interruption 29
      //--------------------------
      @(r15==16'hff20);
      repeat(2) @(posedge mclk);
      irq[`IRQ_NR-35:0] = {`IRQ_NR-35+1{1'b1}};
      repeat(15) @(posedge mclk);
      irq[`IRQ_NR-35:0] = {`IRQ_NR-35+1{1'b0}};

      @(r15==16'hff21);
      if (r1    !==(`PER_SIZE+16'h0052)) tb_error("====== IRQ 29: SP value      =====");
      if (r2[3] !==1'b1)                 tb_error("====== IRQ 29: GIE value     =====");
      if (r6    !==16'h3467)             tb_error("====== IRQ 29: R6 value      =====");
      if (r7    !==16'h0000)             tb_error("====== IRQ 29: R7 value      =====");
      if (r8    !==(`PER_SIZE+16'h004e)) tb_error("====== IRQ 29: R8 value      =====");


      // Test interruption 30
      //--------------------------
      @(r15==16'hff30);
      repeat(2) @(posedge mclk);
      irq[`IRQ_NR-34:0] = {`IRQ_NR-34+1{1'b1}};
      repeat(15) @(posedge mclk);
      irq[`IRQ_NR-34:0] = {`IRQ_NR-34+1{1'b0}};

      @(r15==16'hff31);
      if (r1    !==(`PER_SIZE+16'h0052)) tb_error("====== IRQ 30: SP value      =====");
      if (r2[3] !==1'b1)                 tb_error("====== IRQ 30: GIE value     =====");
      if (r6    !==16'h4578)             tb_error("====== IRQ 30: R6 value      =====");
      if (r7    !==16'h0000)             tb_error("====== IRQ 30: R7 value      =====");
      if (r8    !==(`PER_SIZE+16'h004e)) tb_error("====== IRQ 30: R8 value      =====");


      // Test interruption 31
      //--------------------------
      @(r15==16'hff40);
      repeat(2) @(posedge mclk);
      irq[`IRQ_NR-33:0] = {`IRQ_NR-33+1{1'b1}};
      repeat(15) @(posedge mclk);
      irq[`IRQ_NR-33:0] = {`IRQ_NR-33+1{1'b0}};

      @(r15==16'hff41);
      if (r1    !==(`PER_SIZE+16'h0052)) tb_error("====== IRQ 31: SP value      =====");
      if (r2[3] !==1'b1)                 tb_error("====== IRQ 31: GIE value     =====");
      if (r6    !==16'h5689)             tb_error("====== IRQ 31: R6 value      =====");
      if (r7    !==16'h0000)             tb_error("====== IRQ 31: R7 value      =====");
      if (r8    !==(`PER_SIZE+16'h004e)) tb_error("====== IRQ 31: R8 value      =====");


      stimulus_done = 1;
`else

      tb_skip_finish("|    (RTL configured to support 16 or 32 IRQs)  |");
`endif
   end
