
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FireBaseHelper{
  FirebaseFirestore _db = FirebaseFirestore.instance; 

  getAllStudents(int flag) async{
    QuerySnapshot temp;
    if (flag == 1)
      temp = await _db.collection("users").get();

    if (flag == 2) 
      temp = await _db.collection("staff").get();

    return temp;
  }

  getAllDefaulters(int flag) async{
     QuerySnapshot temp ;
    if (flag == 1)
      temp = await _db.collection("defaulters").get();
    if (flag == 2)
      temp = await _db.collection("defaulter_staff").get();
    return temp;
  }

  deleteStudentDatabase(String grno, int flag) async{
    String path = "Photos/" + grno + "/" + grno + ".jpg";
    
    if (flag == 1)
      await _db.collection("users").doc(grno).delete();
    if (flag == 2){
      await _db.collection("staff").doc(grno).delete();
    }
    
    await FirebaseStorage.instance.ref().child(path).delete();
  }

  addNewStudent(student, int flag) async{
    if (flag == 1)
      await _db.collection("users").doc(student.grno).set(student.toMap());

    if (flag == 2)
      await _db.collection("staff").doc(student.grno).set(student.toMap());
  }

  deleteDefaulterStudent(String grno, int flag) async{
    String path = "Defaulters/" + grno + ".jpg";

    if (flag == 1){
      await _db.collection("defaulters").doc(grno).delete();
    }

    if (flag == 2){
      await _db.collection("defaulter_staff").doc(grno).delete();
    }
    
    await FirebaseStorage.instance.ref().child(path).delete();
  }

  getStudentInfo(String grno, int flag) async {
    var temp;
    if (flag == 1)
      temp = _db.collection("users").doc(grno).get();

    if (flag == 2)
      temp = _db.collection("staff").doc(grno).get();
    return temp;
  }

  getDefaultersEmail(String grno, int flag) async{
    String temp;
    if (flag == 1){
      var a = await _db.collection("users").doc(grno).get();
      temp = a.data()['Email'];
    }

    if (flag == 2){
      var a = await _db.collection("staff").doc(grno).get();
      temp = a.data()['Email'];
    }

    return temp;
  }
}