-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.1 (win64) Build 2188600 Wed Apr  4 18:40:38 MDT 2018
-- Date        : Mon Oct  5 23:10:34 2026
-- Host        : JRestovich running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               {c:/Users/jrest/OneDrive/Escritorio/UBA/CLP/CircuitosLogicosProgramables/Trabajo
--               Final/TrabajoFinalCLP/TrabajoFinalCLP.srcs/sources_1/ip/ila_nco/ila_nco_stub.vhdl}
-- Design      : ila_nco
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z010clg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ila_nco is
  Port ( 
    clk : in STD_LOGIC;
    probe0 : in STD_LOGIC_VECTOR ( 11 downto 0 );
    probe1 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    probe2 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe3 : in STD_LOGIC_VECTOR ( 0 to 0 )
  );

end ila_nco;

architecture stub of ila_nco is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk,probe0[11:0],probe1[31:0],probe2[0:0],probe3[0:0]";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "ila,Vivado 2018.1";
begin
end;
