`timescale 1ns/1ns

module non_stop_ETC_tb #(
	parameter WIDTH_TIK   = 16,
	parameter WIDTH_MS    =  9,
	parameter WIDTH_SPEED = 14
)();

reg                    clk        ;
reg                    reset_n    ;
reg                    sensor1    ;
reg                    sensor2    ;
reg                    sensor3    ;
reg                    valid_Epass;
reg                    enable     ;
wire [WIDTH_SPEED-1:0] speed      ;
wire                   done       ;
wire                   barrier    ;

non_stop_ETC DUT (
	.clk        (clk        ),
	.reset_n    (reset_n    ),
	.sensor1    (sensor1    ),
	.sensor2    (sensor2    ),
	.sensor3    (sensor3    ),
	.valid_Epass(valid_Epass),
	.enable     (enable     ),
	.speed      (speed      ),
	.done       (done       ),
	.barrier    (barrier    )
);

always #10 clk = ~clk;

initial begin
	fork
		// sensor 1
		begin 
			// Luot thu 1
			clk = 0;
			reset_n = 0;
			sensor1 =0;
			enable = 0;
			@(negedge clk);
			reset_n = 1;
			#10000;
			sensor1 = 1;
			#144000000;	// Thoi gian oto di qua 1 sensor
			sensor1 = 0;

			// Luot thu 2
			#1200000000;
			#1000000000;
			sensor1 = 1;
			#144000000; // Thoi gian oto di qua 1 sensor
			sensor1 = 0;
		end

		// sensor 2
		begin 
			// Luot thu 1
			sensor2 = 0;
			valid_Epass = 0;
			@(negedge clk);
			#10000;
			#480000000; // Thoi gian oto di tu sensor 1 den sensor 2
			sensor2 = 1;
			valid_Epass = 1;
			#144000000; // Thoi gian oto di qua 1 sensor
			sensor2 = 0;
			valid_Epass = 0;

			// Luot thu 2
			#720000000;
			#1000000000;
			#240000000;  // Thoi gian oto di tu sensor 1 den sensor 2
			sensor2 = 1;
			valid_Epass = 1;
			#144000000; // Thoi gian oto di qua 1 sensor
			sensor2 = 0;
			valid_Epass = 0;
		end

		// sensor 3
		begin 
			// Luot thu 1
			sensor3 = 0;
			#10000;
			#1200000000; // Thoi gian oto di tu sensor 1 den sensor 3
			sensor3 = 1;
			#144000000; // Thoi gian oto di qua 1 sensor
			sensor3 = 0;

			// Luot thu 2
			#1000000000;
			#600000000; // Thoi gian oto di tu sensor 1 den sensor 3
			sensor3 = 1;
			#144000000; // Thoi gian oto di qua 1 sensor
			sensor3 = 0;
		end
	join

	#1200000000;
	$finish;
end
endmodule
