module push_fifo
#(
  parameter WIDTH_TIK       = 16                    ,
  parameter WIDTH_MS        = 14                    ,
  parameter WIDTH_SPEED     = 14                    ,
  parameter DATA_SIZE       = 8                     ,
  parameter SIZE_FIFO       = 8                     ,
  parameter SYS_FREQ        = 10000000              ,
  parameter BAUD_RATE       = 9600                  ,
  parameter SAMPLE          = 16                    ,
  parameter BAUD_DVSR       = SYS_FREQ/(SAMPLE*BAUD_RATE)
)
(
	input clk,    // Clock
	input reset_n,  // Asynchronous reset active low
	output serial_data_out
);



reg [13:0] count;

wire                     clock     ;
wire                     sample_clk;
wire [DATA_SIZE - 1 : 0] tx_data_in;
wire                     tx_done;
wire                     tx_full;
wire                     tx_empty;
wire  [WIDTH_SPEED-1:0] speed  ;
wire                    done   ;


always @(posedge clk or negedge reset_n) begin
	if(~reset_n) begin
		count <= 0;
	end else begin
		count <= count+1;
	end
end

assign speed = (count == 0) ? 14'b10111110011010 : 14'b00000000000000;
assign done  = ((count == 0) & !tx_full ) ? 1'b1 : 1'b0;


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



// -------------------------------------------------------------
// Generator Clock
// -------------------------------------------------------------
uart_generator_clock #(
	.SYS_FREQ(SYS_FREQ),
	.BAUD_RATE(BAUD_RATE),
	// .CLOCK(CLOCK),
	.SAMPLE(SAMPLE),
	.BAUD_DVSR(BAUD_DVSR))
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

endmodule 