#!usr/bin/env python
import ev3dev.ev3 as ev3
from time import sleep, time


class Robot:
    '''
    This Robot class provides methods for:
    - color detection
    - obsticle detection
    :Constant Global Variables:
        COLOR_METHOD_DICT -- dictionary, assigning a Integer or Long n 2<=n<=5, representing a color, to a method
    '''
    COLOR_METHOD_DICT = {
        2 : self._cDetect_blue()
        3 : self._cDetect_green(),
        4 : self._cDetect_yellow(),
        5 : self._cDetect_red(),
    }

    def __init__(self):
        """
        Conctur of out Robot class, initializing the following variables.
        :Global Variables:
            self.motor_left  -- left motor
            self.motor_right -- right motor
            self.us          -- ultrasonic sensor
            self.cs          -- color sensor
            self.stateList   -- List containg states collected

        after initialization the roboter changes into its initial state
        """
        self.motor_left = ev3.LargeMotor('outB')
        self.motor_right = ev3.LargeMotor('outC')
        self.us = ev3.UltrasonicSensor()
        self.us.mode = 'US-DIST-CM'
        self.cs = ev3.ColorSensor()
        self.cs.mode = 'COL-COLOR'
        self.stateList = ['neutral']
        self.neutral_state()

    # "public" methods
    def drive(self, lcyc, rcyc, time=0.5):
        '''
        This method serves driving maneuevers
        '''
        self.motor_left.run_direct(duty_cycle_sp=lcyc)
        self.motor_right.run_direct(duty_cycle_sp=rcyc)
        sleep(time)

    def stop(self):
        '''
        This method serves stopping the motors
        '''
        self.motor_left.run_direct(duty_cycle_sp=0)
        self.motor_right.run_direct(duty_cycle_sp=0)
        sleep(0.1)

    def detect_col(self, colVal):
        '''
        This Method simply calls the method corresponding to the color
        :param colVal: Integer or Long n 2<=n<=5, representing a color, to a method
        '''
        stateList.append('color')
        COLOR_METHOD_DICT[colVal]

    def evade_obsticle(self):
        '''
        Method to evade an obsticle
        '''
        self.stateList.append
        pass

    def neutral_state(self):
        '''
        In its neutral state the roboter drives back and forth, slowly
        '''
        while len(self.stateList) == 1:
            self.drive(10,10,0.5)
            self.drive(-10,-10,0.5)

    # "private" methods
    ## methods for their corresponding colors
    def _cDetect_red():
        pass

    def _cDetect_green():
        pass

    def _cDetect_yellow():
        pass

    def _cDetect_blue():
        pass

if __name__ == '__main__':
    robo = Robot()
