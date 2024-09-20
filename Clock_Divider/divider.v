module divider (
    input           i_ref_clk,
    input           i_rst_n,
    input           i_clk_en,
    input    [7:0]  i_div_ratio,
    output   reg    divided_clk
);
reg [7:0] count;  // Counter for clock division
wire ClK_DIV_EN;
reg flag;
assign ClK_DIV_EN = i_clk_en && ( i_div_ratio != 0) && ( i_div_ratio != 1);

always@(posedge i_ref_clk or negedge i_clk_en)
begin
    if(!ClK_DIV_EN)
    begin
        count<= 0;
        divided_clk <= 1'b0;

        flag <= 1'b0;
    end
    else if (ClK_DIV_EN && (!i_div_ratio[0]))
    begin
        if (count >= (i_div_ratio / 2 -1)) begin
            count <= 0;
            divided_clk <= ~divided_clk;  // Toggle the clock output
            flag <= 1'b0;
            
        end
        
        else begin
            count <= count + 1;
            flag <= 1'b0;
           
        end
    end
    else if(ClK_DIV_EN && i_div_ratio[0])
    begin
        if(!flag)
        begin
            if (count == (i_div_ratio / 2)-1) begin
                count <= 0;
                divided_clk <= ~divided_clk;  // Toggle the clock output
                flag <= 1'b1; 
            end
            else begin
            
                count <= count + 1;
                divided_clk <= 1'b1;
            end

        end
        else if(flag)
        begin

            if (count == ((i_div_ratio / 2))) begin
                count <= 0;
                divided_clk <= ~divided_clk;
                flag <= 1'b0;

            end
            else begin
            
                count <= count + 1;
                divided_clk <= 1'b0;
                flag <= 1'b1;
            end
        
         end




end
end


endmodule
