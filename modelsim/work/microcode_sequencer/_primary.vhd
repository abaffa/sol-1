library verilog;
use verilog.vl_types.all;
entity microcode_sequencer is
    port(
        arst            : in     vl_logic;
        clk             : in     vl_logic;
        ir              : in     vl_logic_vector(7 downto 0);
        alu_flags       : in     vl_logic_vector(7 downto 0);
        cpu_status      : in     vl_logic_vector(7 downto 0);
        any_interruption: in     vl_logic;
        alu_out         : in     vl_logic_vector(7 downto 0);
        z_bus           : in     vl_logic_vector(7 downto 0);
        alu_of          : in     vl_logic;
        alu_final_cf    : in     vl_logic;
        dma_req         : in     vl_logic;
        \WAIT\          : in     vl_logic;
        int_pending     : in     vl_logic;
        ext_input       : in     vl_logic;
        u_flags         : out    vl_logic_vector(7 downto 0);
        control_word    : out    vl_logic_vector(111 downto 0)
    );
end microcode_sequencer;
