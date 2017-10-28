#!usr/bin/env python
import ev3dev.ev3 as ev3
from time import sleep, time

class Klatscher:

    def __init__(self):
        self.ss = ev3.Sensor()
        self.ss.mode = 'ANALOG-1'

        self.motor_left = ev3.LargeMotor('outB')
        self.motor_right = ev3.LargeMotor('outC')

        self.f = 0
        self.k = 0

    def forward(self, fastBool):
        print('forwards{}'.format(fastBool))
        if fastBool:
            self.motor_left.run_direct(duty_cycle_sp=75)
            self.motor_right.run_direct(duty_cycle_sp=75)
            self.f=2
        else:
            self.motor_left.run_direct(duty_cycle_sp=25)
            self.motor_right.run_direct(duty_cycle_sp=25)
            self.f=1
        self.k=0

    def backwards(self, fastBool):
        print('backwards{}'.format(fastBool))
        if fastBool:
            self.motor_left.run_direct(duty_cycle_sp=-75)
            self.motor_right.run_direct(duty_cycle_sp=-75)
            self.f=-2
        else:
            self.motor_left.run_direct(duty_cycle_sp=-25)
            self.motor_right.run_direct(duty_cycle_sp=-25)
            self.f=-1
        self.k=0

    def stop(self):
        print('stop')
        self.motor_left.run_direct(duty_cycle_sp=0)
        self.motor_right.run_direct(duty_cycle_sp=0)
        self.f = 0
        self.k = 0

    def still(self):
        print('still')
        self.motor_left.run_direct(duty_cycle_sp=0)
        self.motor_right.run_direct(duty_cycle_sp=0)

if __name__ == '__main__':
    robo = Klatscher()
    robo.still()
    while robo.k == 0:
        if robo.ss.value() <= 1000:
            robo.k=1
    robo.forward(False)
    while True:
        if robo.k == 2 and robo.f == 1:
            robo.forward(True)
        elif robo.k == 2 and robo.f == 2:
            robo.forward(False)
        elif robo.k == 2 and robo.f == -1:
            robo.backwards(True)
        elif robo.k == 2 and robo.f == -2:
            robo.backwards(False)
        elif robo.k == 1 and robo.f == 0:
            robo.forward(False)
        elif robo.k == 2 and robo.f == 0:
            robo.backwards(False)
        elif robo.k == 1 and robo.f != 0:
            robo.stop()

        while robo.k == 0:
            if robo.ss.value() <= 1000:
                robo.k = 1
                tStart = time()
                sleep(0.2)
                while (time() - tStart) < 0.5:
                    if robo.ss.value() <= 1000:
                        robo.k = 2