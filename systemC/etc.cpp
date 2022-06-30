#includes <systemc>
using namespace sc_core;

SC_MODULE(etc) {
    sc_port<sc_signal_in_if<bool>> clk;
    sc_port<sc_signal_in_if<bool>> reset_n;    
    sc_port<sc_signal_in_if<bool>> sensor1;
    sc_port<sc_signal_in_if<bool>> sensor2;
    sc_port<sc_signal_in_if<bool>> sensor3;
    sc_port<sc_signal_in_if<int>> validEpass;
    sc_port<sc_signal_in_if<bool>> enable;
    sc_port<sc_signal_out_if<bool>>barrier;
    sc_port<sc_signal_out_if<float>> speed;

    SC_CTOR(etc) {
        SC_CTHREAD (cthread, clk.pos());
    }

    void cthread() {
        sc_time start(1, SC_MS);
        sc_time stop(1, SC_MS);
        sc_time period(1, SC_MS);

        while (true)
        {
            float time = 0;
START:
            wait();
            sensor1.read();
            if (sensor1)
            {
                start = sc_time_stamp();
                cout << "Sensor1 has a passing vehicle";
            }
            else
            {
                goto START;
            }
COUNT_TIME:
            wait();
            sensor2.read();
            if (sensor2)
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
            speed.write(sp);
            cout << "Speed: " << speed << endl;

WAIT_EPASS:
            wait();
            validEpass.read();
            if (validEpass == 2)
            {
                cout << "Valid Epass" << endl;
                cout << "Turn on Barrier" << endl;
                barrier.write(1);
WAIT_SEN3_EN:
                wait();
                sensor3.read();
                if (sensor3)
                {
                    cout << "Sensor2 has a passing vehicle" << endl;
WAIT_SEN3_DIS:
                    wait();
                    sensor3.read();
                    if (!sensor3)
                    {
                        barrier.write(0);
                        cout << "Turn off barrier!" << endl;
                    }
                }
            }
            else if (validEpass == 1)
            {
                cout << "Illegal ePass" << endl;
WAIT_EN:
                wait();
                enable.read();
                if (enable)
                {
                    cout << "Turn on barrier" << endl;
WAIT_DIS:
                    wait();
                    enable.read();
                    if (!enable)
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
    }
};