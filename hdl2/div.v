module div
#(
	parameter N   = 14,
	parameter DEC =  4
)
(
	input              clk     ,    
	input              reset_n , 
	input      [N-1:0] dividend,
	input      [N-1:0] divisor ,
	input              sen1    ,
	input              sen2    ,
	output reg [N-1:0] Q       ,
	output reg         done    
);
parameter COUNT_WIDTH = $clog2(N);

reg [N-1:0] X, A, Y;
reg [COUNT_WIDTH:0] count;
wire [N-1:0] minus;

assign minus = A - Y;


localparam IDLE  = 3'b000,
		   ENA   = 3'b001,
		   SHIFT = 3'b010,
		   CALC  = 3'b011;
reg [2:0] current_state, next_state;


always @(*) begin
	case (current_state)
		IDLE: begin
			if (sen1) begin
				next_state = ENA;
			end
			else begin
				next_state = current_state;
			end
		end
		
		ENA: begin
			if (sen2) begin
				next_state = CALC;
			end
			else begin
				next_state = current_state;
			end
		end

		CALC: begin
			if (count == N+DEC) begin
				next_state = IDLE;
			end
			else begin 
				next_state = CALC;
			end
		end
	
		default : next_state = current_state;
	endcase
end

always @(posedge clk or negedge reset_n) begin
	if(~reset_n) begin
		current_state <= IDLE;
	end else begin
		current_state <= next_state;
	end
end


always @(posedge clk or negedge reset_n) begin
	if(~reset_n) begin
		Q     <= {N{1'b0}};
		done  <= 1'b0;
		X     <= {N{1'b0}};
		Y     <= {N{1'b0}};
		A     <= {N{1'b0}};
		count <= {COUNT_WIDTH{1'b0}};
	end else begin
		case (current_state)
			IDLE: begin
				done <= 1'b0;
			end
			ENA: begin
				X <= dividend;
				A <= {N{1'b0}};
				Y <= divisor;
				done <= 1'b0;
				count <= {COUNT_WIDTH{1'b0}};
			end

			CALC: begin
				if (A >= Y) begin
					{A, X} <= {minus[N-2:0], X, 1'b0};
					Q <= {Q[N-2:0], 1'b1};
					count <= count + 1;
				end
				else begin 
					{A, X} <= {A[N-2:0], X, 1'b0};
					Q <= {Q[N-2:0], 1'b0};
					count <= count + 1;
				end
				if (count == N+DEC) begin
					count <= {COUNT_WIDTH{1'b0}};
					done <= 1'b1;
				end
			end
				
		endcase
	end
end

endmodule