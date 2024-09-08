module testbench;

logic clk100 = 0;
logic gt_refclk_p = 0;
logic gt_refclk_n;

logic [7:0] aurora_reset_counter = 0;
logic aresetn = 0;
logic aurora_reset = 1;

logic aurora_master_gt_rx_n;
logic aurora_master_gt_rx_p;
logic aurora_slave_gt_rx_n;
logic aurora_slave_gt_rx_p;

logic aurora0_gt_rx_n;
logic aurora0_gt_rx_p;
logic aurora1_gt_rx_n;
logic aurora1_gt_rx_p;

logic [31:0] gpio;
logic axi_c2c_link_status_out_master;
logic axi_c2c_link_status_out_slave;
logic axi_c2c_multi_bit_error_out_master;
logic axi_c2c_multi_bit_error_out_slave;
logic channel_up_master;
logic channel_up_slave;
logic lane_up_master;
logic lane_up_slave;
logic axi_c2c_link_status_out_0;
logic axi_c2c_link_status_out_1;
logic axi_c2c_multi_bit_error_out_0;
logic axi_c2c_multi_bit_error_out_1;
logic channel_up_0;
logic channel_up_1;
logic lane_up_0;
logic lane_up_1;

logic aurora0_clk;
logic [63:0] aurora0_axis_rx_tdata;
logic aurora0_axis_rx_tvalid;
logic [63:0] chip2chip0_axis_rx_tdata;
logic chip2chip0_axis_rx_tvalid;
logic [63:0] aurora0_axis_tx_tdata;
logic aurora0_axis_tx_tready;
logic aurora0_axis_tx_tvalid;
logic [63:0] chip2chip0_axis_tx_tdata;
logic chip2chip0_axis_tx_tready;
logic chip2chip0_axis_tx_tvalid;

logic aurora1_clk;
logic [63:0] aurora1_axis_rx_tdata;
logic aurora1_axis_rx_tvalid;
logic [63:0] chip2chip1_axis_rx_tdata;
logic chip2chip1_axis_rx_tvalid;
logic [63:0] aurora1_axis_tx_tdata;
logic aurora1_axis_tx_tready;
logic aurora1_axis_tx_tvalid;
logic [63:0] chip2chip1_axis_tx_tdata;
logic chip2chip1_axis_tx_tready;
logic chip2chip1_axis_tx_tvalid;

always
begin
  #5ns clk100 = ~clk100;
end

always
begin
  #3.2ns gt_refclk_p = ~gt_refclk_p;
end
assign gt_refclk_n = ~gt_refclk_p;

