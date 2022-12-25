library verilog;
use verilog.vl_types.all;
entity clock is
    generic(
        FREQ            : real    := 2.750000
    );
    port(
        arst            : in     vl_logic;
        stop_clk_req    : in     vl_logic;
        clk_out         : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of FREQ : constant is 1;
end clock;
