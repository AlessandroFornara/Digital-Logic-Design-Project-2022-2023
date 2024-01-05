-----------------------------------------
-- Politecnico Di Milano
-- Alessandro Fornara, Donato Fiore
-- Progetto di Reti Logiche AA 2022-2023
-----------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity project_reti_logiche is
    port(
        i_clk : in std_logic;
        i_rst : in std_logic;
        i_start : in std_logic;
        i_w : in std_logic;
        o_z0 : out std_logic_vector(7 downto 0);
        o_z1 : out std_logic_vector(7 downto 0);
        o_z2 : out std_logic_vector(7 downto 0);
        o_z3 : out std_logic_vector(7 downto 0);
        o_done : out std_logic;
        o_mem_addr : out std_logic_vector(15 downto 0);
        i_mem_data : in std_logic_vector(7 downto 0);
        o_mem_we : out std_logic;
        o_mem_en : out std_logic
        );
end project_reti_logiche;

architecture Behavioral of project_reti_logiche is
component datapath is
    port( 
        i_clk : in STD_LOGIC;
        i_rst : in STD_LOGIC;
        i_w : in STD_LOGIC;
        o_z0 : out STD_LOGIC_VECTOR (7 downto 0);
        o_z1 : out STD_LOGIC_VECTOR (7 downto 0);
        o_z2 : out STD_LOGIC_VECTOR (7 downto 0);
        o_z3 : out STD_LOGIC_VECTOR (7 downto 0);
        r1_load : in STD_LOGIC;
        r2_load : in STD_LOGIC;
        r3_load : in STD_LOGIC;
        r4_load : in STD_LOGIC;      
        output_sel : in STD_LOGIC;
        sum_sel : in STD_LOGIC;
        input_sel : in STD_LOGIC;
        save : in STD_LOGIC;
        load_addr : in STD_LOGIC;
        o_done : out STD_LOGIC;
        i_mem_data : in STD_LOGIC_VECTOR(7 downto 0);
        o_mem_addr : out STD_LOGIC_VECTOR(15 downto 0));
end component;

--Segnali Macchina a Stati
signal r1_load : STD_LOGIC;
signal r2_load : STD_LOGIC;
signal r3_load : STD_LOGIC;
signal r4_load : STD_LOGIC;
signal sum_sel : STD_LOGIC;
signal output_sel : STD_LOGIC;
signal input_sel : STD_LOGIC;
signal save : STD_LOGIC;
signal load_addr : STD_LOGIC;
type S is(S0,S1,S2,S3,S4,S5,S6,S7,S8,S9,S10,S11,S12,S13,S14,S15,S16,S17,S18,S19,S20,S21);
signal cur_state, next_state : S;

