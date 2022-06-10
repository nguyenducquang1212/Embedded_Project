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


// module div
// #(
//  parameter N = 4
// )
// (
//  input              clk     ,    
//  input              reset_n , 
//  input      [N-1:0] dividend,
//  input      [N-1:0] divisor ,
//  input              sen1    ,
//  input              sen2    ,
//  output reg [N-1:0] Q       ,
//  output reg         done    
// );
// parameter COUNT_WIDTH = $clog2(N);

// reg [N-1:0] X, A, Y;
// reg [COUNT_WIDTH:0] count;


// localparam IDLE  = 3'b000,
//         ENA   = 3'b001,
//         SHIFT = 3'b010,
//         CALC  = 3'b011;
// reg [2:0] current_state, next_state;


// always @(*) begin
//  case (current_state)
//      IDLE: begin
//          if (sen1) begin
//              next_state = ENA;
//          end
//          else begin
//              next_state = current_state;
//          end
//      end
        
//      ENA: begin
//          if (sen2) begin
//              next_state = SHIFT;
//          end
//          else begin
//              next_state = current_state;
//          end
//      end

//      SHIFT: begin
//          next_state = CALC;
//      end

//      CALC: begin
//          if (count == N-1) begin
//              next_state = IDLE;
//          end
//          else begin 
//              next_state = SHIFT;
//          end
//      end
    
//      default : next_state = current_state;
//  endcase
// end

// always @(posedge clk or negedge reset_n) begin
//  if(~reset_n) begin
//      current_state <= IDLE;
//  end else begin
//      current_state <= next_state;
//  end
// end


// always @(posedge clk or negedge reset_n) begin
//  if(~reset_n) begin
//      Q     <= {N{1'b0}};
//      done  <= 1'b0;
//      X     <= {N{1'b0}};
//      Y     <= {N{1'b0}};
//      A     <= {N{1'b0}};
//      count <= {COUNT_WIDTH{1'b0}};
//  end else begin
//      case (current_state)
//          ENA: begin
//              X <= dividend;
//              A <= {N{1'b0}};
//              Y <= divisor;
//              done <= 1'b0;
//              count <= {COUNT_WIDTH{1'b0}};
//          end

//          SHIFT: begin 
//              {A, X} <= {A[N-2:0], X, 1'b0};
//              Q <= {Q[N-2:0], 1'b0};
//              done <= 1'b0;
//          end

//          CALC: begin
//              if (A >= Y) begin
//                  A <= A - Y;
//                  Q[0] <= 1'b1;
//                  count <= count + 1;
//              end
//              else begin 
//                  count <= count + 1;
//              end
//              if (count == N-1) begin
//                  count <= {COUNT_WIDTH{1'b0}};
//                  done <= 1'b1;
//              end
//          end
                
//      endcase
//  end
// end

// endmodule