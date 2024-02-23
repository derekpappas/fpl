#include "v_top.h"

namespace NSCsimGen {

void v_top::defaultInitialize() {
  setInstanceName(RefString(new std::string("v_top")));
  //port allocations
  uart1_rx = CsimPortTBool::build(RefString(new std::string("uart1_rx")),1, getThis(), PORT_DIR_INPUT);
  uart1_tx = CsimPortTBool::build(RefString(new std::string("uart1_tx")),1, getThis(), PORT_DIR_OUTPUT);
  uart1_gp0_in = CsimPortTBool::build(RefString(new std::string("uart1_gp0_in")),1, getThis(), PORT_DIR_INPUT);
  uart1_gp0_out = CsimPortTBool::build(RefString(new std::string("uart1_gp0_out")),1, getThis(), PORT_DIR_OUTPUT);
  uart1_gp0_en = CsimPortTBool::build(RefString(new std::string("uart1_gp0_en")),1, getThis(), PORT_DIR_OUTPUT);
  uart1_gp1_in = CsimPortTBool::build(RefString(new std::string("uart1_gp1_in")),1, getThis(), PORT_DIR_INPUT);
  uart1_gp1_out = CsimPortTBool::build(RefString(new std::string("uart1_gp1_out")),1, getThis(), PORT_DIR_OUTPUT);
  uart1_gp1_en = CsimPortTBool::build(RefString(new std::string("uart1_gp1_en")),1, getThis(), PORT_DIR_OUTPUT);
  uart1_gp2_in = CsimPortTBool::build(RefString(new std::string("uart1_gp2_in")),1, getThis(), PORT_DIR_INPUT);
  uart1_gp2_out = CsimPortTBool::build(RefString(new std::string("uart1_gp2_out")),1, getThis(), PORT_DIR_OUTPUT);
  uart1_gp2_en = CsimPortTBool::build(RefString(new std::string("uart1_gp2_en")),1, getThis(), PORT_DIR_OUTPUT);
  uart1_gp3_in = CsimPortTBool::build(RefString(new std::string("uart1_gp3_in")),1, getThis(), PORT_DIR_INPUT);
  uart1_gp3_out = CsimPortTBool::build(RefString(new std::string("uart1_gp3_out")),1, getThis(), PORT_DIR_OUTPUT);
  uart1_gp3_en = CsimPortTBool::build(RefString(new std::string("uart1_gp3_en")),1, getThis(), PORT_DIR_OUTPUT);
  uart1_gp4_in = CsimPortTBool::build(RefString(new std::string("uart1_gp4_in")),1, getThis(), PORT_DIR_INPUT);
  uart1_gp4_out = CsimPortTBool::build(RefString(new std::string("uart1_gp4_out")),1, getThis(), PORT_DIR_OUTPUT);
  uart1_gp4_en = CsimPortTBool::build(RefString(new std::string("uart1_gp4_en")),1, getThis(), PORT_DIR_OUTPUT);
  uart1_gp5_in = CsimPortTBool::build(RefString(new std::string("uart1_gp5_in")),1, getThis(), PORT_DIR_INPUT);
  uart1_gp5_out = CsimPortTBool::build(RefString(new std::string("uart1_gp5_out")),1, getThis(), PORT_DIR_OUTPUT);
  uart1_gp5_en = CsimPortTBool::build(RefString(new std::string("uart1_gp5_en")),1, getThis(), PORT_DIR_OUTPUT);
  uart2_rx = CsimPortTBool::build(RefString(new std::string("uart2_rx")),1, getThis(), PORT_DIR_INPUT);
  uart2_tx = CsimPortTBool::build(RefString(new std::string("uart2_tx")),1, getThis(), PORT_DIR_OUTPUT);
  uart2_gp0_in = CsimPortTBool::build(RefString(new std::string("uart2_gp0_in")),1, getThis(), PORT_DIR_INPUT);
  uart2_gp0_out = CsimPortTBool::build(RefString(new std::string("uart2_gp0_out")),1, getThis(), PORT_DIR_OUTPUT);
  uart2_gp0_en = CsimPortTBool::build(RefString(new std::string("uart2_gp0_en")),1, getThis(), PORT_DIR_OUTPUT);
  uart2_gp1_in = CsimPortTBool::build(RefString(new std::string("uart2_gp1_in")),1, getThis(), PORT_DIR_INPUT);
  uart2_gp1_out = CsimPortTBool::build(RefString(new std::string("uart2_gp1_out")),1, getThis(), PORT_DIR_OUTPUT);
  uart2_gp1_en = CsimPortTBool::build(RefString(new std::string("uart2_gp1_en")),1, getThis(), PORT_DIR_OUTPUT);
  uart2_gp2_in = CsimPortTBool::build(RefString(new std::string("uart2_gp2_in")),1, getThis(), PORT_DIR_INPUT);
  uart2_gp2_out = CsimPortTBool::build(RefString(new std::string("uart2_gp2_out")),1, getThis(), PORT_DIR_OUTPUT);
  uart2_gp2_en = CsimPortTBool::build(RefString(new std::string("uart2_gp2_en")),1, getThis(), PORT_DIR_OUTPUT);
  uart2_gp3_in = CsimPortTBool::build(RefString(new std::string("uart2_gp3_in")),1, getThis(), PORT_DIR_INPUT);
  uart2_gp3_out = CsimPortTBool::build(RefString(new std::string("uart2_gp3_out")),1, getThis(), PORT_DIR_OUTPUT);
  uart2_gp3_en = CsimPortTBool::build(RefString(new std::string("uart2_gp3_en")),1, getThis(), PORT_DIR_OUTPUT);
  uart2_gp4_in = CsimPortTBool::build(RefString(new std::string("uart2_gp4_in")),1, getThis(), PORT_DIR_INPUT);
  uart2_gp4_out = CsimPortTBool::build(RefString(new std::string("uart2_gp4_out")),1, getThis(), PORT_DIR_OUTPUT);
  uart2_gp4_en = CsimPortTBool::build(RefString(new std::string("uart2_gp4_en")),1, getThis(), PORT_DIR_OUTPUT);
  uart2_gp5_in = CsimPortTBool::build(RefString(new std::string("uart2_gp5_in")),1, getThis(), PORT_DIR_INPUT);
  uart2_gp5_out = CsimPortTBool::build(RefString(new std::string("uart2_gp5_out")),1, getThis(), PORT_DIR_OUTPUT);
  uart2_gp5_en = CsimPortTBool::build(RefString(new std::string("uart2_gp5_en")),1, getThis(), PORT_DIR_OUTPUT);
  uart3_rx = CsimPortTBool::build(RefString(new std::string("uart3_rx")),1, getThis(), PORT_DIR_INPUT);
  uart3_tx = CsimPortTBool::build(RefString(new std::string("uart3_tx")),1, getThis(), PORT_DIR_OUTPUT);
  uart3_gp0_in = CsimPortTBool::build(RefString(new std::string("uart3_gp0_in")),1, getThis(), PORT_DIR_INPUT);
  uart3_gp0_out = CsimPortTBool::build(RefString(new std::string("uart3_gp0_out")),1, getThis(), PORT_DIR_OUTPUT);
  uart3_gp0_en = CsimPortTBool::build(RefString(new std::string("uart3_gp0_en")),1, getThis(), PORT_DIR_OUTPUT);
  uart3_gp1_in = CsimPortTBool::build(RefString(new std::string("uart3_gp1_in")),1, getThis(), PORT_DIR_INPUT);
  uart3_gp1_out = CsimPortTBool::build(RefString(new std::string("uart3_gp1_out")),1, getThis(), PORT_DIR_OUTPUT);
  uart3_gp1_en = CsimPortTBool::build(RefString(new std::string("uart3_gp1_en")),1, getThis(), PORT_DIR_OUTPUT);
  uart3_gp2_in = CsimPortTBool::build(RefString(new std::string("uart3_gp2_in")),1, getThis(), PORT_DIR_INPUT);
  uart3_gp2_out = CsimPortTBool::build(RefString(new std::string("uart3_gp2_out")),1, getThis(), PORT_DIR_OUTPUT);
  uart3_gp2_en = CsimPortTBool::build(RefString(new std::string("uart3_gp2_en")),1, getThis(), PORT_DIR_OUTPUT);
  uart3_gp3_in = CsimPortTBool::build(RefString(new std::string("uart3_gp3_in")),1, getThis(), PORT_DIR_INPUT);
  uart3_gp3_out = CsimPortTBool::build(RefString(new std::string("uart3_gp3_out")),1, getThis(), PORT_DIR_OUTPUT);
  uart3_gp3_en = CsimPortTBool::build(RefString(new std::string("uart3_gp3_en")),1, getThis(), PORT_DIR_OUTPUT);
  uart3_gp4_in = CsimPortTBool::build(RefString(new std::string("uart3_gp4_in")),1, getThis(), PORT_DIR_INPUT);
  uart3_gp4_out = CsimPortTBool::build(RefString(new std::string("uart3_gp4_out")),1, getThis(), PORT_DIR_OUTPUT);
  uart3_gp4_en = CsimPortTBool::build(RefString(new std::string("uart3_gp4_en")),1, getThis(), PORT_DIR_OUTPUT);
  uart3_gp5_in = CsimPortTBool::build(RefString(new std::string("uart3_gp5_in")),1, getThis(), PORT_DIR_INPUT);
  uart3_gp5_out = CsimPortTBool::build(RefString(new std::string("uart3_gp5_out")),1, getThis(), PORT_DIR_OUTPUT);
  uart3_gp5_en = CsimPortTBool::build(RefString(new std::string("uart3_gp5_en")),1, getThis(), PORT_DIR_OUTPUT);
  usb_rpu1_en = CsimPortTBool::build(RefString(new std::string("usb_rpu1_en")),1, getThis(), PORT_DIR_INPUT);
  usb_rpu2_en = CsimPortTBool::build(RefString(new std::string("usb_rpu2_en")),1, getThis(), PORT_DIR_INPUT);
  usb_data_in = CsimPortTBool::build(RefString(new std::string("usb_data_in")),1, getThis(), PORT_DIR_INPUT);
  usb_force_se0 = CsimPortTBool::build(RefString(new std::string("usb_force_se0")),1, getThis(), PORT_DIR_INPUT);
  usb_drv_enable = CsimPortTBool::build(RefString(new std::string("usb_drv_enable")),1, getThis(), PORT_DIR_INPUT);
  usb_suspend = CsimPortTBool::build(RefString(new std::string("usb_suspend")),1, getThis(), PORT_DIR_INPUT);
  usb_se_dp = CsimPortTBool::build(RefString(new std::string("usb_se_dp")),1, getThis(), PORT_DIR_OUTPUT);
  usb_enable_se = CsimPortTBool::build(RefString(new std::string("usb_enable_se")),1, getThis(), PORT_DIR_OUTPUT);
  usb_se_dn = CsimPortTBool::build(RefString(new std::string("usb_se_dn")),1, getThis(), PORT_DIR_OUTPUT);
  usb_data_out = CsimPortTBool::build(RefString(new std::string("usb_data_out")),1, getThis(), PORT_DIR_OUTPUT);
  usb_strobe = CsimPortTBool::build(RefString(new std::string("usb_strobe")),1, getThis(), PORT_DIR_OUTPUT);
  usb_enable_diff = CsimPortTBool::build(RefString(new std::string("usb_enable_diff")),1, getThis(), PORT_DIR_INPUT);
  gpio_a0 = CsimPortTBool::build(RefString(new std::string("gpio_a0")),1, getThis(), PORT_DIR_INOUT);
  gpio_a1 = CsimPortTBool::build(RefString(new std::string("gpio_a1")),1, getThis(), PORT_DIR_INOUT);
  gpio_a2 = CsimPortTBool::build(RefString(new std::string("gpio_a2")),1, getThis(), PORT_DIR_INOUT);
  gpio_a3 = CsimPortTBool::build(RefString(new std::string("gpio_a3")),1, getThis(), PORT_DIR_INOUT);
  gpio_a4 = CsimPortTBool::build(RefString(new std::string("gpio_a4")),1, getThis(), PORT_DIR_INOUT);
  gpio_a5 = CsimPortTBool::build(RefString(new std::string("gpio_a5")),1, getThis(), PORT_DIR_INOUT);
  //port registrations
  addConnectable(uart1_rx);
  addConnectable(uart1_tx);
  addConnectable(uart1_gp0_in);
  addConnectable(uart1_gp0_out);
  addConnectable(uart1_gp0_en);
  addConnectable(uart1_gp1_in);
  addConnectable(uart1_gp1_out);
  addConnectable(uart1_gp1_en);
  addConnectable(uart1_gp2_in);
  addConnectable(uart1_gp2_out);
  addConnectable(uart1_gp2_en);
  addConnectable(uart1_gp3_in);
  addConnectable(uart1_gp3_out);
  addConnectable(uart1_gp3_en);
  addConnectable(uart1_gp4_in);
  addConnectable(uart1_gp4_out);
  addConnectable(uart1_gp4_en);
  addConnectable(uart1_gp5_in);
  addConnectable(uart1_gp5_out);
  addConnectable(uart1_gp5_en);
  addConnectable(uart2_rx);
  addConnectable(uart2_tx);
  addConnectable(uart2_gp0_in);
  addConnectable(uart2_gp0_out);
  addConnectable(uart2_gp0_en);
  addConnectable(uart2_gp1_in);
  addConnectable(uart2_gp1_out);
  addConnectable(uart2_gp1_en);
  addConnectable(uart2_gp2_in);
  addConnectable(uart2_gp2_out);
  addConnectable(uart2_gp2_en);
  addConnectable(uart2_gp3_in);
  addConnectable(uart2_gp3_out);
  addConnectable(uart2_gp3_en);
  addConnectable(uart2_gp4_in);
  addConnectable(uart2_gp4_out);
  addConnectable(uart2_gp4_en);
  addConnectable(uart2_gp5_in);
  addConnectable(uart2_gp5_out);
  addConnectable(uart2_gp5_en);
  addConnectable(uart3_rx);
  addConnectable(uart3_tx);
  addConnectable(uart3_gp0_in);
  addConnectable(uart3_gp0_out);
  addConnectable(uart3_gp0_en);
  addConnectable(uart3_gp1_in);
  addConnectable(uart3_gp1_out);
  addConnectable(uart3_gp1_en);
  addConnectable(uart3_gp2_in);
  addConnectable(uart3_gp2_out);
  addConnectable(uart3_gp2_en);
  addConnectable(uart3_gp3_in);
  addConnectable(uart3_gp3_out);
  addConnectable(uart3_gp3_en);
  addConnectable(uart3_gp4_in);
  addConnectable(uart3_gp4_out);
  addConnectable(uart3_gp4_en);
  addConnectable(uart3_gp5_in);
  addConnectable(uart3_gp5_out);
  addConnectable(uart3_gp5_en);
  addConnectable(usb_rpu1_en);
  addConnectable(usb_rpu2_en);
  addConnectable(usb_data_in);
  addConnectable(usb_force_se0);
  addConnectable(usb_drv_enable);
  addConnectable(usb_suspend);
  addConnectable(usb_se_dp);
  addConnectable(usb_enable_se);
  addConnectable(usb_se_dn);
  addConnectable(usb_data_out);
  addConnectable(usb_strobe);
  addConnectable(usb_enable_diff);
  addConnectable(gpio_a0);
  addConnectable(gpio_a1);
  addConnectable(gpio_a2);
  addConnectable(gpio_a3);
  addConnectable(gpio_a4);
  addConnectable(gpio_a5);
  //signal allocations
  gpio_connect_a0_in = CsimSignalTBool::build(RefString(new std::string("gpio_connect_a0_in")),1, getThis());
  gpio_connect_a0_out = CsimSignalTBool::build(RefString(new std::string("gpio_connect_a0_out")),1, getThis());
  gpio_connect_a0_en = CsimSignalTBool::build(RefString(new std::string("gpio_connect_a0_en")),1, getThis());
  gpio_connect_a1_in = CsimSignalTBool::build(RefString(new std::string("gpio_connect_a1_in")),1, getThis());
  gpio_connect_a1_out = CsimSignalTBool::build(RefString(new std::string("gpio_connect_a1_out")),1, getThis());
  gpio_connect_a1_en = CsimSignalTBool::build(RefString(new std::string("gpio_connect_a1_en")),1, getThis());
  gpio_connect_a2_in = CsimSignalTBool::build(RefString(new std::string("gpio_connect_a2_in")),1, getThis());
  gpio_connect_a2_out = CsimSignalTBool::build(RefString(new std::string("gpio_connect_a2_out")),1, getThis());
  gpio_connect_a2_en = CsimSignalTBool::build(RefString(new std::string("gpio_connect_a2_en")),1, getThis());
  gpio_connect_a3_in = CsimSignalTBool::build(RefString(new std::string("gpio_connect_a3_in")),1, getThis());
  gpio_connect_a3_out = CsimSignalTBool::build(RefString(new std::string("gpio_connect_a3_out")),1, getThis());
  gpio_connect_a3_en = CsimSignalTBool::build(RefString(new std::string("gpio_connect_a3_en")),1, getThis());
  gpio_connect_a4_in = CsimSignalTBool::build(RefString(new std::string("gpio_connect_a4_in")),1, getThis());
  gpio_connect_a4_out = CsimSignalTBool::build(RefString(new std::string("gpio_connect_a4_out")),1, getThis());
  gpio_connect_a4_en = CsimSignalTBool::build(RefString(new std::string("gpio_connect_a4_en")),1, getThis());
  gpio_connect_a5_in = CsimSignalTBool::build(RefString(new std::string("gpio_connect_a5_in")),1, getThis());
  gpio_connect_a5_out = CsimSignalTBool::build(RefString(new std::string("gpio_connect_a5_out")),1, getThis());
  gpio_connect_a5_en = CsimSignalTBool::build(RefString(new std::string("gpio_connect_a5_en")),1, getThis());
  //signal registrations
  addConnectable(gpio_connect_a0_in);
  addConnectable(gpio_connect_a0_out);
  addConnectable(gpio_connect_a0_en);
  addConnectable(gpio_connect_a1_in);
  addConnectable(gpio_connect_a1_out);
  addConnectable(gpio_connect_a1_en);
  addConnectable(gpio_connect_a2_in);
  addConnectable(gpio_connect_a2_out);
  addConnectable(gpio_connect_a2_en);
  addConnectable(gpio_connect_a3_in);
  addConnectable(gpio_connect_a3_out);
  addConnectable(gpio_connect_a3_en);
  addConnectable(gpio_connect_a4_in);
  addConnectable(gpio_connect_a4_out);
  addConnectable(gpio_connect_a4_en);
  addConnectable(gpio_connect_a5_in);
  addConnectable(gpio_connect_a5_out);
  addConnectable(gpio_connect_a5_en);
  //building vector writers
  //initializers
  allocate();
  //instance registration
  v_core->setParent(getThis());
  v_core->setInstanceName(RefString(new std::string("v_core")));
  rx_mod_0->setParent(getThis());
  rx_mod_0->setInstanceName(RefString(new std::string("rx_mod_0")));
  tx_mod_0->setParent(getThis());
  tx_mod_0->setInstanceName(RefString(new std::string("tx_mod_0")));
  gpio_mod_a0->setParent(getThis());
  gpio_mod_a0->setInstanceName(RefString(new std::string("gpio_mod_a0")));
  gpio_mod_a1->setParent(getThis());
  gpio_mod_a1->setInstanceName(RefString(new std::string("gpio_mod_a1")));
  gpio_mod_a2->setParent(getThis());
  gpio_mod_a2->setInstanceName(RefString(new std::string("gpio_mod_a2")));
  gpio_mod_a3->setParent(getThis());
  gpio_mod_a3->setInstanceName(RefString(new std::string("gpio_mod_a3")));
  gpio_mod_a4->setParent(getThis());
  gpio_mod_a4->setInstanceName(RefString(new std::string("gpio_mod_a4")));
  gpio_mod_a5->setParent(getThis());
  gpio_mod_a5->setInstanceName(RefString(new std::string("gpio_mod_a5")));
  usb_analog_phy_->setParent(getThis());
  usb_analog_phy_->setInstanceName(RefString(new std::string("usb_analog_phy_")));
  //clock connections
                                                                                                                                                                                                                                                                                                                                                                                                                                                                          //default initis
  v_core->defaultInitialize();
  rx_mod_0->defaultInitialize();
  tx_mod_0->defaultInitialize();
  gpio_mod_a0->defaultInitialize();
  gpio_mod_a1->defaultInitialize();
  gpio_mod_a2->defaultInitialize();
  gpio_mod_a3->defaultInitialize();
  gpio_mod_a4->defaultInitialize();
  gpio_mod_a5->defaultInitialize();
  usb_analog_phy_->defaultInitialize();
  connect();
  initialize();
}

void v_top::connect() {
    en->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("en")))));
    in->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("in")))));
    out->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("out")))));
    en->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("en")))));
    in->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("in")))));
    out->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("out")))));
    en->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("en")))));
    in->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("in")))));
    out->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("out")))));
    en->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("en")))));
    in->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("in")))));
    out->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("out")))));
    en->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("en")))));
    in->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("in")))));
    out->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("out")))));
    en->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("en")))));
    in->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("in")))));
    out->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("out")))));
    en->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("en")))));
    in->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("in")))));
    out->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("out")))));
    en->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("en")))));
    in->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("in")))));
    out->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("out")))));
    en->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("en")))));
    in->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("in")))));
    out->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("out")))));
    en->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("en")))));
    in->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("in")))));
    out->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("out")))));
    en->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("en")))));
    in->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("in")))));
    out->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("out")))));
    en->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("en")))));
    in->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("in")))));
    out->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("out")))));
    rx->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("rx")))));
    tx->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("tx")))));
    en->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("en")))));
    in->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("in")))));
    out->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("out")))));
    en->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("en")))));
    in->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("in")))));
    out->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("out")))));
    en->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("en")))));
    in->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("in")))));
    out->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("out")))));
    en->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("en")))));
    in->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("in")))));
    out->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("out")))));
    en->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("en")))));
    in->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("in")))));
    out->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("out")))));
    en->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("en")))));
    in->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("in")))));
    out->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("out")))));
    rx->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("rx")))));
    tx->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("tx")))));
    en->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("en")))));
    in->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("in")))));
    out->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("out")))));
    en->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("en")))));
    in->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("in")))));
    out->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("out")))));
    en->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("en")))));
    in->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("in")))));
    out->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("out")))));
    en->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("en")))));
    in->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("in")))));
    out->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("out")))));
    en->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("en")))));
    in->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("in")))));
    out->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("out")))));
    en->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("en")))));
    in->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("in")))));
    out->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("out")))));
    rx->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("rx")))));
    tx->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("tx")))));
    data_in->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("data_in")))));
    data_out->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("data_out")))));
    drv_enable->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("drv_enable")))));
    enable_diff->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("enable_diff")))));
    enable_se->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("enable_se")))));
    force_se0->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("force_se0")))));
    rpu1_en->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("rpu1_en")))));
    rpu2_en->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("rpu2_en")))));
    se_dn->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("se_dn")))));
    se_dp->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("se_dp")))));
    strobe->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("strobe")))));
    suspend->connect(boost::static_pointer_cast<CsimPortTBool>(v_core->getSignalByName(RefString(new std::string("suspend")))));
    en->connect(boost::static_pointer_cast<CsimPortTBool>(gpio_mod_a0->getSignalByName(RefString(new std::string("en")))));
    in->connect(boost::static_pointer_cast<CsimPortTBool>(gpio_mod_a0->getSignalByName(RefString(new std::string("in")))));
    out->connect(boost::static_pointer_cast<CsimPortTBool>(gpio_mod_a0->getSignalByName(RefString(new std::string("out")))));
    gpio_a0->connect(boost::static_pointer_cast<CsimPortTBool>(gpio_mod_a0->getSignalByName(RefString(new std::string("pad_pin")))));
    en->connect(boost::static_pointer_cast<CsimPortTBool>(gpio_mod_a1->getSignalByName(RefString(new std::string("en")))));
    in->connect(boost::static_pointer_cast<CsimPortTBool>(gpio_mod_a1->getSignalByName(RefString(new std::string("in")))));
    out->connect(boost::static_pointer_cast<CsimPortTBool>(gpio_mod_a1->getSignalByName(RefString(new std::string("out")))));
    gpio_a1->connect(boost::static_pointer_cast<CsimPortTBool>(gpio_mod_a1->getSignalByName(RefString(new std::string("pad_pin")))));
    en->connect(boost::static_pointer_cast<CsimPortTBool>(gpio_mod_a2->getSignalByName(RefString(new std::string("en")))));
    in->connect(boost::static_pointer_cast<CsimPortTBool>(gpio_mod_a2->getSignalByName(RefString(new std::string("in")))));
    out->connect(boost::static_pointer_cast<CsimPortTBool>(gpio_mod_a2->getSignalByName(RefString(new std::string("out")))));
    gpio_a2->connect(boost::static_pointer_cast<CsimPortTBool>(gpio_mod_a2->getSignalByName(RefString(new std::string("pad_pin")))));
    en->connect(boost::static_pointer_cast<CsimPortTBool>(gpio_mod_a3->getSignalByName(RefString(new std::string("en")))));
    in->connect(boost::static_pointer_cast<CsimPortTBool>(gpio_mod_a3->getSignalByName(RefString(new std::string("in")))));
    out->connect(boost::static_pointer_cast<CsimPortTBool>(gpio_mod_a3->getSignalByName(RefString(new std::string("out")))));
    gpio_a3->connect(boost::static_pointer_cast<CsimPortTBool>(gpio_mod_a3->getSignalByName(RefString(new std::string("pad_pin")))));
    en->connect(boost::static_pointer_cast<CsimPortTBool>(gpio_mod_a4->getSignalByName(RefString(new std::string("en")))));
    in->connect(boost::static_pointer_cast<CsimPortTBool>(gpio_mod_a4->getSignalByName(RefString(new std::string("in")))));
    out->connect(boost::static_pointer_cast<CsimPortTBool>(gpio_mod_a4->getSignalByName(RefString(new std::string("out")))));
    gpio_a4->connect(boost::static_pointer_cast<CsimPortTBool>(gpio_mod_a4->getSignalByName(RefString(new std::string("pad_pin")))));
    en->connect(boost::static_pointer_cast<CsimPortTBool>(gpio_mod_a5->getSignalByName(RefString(new std::string("en")))));
    in->connect(boost::static_pointer_cast<CsimPortTBool>(gpio_mod_a5->getSignalByName(RefString(new std::string("in")))));
    out->connect(boost::static_pointer_cast<CsimPortTBool>(gpio_mod_a5->getSignalByName(RefString(new std::string("out")))));
    gpio_a5->connect(boost::static_pointer_cast<CsimPortTBool>(gpio_mod_a5->getSignalByName(RefString(new std::string("pad_pin")))));
}
}