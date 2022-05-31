`timescale 1ns/1ns;

module div__tb();

parameter N = 20;
    
reg          clk     ;
reg          reset_n ;
reg  [N-1:0] dividend;
reg  [N-1:0] divisor ;
reg          sen1    ;
reg          sen2    ;
wire [N-1:0] Q       ;
wire         done    ;

div  
#(
        .N(N)
) DUT (
        .clk     (clk     ),
        .reset_n (reset_n ),
        .dividend(dividend),
        .divisor (divisor ),
        .sen1    (sen1    ),
        .sen2    (sen2    ),
        .Q       (Q       ),
        .done    (done    )
);

    always #5 clk = ~clk;


    initial begin
        clk = 0;
        reset_n = 0;
        dividend = 25;
        divisor = 3;
        sen1 = 0;
        sen2 = 0;

        @(negedge clk);
        reset_n = 1;
        sen1 = 1;
        @(negedge clk);
        sen2 = 1;

        wait(done);
        sen1 = 0;
        sen2 = 0;
        @(negedge clk);

        repeat (10) begin 
            @(negedge clk);
            divisor = $random()%1000;
            dividend = 4000*3.6;
            sen1 = 1;
            @(negedge clk);
            sen2 = 1;
            @(negedge clk);

            wait(done);
            //#(50*N);
            sen1 = 0;
            sen2 = 0;   
            #1000;         
        end

        @(negedge clk);
        divisor = 480;
        dividend = 4000*3.6;
        sen1 = 1;
        @(negedge clk);
        sen2 = 1;
        @(negedge clk);

        wait(done);
        //#(50*N);
        sen1 = 0;
        sen2 = 0;   
        #1000; 
        $stop;
    end
endmodule
