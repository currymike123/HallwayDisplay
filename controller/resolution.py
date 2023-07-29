import cv2

def get_webcam_resolution():
    # Access the default webcam (index 0)
    cap = cv2.VideoCapture(0)

    if not cap.isOpened():
        print("Unable to access the webcam.")
        return

    # Get the webcam resolution
    width = int(cap.get(cv2.CAP_PROP_FRAME_WIDTH))
    height = int(cap.get(cv2.CAP_PROP_FRAME_HEIGHT))

    cap.release()  # Release the webcam
    return width, height

if __name__ == "__main__":
    webcam_width, webcam_height = get_webcam_resolution()
    print(f"Webcam resolution: {webcam_width}x{webcam_height}")
import cv2

def get_webcam_resolution():
    # Access the default webcam (index 0)
    cap = cv2.VideoCapture(0)

    if not cap.isOpened():
        print("Unable to access the webcam.")
        return

    # Get the webcam resolution
    width = int(cap.get(cv2.CAP_PROP_FRAME_WIDTH))
    height = int(cap.get(cv2.CAP_PROP_FRAME_HEIGHT))

    cap.release()  # Release the webcam
    return width, height

if __name__ == "__main__":
    webcam_width, webcam_height = get_webcam_resolution()
    print(f"Webcam resolution: {webcam_width}x{webcam_height}")
