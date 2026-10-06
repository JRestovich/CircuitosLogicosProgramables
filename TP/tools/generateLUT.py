import numpy as np
from numpy import sin, pi
from pathlib import Path

POINTS = 1024
BITS = 12
OFFSET_MV = 1500
AMPLITUDE_MV = 1000

x = np.linspace(0, 1, POINTS, endpoint=False)
sine = OFFSET_MV + AMPLITUDE_MV * sin(2 * pi * x)
codes = np.floor(sine + 0.5).astype(int)

if codes.min() < 0 or codes.max() >= 2**BITS:
    raise ValueError("Las muestras no caben en el ancho de bits elegido")

data = f"type rom_t is array (0 to {POINTS - 1}) of unsigned({BITS - 1} downto 0);\n"
data += "constant SENO_ROM : rom_t := (\n"
for i, code in enumerate(codes):
    comma = "," if i < POINTS - 1 else ""
    data += f"    {i} => to_unsigned({code}, {BITS}){comma}\n"
data += ");\n"

Path(__file__).with_name("lut_seno.txt").write_text(data, encoding="utf-8")
print(data, end="")
