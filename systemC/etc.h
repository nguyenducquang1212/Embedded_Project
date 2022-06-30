#ifndef ETC_H
#define ETC_H

#include <systemc.h>

SC_MODULE(etc) {
    // sc_port<sc_signal_in_if<bool>> clk;
    sc_port<sc_signal_in_if<bool>> sensor1;
    sc_port<sc_signal_in_if<bool>> sensor2;
    sc_port<sc_signal_in_if<bool>> sensor3;
    sc_port<sc_signal_in_if<int>> validEpass;
    sc_port<sc_signal_in_if<bool>> enable;
    sc_port<sc_signal_out_if<bool>>barrier;
    sc_port<sc_signal_out_if<float>> speed;

    SC_CTOR(etc) {
        // SC_CTHREAD(cthread, clk->posedge_event());
        SC_METHOD(cthread);
    }

    void cthread(){
        sc_time start(1, SC_MS);
        sc_time stop(1, SC_MS);
        sc_time period(1, SC_MS);

        while (true)
        {
            float time = 0;
START:
            //wait();
            // sensor1->read();
            if (sensor1->read())
            {
                start = sc_time_stamp();
                cout << "Sensor1 has a passing vehicle";
            }
            else
            {
                goto START;
            }
COUNT_TIME:
            //wait();
            // sensor2->read();
            if (sensor2->read())
            {
                stop = sc_time_stamp();
                period = stop - start;
                time = period.to_seconds();
                cout << "Sensor2 has a passing vehicle";
            }
            else
            {
                goto COUNT_TIME;
            }

            float sp = 4*3.6 / time;
            speed->write(sp);
            cout << "Speed: " << speed->read() << endl;

WAIT_EPASS:
            //wait();
            // validEpass->read();
            if (validEpass->read() == 2)
            {
                cout << "Valid Epass" << endl;
                cout << "Turn on Barrier" << endl;
                barrier->write(1);
WAIT_SEN3_EN:
                //wait();
                // sensor3->read();
                if (sensor3->read())
                {
                    cout << "Sensor2 has a passing vehicle" << endl;
WAIT_SEN3_DIS:
                    //wait();
                    // sensor3->read();
                    if (!sensor3->read())
                    {
                        barrier->write(0);
                        cout << "Turn off barrier!" << endl;
                    }
                }
            }
            else if (validEpass->read() == 1)
            {
                cout << "Illegal ePass" << endl;
WAIT_EN:
                //wait();
                // enable->read();
                if (enable->read())
                {
                    cout << "Turn on barrier" << endl;
WAIT_DIS:
                    //wait();
                    // enable->read();
                    if (!enable->read())
                    {
                        cout << "Turn off barrier" << endl;
                    }
                }
                else
                {
                    goto WAIT_EN;
                }
                
            }
            else {
                goto WAIT_EPASS;
            }
        }
    };

};

#endif