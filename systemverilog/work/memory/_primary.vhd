library verilog;
use verilog.vl_types.all;
entity memory is
    generic(
        MEM_SIZE        : vl_notype
    );
    port(
        ce_n            : in     vl_logic;
        oe_n            : in     vl_logic;
        we_n            : in     vl_logic;
        address         : in     vl_logic_vector;
        data_in         : in     vl_logic_vector(7 downto 0);
        data_out        : out    vl_logic_vector(7 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of MEM_SIZE : constant is 5;
end memory;
