library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control_block is
    generic (N: positive := 18);
    port (
        --control input
        clock : in std_logic;
        reset : in std_logic;
        start : in std_logic;
        enter : in std_logic;
        comp_s: in std_logic;
        
        input: in std_logic_vector(N-1 downto 0);
             
        --control output
        load_x : out std_logic;  -- enable register X
        load_y : out std_logic;  -- enable register y
        load_pi: out std_logic
        
    );
end entity;

architecture fsm of control_block is
    type internal_state is (first_state, S0, S1, S2, S3, S4, S5);
    signal next_state, current_state: internal_state;
  
    
begin

    --Next State Logic
    nsl: process (current_state, start)
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
                for i in 0 to iterations loop
                    if (i < iterations) then
                        next_state <= S2;
                    else
                        next_state <= S5;
                    end if;
                end loop;
            
            when S2 =>
                --initializes x and y with random numbers
                --squares x and y
                --adds x² and y²
                load_x <= '1';
                load_y <= '1';
                
                if comp_s <= '1' then
                    next_state <= S3;
                else
                    next_state <= S4;
                end if;
                
            when S3 =>
                --in_circle ++
                next_state <= S4;
            when S4 =>
                --total ++
                next_state <= S1;
            when S5 =>
                --show result;
                if (reset = '1') then
                    next_state <= first_state;
                else
                    next_state <= S5;
                end if;
        end case;
    end process;
    
    --Memory Element
    memory: process (clock, reset)
    begin
        if reset='1' then
            current_state <= First_state;
        elsif rising_edge(clock) then
            current_state <= next_state;
        end if;
     end process;
    
end architecture;