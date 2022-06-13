module cotroller (
	input            clk        ,    
	input            reset_n    ,  
	input            sensor1    ,
	input            sensor2    ,
	input            sensor3    ,
	input            valid_Epass,
	input            enable     ,
	input      [1:0] num_veh    ,
	input            done       ,
	output reg       init       ,
	output reg       count      ,
	output reg       cal        ,
	output reg       up         ,
	output reg       down       ,
	output reg       en         ,
	output reg       dis        
);

localparam START      = 2'b00,
		   COUNT_TIME = 2'b01,
		   CALC       = 2'b10;

reg       reg_sensor3;		// reg_sensor3 is a register stores the value of sensor3
reg [1:0] next_state, current_state;


/**============================================
 * 	          Update value for current_state
 *=============================================*/
always @(posedge clk or negedge reset_n) begin
	if(~reset_n) begin
		current_state <= START;
	end else begin
		current_state <= next_state;
	end
end

/**============================================
 * 	          Update value for reg_sensor3
 *=============================================*/
always @(posedge clk or negedge reset_n) begin
	if(~reset_n) begin
		reg_sensor3 <= 0;
	end else begin
		reg_sensor3 <= sensor3;
	end
end


always @(*) begin
	init = 0;
	count = 0;
	cal = 0;
	up = 0;
	en = 0;
	dis = 0;
	
	if (num_veh == 0) begin
		dis = 1;
	end
	else begin 
		en = 1;
	end

	case (current_state)
		START: begin 
			init = 1;
			if (sensor1) begin
				next_state = COUNT_TIME;
			end
			else begin 
				next_state = current_state;
			end
		end

		COUNT_TIME: begin 
			count = 1;
			if (sensor2) begin
				next_state = CALC;
			end
			else begin 
				next_state = current_state;
			end
		end

		CALC: begin 
			cal = 1;
			if (valid_Epass) begin
				up = 1;
			end
			else begin 
				dis = 1;
			end

			// if (num_veh == 0) begin
			// 	dis = 1;
			// end
			// else begin 
			// 	en = 1;
			// end
			next_state = START;
		end
		default : next_state = current_state;
	endcase
end


/**============================================
 * 	          Update value for down
 *=============================================*/
always @(*) begin
	if (reg_sensor3 & !sensor3) begin
		down = 1;
	end
	else begin 
		down = 0;
	end
end


/**============================================
 * 	          Update value for dis
 *=============================================*/
// always @(*) begin
// 	if (num_veh == 0) begin
// 		dis = 1;
// 	end
// 	else begin 
// 		en = 1;
// 	end
// end


endmodule