--Segnali Datapath
signal o_reg1 : STD_LOGIC := '0';
signal o_reg2 : STD_LOGIC := '0';
signal o_reg3 : STD_LOGIC := '0';
signal o_reg4 : STD_LOGIC_VECTOR (15 downto 0) := (others => '0');
signal mux_input : STD_LOGIC;
signal mux_reg4 : STD_LOGIC_VECTOR (15 downto 0);
signal sum : STD_LOGIC_VECTOR (15 downto 0);
signal shift : STD_LOGIC_VECTOR (15 downto 0);
signal o_reg_addr : STD_LOGIC_VECTOR (15 downto 0) := (others => '0');
signal r_z0_load : STD_LOGIC;
signal r_z1_load : STD_LOGIC;
signal r_z2_load : STD_LOGIC;
signal r_z3_load : STD_LOGIC;
signal o_reg_z0 : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
signal o_reg_z1 : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
signal o_reg_z2 : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
signal o_reg_z3 : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
signal mux_z0 : STD_LOGIC_VECTOR ( 7 downto 0);
signal mux_z1 : STD_LOGIC_VECTOR ( 7 downto 0);
signal mux_z2 : STD_LOGIC_VECTOR ( 7 downto 0);
signal mux_z3 : STD_LOGIC_VECTOR ( 7 downto 0);
signal done_sel : STD_LOGIC_VECTOR (7 downto 0);
begin
    
    process(i_clk, i_rst)
    begin
        if(i_rst = '1') then
            cur_state <= S0;
        elsif i_clk'event and i_clk = '1' then
            cur_state <= next_state;
        end if;
    end process;
    
    process(cur_state, i_start)
    begin
        next_state <= cur_state;
        case cur_state is
            when S0 => 
                if i_start='1' then
                    next_state <= S1;
                end if;
            when S1 => 
                if i_rst='1' then
                    next_state <= S0;
                elsif i_rst='0' then  
                    next_state <= S2;
                end if;
            when S2 => 
                if i_rst='1' then
                    next_state <= S0;
                elsif i_start='0' then
                   next_state <= S19;
                elsif i_rst='0' then 
                    next_state <= S3;
                end if;
            when S3 => 
                if i_rst='1' then
                    next_state <= S0;
                elsif i_start='0' then
                    next_state <= S19;
                elsif i_rst='0' then
                    next_state <= S4;
                end if;
            when S4 => 
                if i_rst='1' then
                    next_state <= S0;
                elsif i_start='0' then
                    next_state <= S19;
                elsif i_rst='0' then
                    next_state <= S5;
                end if;
            when S5 => 
                if i_rst='1' then
                    next_state <= S0;
                elsif i_start='0' then
                    next_state <= S19;
                elsif i_rst='0' then
                    next_state <= S6;
                end if;
            when S6 => 
                if i_rst='1' then
                    next_state <= S0;
                elsif i_start='0' then
                    next_state <= S19;
                elsif i_rst='0' then
                    next_state <= S7;
                end if; 
            when S7 => 
                if i_rst='1' then
                    next_state <= S0;
                elsif i_start='0' then
                    next_state <= S19;
                elsif i_rst='0' then
                    next_state <= S8;
                end if;
            when S8 => 
                if i_rst='1' then
                    next_state <= S0;
                elsif i_start='0' then
                    next_state <= S19;
                elsif i_rst='0' then
                    next_state <= S9;
                end if;
            when S9 => 
                if i_rst='1' then
                    next_state <= S0;
                elsif i_start='0' then
                    next_state <= S19;
                elsif i_rst='0' then
                    next_state <= S10;
                end if;
            when S10 => 
                if i_rst='1' then
                    next_state <= S0;
                elsif i_start='0' then
                    next_state <= S19;
                elsif i_rst='0' then
                    next_state <= S11;
                end if;
            when S11 => 
                if i_rst='1' then
                    next_state <= S0;
                elsif i_start='0' then
                    next_state <= S19;
                elsif i_rst='0' then
                    next_state <= S12;
                end if;
            when S12 => 
                if i_rst='1' then
                    next_state <= S0;
                elsif i_start='0' then
                    next_state <= S19;
                elsif i_rst='0' then
                    next_state <= S13;
                end if; 
            when S13 => 
                if i_rst='1' then
                    next_state <= S0;
                elsif i_start='0' then
                    next_state <= S19;
                elsif i_rst='0' then
                    next_state <= S14;
                end if;
            when S14 => 
                if i_rst='1' then
                    next_state <= S0;
                elsif i_start='0' then
                    next_state <= S19;
                elsif i_rst='0' then
                    next_state <= S15;
                end if;
            when S15 => 
                if i_rst='1' then
                    next_state <= S0;
                elsif i_start='0' then
                    next_state <= S19;
                elsif i_rst='0' then
                    next_state <= S16;
                end if;
            when S16 => 
                if i_rst='1' then
                    next_state <= S0;
                elsif i_start='0' then
                    next_state <= S19;
                elsif i_rst='0' then  
                    next_state <= S17;
                end if;
            when S17 => 
                if i_rst='1' then
                    next_state <= S0;
                elsif i_start='0' then
                    next_state <= S19;
                elsif i_rst='0' then  
                    next_state <= S18;
                end if;
            when S18 => 
                if i_rst='1' then
                    next_state <= S0;
                elsif i_rst='0' then  
                    next_state <= S19;
                end if;
            when S19 => 
                if i_rst='1' then
                    next_state <= S0;
                elsif i_rst='0' then  
                    next_state <= S20;
                end if;
            when S20 => 
                if i_rst='1' then
                    next_state <= S0;
                elsif i_rst='0' then  
                    next_state <= S21;
                end if;
            when S21 => 
                if i_rst='1' then
                    next_state <= S0;
                elsif i_rst='0' then  
                    next_state <= S0;
                end if;
            end case;
    end process; 

    process(cur_state)
    begin
        r1_load<='1';
        r2_load<='1';
        r3_load<='1';        
        r4_load<='1';
        sum_sel<='1';
        output_sel<='0';
        input_sel<='1';
        save<='0';
        load_addr<='1';
        o_mem_en<='0';
        o_mem_we<='0';
        
        case cur_state is
            when S0 =>
                sum_sel<='0';
                input_sel<='0';
                
            when S1 =>
                r1_load<='0';
                input_sel<='0';
                sum_sel<='0';
            
            when S2 => 
                r1_load<='0';
                r2_load<='0';
                input_sel<='0';
                sum_sel<='0';
            
            when S3 =>
                r1_load<='0';
                r2_load<='0';

            when S4 =>
                r1_load<='0';
                r2_load<='0';

            when S5 =>
                r1_load<='0';
                r2_load<='0';

            when S6 =>
                r1_load<='0';
                r2_load<='0';

            when S7 =>
                r1_load<='0';
                r2_load<='0';

            when S8 =>
                r1_load<='0';
                r2_load<='0';

            when S9 =>
                r1_load<='0';
                r2_load<='0';

            when S10 =>
                r1_load<='0';
                r2_load<='0';

            when S11 =>
                r1_load<='0';
                r2_load<='0';

            when S12 =>
                r1_load<='0';
                r2_load<='0';

            when S13 =>
                r1_load<='0';
                r2_load<='0';
                
            when S14 =>
                r1_load<='0';
                r2_load<='0';

            when S15 =>
                r1_load<='0';
                r2_load<='0';

            when S16 =>
                r1_load<='0';
                r2_load<='0';

            when S17 =>
                r1_load<='0';
                r2_load<='0';

            when S18 =>
                r1_load<='0';
                r2_load<='0';
                r3_load<='0';
                
            when S19 =>
                r1_load<='0';
                r2_load<='0';
                r3_load<='0';
                r4_load<='0';
                o_mem_en<='1';
                sum_sel<='0';

            when S20 =>
                r1_load<='0';
                r2_load<='0';
                r3_load<='0';
                sum_sel<='0';
                save<='1';
                
            when S21 =>
                r1_load<='0';
                r2_load<='0';
                r3_load<='0';
                sum_sel<='0';
                input_sel<='0';
                output_sel<='1';

        end case;        
    end process;
    
    --Datapath
    process(i_clk, i_rst)
        begin
            if(i_rst = '1') then
                o_reg1 <= '0';
            elsif i_clk'event and i_clk = '1' then
                if(r1_load = '1') then
                    o_reg1 <= i_w;
                end if;
            end if;
        end process; 
        
        process(i_clk, i_rst)
        begin
            if(i_rst = '1') then
                o_reg2 <= '0';
            elsif i_clk'event and i_clk = '1' then
                if(r2_load = '1') then
                    o_reg2 <= i_w;
                end if;
            end if;
        end process; 
        
        process(i_clk, i_rst)
        begin
            if(i_rst = '1') then
                o_reg3 <= '0';
            elsif i_clk'event and i_clk = '1' then
                if(r3_load = '1') then
                    o_reg3 <= i_w;
                end if;
            end if;
        end process;
        
        with sum_sel select
            mux_reg4 <= "0000000000000000" when '0',
            shift when '1',
            "XXXXXXXXXXXXXXXX" when others;  
            
        process(i_clk, i_rst)
        begin
            if(i_rst = '1') then
                o_reg4 <= "0000000000000000";
            elsif i_clk'event and i_clk = '1' then
                if(r4_load = '1') then
                    o_reg4 <= mux_reg4;
                end if;
            end if;
        end process;   
        
        with input_sel select
            mux_input <= '0' when '0',
            o_reg3 when '1',
            'X' when others;       
        
        sum <= ("000000000000000" & mux_input) + o_reg4;
        
        process(i_clk, i_rst)
        begin
           if(i_rst = '1') then
               o_reg_addr <= "0000000000000000";
           elsif i_clk'event and i_clk = '1' then
               if(load_addr = '1') then
                   o_reg_addr <= sum;
               end if;
           end if;
        end process; 
        
        o_mem_addr <= o_reg_addr;  
      
        shift <= sum + sum;
        
        with save select
            r_z0_load <= not(o_reg1) and not(o_reg2) when '1',
            '0' when '0',
            'X' when others;
        with save select
            r_z1_load <= not(o_reg1) and o_reg2 when '1',
            '0' when '0',
            'X' when others;
        with save select
            r_z2_load <= o_reg1 and not(o_reg2) when '1',
            '0' when '0',
            'X' when others;  
        with save select
            r_z3_load <= o_reg1 and o_reg2 when '1',
            '0' when '0',
            'X' when others;   
     
        process(i_clk, i_rst)
        begin
            if(i_rst = '1') then
                o_reg_z0 <= "00000000";
            elsif i_clk'event and i_clk = '1' then
                if(r_z0_load = '1' and o_reg1 ='0' and o_reg2='0') then
                    o_reg_z0 <= i_mem_data;
                end if;
            end if;
        end process;      
        
        process(i_clk, i_rst)
        begin
            if(i_rst = '1') then
                o_reg_z1 <= "00000000";
            elsif i_clk'event and i_clk = '1' then
                if(r_z1_load = '1' and o_reg1 ='0' and o_reg2='1') then
                    o_reg_z1 <= i_mem_data;
                end if;
            end if;
        end process; 
        
        process(i_clk, i_rst)
        begin
            if(i_rst = '1') then
                o_reg_z2 <= "00000000";
            elsif i_clk'event and i_clk = '1' then
                if(r_z2_load = '1' and o_reg1 ='1' and o_reg2='0') then
                    o_reg_z2 <= i_mem_data;
                end if;
            end if;
        end process; 
        
        process(i_clk, i_rst)
        begin
            if(i_rst = '1') then
                o_reg_z3 <= "00000000";
            elsif i_clk'event and i_clk = '1' then
                if(r_z3_load = '1' and o_reg1 ='1' and o_reg2='1') then
                    o_reg_z3 <= i_mem_data;
                end if;
            end if;
        end process; 
        
        with output_sel select
            mux_z0 <= "00000000" when '0',
            o_reg_z0 when '1',
            "XXXXXXXX" when others;
            
        o_z0 <= mux_z0; 
            
        with output_sel select
            mux_z1 <= "00000000" when '0',
            o_reg_z1 when '1',
            "XXXXXXXX" when others;
        
        o_z1 <= mux_z1;
        
        with output_sel select
            mux_z2 <= "00000000" when '0',
            o_reg_z2 when '1',
            "XXXXXXXX" when others;
            
        o_z2 <= mux_z2;
            
        with output_sel select
            mux_z3 <= "00000000" when '0',
            o_reg_z3 when '1',
            "XXXXXXXX" when others;
       
        o_z3 <= mux_z3;
       
        done_sel <= ("0000000" & output_sel);
        
        with done_sel select
            o_done <= '0' when "00000000",
            '1' when others;

end Behavioral;