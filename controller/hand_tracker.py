import cv2
import mediapipe as mp
import socket
import numpy as np



# create a socket object
serversocket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)


# get local machine name
host = 'localhost'


port = 9999

# bind to the port
serversocket.bind((host, port))

# queue up to 5 requests
serversocket.listen(5)

# Are there multiple hands?
multiple_hands = -1

# Hand coordinates
center_x = 0
center_y = 0

while True:
# establish a connection
    clientsocket, addr = serversocket.accept()

    print("Got a connection from %s" % str(addr))



    # Prepare Drawing utilities
    mp_drawing = mp.solutions.drawing_utils
    mp_hands = mp.solutions.hands

    # For webcam input:
    cap = cv2.VideoCapture(0)

    with mp_hands.Hands(min_detection_confidence=0.5, min_tracking_confidence=0.5) as hands:
        while cap.isOpened():
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
            results = hands.process(image)

            # Draw the hand annotations on the image.
            image.flags.writeable = True
            #image = cv2.cvtColor(image, cv2.COLOR_RGB2BGR)

            if results.multi_hand_landmarks:
                if len(results.multi_hand_landmarks) > 1:
                    print("Multiple hands detected, please keep one hand behind.")
                    multiple_hands = 1
                    
                    # send hand positions via server.
                    msg = f'{center_x},{center_y},{multiple_hands}'
                    try:
                        clientsocket.send(msg.encode('ascii'))
                    except BrokenPipeError:
                        clientsocket.close()
                        print("BrokenPipeError occurred, client disconnected prematurely.")

                        
                else:
                    hand_landmarks = results.multi_hand_landmarks[0]
                    multiple_hands = 0
                    # Find the bounding box coordinates
                    lm_list = []
                    for id, lm in enumerate(hand_landmarks.landmark):
                        h, w, c = image.shape
                        cx, cy = int(lm.x * w), int(lm.y * h)
                        lm_list.append([id, cx, cy])

                    # Get the center of the hand
                    x_min, x_max = np.min(np.array(lm_list)[:,1]), np.max(np.array(lm_list)[:,1])
                    y_min, y_max = np.min(np.array(lm_list)[:,2]), np.max(np.array(lm_list)[:,2])
                    center_x, center_y = (x_min + x_max) // 2, (y_min + y_max) // 2
                    #cv2.circle(image, (center_x, center_y), 5, (255, 0, 0), cv2.FILLED)
                    print(f'Hand center: x={center_x}, y={center_y}')

                    # send hand positions via server.
                    msg = f'{center_x},{center_y}{multiple_hands}'
                    try:
                        clientsocket.send(msg.encode('ascii'))
                    except BrokenPipeError:
                        clientsocket.close()
                        print("BrokenPipeError occurred, client disconnected prematurely.")
                        
                    

            #cv2.imshow('MediaPipe Hands', image)
            if cv2.waitKey(5) & 0xFF == 27:
                break

    # close connection
    clientsocket.close()

    cap.release()
    cv2.destroyAllWindows()
