
module tb_clock_divider;

    // Testbench signals
    reg           tb_ref_clk;     // Reference clock
    reg           tb_rst_n;       // Active low reset
    reg           tb_clk_en;      // Clock enable
    reg   [7:0]   tb_div_ratio;   // Division ratio
    wire          tb_div_clk;     // Output divided clock

    // Clock generation parameters
    parameter REF_CLK_PERIOD = 10; // Reference clock period (e.g., 100MHz -> 10ns)

    // Instantiate the top module (Unit Under Test)
    cLOCK_DIVIDER_top uut (
        .i_ref_clk(tb_ref_clk),
        .i_rst_n(tb_rst_n),
        .i_clk_en(tb_clk_en),
        .i_div_ratio(tb_div_ratio),
        .o_div_clk(tb_div_clk)
    );

    // Reference clock generation (50% duty cycle)
    initial begin
        tb_ref_clk = 0;
        forever #(REF_CLK_PERIOD / 2) tb_ref_clk = ~tb_ref_clk;
    end

    // Test sequence
    initial begin
        // Initialize inputs
        tb_rst_n = 1'b0;          // Apply reset
        tb_clk_en = 1'b0;         // Clock disable
        tb_div_ratio = 8'd0;      // Set division ratio to 0
        #100;                     // Wait for some time

        // Release reset
        tb_rst_n = 1'b1;          // Release reset
        tb_clk_en = 1'b1;         // Enable the clock
        
        // Test case: Even division ratio (divide by 8)
        tb_div_ratio = 8'd8;      // Set division ratio to 8
        #200;                    // Observe divided clock output for a while

        // Test case: Odd division ratio (divide by 5)
        tb_div_ratio = 8'd5;      // Set division ratio to 5
        #200;                    // Observe divided clock output for a while

        // Test case: Even division ratio (divide by 4)
        tb_div_ratio = 8'd4;      // Set division ratio to 4
        #200;                    // Observe divided clock output for a while

        // Test case: Odd division ratio (divide by 7)
        tb_div_ratio = 8'd7;      // Set division ratio to 7
        #2000;                    // Observe divided clock output for a while

        // Test case: Reset the system
        tb_rst_n = 1'b0;          // Apply reset
        #100;                     // Wait for some time
        tb_rst_n = 1'b1;          // Release reset
        #200;                    // Observe behavior after reset

        // Test case: Disable the clock
        tb_clk_en = 1'b0;         // Disable the clock
        #200;   
                         // Observe that clock stops
        tb_clk_en = 1'b1;         // Re-enable the clock
        #200
        tb_div_ratio = 8'd0; 
        #200
        tb_div_ratio = 8'd1;
        


        #500;                    // Observe clock output after re-enabling

        // Finish simulation
        $stop;
    end

    // Monitor the key signals
    initial begin
        $monitor("Time: %0t | Ref Clk: %b | Divided Clk: %b | Div Ratio: %d | Rst: %b | Clk En: %b", 
                 $time, tb_ref_clk, tb_div_clk, tb_div_ratio, tb_rst_n, tb_clk_en);
    end

endmodule
