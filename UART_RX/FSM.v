module FSM(
    input           CLK,
    input           RST,
    input           RX_IN,
    input           PAR_EN,
    input  [5:0]    edge_cnt,
    input  [3:0]    bit_cnt,
    input           strt_glitch,
    input           par_err,
    input           stp_err,
    input   [5:0]   Prescale,
    output  reg     dat_samp_en,
    output  reg     enable,
    output  reg     par_chk_en,
    output  reg     strt_chk_en,
    output  reg     stp_chk_en,
    output  reg     data_valid,
    output  reg     deser_en
);
reg     [2:0]   c_state;
reg     [2:0]   n_state;

localparam  IDEAL       = 3'b001 ,
            START       = 3'b010,
            DATA        = 3'b011,
            PARITY      = 3'b100,
            STOP        = 3'b101,
            DAT_VALID   = 3'b110;

always @(posedge CLK or negedge RST ) begin
    if (!RST) begin
        c_state <= IDEAL;
    end
    else begin
      c_state <= n_state;
    end
end
always @(*) begin
    case(c_state)
    IDEAL: begin
        dat_samp_en <= 1'b0 ;
        enable      <= 1'b0 ;
        par_chk_en  <= 1'b0 ;
        strt_chk_en <= 1'b0 ;
        stp_chk_en  <= 1'b0 ;
        data_valid  <= 1'b0 ;
        deser_en    <= 1'b0 ;
        if(!RX_IN)
            n_state <= START ;
        else
            n_state <= IDEAL ;
        
    end

    START: begin
        dat_samp_en <= 1'b1 ;
        enable      <= 1'b1 ;
        par_chk_en  <= 1'b0 ;
        strt_chk_en <= 1'b0 ;
        stp_chk_en  <= 1'b0 ;
        data_valid  <= 1'b0 ;
        deser_en    <= 1'b0 ;
        if(edge_cnt >= Prescale -2) strt_chk_en <= 1'b1 ; 
        if(edge_cnt >= Prescale -1) begin
          if(!strt_glitch)
            n_state <= DATA ;
        else
            n_state <= IDEAL ;
        end
        else begin
          n_state <= START ;
        end
        
    end
    DATA: begin
        dat_samp_en <= 1'b1 ;
        enable      <= 1'b1 ;
        par_chk_en  <= 1'b0 ;
        strt_chk_en <= 1'b0 ;
        stp_chk_en  <= 1'b0 ;
        data_valid  <= 1'b0 ;
        deser_en    <= 1'b0 ;
        if(edge_cnt== Prescale-2) deser_en    <= 1'b1 ;
        if(bit_cnt >= 4'b1001) begin
            if (PAR_EN) begin
                n_state <= PARITY;
            end
            else begin
              n_state <= STOP;
            end
        end
        else
            n_state <= DATA ;
        
    end 
    PARITY: begin
        dat_samp_en <= 1'b1 ;
        enable      <= 1'b1 ;
        par_chk_en  <= 1'b0 ;
        strt_chk_en <= 1'b0 ;
        stp_chk_en  <= 1'b0 ;
        data_valid  <= 1'b0 ;
        deser_en    <= 1'b0 ;
        if(edge_cnt == (Prescale-2)) par_chk_en  <= 1'b1 ;
        if(edge_cnt >= Prescale -1) begin
          if(!par_err)
            n_state <= STOP ;
        else
            n_state <= IDEAL ;
        end
        else begin
          n_state <= PARITY ;
        end
        
      
    end
    STOP: begin
        dat_samp_en <= 1'b1 ;
        enable      <= 1'b1 ;
        par_chk_en  <= 1'b0 ;
        strt_chk_en <= 1'b0 ;
        stp_chk_en  <= 1'b0 ;
        data_valid  <= 1'b0 ;
        deser_en    <= 1'b0 ;
        if(edge_cnt == (Prescale-2)) stp_chk_en  <= 1'b1 ;
        if(edge_cnt >= Prescale -1) begin
          if(!stp_err)
            n_state <= DAT_VALID ;
        else
            n_state <= IDEAL ;
        end
        else begin
          n_state <= STOP ;
        end
        
      
    end
    DAT_VALID: begin
        dat_samp_en <= 1'b0 ;
        enable      <= 1'b0 ;
        par_chk_en  <= 1'b0 ;
        strt_chk_en <= 1'b0 ;
        stp_chk_en  <= 1'b0 ;
        data_valid  <= 1'b1 ;
        deser_en    <= 1'b0 ;
        
        n_state <= IDEAL ;
    end
    endcase

end









endmodule
