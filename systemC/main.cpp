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
        cout << "Case 1: Valid Epass" << endl;
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
        
        cout << "Case 2: Valid Epass" << endl;
        sensor1->write(1);
        wait(3, SC_SEC);
        sensor3->write(0);

       // valid Epass
        sensor2->write(0);
        sensor3->write(0);
        validEpass->write(0);
        enable->write(0);

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

        wait(4, SC_SEC);
        cout << "\n\nCase 3: Illegal Epass" << endl;
        sensor1->write(0);
        sensor2->write(0);
        sensor3->write(0);
        validEpass->write(0);
        enable->write(0);

        wait(2, SC_SEC);

        sensor1->write(1);
        wait(2, SC_SEC);
        sensor2->write(1);
        validEpass->write(1);
        wait(1, SC_SEC);
        sensor1->write(0);
        wait(1, SC_SEC);
        enable->write(1);
        wait(1, SC_SEC);
        sensor2->write(0);
        sensor3->write(1);
        wait(3, SC_SEC);
        enable->write(0);
        sensor3->write(0);

        cout << "END!";
    }

};

int sc_main(int, char*[])
{
    testbench test("test");
    etc DUT("DUT");

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


    sc_start(60, SC_SEC);
    // sc_start();
    return 0;
}