----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/14/2023 09:20:51 AM
-- Design Name: 
-- Module Name: test_driver - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity test_driver is
--  Port ( );
end test_driver;

architecture Behavioral of test_driver is
    signal clk, res : STD_LOGIC;                        --clock and reset signals
    signal i2c_ena     : STD_LOGIC;                     --i2c enable signal
    signal i2c_addr    : STD_LOGIC_VECTOR(6 DOWNTO 0);  --i2c address signal
    signal i2c_rw      : STD_LOGIC;                     --i2c read/write command signal
    signal i2c_data_wr : STD_LOGIC_VECTOR;              --i2c write data
    signal i2c_data_rd : STD_LOGIC_VECTOR;              --i2c read data
    signal i2c_busy    : STD_LOGIC;                     --i2c busy signal
    signal i2c_error   : STD_LOGIC;                     --i2c Error signal
    signal i2c_sda, i2c_scl    : STD_LOGIC;             --i2c sda and scl signal
    signal i2c_data_length     : STD_LOGIC_VECTOR;      --i2c data length signal
begin
    driver : entity work.I2C_driver
    port map(
        clk => clk, 
        res => res, 
        en => i2c_ena, 
        rw_n => i2c_rw, 
        addr_in => i2c_addr,
        data_length => i2c_data_length,
        d_in => i2c_data_wr, 
        d_out => i2c_data_rd, 
        busy => i2c_busy,
        error => i2c_error,
        sda => i2c_sda,
        scl => i2c_scl
    );

    clk_gen : process
    begin
        clk <= '0';
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;
    end process ; -- clk_gen

    res_gen : process begin
        res <= '0';
        wait for 9 ns;
        res <= '1';
        wait;
    end process ; -- res_gen

    test_pro : process begin
        wait until res = '1';
        i2c_addr <= "1010000";
        i2c_rw <= '0';                  --write
        i2c_data_wr <= x"00000052";     --write 0x52 to register 0x00
        i2c_data_length <= "001";       --write 1 byte
        i2c_ena <= '1';
        wait until i2c_busy = '0';




        wait;
    end process ; -- test_pro

end Behavioral;
