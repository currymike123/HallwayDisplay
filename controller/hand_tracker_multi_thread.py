import cv2
import mediapipe as mp
import socket
import numpy as np
import threading

# create a socket object
serversocket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

# get local machine name
host = 'localhost'
port = 9999

# bind to the port
serversocket.bind((host, port))

# queue up to 5 requests
serversocket.listen(5)

# Prepare Drawing utilities
mp_drawing = mp.solutions.drawing_utils
mp_hands = mp.solutions.hands

# For webcam input
cap = cv2.VideoCapture(0)

# Define a ClientHandler class and inherit from the Thread class.
class ClientHandler(threading.Thread):

    # Intialize class
    def __init__(self, clientsocket):
        threading.Thread.__init__(self)
        self.clientsocket = clientsocket
        self.center_x = 0
        self.center_y = 0
        self.multiple_hands = -1
        self.hands = mp_hands.Hands(min_detection_confidence=0.5, min_tracking_confidence=0.5)

    # Runs when the thread is called: ClientHandler(clientsocket).start(
    def run(self):

        # Infite loop to transmit the coordinates.
        while True:

            # Get the image from the webcam.
            success, image = cap.read()
            if not success:
                print("Ignoring empty camera frame.")
                continue

            # Flip the image horizontally for a later selfie-view display, and convert
            # the BGR image to RGB.
            image = cv2.cvtColor(cv2.flip(image, 1), cv2.COLOR_BGR2RGB)

            # To improve performance, optionally mark the image as not writeable to
            # pass by reference.
            image.flags.writeable = False
            results = self.hands.process(image)

            # Draw the hand annotations on the image. No need to do this step because we just want the coordinates. 
            # image.flags.writeable = True

            # If a hand is detected.
            if results.multi_hand_landmarks:

                #If there is more than one hand detected.
                if len(results.multi_hand_landmarks) > 1:
                    print("Multiple hands detected, please keep one hand behind.")

                    # Flag that there is more than one hand.
                    self.multiple_hands = 2
                
                #Else there is only one hand detected.
                else:
                    #Get the hand coordinates.
                    hand_landmarks = results.multi_hand_landmarks[0]

                    #Flag only one hand is detected.
                    self.multiple_hands = 1

                    # Find the bounding box coordinates
                    lm_list = []

                    # The x and y coordinates are normalized.  Get the array position and the coordinate object.
                    for id, lm in enumerate(hand_landmarks.landmark):
                        # 
                        h, w, c = image.shape
                        cx, cy = int(lm.x * w), int(lm.y * h)
                        lm_list.append([id, cx, cy])

                    # Get the center of the hand

                    # Get the minimum and maximum x coordinates among all landmarks
                    x_min, x_max = np.min(np.array(lm_list)[:,1]), np.max(np.array(lm_list)[:,1])

                    # Get the minimum and maximum y coordinates among all landmarks
                    y_min, y_max = np.min(np.array(lm_list)[:,2]), np.max(np.array(lm_list)[:,2])

                    # Calculate the center of the hand by finding the average of the minimum and maximum x and y coordinates
                    self.center_x, self.center_y = (x_min + x_max) // 2, (y_min + y_max) // 2

                    # Print the center coordinates of the hand
                    print(f'Hand center: x={self.center_x}, y={self.center_y}')

                # send hand positions via server.
                msg = f'{self.center_x},{self.center_y},{self.multiple_hands}\n'
                try:
                    self.clientsocket.send(msg.encode('ascii'))
                except BrokenPipeError:
                    self.clientsocket.close()
                    print("BrokenPipeError occurred, client disconnected prematurely.")
            else:
                print("No Hands Detected")

                #Flag only one hand is detected.
                self.multiple_hands = 0

                # send hand positions via server.
                msg = f'{self.center_x},{self.center_y},{self.multiple_hands}\n'
                try:
                    self.clientsocket.send(msg.encode('ascii'))
                except BrokenPipeError:
                    self.clientsocket.close()
                    print("BrokenPipeError occurred, client disconnected prematurely.")
                
# Infinte loop to listen for server connections
while True:
    # establish a connection
    clientsocket, addr = serversocket.accept()

    print("Got a connection from %s" % str(addr))

    # Start a thread so there can be multiple connections. 
    ClientHandler(clientsocket).start()
