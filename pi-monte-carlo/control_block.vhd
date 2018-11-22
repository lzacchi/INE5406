library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control_block is
    generic (N: positive := 18);
    port (
        --control input
        clock: in std_logic;
        reset: in std_logic;
        start: in std_logic;
        enter: in std_logic;
        cmp_s: in std_logic;
        
        input: in std_logic_vector(N-1 downto 0);
             
        --control output
        startS: out std_logic;
        compare: out std_logic;
        load_circle: out std_logic;
        load_od: out std_logic;
        load_pi: out std_logic;
        load_total: out std_logic;
        load_x : out std_logic;
        load_y : out std_logic;
        
        
        done: out std_logic
    );
end entity;

architecture fsm of control_block is
    type internal_state is (first_state, S0, S1, S2, S3, S4, S5, S6);
    signal next_state, current_state: internal_state;
    
    signal i: integer:= 0;
    signal it: integer;
  
    
begin
    it <= to_integer(unsigned(input));
    
    --Memory Element
    memory: process (clock, reset)
    begin
        if reset='1' then
            current_state <= First_state;
        elsif rising_edge(clock) then
            current_state <= next_state;
        end if;
     end process;
    
    
    --Next State Logic
    nsl: process (current_state, start, enter, input)
    begin
        next_state <= current_state;
        
        case current_state is
            when first_state=>
                if (start = '1') then
                    next_state <= S0;
                else
                    next_state <= first_state;
                end if;
              
            when S0 =>
            
                if (enter  = '1') then
                    next_state <= S1;
                else
                    next_state <= S0;
                end if;
            
            when S1 =>
                
                if (i < it) then
                    next_state <= S2;
                else
                    next_state <= S6;
                end if;
                
                i<= i + 1;
                
                
            when S2 =>
                next_state <= S3;
                
            when S3 =>

                if (cmp_s = '1') then
                    next_state <= S4;
                else
                    next_state <= S5;
                end if;
            
            when S4 =>
                next_state <= S5;
            
            when S5 =>
                next_state <= S1;
            
            when S6 =>
                if (reset = '1') then
                    next_state <= first_state;
                else
                    next_state <= S6;
                end if;
                done <= '1';
                
        end case;
    end process;
    
    --output logic
    load_x <= '1' when current_state = S2 else '0';
    load_y <= '1' when current_state = S2 else '0';
    
    load_od <= '1' when current_state = S3 else '0';
    
    load_circle <= '1' when current_state = S4 else '0';
    load_total <= '1' when current_state = S5 else '0';
    load_pi <= '1' when current_state = S6 else '0';
    
    compare <= '1' when current_state = S3 else '0';
    
end architecture;