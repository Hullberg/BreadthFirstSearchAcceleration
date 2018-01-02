-- megafunction wizard: %ALTCLKCTRL%
-- GENERATION: STANDARD
-- VERSION: WM1.0
-- MODULE: altclkctrl 

-- ============================================================
-- File Name: MWAltClkCtrl_quartusv13_1_0_GCLK_numclk_1.vhd
-- Megafunction Name(s):
-- 			altclkctrl
--
-- Simulation Library Files(s):
-- 			
-- ============================================================
-- ************************************************************
-- THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
--
-- 13.1.0 Build 162 10/23/2013 SJ Full Version
-- ************************************************************


--Copyright (C) 1991-2013 Altera Corporation
--Your use of Altera Corporation's design tools, logic functions 
--and other software and tools, and its AMPP partner logic 
--functions, and any output files from any of the foregoing 
--(including device programming or simulation files), and any 
--associated documentation or information are expressly subject 
--to the terms and conditions of the Altera Program License 
--Subscription Agreement, Altera MegaCore Function License 
--Agreement, or other applicable license agreement, including, 
--without limitation, that your use is for the sole purpose of 
--programming logic devices manufactured by Altera and sold by 
--Altera or its authorized distributors.  Please refer to the 
--applicable agreement for further details.


--altclkctrl CBX_AUTO_BLACKBOX="ALL" CLOCK_TYPE="Global Clock" DEVICE_FAMILY="Stratix V" ENA_REGISTER_MODE="always enabled" USE_GLITCH_FREE_SWITCH_OVER_IMPLEMENTATION="OFF" ena inclk outclk
--VERSION_BEGIN 13.1 cbx_altclkbuf 2013:10:17:04:07:49:SJ cbx_cycloneii 2013:10:17:04:07:49:SJ cbx_lpm_add_sub 2013:10:17:04:07:49:SJ cbx_lpm_compare 2013:10:17:04:07:49:SJ cbx_lpm_decode 2013:10:17:04:07:49:SJ cbx_lpm_mux 2013:10:17:04:07:49:SJ cbx_mgl 2013:10:17:04:34:36:SJ cbx_stratix 2013:10:17:04:07:49:SJ cbx_stratixii 2013:10:17:04:07:49:SJ cbx_stratixiii 2013:10:17:04:07:49:SJ cbx_stratixv 2013:10:17:04:07:49:SJ  VERSION_END

 LIBRARY stratixv;
 USE stratixv.all;

--synthesis_resources = stratixv_clkena 1 
 LIBRARY ieee;
 USE ieee.std_logic_1164.all;

 ENTITY  MWAltClkCtrl_quartusv13_1_0_GCLK_numclk_1_altclkctrl_blh IS 
	 PORT 
	 ( 
		 ena	:	IN  STD_LOGIC := '1';
		 inclk	:	IN  STD_LOGIC_VECTOR (3 DOWNTO 0) := (OTHERS => '0');
		 outclk	:	OUT  STD_LOGIC
	 ); 
 END MWAltClkCtrl_quartusv13_1_0_GCLK_numclk_1_altclkctrl_blh;

 ARCHITECTURE RTL OF MWAltClkCtrl_quartusv13_1_0_GCLK_numclk_1_altclkctrl_blh IS

	 SIGNAL  wire_sd1_outclk	:	STD_LOGIC;
	 SIGNAL  clkselect	:	STD_LOGIC_VECTOR (1 DOWNTO 0);
	 COMPONENT  stratixv_clkena
	 GENERIC 
	 (
		clock_type	:	STRING := "Auto";
		disable_mode	:	STRING := "low";
		ena_register_mode	:	STRING := "always enabled";
		ena_register_power_up	:	STRING := "high";
		test_syn	:	STRING := "high";
		lpm_type	:	STRING := "stratixv_clkena"
	 );
	 PORT
	 ( 
		ena	:	IN STD_LOGIC := '1';
		enaout	:	OUT STD_LOGIC;
		inclk	:	IN STD_LOGIC := '1';
		outclk	:	OUT STD_LOGIC
	 ); 
	 END COMPONENT;
 BEGIN

	clkselect <= (OTHERS => '0');
	outclk <= wire_sd1_outclk;
	sd1 :  stratixv_clkena
	  GENERIC MAP (
		clock_type => "Global Clock",
		ena_register_mode => "always enabled"
	  )
	  PORT MAP ( 
		ena => ena,
		inclk => inclk(0),
		outclk => wire_sd1_outclk
	  );

 END RTL; --MWAltClkCtrl_quartusv13_1_0_GCLK_numclk_1_altclkctrl_blh
