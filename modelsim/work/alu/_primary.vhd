library verilog;
use verilog.vl_types.all;
entity alu is
    port(
        a               : in     vl_logic_vector(7 downto 0);
        b               : in     vl_logic_vector(7 downto 0);
        cf_in           : in     vl_logic;
        sel             : in     vl_logic_vector(3 downto 0);
        mode            : in     vl_logic;
        alu_out         : out    vl_logic_vector(7 downto 0);
        cf_out          : out    vl_logic
    );
end alu;
