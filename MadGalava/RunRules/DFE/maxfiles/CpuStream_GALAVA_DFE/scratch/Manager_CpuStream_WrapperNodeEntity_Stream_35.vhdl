library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity Manager_CpuStream_WrapperNodeEntity_Stream_35 is
	port (
		input_empty: in std_logic;
		input_done: in std_logic;
		input_data: in std_logic_vector(127 downto 0);
		output_stall: in std_logic;
		pullpush_clk: in std_logic;
		pullpush_clk_nobuf: in std_logic;
		pullpush_clk_rst: in std_logic;
		input_read: out std_logic;
		output_valid: out std_logic;
		output_done: out std_logic;
		output_data: out std_logic_vector(127 downto 0)
	);
end Manager_CpuStream_WrapperNodeEntity_Stream_35;

architecture MaxDC of Manager_CpuStream_WrapperNodeEntity_Stream_35 is
	-- Utility functions
	
	function vec_to_bit(v: in std_logic_vector) return std_logic is
	begin
		assert v'length = 1
		report "vec_to_bit: vector must be single bit!"
		severity FAILURE;
		return v(v'left);
	end;
	function bit_to_vec(b: in std_logic) return std_logic_vector is
		variable v: std_logic_vector(0 downto 0);
	begin
		v(0) := b;
		return v;
	end;
	function bool_to_vec(b: in boolean) return std_logic_vector is
		variable v: std_logic_vector(0 downto 0);
	begin
		if b = true then
			v(0) := '1';
		else
			v(0) := '0';
		end if;
		return v;
	end;
	function sanitise_ascendingvec(i : std_logic_vector) return std_logic_vector is
		variable v: std_logic_vector((i'length - 1) downto 0);
	begin
		for j in 0 to (i'length - 1) loop
			v(j) := i(i'high - j);
		end loop;
		return v;
	end;
	function slice(i : std_logic_vector; base : integer; size : integer) return std_logic_vector is
		variable v: std_logic_vector(size - 1 downto 0);
		variable z: std_logic_vector(i'length - 1 downto 0);
	begin
		assert i'length >= (base + size)
		report "vslice: slice out of range."
		severity FAILURE;
		if i'ascending = true then
			z := sanitise_ascendingvec(i);
		else
			z := i;
		end if;
		v(size - 1 downto 0) := z((size + base - 1) downto base);
		return v;
	end;
	function slv_to_slv(v : std_logic_vector) return std_logic_vector is
	begin
		return v;
	end;
	function slv_to_signed(ARG: STD_LOGIC_VECTOR; SIZE: INTEGER) return SIGNED is
		variable result: SIGNED (SIZE-1 downto 0);
	begin
		for i in 0 to SIZE-1 loop
			result(i) := ARG(i);
		end loop;
		return result;
	end;
	
	-- Component declarations
	
	attribute box_type : string;
	component StreamPullPushAdapter128 is
		port (
			clk: in std_logic;
			rst: in std_logic;
			inputstream_pull_empty: in std_logic;
			inputstream_pull_done: in std_logic;
			inputstream_pull_data: in std_logic_vector(127 downto 0);
			outputstream_push_stall: in std_logic;
			inputstream_pull_read: out std_logic;
			outputstream_push_valid: out std_logic;
			outputstream_push_done: out std_logic;
			outputstream_push_data: out std_logic_vector(127 downto 0)
		);
	end component;
	
	-- Signal declarations
	
	signal inst_ln31_streamingblock_inputstream_pull_read : std_logic_vector(0 downto 0);
	signal inst_ln31_streamingblock_outputstream_push_valid : std_logic_vector(0 downto 0);
	signal inst_ln31_streamingblock_outputstream_push_done : std_logic_vector(0 downto 0);
	signal inst_ln31_streamingblock_outputstream_push_data : std_logic_vector(127 downto 0);
	signal inst_ln31_streamingblock_inputstream_pull_data1 : std_logic_vector(127 downto 0);
	signal cat_ln31_streamiogrouputils : std_logic_vector(127 downto 0);
	signal cat_ln31_streamiogrouputils1 : std_logic_vector(127 downto 0);
	
	-- Attribute type declarations
	
	
	-- Attribute declarations
	
begin
	
	-- Assignments
	
	cat_ln31_streamiogrouputils<=input_data;
	inst_ln31_streamingblock_inputstream_pull_data1 <= cat_ln31_streamiogrouputils;
	cat_ln31_streamiogrouputils1<=inst_ln31_streamingblock_outputstream_push_data;
	input_read <= vec_to_bit(inst_ln31_streamingblock_inputstream_pull_read);
	output_valid <= vec_to_bit(inst_ln31_streamingblock_outputstream_push_valid);
	output_done <= vec_to_bit(inst_ln31_streamingblock_outputstream_push_done);
	output_data <= cat_ln31_streamiogrouputils1;
	
	-- Register processes
	
	
	-- Entity instances
	
	inst_ln31_streamingblock : StreamPullPushAdapter128
		port map (
			inputstream_pull_read => inst_ln31_streamingblock_inputstream_pull_read(0), -- 1 bits (out)
			outputstream_push_valid => inst_ln31_streamingblock_outputstream_push_valid(0), -- 1 bits (out)
			outputstream_push_done => inst_ln31_streamingblock_outputstream_push_done(0), -- 1 bits (out)
			outputstream_push_data => inst_ln31_streamingblock_outputstream_push_data, -- 128 bits (out)
			clk => pullpush_clk, -- 1 bits (in)
			rst => pullpush_clk_rst, -- 1 bits (in)
			inputstream_pull_empty => input_empty, -- 1 bits (in)
			inputstream_pull_done => input_done, -- 1 bits (in)
			inputstream_pull_data => inst_ln31_streamingblock_inputstream_pull_data1, -- 128 bits (in)
			outputstream_push_stall => output_stall -- 1 bits (in)
		);
end MaxDC;