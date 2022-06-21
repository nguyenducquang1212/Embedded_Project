module non_stop_ETC 
#(
	parameter WIDTH_TIK   = 16      ,
	parameter WIDTH_MS    = 14      ,
	parameter WIDTH_SPEED = 14      ,
	parameter SYS_FREQ    = 10000000
)
(
	input                     clk            ,
	input                     reset_n        ,
	input                     sensor1        ,
	input                     sensor2        ,
	input                     sensor3        ,
	input        [1:0]        valid_Epass    ,
	input                     enable         ,
	output                    led1           ,	// sensor1
	output                    led2           ,	// sensor2
	output                    led3           ,	// sensor3
	output                    led4           ,	// valid_Epass[1]
	output                    led5           ,	// valid_Epass[0]
	output                    led6           ,	// enable	
	output  [WIDTH_SPEED:0]   done_speed     ,
	output                    barrier    
);

wire [WIDTH_SPEED-1:0] speed;
wire                   done ;

assign done_speed = {done, speed};

assign led1 = sensor1;
assign led2 = sensor2;
assign led3 = sensor3;
assign led4 = valid_Epass[1];
assign led5 = valid_Epass[0];
assign led6 = enable;

// wire [1:0] num_veh    ;
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
	// .num_veh    (num_veh    ),
	.done       (done       ),
	.init       (init       ),
	.count      (count      ),
	.cal        (cal        ),
	.up         (up         ),
	.down       (down       ),
	.en         (en         ),
	.dis        (dis        )
);

datapath #(
	.WIDTH_TIK   (WIDTH_TIK   ),
	.WIDTH_MS    (WIDTH_MS    ),
	.WIDTH_SPEED (WIDTH_SPEED ),
	.SYS_FREQ    (SYS_FREQ    )
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
	// .num_veh    (num_veh    ),
	.speed      (speed      ),
	.done       (done       ),
	.en_barrier (en_barrier )
);

assign barrier = enable ? 1'b1 : en_barrier;


endmodule
