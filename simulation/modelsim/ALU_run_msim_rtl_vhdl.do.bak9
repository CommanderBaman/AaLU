transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {D:/study material/IITB/project 224/ALU.vhd}
vcom -93 -work work {D:/study material/IITB/project 224/XOR_2input.vhd}
vcom -93 -work work {D:/study material/IITB/project 224/and_2input.vhd}
vcom -93 -work work {D:/study material/IITB/project 224/gpgen.vhd}
vcom -93 -work work {D:/study material/IITB/project 224/node_operation.vhd}
vcom -93 -work work {D:/study material/IITB/project 224/KoggeStoneAdder.vhd}
vcom -93 -work work {D:/study material/IITB/project 224/Get1Complement.vhd}
vcom -93 -work work {D:/study material/IITB/project 224/ZeroBitCalculator.vhd}
vcom -93 -work work {D:/study material/IITB/project 224/SelectHandler.vhd}

vcom -93 -work work {D:/study material/IITB/project 224/Testbench.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cyclonev -L rtl_work -L work -voptargs="+acc"  Testbench

add wave *
view structure
view signals
run -all
