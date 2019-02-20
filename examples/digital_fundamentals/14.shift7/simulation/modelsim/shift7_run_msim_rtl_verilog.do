transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/liuyu/Desktop/experimrnt\ for\ 08sam/shift7 {C:/Users/liuyu/Desktop/experimrnt for 08sam/shift7/shift7.v}

