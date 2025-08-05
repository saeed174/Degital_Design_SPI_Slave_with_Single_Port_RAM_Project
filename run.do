vlib work
vlog RAM.v Serial_to_Parallel.v Parallel_to_Serial.v SPI_Slave.v SPI_Wrapper.v
vsim -voptargs=+acc work.SPI_Wrapper_tb
add wave -position insertpoint sim:/SPI_Wrapper_tb/*
add wave -position insertpoint  \
sim:/SPI_Wrapper_tb/SPI/rx_data \
sim:/SPI_Wrapper_tb/SPI/rx_valid \
sim:/SPI_Wrapper_tb/SPI/tx_data \
sim:/SPI_Wrapper_tb/SPI/tx_valid
add wave -position insertpoint  \
sim:/SPI_Wrapper_tb/SPI/SPI/cs
add wave -position 0  sim:/SPI_Wrapper_tb/SPI/u_ram/mem
run -all
#quit -sim