--VALID FILE


LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY MWAltClkCtrl_quartusv13_1_0_GCLK_numclk_1 IS
	PORT
	(
		inclk		: IN STD_LOGIC ;
		outclk		: OUT STD_LOGIC 
	);
END MWAltClkCtrl_quartusv13_1_0_GCLK_numclk_1;


ARCHITECTURE RTL OF mwaltclkctrl_quartusv13_1_0_gclk_numclk_1 IS

	SIGNAL sub_wire0	: STD_LOGIC ;
	SIGNAL sub_wire1	: STD_LOGIC ;
	SIGNAL sub_wire2	: STD_LOGIC ;
	SIGNAL sub_wire3	: STD_LOGIC_VECTOR (3 DOWNTO 0);
	SIGNAL sub_wire4_bv	: BIT_VECTOR (2 DOWNTO 0);
	SIGNAL sub_wire4	: STD_LOGIC_VECTOR (2 DOWNTO 0);



	COMPONENT MWAltClkCtrl_quartusv13_1_0_GCLK_numclk_1_altclkctrl_blh
	PORT (
			ena	: IN STD_LOGIC ;
			inclk	: IN STD_LOGIC_VECTOR (3 DOWNTO 0);
			outclk	: OUT STD_LOGIC 
	);
	END COMPONENT;

BEGIN
	sub_wire1    <= '1';
	sub_wire4_bv(2 DOWNTO 0) <= "000";
	sub_wire4    <= To_stdlogicvector(sub_wire4_bv);
	outclk    <= sub_wire0;
	sub_wire2    <= inclk;
	sub_wire3    <= sub_wire4(2 DOWNTO 0) & sub_wire2;

	MWAltClkCtrl_quartusv13_1_0_GCLK_numclk_1_altclkctrl_blh_component : MWAltClkCtrl_quartusv13_1_0_GCLK_numclk_1_altclkctrl_blh
	PORT MAP (
		ena => sub_wire1,
		inclk => sub_wire3,
		outclk => sub_wire0
	);



END RTL;

-- ============================================================
-- CNX file retrieval info
-- ============================================================
-- Retrieval info: PRIVATE: INTENDED_DEVICE_FAMILY STRING "Stratix V"
-- Retrieval info: PRIVATE: SYNTH_WRAPPER_GEN_POSTFIX STRING "0"
-- Retrieval info: PRIVATE: clock_inputs NUMERIC "1"
-- Retrieval info: CONSTANT: ENA_REGISTER_MODE STRING "always enabled"
-- Retrieval info: CONSTANT: INTENDED_DEVICE_FAMILY STRING "Stratix V"
-- Retrieval info: CONSTANT: USE_GLITCH_FREE_SWITCH_OVER_IMPLEMENTATION STRING "OFF"
-- Retrieval info: CONSTANT: clock_type STRING "Global Clock"
-- Retrieval info: USED_PORT: inclk 0 0 0 0 INPUT NODEFVAL "inclk"
-- Retrieval info: USED_PORT: outclk 0 0 0 0 OUTPUT NODEFVAL "outclk"
-- Retrieval info: CONNECT: @ena 0 0 0 0 VCC 0 0 0 0
-- Retrieval info: CONNECT: @inclk 0 0 3 1 GND 0 0 3 0
-- Retrieval info: CONNECT: @inclk 0 0 1 0 inclk 0 0 0 0
-- Retrieval info: CONNECT: outclk 0 0 0 0 @outclk 0 0 0 0
-- Retrieval info: GEN_FILE: TYPE_NORMAL MWAltClkCtrl_quartusv13_1_0_GCLK_numclk_1.vhd TRUE
-- Retrieval info: GEN_FILE: TYPE_NORMAL MWAltClkCtrl_quartusv13_1_0_GCLK_numclk_1.inc FALSE
-- Retrieval info: GEN_FILE: TYPE_NORMAL MWAltClkCtrl_quartusv13_1_0_GCLK_numclk_1.cmp TRUE
-- Retrieval info: GEN_FILE: TYPE_NORMAL MWAltClkCtrl_quartusv13_1_0_GCLK_numclk_1.bsf FALSE
-- Retrieval info: GEN_FILE: TYPE_NORMAL MWAltClkCtrl_quartusv13_1_0_GCLK_numclk_1_inst.vhd FALSE