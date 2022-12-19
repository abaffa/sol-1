library verilog;
use verilog.vl_types.all;
entity ram is
    port(
        ce_n            : in     vl_logic;
        oe_n            : in     vl_logic;
        we_n            : in     vl_logic;
        address         : in     vl_logic_vector(12 downto 0);
        data            : inout  vl_logic_vector(7 downto 0)
    );
end ram;
