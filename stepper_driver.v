module stepper_driver(
input wire step,
input wire [1:0] step_mode,
input wire enable,
input wire direction,
output wire [3:0] coils
);

// Step pulse input (used as a clock)
// "00": full step, "01": half step, "10": wave drive


// A 3-bit state counter. (Half–step mode uses all 8 states.)
reg [2:0] state = 1'b0;
reg [3:0] coil_state;

  assign coils = coil_state;
  // State update process: on each rising edge of 'step' (when enable is high)
  always @(posedge step) begin : P2
    reg [2:0] step_inc;

    if(enable == 1'b0) begin
      state <= {3{1'b0}};
    end else begin
      case(step_mode)
      2'b01 : begin
        // Half–step: advance one phase (0..7)
        step_inc = 1;
      end
      2'b00 : begin
        // Full Step: advance two phases on odd numbers, i.e. 1,3,5,7
        if((state == 3'b000) || (state == 3'b010) || (state == 3'b100) || (state == 3'b110)) begin
          step_inc = 3'b001;
        end
        else begin
          step_inc = 3'b010;
        end
      end
      2'b10 : begin
        // Wave drive: advance two phases on even numbers, i.e. 0,2,4,6
        if((state == 3'b000) || (state == 3'b010) || (state == 3'b100) || (state == 3'b110)) begin
          step_inc = 3'b010;
        end
        else begin
          step_inc = 3'b001;
        end
      end
      default : begin
        step_inc = 3'b000;
      end
      endcase
      if(direction == 1'b1) begin
        state <= state + step_inc;
      end
      else begin
        state <= state - step_inc;
      end
    end
  end

  // Combinational process to generate the proper coil outputs
  always @(enable, state) begin : P1
    reg [31:0] idx;

    if((enable == 1'b1)) begin
      case(state)
      3'b000 : begin
        coil_state <= 4'b1000;
      end
      3'b001 : begin
        coil_state <= 4'b1100;
      end
      3'b010 : begin
        coil_state <= 4'b0100;
      end
      3'b011 : begin
        coil_state <= 4'b0110;
      end
      3'b100 : begin
        coil_state <= 4'b0010;
      end
      3'b101 : begin
        coil_state <= 4'b0011;
      end
      3'b110 : begin
        coil_state <= 4'b0001;
      end
      3'b111 : begin
        coil_state <= 4'b1001;
      end
      default : begin
        coil_state <= 4'b0000;
      end
      endcase
    end
    else begin
      coil_state <= 4'b0000;
    end
  end

endmodule
