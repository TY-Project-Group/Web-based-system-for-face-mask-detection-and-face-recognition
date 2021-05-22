import cv2
import os
from keras.models import load_model
import numpy as np
import time
from label_detect import classify_face
import face_recognition
import cv2
import numpy as np
import time

cap = cv2.VideoCapture(0)
font = cv2.FONT_HERSHEY_COMPLEX_SMALL
score=0
thicc=2

pranjal_image = face_recognition.load_image_file("pranjal.jpg")
pranjal_face_encoding = face_recognition.face_encodings(pranjal_image)[0]

prahlad_image = face_recognition.load_image_file("prahlad.jpg")
prahlad_face_encoding = face_recognition.face_encodings(prahlad_image)[0]

ojas_image = face_recognition.load_image_file("ojas.jpeg")
ojas_face_encoding = face_recognition.face_encodings(ojas_image)[0]

face_locations = []
face_encodings = []
face_names = []
process_this_frame = True

known_face_encodings = [pranjal_face_encoding, prahlad_face_encoding, ojas_face_encoding]
known_face_names = ["Pranjal", "Prahlad", "Ojas"]

while(True):
    ret, frame = cap.read()
    height,width = frame.shape[:2]
    label = classify_face(frame)
    if(label == 'with_mask'):
        print("No Beep")

    else:
        ret, frame = cap.read()

        small_frame = cv2.resize(frame, (0, 0), fx=0.25, fy=0.25)

        rgb_small_frame = small_frame[:, :, ::-1]

        if process_this_frame:
            face_locations = face_recognition.face_locations(rgb_small_frame)
            face_encodings = face_recognition.face_encodings(rgb_small_frame, face_locations)
            
            face_names = []
            for face_encoding in face_encodings:
                matches = face_recognition.compare_faces(known_face_encodings, face_encoding)
                name = "Unknown"
                
                face_distances = face_recognition.face_distance(known_face_encodings, face_encoding)
                best_match_index = np.argmin(face_distances)
                
                if matches[best_match_index]:
                    name = known_face_names[best_match_index]
                
                face_names.append(name)
        
        process_this_frame = not process_this_frame
        
        for (top, right, bottom, left), name in zip(face_locations, face_names):
            top *= 4
            right *= 4
            bottom *= 4
            left *= 4
            
            cv2.rectangle(frame, (left, top), (right, bottom), (0, 0, 255), 2)
            
            cv2.rectangle(frame, (left, bottom - 35), (right, bottom), (0, 0, 255), cv2.FILLED)
            
            font = cv2.FONT_HERSHEY_DUPLEX
            
            cv2.putText(frame, name, (left + 6, bottom - 6), font, 1.0, (255, 255, 255), 1)
        #cv2.imshow('Video', frame)

    cv2.putText(frame,str(label),(100,height-20), font, 1,(255,255,255),1,cv2.LINE_AA)
    cv2.imshow('frame',frame)
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break
cap.release()
cv2.destroyAllWindows()