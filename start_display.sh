#!/bin/bash

# Start the Python script in the background
python controller/hand_tracker_multi_thread.py &

# Run the Processing script
# Note: Modify this command according to your Processing installation
processing-java --sketch=$(pwd)/controller/controller --run

# Optional: If you want to wait for the Python script to finish before exiting
# wait
