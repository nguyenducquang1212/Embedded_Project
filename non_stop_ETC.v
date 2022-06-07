module non_stop_ETC 
#(
	parameter WIDTH_TIK   = 16,
	parameter WIDTH_MS    =  9,
	parameter WIDTH_SPEED = 14
)
(
	input                        clk        ,
	input                        reset_n    ,
	input                        sensor1    ,
	input                        sensor2    ,
	input                        sensor3    ,
	input                        valid_Epass,
	input                        enable     ,
	output reg [WIDTH_SPEED-1:0] speed      ,
	output reg                   done       ,
	output reg                   en_barrier 
);


wire [1:0] num_veh    ;
wire       init       ;
wire       count      ;
wire       cal        ;
wire       up         ;
wire       down       ;
wire       en         ;
wire       dis        ;
wire       num_veh    ;


cotroller cotroller_DUT (
	.clk        (clk        ),
	.reset_n    (reset_n    ),
	.sensor1    (sensor1    ),
	.sensor2    (sensor2    ),
	.sensor3    (sensor3    ),
	.valid_Epass(valid_Epass),
	.enable     (enable     ),
	.num_veh    (num_veh    ),
	.init       (init       ),
	.count      (count      ),
	.cal        (cal        ),
	.up         (up         ),
	.down       (down       ),
	.en         (en         ),
	.dis        (dis        )
);

datapath datapath_DUT
#(
	.WIDTH_TIK   (WIDTH_TIK   ),
	.WIDTH_MS    (WIDTH_MS    ),
	.WIDTH_SPEED (WIDTH_SPEED )
)
(
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

endmodule