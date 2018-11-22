library ieee;
use ieee.std_logic_1164.all;

entity pi_monte_carlo is
    generic(N: positive:= 18);
    port(
        CLOCK_50: in std_logic;
        KEY: in std_logic_vector(2 downto 0);
        
        SWITCH: in std_logic_vector(9 downto 0);
        
        HEX0: out std_logic_vector(6 downto 0);
        HEX1: out std_logic_vector(6 downto 0);
        HEX2: out std_logic_vector(6 downto 0);
        HEX3: out std_logic_vector(6 downto 0);
        HEX4: out std_logic_vector(6 downto 0);
        result_s: out std_logic_vector(N-1 downto 0)
    );
end entity;

architecture rtl of pi_monte_carlo is

    signal comp: std_logic;
    signal comp_sign: std_logic;
    signal en_circle: std_logic;
    signal en_od: std_logic;
    signal en_pi: std_logic;
    signal en_total: std_logic;
    signal en_x: std_logic;
    signal en_y: std_logic;
    signal startS: std_logic;
    
    component control_block is
        port(
            --control input
            clock: in std_logic;
            reset: in std_logic;
            start: in std_logic;
            enter: in std_logic;
            cmp_s: in std_logic;
            
            input: in std_logic_vector(9 downto 0);
                 
            --control output
            compare: out std_logic;
            
            load_circle: out std_logic;
            load_od: out std_logic;
            load_pi: out std_logic;
            load_total: out std_logic;
            load_x : out std_logic;
            load_y : out std_logic;
            
            done: out std_logic
        );
    end component;
    
    component datapath is
        port(
            clk: in std_logic;
            reset: in std_logic;
            
            --control signals
            compare: in std_logic;
            start: in std_logic;
            cmp_s: out std_logic; -- signals if origin_distance <= 1
            
            --register enablers
            load_circle: in std_logic;
            load_od: in std_logic;
            load_pi: in std_logic;
            load_total: in std_logic;
            load_x : in std_logic;
            load_y : in std_logic;
            result: out std_logic_vector(N-1 downto 0)
        );
    end component;
begin 
    ctrl_block: control_block port map(CLOCK_50, KEY(0), KEY(1), KEY(2), comp, SWITCH(9 downto 0), comp_sign, en_circle, en_od, en_pi, en_total, en_x, en_y);
    op_block: datapath port map(CLOCK_50, KEY(0), comp, startS, comp_sign, en_circle, en_od, en_pi, en_total, en_x, en_y, result_s);
    
end architecture;