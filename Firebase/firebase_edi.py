import pyrebase
import firebase_admin
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

dflt_GR = int(input("Enter GR Number of defaulter: "))
docs = db.collection('users').where("GRno", "==", dflt_GR).get()
if len(docs) == 0:
    print("GRno not found")
else:
    for doc in docs:
        data = doc.to_dict()
        db.collection('defaulters').document(str(dflt_GR)).set(data)
        img = 'image.png'
        cloud_img = 'Defaulters/testDefault1.png'
        storage.child(cloud_img).put(img)
        cloud_img_url = storage.child(cloud_img).get_url(None)
        db.collection('defaulters').document(str(dflt_GR)).set({'Default_Photo':cloud_img_url}, merge = True)
