#!/usr/bin/env python

import ev3dev.ev3 as ev3
from random import randint
from time import sleep, time

ts= ev3.TouchSensor()
ts.mode = 'TOUCH'

motor_left = ev3.LargeMotor('outB')
motor_right = ev3.LargeMotor('outC')

def drive(lcyc, rcyc, time=0.5):
    motor_left.run_direct(duty_cycle_sp=lcyc)
    motor_right.run_direct(duty_cycle_sp=rcyc)
    sleep(time)

def stop():
    motor_left.run_direct(duty_cycle_sp=0)
    motor_right.run_direct(duty_cycle_sp=0)
    sleep(0.1)

def full_forward():
    motor_turns_deg= 360
    motor_left.run_to_rel_pos(position_sp=motor_turns_deg, speed_sp=400)
    motor_right.run_to_rel_pos(position_sp=motor_turns_deg, speed_sp=400)
    sleep(0.1)

def halfback():
    stop()
    drive(-50, -50, 1)
    stop()

def left_turn():
    print('left')
    drive(50,-50)
    drive(50,50, 2)
    drive(-50,50)
    drive(50,50, 2)
    drive(-50,50)
    drive(50,50, 2)
    drive(50,-50)

def right_turn():
    print('right')
    drive(-50,50)
    drive(50,50,2)
    drive(50,-50)
    drive(50,50, 2)
    drive(50,-50)
    drive(50,50, 2)
    drive(-50,50)

if __name__ == '__main__':
    while True:
        drive(75, 75, 0)
        while True:
            if ts.value():
                halfback()
                break
        if randint(1,100) <= 50:
            left_turn()
        else:
            right_turn()