#set x 4
set time_i 200
for {set x 0} {$x < 5} {incr x 1} {

 # postavljanje hijerarhijske putanje do signala nad kojim vrši forsiranje
 set force_path /fix_fir_tb/fir_under_test/module
 append force_path [$x]

 #postavljanje vremenskog trenutka u kome je potrebno izvršiti forsiranje vrednosti
 set time_c $time_i
 set time_string [append time_c ns]


 #postavljanje vremenskog trenutka u kome treba prekinuti forsiranje vrednosti
 set cancel_f_time [expr {$time_i + 1000}]
 append cancel_f_time ns

 # forsiranje vrednost
 add_force $force_path -radix hex 0 $time_string -cancel_after $cancel_f_time

 # Uvećavanje vrednosti time_i za 400.
 incr time_i 200
}