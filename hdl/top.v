module top 
#(
  parameter WIDTH_TIK       = 16                ,
  parameter WIDTH_MS        = 9                 ,
  parameter WIDTH_SPEED     = 14                ,
  parameter DATA_SIZE       = 8                 ,
  parameter SIZE_FIFO       = 8                 ,
  parameter SYS_FREQ        = 50000000          ,
  parameter BAUD_RATE       = 11500             ,
  parameter CLOCK           = SYS_FREQ/BAUD_RATE,
  parameter SAMPLE          = 16                ,
  parameter BAUD_DVSR       = SYS_FREQ/(SAMPLE*BAUD_RATE)
)
(
	input                     clk            ,
	input                     reset_n        ,
	input                     sensor1        ,
	input                     sensor2        ,
	input                     sensor3        ,
	input        [1:0]        valid_Epass    ,
	input                     enable         ,
	output                    led1           ,
	output                    led2           ,
	output                    led3           ,
	output                    barrier        ,
	output                    serial_data_out
);

assign led1 = sensor1;
assign led2 = sensor2;
assign led3 = sensor3;

// -------------------------------------------------------------
//                non_stop_ETC
// -------------------------------------------------------------
wire  [WIDTH_SPEED-1:0] speed  ;
wire                    done   ;

non_stop_ETC #(
	.WIDTH_TIK  (WIDTH_TIK  ),
	.WIDTH_MS   (WIDTH_MS   ),
	.WIDTH_SPEED(WIDTH_SPEED)
) non_stop_ETC (
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


// -------------------------------------------------------------
//                push data into fifo
// -------------------------------------------------------------
wire [DATA_SIZE-1:0]   data ;
wire                   write;
push_data push_data_DUT(
	.clk    (clk     ), 
	.reset_n(reset_n ), 
	.done   (done    ), 
	.speed  (speed   ), 
	.write  (write   ), 
	.data   (data    )
);


// -------------------------------------------------------------
//                UART
// -------------------------------------------------------------


wire                     clock     ;
wire                     sample_clk;
wire [DATA_SIZE - 1 : 0] tx_data_in;
wire                     tx_done;
wire                     tx_full;
wire                     tx_empty;


// -------------------------------------------------------------
// Generator Clock
// -------------------------------------------------------------
uart_generator_clock #(SYS_FREQ,BAUD_RATE,CLOCK,SAMPLE,BAUD_DVSR)
uart_generator_clock (
  .clk       (clk       ),
  .reset_n   (reset_n   ),
  .clock     (clock     ),
  .sample_clk(sample_clk)
  );

uart_fifo #(
  .DATA_SIZE (DATA_SIZE),
  .SIZE_FIFO (SIZE_FIFO))
uart_fifo_transmitter(
  .clk     (clk          ),
  .reset_n (reset_n      ),
  .data_in (data         ),
  .data_out(tx_data_in   ),
  .write   (write),
  .read    (tx_done      ),
  .full    (tx_full      ),
  .empty   (tx_empty     )
  );


uart_transmitter #(
  .DATA_SIZE (DATA_SIZE))
uart_transmitter(
  .clk            (clock          ),
  .reset_n        (reset_n        ),
  .tx_start_n     (tx_empty     ),
  .data_in        (tx_data_in     ),
  .serial_data_out(serial_data_out),
  .tx_done        (tx_done        )
  );


endmodule : top