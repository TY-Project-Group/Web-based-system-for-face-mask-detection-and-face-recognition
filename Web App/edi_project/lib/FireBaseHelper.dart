
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edi_project/newStudentModel.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FireBaseHelper{
  FirebaseFirestore _db = FirebaseFirestore.instance; 

  getAllStudents() async{
    QuerySnapshot temp = await _db.collection("users").get();
    return temp;
  }

  getAllDefaulters() async{
    QuerySnapshot temp = await _db.collection("defaulters").get();
    return temp;
  }

  deleteStudentDatabase(String grno) async{
    String path = "Photos/" + grno + "/" + grno;
    await _db.collection("users").doc(grno).delete();
    await FirebaseStorage.instance.ref().child(path).delete();
  }

  addNewStudent(StudentModel student) async{
    await _db.collection("users").doc(student.grno).set(student.toMap());
  }

  deleteDefaulterStudent(String grno) async{
    await _db.collection("defaulters").doc(grno).delete();
  }

  getStudentInfo(String grno) async {
    var temp = _db.collection("users").doc(grno).get();
    return temp;
  }
}