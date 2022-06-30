#include <systemc.h>
#include "etc.h"

SC_MODULE(testbench) {
    sc_port<sc_signal_out_if<bool>> sensor1;
    sc_port<sc_signal_out_if<bool>> sensor2;
    sc_port<sc_signal_out_if<bool>> sensor3;
    sc_port<sc_signal_out_if<int>> validEpass;
    sc_port<sc_signal_out_if<bool>> enable;

    SC_CTOR(testbench) {
        SC_THREAD(simulation);
    }

    void simulation() {
        // valid Epass
        sensor1->write(0);
        sensor2->write(0);
        sensor3->write(0);
        validEpass->write(0);
        enable->write(0);

        wait(2, SC_SEC);

        sensor1->write(1);
        wait(2, SC_SEC);
        sensor2->write(1);
        validEpass->write(2);
        wait(1, SC_SEC);
        sensor1->write(0);
        wait(2, SC_SEC);
        sensor2->write(0);
        sensor3->write(1);
        wait(3, SC_SEC);
        sensor3->write(0);
    }

};

int sc_main(int, char*[])
{
    testbench test("test");
    etc DUT("DUT");
    //10s period, 5s true, 5s false, start at 10s, start at false.
    sc_clock clk("clk", 100, SC_NS, 0.5, 100, SC_NS, false);

    // sc_signal<bool>  clk;
    sc_signal<bool>  sensor1;
    sc_signal<bool>  sensor2;
    sc_signal<bool>  sensor3;
    sc_signal<int>   validEpass;
    sc_signal<bool>  enable;
    sc_signal<bool>  barrier;
    sc_signal<float> speed;    

    // DUT.clk(clk);
    DUT.sensor1(sensor1);
    DUT.sensor2(sensor2);
    DUT.sensor3(sensor3);
    DUT.validEpass(validEpass);
    DUT.enable(enable);
    DUT.barrier(barrier);
    DUT.speed(speed);

    test.sensor1(sensor1);
    test.sensor2(sensor2);
    test.sensor3(sensor3);
    test.validEpass(validEpass);
    test.enable(enable);



    return 0;
}