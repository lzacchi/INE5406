library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity datapath is
    generic(N: positive := 18);
    port(
        clock: in std_logic;
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
        
        --output
        result: out std_logic_vector(N-1 downto 0)
    );
end entity;

architecture rtl of datapath is
    --SIGNALS
    signal calculating: std_logic;
    signal cmps: std_logic;
    
    signal in_circle: std_logic_vector(N-1 downto 0);
    signal in_square: std_logic_vector(N-1 downto 0);
    
    signal od_in: std_logic_vector(N-1 downto 0);
    signal od_out: std_logic_vector(N-1 downto 0);
    
    signal x_in: std_logic_vector(N-1 downto 0);
    signal x_out: std_logic_vector(N-1 downto 0);
    
    signal y_in: std_logic_vector(N-1 downto 0);
    signal y_out: std_logic_vector(N-1 downto 0);
    
    signal x_square: std_logic_vector(N-1 downto 0);
    signal y_square: std_logic_vector(N-1 downto 0);
    
    signal square_x: std_logic_vector(N-1 downto 0);
    signal square_y: std_logic_vector(N-1 downto 0);
    
    signal pi_a: std_logic_vector(N-1 downto 0);
    signal pi_in: std_logic_vector(N-1 downto 0);
    

    --COMPONENTS
    component register_nbits is
        port(
            clk, reset, enable: in std_logic;
            input: in std_logic_vector(N-1 downto 0);
            output: out std_logic_vector(N-1 downto 0)
        );
    end component;
    
    component lfsr is
        port(
            reset: in  std_logic;
            clk: in  std_logic; 
            random : out std_logic_vector(N-1 downto 0)
        );
    end component;
    
    component adder is
        port(
            a: in std_logic_vector(N-1 downto 0);
            b: in std_logic_vector(N-1 downto 0);
            sum: in std_logic_vector(N-1 downto 0)
        );
    end component;
    
    component multiplier is
        port(
            a: in std_logic_vector(N-1 downto 0);
            b: in std_logic_vector(N-1 downto 0);
            product: in std_logic_vector(N-1 downto 0)
        );
    end component;
    
    component comparator is
        port(
            a: in std_logic_vector(N-1 downto 0);
            b: in std_logic_vector(N-1 downto 0);
            comp_out: out std_logic
        );
    end component;

begin
    process(clock, reset)
    begin
        if compare = '1' then
            if cmps = '1' then
                in_circle <= std_logic_vector(unsigned(in_circle) + 1);
            end if;
            in_square <= std_logic_vector(unsigned(in_square) + 1);
        end if;
    end process;
    pi_a <= std_logic_vector(shift_left(unsigned(in_circle), 2));
    pi_in <= std_logic_vector(unsigned(pi_a)/ unsigned(in_square));
    
    square_x <= x_square;
    square_y <= y_square;
        
    cmp_s <= cmps;
        
    
    x_rand: lfsr port map(clock, reset, x_in);
    y_rand: lfsr port map(clock, reset, y_in);
    
    x: register_nbits port map(clock, reset, load_x, x_in, x_out);
    y: register_nbits port map(clock, reset, load_y, y_in, y_out);
    
    x_squared: multiplier port map(x_out, x_out, x_square);
    y_squared: multiplier port map(y_out, y_out, y_square);
    
    
    od_sum: adder port map(square_x, square_y, od_in);
    origin_distance: register_nbits port map(clock, reset, load_od, od_in, od_out);
    
    cmpr: comparator port map(od_out, "000000000000000001", cmps);
    
    pi: register_nbits port map(clock, reset, load_pi, pi_in, result);
    
    
    
    
end architecture;