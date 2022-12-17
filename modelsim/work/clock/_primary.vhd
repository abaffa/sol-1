library verilog;
use verilog.vl_types.all;
entity clock is
    port(
        arst            : in     vl_logic;
        clk_sel         : in     vl_logic_vector(2 downto 0);
        stop_clk        : in     vl_logic;
        clk_in          : in     vl_logic;
        clk_out         : out    vl_logic
    );
end clock;
