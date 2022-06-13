// `timescale 1ns/1ns

// module top_tb #(
// 	parameter WIDTH_TIK   = 16,
// 	parameter WIDTH_MS    =  9,
// 	parameter WIDTH_SPEED = 14
// )();

// reg                    clk        ;
// reg                    reset_n    ;
// reg                    sensor1    ;
// reg                    sensor2    ;
// reg                    sensor3    ;
// reg                    valid_Epass;
// reg                    enable     ;
// // wire [WIDTH_SPEED-1:0] speed      ;
// // wire                   done       ;
// wire                   serial_data_out    ;

// top  
// #(
// 	.SYS_FREQ(50000000)
// ) DUT (
// 	.clk        (clk        ),
// 	.reset_n    (reset_n    ),
// 	.sensor1    (sensor1    ),
// 	.sensor2    (sensor2    ),
// 	.sensor3    (sensor3    ),
// 	.valid_Epass(valid_Epass),
// 	.enable     (enable     ),
// 	// .speed      (speed      ),
// 	// .done       (done       ),
// 	// .barrier    (barrier    )
// 	.serial_data_out(serial_data_out)
// );

// always #10 clk = ~clk;

// initial begin
// 	fork
// 		// sensor 1
// 		begin 
// 			// Luot thu 1
// 			clk = 0;
// 			reset_n = 0;
// 			sensor1 = 0;
// 			enable = 0;
// 			@(negedge clk);
// 			reset_n = 1'b1;
// 			#10000;
// 			sensor1 = 1'b1;
// 			#144000000;	// Thoi gian oto di qua 1 sensor
// 			sensor1 = 0;

// 			// Luot thu 2
// 			#1200000000;
// 			#1000000000;
// 			sensor1 = 1'b1;
// 			#144000000; // Thoi gian oto di qua 1 sensor
// 			sensor1 = 0;

// 			// Luot thu 3
// 			#3000000000;
// 			#2000000000;
// 			sensor1 = 1'b1;
// 			// L = 4.62 m, v = 7.5m/s = 27km/h
// 			#616000000;// time qua 1 sensor
// 			sensor1 = 0;
            
// 			// Luot thu 4 
// 			#6000000000;
// 			#10000;
// 			// L = 7.62m, v = 6.945m/s = 25km/h
// 			sensor1 = 1'b1;
// 			#1100000000;
// 			sensor1 = 0;

// 			// Luot thu 5 
// 			#6200000000;
// 			#100000000;
// 			// L = 12m, v = 30km/h
// 			sensor1 = 1'b1;
// 			#1440000000;
// 			sensor1 = 0;

// 			// Luot thu 6 
// 			#8940000000;
// 			#20000000000;
// 			// L = 7.62m, v = 6.945m/s = 25km/h
// 			sensor1 = 1'b1;
// 			#1100000000;
// 			sensor1 = 0;
// 		end

// 		// sensor 2
// 		begin 
// 			// Luot thu 1
// 			sensor2 = 0;
// 			valid_Epass = 2'b00;
// 			@(negedge clk);
// 			#10000;
// 			#(480000000-50000000); // Thoi gian oto di tu sensor 1 den sensor 2
// 			sensor2 = 1'b1;
// 			valid_Epass = 1'b1;
// 			#144000000; // Thoi gian oto di qua 1 sensor
// 			sensor2 = 0;
// 			valid_Epass = 2'b00;

// 			// Luot thu 2
// 			#720000000;
// 			#1000000000;
// 			#240000000;  // Thoi gian oto di tu sensor 1 den sensor 2
// 			sensor2 = 1'b1;
// 			valid_Epass = 1'b1;
// 			#144000000; // Thoi gian oto di qua 1 sensor
// 			sensor2 = 0;
// 			valid_Epass = 2'b00;

// 			// Luot thu 3
// 			#5000000000;
// 			#530000000;  // Thoi gian oto di tu sensor 1 den sensor 2
// 			sensor2 = 1'b1;
// 			valid_Epass = 1'b1;
// 			#616000000; // Thoi gian oto di qua 1 sensor
// 			sensor2 = 0;
// 			valid_Epass = 2'b00;

// 			// Luot thu 4
// 			#6000000000;
// 			#576000000;  // Thoi gian oto di tu sensor 1 den sensor 2
// 			sensor2 = 1'b1;
// 			valid_Epass = 1'b1;
// 			#110000000; // Thoi gian oto di qua 1 sensor
// 			sensor2 = 0;
// 			valid_Epass = 2'b00;

