library verilog;
use verilog.vl_types.all;
entity cpu_top is
    port(
        arst            : in     vl_logic;
        clk             : in     vl_logic;
        data_bus_in     : in     vl_logic_vector(7 downto 0);
        ext_irq_req     : in     vl_logic_vector(7 downto 0);
        dma_req         : in     vl_logic;
        pad_wait        : in     vl_logic;
        ext_input       : in     vl_logic;
        addr            : out    vl_logic_vector(21 downto 0);
        data_out        : out    vl_logic_vector(7 downto 0);
        rd              : out    vl_logic;
        wr              : out    vl_logic;
        mem_io          : out    vl_logic;
        halt            : out    vl_logic;
        dma_ack         : out    vl_logic
    );
end cpu_top;
