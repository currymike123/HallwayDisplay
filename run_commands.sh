#!/bin/bash


cd /home/display/Desktop/HallwayDisplay/controller/

python -u "/home/display/Desktop/HallwayDisplay/controller/hand_tracker_multi_thread.py" &
processing-java --sketch=/home/display/Desktop/HallwayDisplay/controller/controller.edu --present --run
