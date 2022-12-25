library verilog;
use verilog.vl_types.all;
entity ide is
    port(
        arst            : in     vl_logic;
        clk             : in     vl_logic;
        ce_n            : in     vl_logic;
        oe_n            : in     vl_logic;
        we_n            : in     vl_logic;
        address         : in     vl_logic_vector(2 downto 0);
        data_in         : in     vl_logic_vector(7 downto 0);
        data_out        : out    vl_logic_vector(7 downto 0)
    );
end ide;
