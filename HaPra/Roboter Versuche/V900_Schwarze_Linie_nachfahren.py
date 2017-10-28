#!/usr/bin/env python
# Axel Ligon

import ev3dev.ev3 as ev3
print "import done"

cs = ev3.ColorSensor(); 
col.mode = 'COL-REFLECT'

btn = Button() # will use any button to stop script

left_motor = ev3.LargeMotor('outB')
right_motor = ev3.LargeMotor('outC')

# ------Input--------
power = 60       # Max motor power on any of the motors
target = 55      # Normalized target value.
kp = float(0.65) # Proportional gain, Start value 1
kd = 1           # Derivative gain, Start value 0
ki = float(0.02) # Integral gain, Start value 0
direction = -1   # 1 or -1 depending on the direction the robot should steer
minRef = 41      # Min reflecting value of floor or line
maxRef = 63      # Max reflecting value of floor or line 
# -------------------
#siehe Pseudo-Code: http://www.inpharmix.com/jps/PID_Controller_For_Lego_Mindstorms_Robots.html


def stop():
	left_motor.run_direct(duty_cycle_sp=0)
	right_motor.run_direct(duty_cycle_sp=0)
	sleep(0.1)

#============
def lenkung(course):
	power_left = power_right = power
	s = (50 - abs(float(course))) / 50

	if course >= 0:
		power_right *= s
		if course > 100:
			power_right = - power
	else:
		power_left *= s
		if course < -100:
			power_left = - power

	return (int(power_left), int(power_right))

#=============
def folgen:  
	lastError = error = integral = 0
	left_motor.run_direct()
	right_motor.run_direct()
	while not btn.any() :
		refRead = col.value()
		error = target - (100 * ( refRead - minRef ) / ( maxRef - minRef ))
		derivative = error - lastError
		lastError = error
		integral = float(0.5) * integral + error
		course = (kp * error + kd * derivative +ki * integral) * direction
		for (motor, pow) in zip((left_motor, right_motor), lenkung(course)):
			motor.duty_cycle_sp = pow
		sleep(0.01) # Aprox 100 Hz

		
folgen()

# Stop
print 'Stopping motors'
left_motor.stop()
right_motor.stop()




"""
while not btn.any():    # exit loop when any button pressed
    if cs.value()<30:   # weak reflection so over black line
        # medium turn right
        motor_left.run_forever(speed_sp=450)
        motor_right.stop(stop_action='brake')
    else:   # strong reflection (>=30) so over white surface
        # medium turn left
        motor_left.stop(stop_action='brake')
        motor_right.run_forever(speed_sp=450)
"""