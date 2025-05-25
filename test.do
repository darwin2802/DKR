# Початкові сигнали resetb і clk 
force top.resetb 0 0ns
force top.clk 0 0ns, 1 1ns -repeat 2ns
run 3ns
force top.resetb 1 3ns

# Операція: S - R - 1 + CI 
force top.R      8'b01010101 0ns
force top.S      8'b10101010 0ns
force top.CI     1 0ns
force top.ALB_MI 2'b10 0ns

# Операція: R & S 
force top.R      8'b11110000 10ns
force top.S      8'b10101010 10ns
force top.CI     0 10ns
force top.ALB_MI 2'b00 10ns

# Операція: R + S + CI 
force top.R      8'b00001111 20ns
force top.S      8'b11110000 20ns
force top.CI     1 20ns
force top.ALB_MI 2'b01 20ns

# Операція: R ∨ S 
force top.R      8'b00000001 30ns
force top.S      8'b10000000 30ns
force top.CI     0 30ns
force top.ALB_MI 2'b00 30ns     ;# Якщо ALB_MI=00 відповідає за OR у вашому ALB

# ==== Запуск симуляції ====
run 40ns
