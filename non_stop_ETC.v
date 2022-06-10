module non_stop_ETC 
#(
	parameter WIDTH_TIK   = 16,
	parameter WIDTH_MS    =  9,
	parameter WIDTH_SPEED = 14
)
(
	input                     clk        ,
	input                     reset_n    ,
	input                     sensor1    ,
	input                     sensor2    ,
	input                     sensor3    ,
	input                     valid_Epass,
	input                     enable     ,
	output  [WIDTH_SPEED-1:0] speed      ,
	output                    done       ,
	output                    barrier    
);


wire [1:0] num_veh    ;
wire       init       ;
wire       count      ;
wire       cal        ;
wire       up         ;
wire       down       ;
wire       en         ;
wire       dis        ;
wire       en_barrier ;


cotroller cotroller_DUT (
	.clk        (clk        ),
	.reset_n    (reset_n    ),
	.sensor1    (sensor1    ),
	.sensor2    (sensor2    ),
	.sensor3    (sensor3    ),
	.valid_Epass(valid_Epass),
	.enable     (enable     ),
	.num_veh    (num_veh    ),
	.done       (done       ),
	.init       (init       ),
	.count      (count      ),
	.cal        (cal        ),
	.up         (up         ),
	.down       (down       ),
	.en         (en         ),
	.dis        (dis        )
);

datapath 
#(
	.WIDTH_TIK   (WIDTH_TIK   ),
	.WIDTH_MS    (WIDTH_MS    ),
	.WIDTH_SPEED (WIDTH_SPEED )
) datapath_DUT (
	.clk        (clk        ),
	.reset_n    (reset_n    ),
	.init       (init       ),
	.count      (count      ),
	.cal        (cal        ),
	.up         (up         ),
	.down       (down       ),
	.en         (en         ),
	.dis        (dis        ),
	.num_veh    (num_veh    ),
	.speed      (speed      ),
	.done       (done       ),
	.en_barrier (en_barrier )
);

assign barrier = enable ? 1'b1 : en_barrier;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                           UART
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

parameter DATA_SIZE       = WIDTH_SPEED,
          SIZE_FIFO       = 8,
          BIT_COUNT_SIZE  = $clog2(DATA_SIZE+3),
          SYS_FREQ        = 50000000,
          BAUD_RATE       = 11500,
          CLOCK           = SYS_FREQ/BAUD_RATE,
          SAMPLE          = 16,
          BAUD_DVSR       = SYS_FREQ/(SAMPLE*BAUD_RATE);


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

uart_fifo #(
  .DATA_SIZE (WIDTH_SPEED),
  .SIZE_FIFO (SIZE_FIFO))
uart_fifo_transmitter(
  .clk     (clk         ),
  .reset_n (reset_n     ),
  .data_in (speed ),
  .data_out(tx_data_in  ),
  .write   (done  ),
  .read    (tx_done     ),
  .full    (tx_full     ),
  .empty   (tx_empty    )
  );


endmodule
