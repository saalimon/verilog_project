module reset_generator(
	input clock,		// system clock
	input reset_in_n,	// active low reset input from push button
	output reset_out	// active high reset signal assert asynchronously but deassert synchronously to clock
	);

	wire ff2_d, ff3_d;

	FDPE ff1 (				// DFF primitive initializes to high on power up
		.Q(ff2_d),
		.C(clock),
		.CE(1'b1),
		.PRE(~reset_in_n),
		.D(1'b0)			// tie d to 0 to propagate 0 to reset_out after 3 clocks
	);
	
	FDPE ff2 (
		.Q(ff3_d),
		.C(clock),
		.CE(1'b1),
		.PRE(~reset_in_n),
		.D(ff2_d)
	);
	
	FDPE ff3 (
		.Q(reset_out),
		.C(clock),
		.CE(1'b1),
		.PRE(~reset_in_n),
		.D(ff3_d)
	);

endmodule
