#!usr/bin/env python
import ev3dev.ev3 as ev3
from time import sleep, time


class Lab:
    def __init__(self):
        self.detect = 0
        self.us = ev3.UltrasonicSensor()
        self.us.mode = 'US-DIST-CM'
        self.motor_left = ev3.LargeMotor('outB')
        self.motor_right = ev3.LargeMotor('outC')

    def drive(self, lcyc, rcyc, time=0.5):
        self.motor_left.run_direct(duty_cycle_sp=lcyc)
        self.motor_right.run_direct(duty_cycle_sp=rcyc)
        sleep(time)

    def stop(self):
        self.motor_left.run_direct(duty_cycle_sp=0)
        self.motor_right.run_direct(duty_cycle_sp=0)
        sleep(0.1)

    def turn_180(self):
        print('turn 180')
        self.drive(50,-50, 1)
        self.stop()
        self.detect = 0

    def right_turn(self):
        print('right')
        self.drive(-50,50)
        self.stop()
        self.detect = 0

if __name__ == '__main__':
    robo = Lab()
    robo.drive(50,50)
    while True:
        if robo.us.value() < 190:
            robo.stop()
            robo.detect = 1
        if robo.detect == 1:
            robo.right_turn()

        if robo.us.value() < 190:
            robo.stop()
            robo.detect = 1
        if robo.detect == 1:
            robo.turn_180()

        if robo.us.value() < 190:
            robo.stop()
            robo.detect = 1
        if robo.detect == 1:
            robo.stop()
            print('Sie haben das Ziel erreicht')
            break
        if robo.detect == 0:
            robo.drive(50,50)