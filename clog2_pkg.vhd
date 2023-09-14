----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/12/2023 09:04:22 AM
-- Design Name: 
-- Module Name: clog2_pkg - Behavioral
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

package log2_pkg is
    function clog2(x : positive) return natural;
end package log2_pkg;

package body log2_pkg is
    function clog2(x : positive) return natural is
        variable r  : natural := 0;
        variable rp : natural := 1; -- rp tracks the value 2**r
    begin 
        while rp < x loop -- Termination condition T: x <= 2**r
            -- Loop invariant L: 2**(r-1) < x
            r := r + 1;
            if rp > integer'high - rp then exit; end if;  -- If doubling rp overflows
            -- the integer range, the doubled value would exceed x, so safe to exit.
            rp := rp + rp;
        end loop;
        -- L and T  <->  2**(r-1) < x <= 2**r  <->  (r-1) < log2(x) <= r
        return r; --
    end clog2;
end package body log2_pkg;
