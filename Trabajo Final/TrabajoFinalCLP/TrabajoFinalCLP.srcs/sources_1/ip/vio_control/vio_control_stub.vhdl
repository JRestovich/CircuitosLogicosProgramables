-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.1 (win64) Build 2188600 Wed Apr  4 18:40:38 MDT 2018
-- Date        : Mon Oct  5 22:59:39 2026
-- Host        : JRestovich running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               {c:/Users/jrest/OneDrive/Escritorio/UBA/CLP/CircuitosLogicosProgramables/Trabajo
--               Final/TrabajoFinalCLP/TrabajoFinalCLP.srcs/sources_1/ip/vio_control/vio_control_stub.vhdl}
-- Design      : vio_control
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z010clg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity vio_control is
  Port ( 
    clk : in STD_LOGIC;
    probe_out0 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    probe_out1 : out STD_LOGIC_VECTOR ( 0 to 0 );
    probe_out2 : out STD_LOGIC_VECTOR ( 0 to 0 )
  );

end vio_control;

architecture stub of vio_control is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk,probe_out0[31:0],probe_out1[0:0],probe_out2[0:0]";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "vio,Vivado 2018.1";
begin
end;
