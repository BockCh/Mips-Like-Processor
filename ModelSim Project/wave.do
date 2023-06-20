onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group TB -radix hexadecimal /controller_tb/clk
add wave -noupdate -group TB -radix hexadecimal /controller_tb/clk_en
add wave -noupdate -group TB -radix hexadecimal /controller_tb/rst
add wave -noupdate -group TB -radix hexadecimal /controller_tb/OpCode
add wave -noupdate -group TB -radix hexadecimal /controller_tb/IR
add wave -noupdate -group TB -radix hexadecimal /controller_tb/IR5_0
add wave -noupdate -group TB -radix hexadecimal /controller_tb/PCWriteCond
add wave -noupdate -group TB -radix hexadecimal /controller_tb/PCWrite
add wave -noupdate -group TB -radix hexadecimal /controller_tb/IorD
add wave -noupdate -group TB -radix hexadecimal /controller_tb/MemWrite
add wave -noupdate -group TB -radix hexadecimal /controller_tb/MemtoReg
add wave -noupdate -group TB -radix hexadecimal /controller_tb/IRWrite
add wave -noupdate -group TB -radix hexadecimal /controller_tb/JumpAndLink
add wave -noupdate -group TB -radix hexadecimal /controller_tb/IsSigned
add wave -noupdate -group TB -radix hexadecimal /controller_tb/PCSource
add wave -noupdate -group TB -radix hexadecimal /controller_tb/ALUOp
add wave -noupdate -group TB -radix hexadecimal /controller_tb/ALUSrcB
add wave -noupdate -group TB -radix hexadecimal /controller_tb/ALUSrcA
add wave -noupdate -group TB -radix hexadecimal /controller_tb/RegWrite
add wave -noupdate -group TB -radix hexadecimal /controller_tb/RegDst
add wave -noupdate -group TB -radix hexadecimal /controller_tb/s
add wave -noupdate -group TB -radix hexadecimal /controller_tb/buttons
add wave -noupdate -group TB -radix hexadecimal /controller_tb/IR_TO_CTRL
add wave -noupdate -group TB -radix hexadecimal /controller_tb/leds
add wave -noupdate -group TB -radix hexadecimal /controller_tb/WIDTH
add wave -noupdate -expand -group Controller -radix hexadecimal /controller_tb/U_CONTROLLER/WIDTH
add wave -noupdate -expand -group Controller -radix hexadecimal /controller_tb/U_CONTROLLER/clk
add wave -noupdate -expand -group Controller -radix hexadecimal /controller_tb/U_CONTROLLER/rst
add wave -noupdate -expand -group Controller -radix hexadecimal /controller_tb/U_CONTROLLER/OpCode
add wave -noupdate -expand -group Controller -radix hexadecimal /controller_tb/U_CONTROLLER/IR20_16
add wave -noupdate -expand -group Controller -radix hexadecimal /controller_tb/U_CONTROLLER/IR5_0
add wave -noupdate -expand -group Controller -radix hexadecimal /controller_tb/U_CONTROLLER/PCWriteCond
add wave -noupdate -expand -group Controller -radix hexadecimal /controller_tb/U_CONTROLLER/PCWrite
add wave -noupdate -expand -group Controller -radix hexadecimal /controller_tb/U_CONTROLLER/IorD
add wave -noupdate -expand -group Controller -radix hexadecimal /controller_tb/U_CONTROLLER/MemWrite
add wave -noupdate -expand -group Controller -radix hexadecimal /controller_tb/U_CONTROLLER/MemtoReg
add wave -noupdate -expand -group Controller -radix hexadecimal /controller_tb/U_CONTROLLER/IRWrite
add wave -noupdate -expand -group Controller -radix hexadecimal /controller_tb/U_CONTROLLER/JumpAndLink
add wave -noupdate -expand -group Controller -radix hexadecimal /controller_tb/U_CONTROLLER/IsSigned
add wave -noupdate -expand -group Controller -radix hexadecimal /controller_tb/U_CONTROLLER/PCSource
add wave -noupdate -expand -group Controller -radix hexadecimal /controller_tb/U_CONTROLLER/ALUOp
add wave -noupdate -expand -group Controller -radix hexadecimal /controller_tb/U_CONTROLLER/ALUSrcB
add wave -noupdate -expand -group Controller -radix hexadecimal /controller_tb/U_CONTROLLER/ALUSrcA
add wave -noupdate -expand -group Controller -radix hexadecimal /controller_tb/U_CONTROLLER/RegWrite
add wave -noupdate -expand -group Controller -radix hexadecimal /controller_tb/U_CONTROLLER/RegDst
add wave -noupdate -expand -group Controller -radix hexadecimal /controller_tb/U_CONTROLLER/state_r
add wave -noupdate -expand -group Controller -radix hexadecimal /controller_tb/U_CONTROLLER/next_state
add wave -noupdate -expand -group Datapath -radix hexadecimal /controller_tb/U_DATAPATH/WIDTH
add wave -noupdate -expand -group Datapath -radix hexadecimal /controller_tb/U_DATAPATH/clk
add wave -noupdate -expand -group Datapath -radix hexadecimal /controller_tb/U_DATAPATH/rst
add wave -noupdate -expand -group Datapath -radix hexadecimal /controller_tb/U_DATAPATH/JumpAndLink
add wave -noupdate -expand -group Datapath -radix hexadecimal /controller_tb/U_DATAPATH/IsSigned
add wave -noupdate -expand -group Datapath -radix hexadecimal /controller_tb/U_DATAPATH/PCSource
add wave -noupdate -expand -group Datapath -radix hexadecimal /controller_tb/U_DATAPATH/ALUOp
add wave -noupdate -expand -group Datapath -radix hexadecimal /controller_tb/U_DATAPATH/ALUSrcB
add wave -noupdate -expand -group Datapath -radix hexadecimal /controller_tb/U_DATAPATH/ALUSrcA
add wave -noupdate -expand -group Datapath -radix hexadecimal /controller_tb/U_DATAPATH/RegWrite
add wave -noupdate -expand -group Datapath -radix hexadecimal /controller_tb/U_DATAPATH/RegDst
add wave -noupdate -expand -group Datapath -radix hexadecimal /controller_tb/U_DATAPATH/PCWriteCond
add wave -noupdate -expand -group Datapath -radix hexadecimal /controller_tb/U_DATAPATH/PCWrite
add wave -noupdate -expand -group Datapath -radix hexadecimal /controller_tb/U_DATAPATH/IorD
add wave -noupdate -expand -group Datapath -radix hexadecimal /controller_tb/U_DATAPATH/MemWrite
add wave -noupdate -expand -group Datapath -radix hexadecimal /controller_tb/U_DATAPATH/MemToReg
add wave -noupdate -expand -group Datapath -radix hexadecimal /controller_tb/U_DATAPATH/IRWrite
add wave -noupdate -expand -group Datapath -radix hexadecimal /controller_tb/U_DATAPATH/s
add wave -noupdate -expand -group Datapath -radix hexadecimal /controller_tb/U_DATAPATH/buttons
add wave -noupdate -expand -group Datapath -radix hexadecimal /controller_tb/U_DATAPATH/IR31_0
add wave -noupdate -expand -group Datapath -radix hexadecimal /controller_tb/U_DATAPATH/leds
add wave -noupdate -expand -group Datapath -radix hexadecimal /controller_tb/U_DATAPATH/data_mux1
add wave -noupdate -expand -group Datapath -radix hexadecimal /controller_tb/U_DATAPATH/pc_reg_data
add wave -noupdate -expand -group Datapath -radix hexadecimal /controller_tb/U_DATAPATH/data_mux3
add wave -noupdate -expand -group Datapath -radix hexadecimal /controller_tb/U_DATAPATH/data_mux4
add wave -noupdate -expand -group Datapath -radix hexadecimal /controller_tb/U_DATAPATH/data_mux5
add wave -noupdate -expand -group Datapath -radix hexadecimal /controller_tb/U_DATAPATH/data_mux6
add wave -noupdate -expand -group Datapath -radix hexadecimal /controller_tb/U_DATAPATH/data_mux7
add wave -noupdate -expand -group Datapath -radix hexadecimal /controller_tb/U_DATAPATH/pc_en
add wave -noupdate -expand -group Datapath -radix hexadecimal /controller_tb/U_DATAPATH/HI_en
add wave -noupdate -expand -group Datapath -radix hexadecimal /controller_tb/U_DATAPATH/LO_en
add wave -noupdate -expand -group Datapath -radix hexadecimal /controller_tb/U_DATAPATH/port0_en
add wave -noupdate -expand -group Datapath -radix hexadecimal /controller_tb/U_DATAPATH/port1_en
add wave -noupdate -expand -group Datapath -radix hexadecimal -childformat {{/controller_tb/U_DATAPATH/input1(31) -radix hexadecimal} {/controller_tb/U_DATAPATH/input1(30) -radix hexadecimal} {/controller_tb/U_DATAPATH/input1(29) -radix hexadecimal} {/controller_tb/U_DATAPATH/input1(28) -radix hexadecimal} {/controller_tb/U_DATAPATH/input1(27) -radix hexadecimal} {/controller_tb/U_DATAPATH/input1(26) -radix hexadecimal} {/controller_tb/U_DATAPATH/input1(25) -radix hexadecimal} {/controller_tb/U_DATAPATH/input1(24) -radix hexadecimal} {/controller_tb/U_DATAPATH/input1(23) -radix hexadecimal} {/controller_tb/U_DATAPATH/input1(22) -radix hexadecimal} {/controller_tb/U_DATAPATH/input1(21) -radix hexadecimal} {/controller_tb/U_DATAPATH/input1(20) -radix hexadecimal} {/controller_tb/U_DATAPATH/input1(19) -radix hexadecimal} {/controller_tb/U_DATAPATH/input1(18) -radix hexadecimal} {/controller_tb/U_DATAPATH/input1(17) -radix hexadecimal} {/controller_tb/U_DATAPATH/input1(16) -radix hexadecimal} {/controller_tb/U_DATAPATH/input1(15) -radix hexadecimal} {/controller_tb/U_DATAPATH/input1(14) -radix hexadecimal} {/controller_tb/U_DATAPATH/input1(13) -radix hexadecimal} {/controller_tb/U_DATAPATH/input1(12) -radix hexadecimal} {/controller_tb/U_DATAPATH/input1(11) -radix hexadecimal} {/controller_tb/U_DATAPATH/input1(10) -radix hexadecimal} {/controller_tb/U_DATAPATH/input1(9) -radix hexadecimal} {/controller_tb/U_DATAPATH/input1(8) -radix hexadecimal} {/controller_tb/U_DATAPATH/input1(7) -radix hexadecimal} {/controller_tb/U_DATAPATH/input1(6) -radix hexadecimal} {/controller_tb/U_DATAPATH/input1(5) -radix hexadecimal} {/controller_tb/U_DATAPATH/input1(4) -radix hexadecimal} {/controller_tb/U_DATAPATH/input1(3) -radix hexadecimal} {/controller_tb/U_DATAPATH/input1(2) -radix hexadecimal} {/controller_tb/U_DATAPATH/input1(1) -radix hexadecimal} {/controller_tb/U_DATAPATH/input1(0) -radix hexadecimal}} -subitemconfig {/controller_tb/U_DATAPATH/input1(31) {-height 15 -radix hexadecimal} /controller_tb/U_DATAPATH/input1(30) {-height 15 -radix hexadecimal} /controller_tb/U_DATAPATH/input1(29) {-height 15 -radix hexadecimal} /controller_tb/U_DATAPATH/input1(28) {-height 15 -radix hexadecimal} /controller_tb/U_DATAPATH/input1(27) {-height 15 -radix hexadecimal} /controller_tb/U_DATAPATH/input1(26) {-height 15 -radix hexadecimal} /controller_tb/U_DATAPATH/input1(25) {-height 15 -radix hexadecimal} /controller_tb/U_DATAPATH/input1(24) {-height 15 -radix hexadecimal} /controller_tb/U_DATAPATH/input1(23) {-height 15 -radix hexadecimal} /controller_tb/U_DATAPATH/input1(22) {-height 15 -radix hexadecimal} /controller_tb/U_DATAPATH/input1(21) {-height 15 -radix hexadecimal} /controller_tb/U_DATAPATH/input1(20) {-height 15 -radix hexadecimal} /controller_tb/U_DATAPATH/input1(19) {-height 15 -radix hexadecimal} /controller_tb/U_DATAPATH/input1(18) {-height 15 -radix hexadecimal} /controller_tb/U_DATAPATH/input1(17) {-height 15 -radix hexadecimal} /controller_tb/U_DATAPATH/input1(16) {-height 15 -radix hexadecimal} /controller_tb/U_DATAPATH/input1(15) {-height 15 -radix hexadecimal} /controller_tb/U_DATAPATH/input1(14) {-height 15 -radix hexadecimal} /controller_tb/U_DATAPATH/input1(13) {-height 15 -radix hexadecimal} /controller_tb/U_DATAPATH/input1(12) {-height 15 -radix hexadecimal} /controller_tb/U_DATAPATH/input1(11) {-height 15 -radix hexadecimal} /controller_tb/U_DATAPATH/input1(10) {-height 15 -radix hexadecimal} /controller_tb/U_DATAPATH/input1(9) {-height 15 -radix hexadecimal} /controller_tb/U_DATAPATH/input1(8) {-height 15 -radix hexadecimal} /controller_tb/U_DATAPATH/input1(7) {-height 15 -radix hexadecimal} /controller_tb/U_DATAPATH/input1(6) {-height 15 -radix hexadecimal} /controller_tb/U_DATAPATH/input1(5) {-height 15 -radix hexadecimal} /controller_tb/U_DATAPATH/input1(4) {-height 15 -radix hexadecimal} /controller_tb/U_DATAPATH/input1(3) {-height 15 -radix hexadecimal} /controller_tb/U_DATAPATH/input1(2) {-height 15 -radix hexadecimal} /controller_tb/U_DATAPATH/input1(1) {-height 15 -radix hexadecimal} /controller_tb/U_DATAPATH/input1(0) {-height 15 -radix hexadecimal}} /controller_tb/U_DATAPATH/input1
add wave -noupdate -expand -group Datapath -radix hexadecimal /controller_tb/U_DATAPATH/input2
add wave -noupdate -expand -group Datapath -radix hexadecimal /controller_tb/U_DATAPATH/data_mux2
add wave -noupdate -expand -group Datapath -radix hexadecimal /controller_tb/U_DATAPATH/OPSelect
add wave -noupdate -expand -group Datapath -radix hexadecimal /controller_tb/U_DATAPATH/result
add wave -noupdate -expand -group Datapath -radix hexadecimal /controller_tb/U_DATAPATH/result_Hi
add wave -noupdate -expand -group Datapath -radix hexadecimal /controller_tb/U_DATAPATH/branch_Taken
add wave -noupdate -expand -group Datapath -radix hexadecimal /controller_tb/U_DATAPATH/RdData
add wave -noupdate -expand -group Datapath -radix hexadecimal /controller_tb/U_DATAPATH/mem_data_reg
add wave -noupdate -expand -group Datapath -radix hexadecimal /controller_tb/U_DATAPATH/rd_data0
add wave -noupdate -expand -group Datapath -radix hexadecimal /controller_tb/U_DATAPATH/rd_data1
add wave -noupdate -expand -group Datapath -radix hexadecimal /controller_tb/U_DATAPATH/regA_data
add wave -noupdate -expand -group Datapath -radix hexadecimal /controller_tb/U_DATAPATH/regB_data
add wave -noupdate -expand -group Datapath -radix hexadecimal /controller_tb/U_DATAPATH/sign_ex
add wave -noupdate -expand -group Datapath -radix hexadecimal /controller_tb/U_DATAPATH/SHL_bot
add wave -noupdate -expand -group Datapath -radix hexadecimal /controller_tb/U_DATAPATH/SHL_top
add wave -noupdate -expand -group Datapath -radix hexadecimal /controller_tb/U_DATAPATH/IR
add wave -noupdate -expand -group Datapath -radix hexadecimal /controller_tb/U_DATAPATH/IOPORT
add wave -noupdate -expand -group Datapath -radix hexadecimal /controller_tb/U_DATAPATH/concat_out
add wave -noupdate -expand -group Datapath -radix hexadecimal /controller_tb/U_DATAPATH/alu_out_reg_data
add wave -noupdate -expand -group Datapath -radix hexadecimal /controller_tb/U_DATAPATH/lo_out_reg_data
add wave -noupdate -expand -group Datapath -radix hexadecimal /controller_tb/U_DATAPATH/hi_out_reg_data
add wave -noupdate -expand -group Datapath -radix hexadecimal /controller_tb/U_DATAPATH/wr_data
add wave -noupdate -expand -group Datapath -radix hexadecimal /controller_tb/U_DATAPATH/outport
add wave -noupdate -expand -group Datapath -radix hexadecimal /controller_tb/U_DATAPATH/ALU_LO_HI
add wave -noupdate -expand -group RegFile -radix hexadecimal /controller_tb/U_DATAPATH/U_REGFILE/clk
add wave -noupdate -expand -group RegFile -radix hexadecimal /controller_tb/U_DATAPATH/U_REGFILE/rst
add wave -noupdate -expand -group RegFile -radix hexadecimal /controller_tb/U_DATAPATH/U_REGFILE/rd_addr0
add wave -noupdate -expand -group RegFile -radix hexadecimal /controller_tb/U_DATAPATH/U_REGFILE/rd_addr1
add wave -noupdate -expand -group RegFile -radix hexadecimal /controller_tb/U_DATAPATH/U_REGFILE/wr_addr
add wave -noupdate -expand -group RegFile -radix hexadecimal /controller_tb/U_DATAPATH/U_REGFILE/wr_en
add wave -noupdate -expand -group RegFile -radix hexadecimal /controller_tb/U_DATAPATH/U_REGFILE/wr_data
add wave -noupdate -expand -group RegFile -radix hexadecimal /controller_tb/U_DATAPATH/U_REGFILE/rd_data0
add wave -noupdate -expand -group RegFile -radix hexadecimal /controller_tb/U_DATAPATH/U_REGFILE/rd_data1
add wave -noupdate -expand -group RegFile -radix hexadecimal /controller_tb/U_DATAPATH/U_REGFILE/regs
add wave -noupdate -radix hexadecimal /controller_tb/U_DATAPATH/U_MEMORY/outport
add wave -noupdate -expand -group Memory -radix hexadecimal /controller_tb/U_DATAPATH/U_MEMORY/WIDTH
add wave -noupdate -expand -group Memory -radix hexadecimal /controller_tb/U_DATAPATH/U_MEMORY/clk
add wave -noupdate -expand -group Memory -radix hexadecimal /controller_tb/U_DATAPATH/U_MEMORY/rst
add wave -noupdate -expand -group Memory -radix hexadecimal /controller_tb/U_DATAPATH/U_MEMORY/port0_en
add wave -noupdate -expand -group Memory -radix hexadecimal /controller_tb/U_DATAPATH/U_MEMORY/port1_en
add wave -noupdate -expand -group Memory -radix hexadecimal /controller_tb/U_DATAPATH/U_MEMORY/MemWrite
add wave -noupdate -expand -group Memory -radix hexadecimal /controller_tb/U_DATAPATH/U_MEMORY/addr
add wave -noupdate -expand -group Memory -radix hexadecimal /controller_tb/U_DATAPATH/U_MEMORY/wr_data
add wave -noupdate -expand -group Memory -radix hexadecimal /controller_tb/U_DATAPATH/U_MEMORY/ex_Switch_Data
add wave -noupdate -expand -group Memory -radix hexadecimal /controller_tb/U_DATAPATH/U_MEMORY/outport
add wave -noupdate -expand -group Memory -radix hexadecimal /controller_tb/U_DATAPATH/U_MEMORY/RdData
add wave -noupdate -expand -group Memory -radix hexadecimal /controller_tb/U_DATAPATH/U_MEMORY/data_ram
add wave -noupdate -expand -group Memory -radix hexadecimal /controller_tb/U_DATAPATH/U_MEMORY/port0_data
add wave -noupdate -expand -group Memory -radix hexadecimal /controller_tb/U_DATAPATH/U_MEMORY/port1_data
add wave -noupdate -expand -group Memory -radix hexadecimal /controller_tb/U_DATAPATH/U_MEMORY/mux_en
add wave -noupdate -expand -group Memory -radix hexadecimal /controller_tb/U_DATAPATH/U_MEMORY/mux_en_reg
add wave -noupdate -expand -group Memory -radix hexadecimal /controller_tb/U_DATAPATH/U_MEMORY/WrEn
add wave -noupdate -expand -group Memory -radix hexadecimal /controller_tb/U_DATAPATH/U_MEMORY/OutPOrtWrEn
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2187949 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 139
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {2148225 ps} {2390983 ps}