always @ (posedge clk100)
begin
  aurora_reset_counter <= aurora_reset_counter + 1;
  if (aurora_reset_counter == 8'h80)
    begin
      aurora_reset <= 0;
      aresetn <= 1;
    end
end

block_design_wrapper bd (
  .GPIO_0_tri_o                       (gpio),
  .GT_REFCLK_MASTER_clk_n             (gt_refclk_n),
  .GT_REFCLK_MASTER_clk_p             (gt_refclk_p),
  .GT_REFCLK_SLAVE_clk_n              (gt_refclk_n),
  .GT_REFCLK_SLAVE_clk_p              (gt_refclk_p),
  .GT_RX_MASTER_rxn                   (aurora_master_gt_rx_n),
  .GT_RX_MASTER_rxp                   (aurora_master_gt_rx_p),
  .GT_RX_SLAVE_rxn                    (aurora_slave_gt_rx_n),
  .GT_RX_SLAVE_rxp                    (aurora_slave_gt_rx_p),
  .GT_TX_MASTER_txn                   (aurora_slave_gt_rx_n),
  .GT_TX_MASTER_txp                   (aurora_slave_gt_rx_p),
  .GT_TX_SLAVE_txn                    (aurora_master_gt_rx_n),
  .GT_TX_SLAVE_txp                    (aurora_master_gt_rx_p),
  .GT_REFCLK_0_clk_n                  (gt_refclk_n),
  .GT_REFCLK_0_clk_p                  (gt_refclk_p),
  .GT_REFCLK_1_clk_n                  (gt_refclk_n),
  .GT_REFCLK_1_clk_p                  (gt_refclk_p),
  .GT_RX_0_rxn                        (aurora0_gt_rx_n),
  .GT_RX_0_rxp                        (aurora0_gt_rx_p),
  .GT_RX_1_rxn                        (aurora1_gt_rx_n),
  .GT_RX_1_rxp                        (aurora1_gt_rx_p),
  .GT_TX_0_txn                        (aurora1_gt_rx_n),
  .GT_TX_0_txp                        (aurora1_gt_rx_p),
  .GT_TX_1_txn                        (aurora0_gt_rx_n),
  .GT_TX_1_txp                        (aurora0_gt_rx_p),
  .aclk                               (clk100),
  .aresetn                            (aresetn),
  .aurora_reset                       (aurora_reset),
  .axi_c2c_link_status_out_master     (axi_c2c_link_status_out_master),
  .axi_c2c_link_status_out_slave      (axi_c2c_link_status_out_slave),
  .axi_c2c_multi_bit_error_out_master (axi_c2c_multi_bit_error_out_master),
  .axi_c2c_multi_bit_error_out_slave  (axi_c2c_multi_bit_error_out_slave),
  .channel_up_master                  (channel_up_master),
  .channel_up_slave                   (channel_up_slave),
  .lane_up_master                     (lane_up_master),
  .lane_up_slave                      (lane_up_slave),
  .axi_c2c_link_status_out_0          (axi_c2c_link_status_out_0),
  .axi_c2c_link_status_out_1          (axi_c2c_link_status_out_1),
  .axi_c2c_multi_bit_error_out_0      (axi_c2c_multi_bit_error_out_0),
  .axi_c2c_multi_bit_error_out_1      (axi_c2c_multi_bit_error_out_1),
  .channel_up_0                       (channel_up_0),
  .channel_up_1                       (channel_up_1),
  .lane_up_0                          (lane_up_0),
  .lane_up_1                          (lane_up_1),
  .AURORA0_AXIS_RX_tdata              (aurora0_axis_rx_tdata),
  .AURORA0_AXIS_RX_tvalid             (aurora0_axis_rx_tvalid),
  .AURORA0_AXIS_TX_tdata              (aurora0_axis_tx_tdata),
  .AURORA0_AXIS_TX_tready             (aurora0_axis_tx_tready),
  .AURORA0_AXIS_TX_tvalid             (aurora0_axis_tx_tvalid),
  .AURORA0_CLK                        (aurora0_clk),
  .CHIP2CHIP0_AXIS_RX_tdata           (chip2chip0_axis_rx_tdata),
  .CHIP2CHIP0_AXIS_RX_tvalid          (chip2chip0_axis_rx_tvalid),
  .CHIP2CHIP0_AXIS_TX_tdata           (chip2chip0_axis_tx_tdata),
  .CHIP2CHIP0_AXIS_TX_tready          (chip2chip0_axis_tx_tready),
  .CHIP2CHIP0_AXIS_TX_tvalid          (chip2chip0_axis_tx_tvalid),
  .AURORA1_AXIS_RX_tdata              (aurora1_axis_rx_tdata),
  .AURORA1_AXIS_RX_tvalid             (aurora1_axis_rx_tvalid),
  .AURORA1_AXIS_TX_tdata              (aurora1_axis_tx_tdata),
  .AURORA1_AXIS_TX_tready             (aurora1_axis_tx_tready),
  .AURORA1_AXIS_TX_tvalid             (aurora1_axis_tx_tvalid),
  .AURORA1_CLK                        (aurora1_clk),
  .CHIP2CHIP1_AXIS_RX_tdata           (chip2chip1_axis_rx_tdata),
  .CHIP2CHIP1_AXIS_RX_tvalid          (chip2chip1_axis_rx_tvalid),
  .CHIP2CHIP1_AXIS_TX_tdata           (chip2chip1_axis_tx_tdata),
  .CHIP2CHIP1_AXIS_TX_tready          (chip2chip1_axis_tx_tready),
  .CHIP2CHIP1_AXIS_TX_tvalid          (chip2chip1_axis_tx_tvalid)
);

assign aurora0_axis_tx_tdata = chip2chip0_axis_tx_tdata;
assign aurora0_axis_tx_tvalid = chip2chip0_axis_tx_tvalid;
assign chip2chip0_axis_tx_tready = aurora0_axis_tx_tready;

always @ (posedge aurora0_clk)
begin
  chip2chip0_axis_rx_tdata <= aurora0_axis_rx_tdata;
  chip2chip0_axis_rx_tvalid <= aurora0_axis_rx_tvalid;
  if (aurora0_axis_rx_tdata[63:56] == 8'h1B)
    begin
      chip2chip0_axis_rx_tdata[1] <= ~aurora0_axis_rx_tdata[1];
      chip2chip0_axis_rx_tdata[0] <= ~aurora0_axis_rx_tdata[0];
    end
end

assign aurora1_axis_tx_tdata = chip2chip1_axis_tx_tdata;
assign aurora1_axis_tx_tvalid = chip2chip1_axis_tx_tvalid;
assign chip2chip1_axis_tx_tready = aurora1_axis_tx_tready;

always @ (posedge aurora1_clk)
begin
  chip2chip1_axis_rx_tdata <= aurora1_axis_rx_tdata;
  chip2chip1_axis_rx_tvalid <= aurora1_axis_rx_tvalid;
  if (aurora1_axis_rx_tdata[63:56] == 8'h2D)
    chip2chip1_axis_rx_tdata[0] <= ~aurora1_axis_rx_tdata[0];
  if (aurora1_axis_rx_tdata[63:56] == 8'hA7)
    begin
      chip2chip1_axis_rx_tdata[1] <= ~aurora1_axis_rx_tdata[1];
      chip2chip1_axis_rx_tdata[0] <= ~aurora1_axis_rx_tdata[0];
    end
end

import block_design_axi_vip_0_0_pkg::*;
import axi_vip_pkg::*;

initial
begin
  block_design_axi_vip_0_0_mst_t axi_vip_master;
  logic resp;
  logic [31:0] data;

  axi_vip_master = new("VIP agent", bd.block_design_i.axi_vip_0.inst.IF);
  axi_vip_master.start_master();

  //Wait for Aurora and AXI Chip2Chip initialization
  #700us
  
  //Aurora1 -> Chip2Chip1 single bit error
  axi_vip_master.AXI4LITE_WRITE_BURST(32'h0, 0, 32'hABCDABCD, resp);  	  //AXI GPIO
  #10us

  //Aurora1 -> Chip2Chip1 double bit error
  axi_vip_master.AXI4LITE_WRITE_BURST(32'h1034, 0, 32'hBB8, resp);		  //AXI Firewall MAX_WRITE_TO_BVALID_WAITS
  axi_vip_master.AXI4LITE_WRITE_BURST(32'h0, 0, 32'h12345678, resp);	  //AXI GPIO
  aresetn = 0;
  #1us
  aresetn = 1;
  #10us

  //Aurora0 -> Chip2Chip0 double bit error
  axi_vip_master.AXI4LITE_WRITE_BURST(32'h1030, 0, 32'hBB8, resp);		  //AXI Firewall MAX_CONTINUOUS_RTRANSFERS_WAITS
  axi_vip_master.AXI4LITE_WRITE_BURST(32'h0, 0, 32'h87654321, resp);	  //AXI GPIO
  axi_vip_master.AXI4LITE_READ_BURST(32'h0, 0, data, resp); 			  //AXI GPIO
  aresetn = 0;
  #1us
  aresetn = 1;
end

endmodule
