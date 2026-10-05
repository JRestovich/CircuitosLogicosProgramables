# Pin y estándar eléctrico del reloj, tomados de la guía.
set_property PACKAGE_PIN H16 [get_ports clk_pin]
set_property IOSTANDARD LVCMOS33 [get_ports clk_pin]

# Restricción temporal tomada de uart_led_timing_ArtyZ7.xdc.
# 10 ns equivalen a 100 MHz.
create_clock -period 10.000 -name clk_pin -waveform {0.000 5.000} [get_ports clk_pin]