// 			// Luot thu 5
// 			#6300000000;
// 			#480000000;  // Thoi gian oto di tu sensor 1 den sensor 2
// 			sensor2 = 1'b1;
// 			valid_Epass = 1'b1;
// 			#1440000000; // Thoi gian oto di qua 1 sensor
// 			sensor2 = 0;
// 			valid_Epass = 2'b00;
 
//             // Luot thu 6
// 			#28940000000;
// 			#576000000;  // Thoi gian oto di tu sensor 1 den sensor 2
// 			sensor2 = 1'b1;
// 			valid_Epass = 1'b1;
// 			#1100000000; // Thoi gian oto di qua 1 sensor
// 			sensor2 = 0;
// 			valid_Epass = 2'b00;

// 		end

// 		// sensor 3
// 		begin 
// 			// Luot thu 1
// 			sensor3 = 0;
// 			#10000;
// 			#1200000000; // Thoi gian oto di tu sensor 1 den sensor 3
// 			sensor3 = 1'b1;
// 			#144000000; // Thoi gian oto di qua 1 sensor
// 			sensor3 = 0;

// 			// Luot thu 2
// 			#1000000000;
// 			#600000000; // Thoi gian oto di tu sensor 1 den sensor 3
// 			sensor3 = 1'b1;
// 			#144000000; // Thoi gian oto di qua 1 sensor
// 			sensor3 = 0;
            
// 			// Luot thu 3
// 			#5000000000;
// 			#1330000000; // Thoi gian oto di tu sensor 1 den sensor 3
// 			sensor3 = 1'b1;
// 			#616000000; // Thoi gian oto di qua 1 sensor
// 			sensor3 = 0;
            
// 			// Luot thu 4
// 			#6000000000;
// 			#1440000000; // Thoi gian oto di tu sensor 1 den sensor 3
// 			sensor3 = 1'b1;
// 			#1100000000; // Thoi gian oto di qua 1 sensor
// 			sensor3 = 0;

// 			// Luot thu 5
// 			#6300000000;
// 			#1200000000; // Thoi gian oto di tu sensor 1 den sensor 3
// 			sensor3 = 1'b1;
// 			#1440000000; // Thoi gian oto di qua 1 sensor
// 			sensor3 = 0;
       
// 	     	// Luot thu 6
// 			#28940000000;
// 			#1440000000; // Thoi gian oto di tu sensor 1 den sensor 3
// 			sensor3 = 1'b1;
// 			#1100000000; // Thoi gian oto di qua 1 sensor
// 			sensor3 = 0;


// 		end
// 	join

// 	#1200000000;
// 	$finish;
// end
// endmodule
`timescale 1ns/1ns

module top_tb #(
	parameter WIDTH_TIK   = 16,
	parameter WIDTH_MS    =  9,
	parameter WIDTH_SPEED = 14
)();

reg                    clk           ;
reg                    reset_n       ;
reg                    sensor1       ;
reg                    sensor2       ;
reg                    sensor3       ;
reg     [1:0]          valid_Epass   ;
reg                    enable        ;
// wire [WIDTH_SPEED-1:0] speed      ;
// wire                   done       ;
wire                   barrier       ;
wire                   serial_data_out    ;

top  
#(
	.SYS_FREQ(50000000)
) DUT (
	.clk        (clk        ),
	.reset_n    (reset_n    ),
	.sensor1    (sensor1    ),
	.sensor2    (sensor2    ),
	.sensor3    (sensor3    ),
	.valid_Epass(valid_Epass),
	.enable     (enable     ),
	.barrier    (barrier    ),
	.serial_data_out(serial_data_out)
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
			valid_Epass = 2'b00;
			@(negedge clk);
			#10000;
			#(480000000-50000000); // Thoi gian oto di tu sensor 1 den sensor 2
			sensor2 = 1;
			#50000000;
			valid_Epass = 2'b10;
			#144000000; // Thoi gian oto di qua 1 sensor
			sensor2 = 0;
			valid_Epass = 2'b00;

			// Luot thu 2
			#(720000000-50000000);
			#1000000000;
			#240000000;  // Thoi gian oto di tu sensor 1 den sensor 2
			sensor2 = 1;
			#50000000;
			valid_Epass = 2'b10;
			#144000000; // Thoi gian oto di qua 1 sensor
			sensor2 = 0;
			valid_Epass = 2'b00;
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