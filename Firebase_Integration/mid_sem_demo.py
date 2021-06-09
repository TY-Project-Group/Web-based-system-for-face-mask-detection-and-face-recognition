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

import pyrebase
import firebase_admin
from datetime import datetime
from firebase_admin import credentials
from firebase_admin import firestore

firebaseConfig = {'apiKey': "AIzaSyCe0lM1k9nVZYCbNUO0vrtViTYPca77Ppo",
    'authDomain': "edi-sem-6-d7e25.firebaseapp.com",
    'projectId': "edi-sem-6-d7e25",
    'storageBucket': "edi-sem-6-d7e25.appspot.com",
    'messagingSenderId': "800771699226",
    'appId': "1:800771699226:web:e4b265d005f8a4f32857a3",
    'databaseURL': "yourstoragebucketurl.com"}

firebase = pyrebase.initialize_app(firebaseConfig)

cred = credentials.Certificate("serviceAccountKey.json")
firebase_admin.initialize_app(cred)

db = firestore.client()
storage = firebase.storage()

cap = cv2.VideoCapture(0)
font = cv2.FONT_HERSHEY_COMPLEX_SMALL
score=0
thicc=2

known_face_encodings= []
known_face_names = []

files = ['Photos/11810148/11810148.jpg','Photos/11810254/11810254.jpg','Photos/11810321/11810321.jpg']
i = 0

gr = []
path = []

docs = db.collection('users').get()
for doc in docs:
    gr.append(doc.to_dict().get('GRno'))

print (len(gr))

for i in gr:
    pth = 'Photos/' + str(i) + '/' + str(i) + '.jpg'
    path.append(pth)

i = 1
for f in path:
    print (i)
    storage.child(f).download("", "img.jpg")
    x = face_recognition.load_image_file("img.jpg")
    y = face_recognition.face_encodings(x)[0]
    known_face_encodings.append(y)
    known_face_names.append(f[-12:-4])
    i = i + 1

docs = db.collection('staff').get()
gr = []
path= [] 
for doc in docs:
    gr.append(doc.to_dict().get('GRno'))

print (len(gr))

for i in gr:
    pth = 'Photos/' + str(i) + '/' + str(i) + '.jpg'
    path.append(pth)

i = 1
for f in path:
    print (i)
    storage.child(f).download("", "img.jpg")
    x = face_recognition.load_image_file("img.jpg")
    y = face_recognition.face_encodings(x)[0]
    known_face_encodings.append(y)
    known_face_names.append(f[-8:-4])
    i = i + 1

print (known_face_names, len(known_face_encodings))


#pranjal_image = face_recognition.load_image_file("11810148.jpg")
#pranjal_face_encoding = face_recognition.face_encodings(pranjal_image)[0]
#
#prahlad_image = face_recognition.load_image_file("11810254.jpg")
#prahlad_face_encoding = face_recognition.face_encodings(prahlad_image)[0]
#
#ojas_image = face_recognition.load_image_file("11810321.jpg")
#ojas_face_encoding = face_recognition.face_encodings(ojas_image)[0]

face_locations = []
face_encodings = []
face_names = []
process_this_frame = True

#known_face_encodings = [pranjal_face_encoding, prahlad_face_encoding, ojas_face_encoding]
#known_face_names = ["Pranjal", "Prahlad", "Ojas"]

startTime = time.time()
print ("start")
defaultersList = []

while(True):
    currentTime = time.time()
    print(currentTime - startTime)
    print(defaultersList)
    if (currentTime - startTime >= 20):
        startTime = time.time()
        defaultersList = []
        
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
            
            cv2.imwrite("ss.jpg", frame)

            cv2.rectangle(frame, (left, top), (right, bottom), (0, 0, 255), 2)
            
            cv2.rectangle(frame, (left, bottom - 35), (right, bottom), (0, 0, 255), cv2.FILLED)
            
            font = cv2.FONT_HERSHEY_DUPLEX
            
            cv2.putText(frame, name, (left + 6, bottom - 6), font, 1.0, (255, 255, 255), 1)

            if (name not in defaultersList):
                defaultersList.append(name)
                now = datetime.now()
                now = now.strftime("%Y-%m-%d %H:%M:%S")
                if (len(name) < 5):
                    print ("innnnnnnnnnnn staffffffffffffffffffffff")
                    docs = db.collection('staff').where("GRno", "==", str(name)).get()
                    if len(docs) == 0:
                        print("GRno not found")
                    else:
                        for doc in docs:
                            data = doc.to_dict()
                            db.collection('defaulter_staff').document(name).set(data)
                            img = 'ss.jpg'
                            cloud_img = 'Defaulters/' + name + '.jpg'
                            storage.child(cloud_img).put(img)
                            cloud_img_url = storage.child(cloud_img).get_url(None)
                            db.collection('defaulter_staff').document(str(int(name))).set({'Default_Photo':cloud_img_url}, merge = True)
                            db.collection('defaulter_staff').document(name).set({'Default_Time':now}, merge = True)           
                        print("Default Table Updated")
                else :
                    print ("innnnnnnnnnnnnn usssssserrrrrrrrrrrrr")
                    docs = db.collection('user').where("GRno", "==", str(name)).get()
                    if len(docs) == 0:
                        print("GRno not found")
                    else:
                        for doc in docs:
                            data = doc.to_dict()
                            db.collection('defaulters').document(name).set(data)
                            img = 'ss.jpg'
                            cloud_img = 'Defaulters/' + name + '.jpg'
                            storage.child(cloud_img).put(img)
                            cloud_img_url = storage.child(cloud_img).get_url(None)
                            db.collection('defaulters').document(str(int(name))).set({'Default_Photo':cloud_img_url}, merge = True)
                            db.collection('defaulters').document(name).set({'Default_Time':now}, merge = True)           
                        print("Default Table Updated")

                    #cv2.imshow('Video', frame)

    cv2.putText(frame,str(label),(100,height-20), font, 1,(255,255,255),1,cv2.LINE_AA)
    cv2.imshow('frame',frame)
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break
cap.release()
cv2.destroyAllWindows()