import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edi_project/FireBaseHelper.dart';
import 'package:edi_project/newStudentModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'package:firebase_storage/firebase_storage.dart';

class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final fs = FireBaseHelper();

  bool dashBoardPressed = true;
  bool defaultersPressed = false;
  bool databasePressed = false;

  bool databaseAddPressed = false;
  bool databaseUpdatePressed = false;
  List<TableRow> rows = [];

  TextEditingController grnoController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController phnoController = new TextEditingController();
  TextEditingController yearController = new TextEditingController();
  TextEditingController imageController = new TextEditingController();

  String studentName = "";
  String studentGrno = "";
  String studentEmail = "";
  String studentphone = "";
  String studentYear= "";
  String studentPhoto = "";
  String studentDefaultPhoto = "";

  html.File image;

  List<TableRow> defaulterRows = [];

  String imageLink = "";

  void getStudentInfo(String grno) async{
    var temp = await fs.getStudentInfo(grno);
    setState(() {
      studentGrno = grno;
      studentName = temp.data()['Name'];
      studentEmail = temp.data()['Email'];
      studentphone = temp.data()['Phone'].toString();
      studentYear = temp.data()['Year'].toString();
      studentPhoto = temp.data()['Photo'].toString();   
    });
    showInfoDialog(context);
  }

  void selectImage() {
    html.InputElement uploadInput = html.FileUploadInputElement()..accept = 'image/*';

    uploadInput.click();
    uploadInput.onChange.listen((event) async{
      html.File file = uploadInput.files.first;
      final reader = html.FileReader();
      reader.readAsDataUrl(file);

      setState(() {
        image = file;
        imageController.text = file.name;
      });
    });
  }

  void showInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            width: 600,
            margin: EdgeInsets.only(left : 20, right : 40, top : 50, bottom : 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top : 20, left : 20),
                  child: Text(
                    "Defaulter Student Details",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top : 20, bottom : 40, left : 20),
                  child: Divider(
                    color: Colors.black,
                    thickness: 1,
                  ),
                ),

                Center(
                  child: Container(
                    height: 300,
                    width: 600,
                    child: Image.network(studentPhoto),
                  ),
                ),

                SizedBox(
                  height: 30,
                ),

                Container(
                  child: Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left : 20),
                              width: 200,
                              child: Text(
                                "GR Number : ",
                                style: TextStyle(
                                  fontSize: 20
                                ),
                              ),
                            ),

                            Expanded(
                              child : Container(
                                margin: EdgeInsets.only(right : 20),
                                padding: EdgeInsets.only(left : 10),
                                child: Text(
                                  studentGrno,
                                  style: TextStyle(
                                    fontSize: 20
                                  ),
                                )
                              )
                            )
                          ],
                        ),

                        SizedBox(
                          height: 30,
                        ),

                        Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left : 20),
                              width: 200,
                              child: Text(
                                "Name : ",
                                style: TextStyle(
                                  fontSize: 20
                                ),
                              ),
                            ),

                            Expanded(
                              child : Container(
                                margin: EdgeInsets.only(right : 20),
                                padding: EdgeInsets.only(left : 10),
                                child: Text(
                                  studentName,
                                  style: TextStyle(
                                    fontSize: 20
                                  ),
                                )
                              )
                            )
                          ],
                        ),

                        SizedBox(
                          height: 30,
                        ),

                        Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left : 20),
                              width: 200,
                              child: Text(
                                "Email : ",
                                style: TextStyle(
                                  fontSize: 20
                                ),
                              ),
                            ),

                            Expanded(
                              child : Container(
                                margin: EdgeInsets.only(right : 20),
                                padding: EdgeInsets.only(left : 10),
                                child: Text(
                                  studentEmail,
                                  style: TextStyle(
                                    fontSize: 20
                                  ),
                                )
                              )
                            )
                          ],
                        ),

                        SizedBox(
                          height: 30,
                        ),

                        Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left : 20),
                              width: 200,
                              child: Text(
                                "Phone : ",
                                style: TextStyle(
                                  fontSize: 20
                                ),
                              ),
                            ),

                            Expanded(
                              child : Container(
                                margin: EdgeInsets.only(right : 20),
                                padding: EdgeInsets.only(left : 10),
                                child: Text(
                                  studentphone,
                                  style: TextStyle(
                                    fontSize: 20
                                  ),
                                )
                              )
                            )
                          ],
                        ),

                        SizedBox(
                          height: 30,
                        ),

                        Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left : 20),
                              width: 200,
                              child: Text(
                                "Year : ",
                                style: TextStyle(
                                  fontSize: 20
                                ),
                              ),
                            ),

                            Expanded(
                              child : Container(
                                margin: EdgeInsets.only(right : 20),
                                padding: EdgeInsets.only(left : 10),
                                child: Text(
                                  studentYear,
                                  style: TextStyle(
                                    fontSize: 20
                                  ),
                                )
                              )
                            )
                          ],
                        ),

                        SizedBox(
                          height: 30,
                        ),

                        Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left : 20),
                              width: 200,
                              child: Text(
                                "Default Photo : ",
                                style: TextStyle(
                                  fontSize: 20
                                ),
                              ),
                            ),

                            IconButton(
                              onPressed: (){
                                js.context.callMethod('open', [studentDefaultPhoto]);
                              }, 

                              icon: Icon(Icons.collections_outlined),
                              color: Color(0xFF34A853),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void showAddDialog(BuildContext context, bool edit) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            width: 600,
            height : 700,
            margin: EdgeInsets.only(left : 20, right : 40, top : 50, bottom : 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if (edit == false)
                Container(
                  margin: EdgeInsets.only(top : 20, left : 20),
                  child: Text(
                    "Add Student Form",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),

                if (edit == true)
                Container(
                  margin: EdgeInsets.only(top : 20, left : 20),
                  child: Text(
                    "Update Student Details",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top : 20, bottom : 40, left : 20, right: 20),
                  child: Divider(
                    color: Colors.black,
                    thickness: 1,
                  ),
                ),

                Container(
                  child: Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left : 20),
                              width: 140,
                              child: Text(
                                "GR Number : ",
                                style: TextStyle(
                                  fontSize: 20
                                ),
                              ),
                            ),

                            Expanded(
                              child : Container(
                                margin: EdgeInsets.only(right : 20),
                                padding: EdgeInsets.only(left : 10),
                                height: 42,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black)
                                ),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Enter student GR Number"
                                  ),
                                  keyboardType: TextInputType.name,
                                  controller: grnoController,
                                  textAlignVertical: TextAlignVertical.center,
                                )
                              )
                            )
                          ],
                        ),

                        SizedBox(
                          height: 30,
                        ),

                        Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left : 20),
                              width: 140,
                              child: Text(
                                "Name : ",
                                style: TextStyle(
                                  fontSize: 20
                                ),
                              ),
                            ),

                            Expanded(
                              child : Container(
                                margin: EdgeInsets.only(right : 20),
                                padding: EdgeInsets.only(left : 10),
                                height: 42,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black)
                                ),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Enter student name"
                                  ),
                                  keyboardType: TextInputType.name,
                                  controller: nameController,
                                  textAlignVertical: TextAlignVertical.center,
                                )
                              )
                            )
                          ],
                        ),

                        SizedBox(
                          height: 30,
                        ),

                        Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left : 20),
                              width: 140,
                              child: Text(
                                "Email : ",
                                style: TextStyle(
                                  fontSize: 20
                                ),
                              ),
                            ),

                            Expanded(
                              child : Container(
                                margin: EdgeInsets.only(right : 20),
                                padding: EdgeInsets.only(left : 10),
                                height: 42,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black)
                                ),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Enter student email"
                                  ),
                                  keyboardType: TextInputType.name,
                                  controller: emailController,
                                  textAlignVertical: TextAlignVertical.center,
                                )
                              )
                            )
                          ],
                        ),

                        SizedBox(
                          height: 30,
                        ),

                        Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left : 20),
                              width: 140,
                              child: Text(
                                "Phone : ",
                                style: TextStyle(
                                  fontSize: 20
                                ),
                              ),
                            ),

                            Expanded(
                              child : Container(
                                margin: EdgeInsets.only(right : 20),
                                padding: EdgeInsets.only(left : 10),
                                height: 42,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black)
                                ),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Enter phone number"
                                  ),
                                  keyboardType: TextInputType.name,
                                  controller: phnoController,
                                  textAlignVertical: TextAlignVertical.center,
                                )
                              )
                            )
                          ],
                        ),

                        SizedBox(
                          height: 30,
                        ),

                        Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left : 20),
                              width: 140,
                              child: Text(
                                "Year : ",
                                style: TextStyle(
                                  fontSize: 20
                                ),
                              ),
                            ),

                            Expanded(
                              child : Container(
                                margin: EdgeInsets.only(right : 20),
                                padding: EdgeInsets.only(left : 10),
                                height: 42,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black)
                                ),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Enter year of study"
                                  ),
                                  keyboardType: TextInputType.name,
                                  controller: yearController,
                                  textAlignVertical: TextAlignVertical.center,
                                )
                              )
                            )
                          ],
                        ),

                        SizedBox(
                          height: 30,
                        ),

                        Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left : 20),
                              width: 140,
                              child: Text(
                                "Photo : ",
                                style: TextStyle(
                                  fontSize: 20
                                ),
                              ),
                            ),

                            ElevatedButton(
                              onPressed: (){
                                selectImage();
                              }, 
                              child: Text("Choose Image"),
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(0)),
                                ),
                                minimumSize: Size(80, 50.8),
                                shadowColor: Colors.white
                              ),
                            ),

                            Expanded(
                              child : Container(
                                margin: EdgeInsets.only(right : 20),
                                padding: EdgeInsets.only(left : 10),
                                height: 42,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black)
                                ),
                                child: TextFormField(
                                  enabled: false,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "",
                                  ),
                                  keyboardType: TextInputType.name,
                                  controller: imageController,
                                  textAlignVertical: TextAlignVertical.center,

                                )
                              )
                            )
                          ],
                        ),

                        SizedBox(
                          height: 30,
                        ),

                        Container(
                          margin: EdgeInsets.only(left : 20, right: 20),
                          child: ElevatedButton(
                            child: Text(
                              "Submit",
                              style: TextStyle(
                                fontSize: 20
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(780, 60)
                            ),
                            onPressed: () async{
                              

                              StudentModel student = StudentModel(
                                grno: grnoController.text,
                                name: nameController.text,
                                email: emailController.text,
                                phone: phnoController.text,
                                year: yearController.text
                              );

                              String path = "Photos/" + student.grno + "/" + student.grno;
                              await FirebaseStorage.instance.ref().child(path).putBlob(image);
                              String downloadURL = await FirebaseStorage.instance.ref(path).getDownloadURL();
                              //print (downloadURL);

                              StudentModel student1 = StudentModel(
                                grno: grnoController.text,
                                name: nameController.text,
                                email: emailController.text,
                                phone: phnoController.text,
                                year: yearController.text,
                                imgUrl: downloadURL
                              );

                              await fs.addNewStudent(student1);

                              grnoController.text = "";
                              nameController.text = "";
                              emailController.text = "";
                              phnoController.text = "";
                              yearController.text = "";
                              imageController.text = "";

                              image = null;
                              
                              if (edit == true){
                                final snackText = SnackBar(content: Text("Update Successful"));
                                ScaffoldMessenger.of(context).showSnackBar(snackText);
                              }

                              if (edit == false){
                                final snackText = SnackBar(content: Text("Student Successfully Added"));
                                ScaffoldMessenger.of(context).showSnackBar(snackText);
                              }

                              getAllStudents();
                              Navigator.pop(context);
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void getallDefaulters() async{
    defaulterRows.clear();
    fs.getAllDefaulters().then((temp){
      setState(() {
        defaulterRows.add(TableRow(
        children: [
          Container(
            height: 60,
            padding: EdgeInsets.only(left : 5, right : 5, bottom: 15, top : 15),
            child : Text(
              "#",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold
              ),
            ),
          ),

          Container(
            height: 60,
            padding: EdgeInsets.only(left : 5, right : 5, bottom: 15, top : 15),
            child : Text(
              "Name",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold
              ),
            ),
          ),

          Container(
            height: 60,
            padding: EdgeInsets.only(left : 5, right : 5,bottom: 15, top : 15),
            child : Text(
              "Default Timestamp",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold
              ),
            ),
          ),

          Container(
            height: 60,
            padding: EdgeInsets.only(left : 5, right : 5, bottom: 15, top : 15),
            child : Center(
              child: Text(
                "Defaulter Photo",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold
                ),
              ),
            )
          ),

          Container(
            height: 60,
            padding: EdgeInsets.only(left : 5, right : 5, bottom: 15, top : 15),
            child : Center(
              child: Text(
                "Actions",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold
                ),
              ),
            )
          ),
          ]
        ));

        for (int i = 0; i < temp.docs.length; i++){
            defaulterRows.add(
              TableRow(
                children: [
                  Container(height: 60,
                    padding: EdgeInsets.only(left : 5, right : 5, bottom: 15, top : 15),
                    child : Text(
                      (i+1).toString(),
                      style: TextStyle(
                        fontSize: 22,
                      ),
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.only(left : 5, right : 5, bottom: 15, top : 15),
                    child : Text(
                      temp.docs[i].data()['Name'].toString(),
                      style: TextStyle(
                        fontSize: 22,
                      ),
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.only(left : 5, right : 5, bottom: 15, top : 15),
                    child : Text(
                      temp.docs[i].data()['Default_Time'].toString(),
                      style: TextStyle(
                        fontSize: 22,
                      ),
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.only(left : 5, right : 5, bottom: 15, top : 15),
                    child : Center(
                      child: IconButton(
                        icon: Icon(Icons.collections_outlined), 
                        onPressed: (){
                          js.context.callMethod('open', [temp.docs[i].data()['Default_Photo'].toString()]);
                        },
                        color: Color(0XFF34A853),
                      ),
                    )
                  ),

                  Container(
                    padding: EdgeInsets.only(left : 5, right : 5, bottom: 15, top : 15),
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.info_outline), 
                          onPressed: () async{
                            studentDefaultPhoto = temp.docs[i].data()['Default_Photo'].toString();
                            getStudentInfo(temp.docs[i].id.toString());
                          },
                          color: Color (0xFF2F84FB),
                        ),

                        IconButton(
                          icon: Icon(Icons.email_outlined), 
                          onPressed: (){

                          },
                          color: Color (0xFFFBBC04),
                        ),

                        IconButton(
                          icon: Icon(Icons.delete_outline), 
                          onPressed: () async{
                            fs.deleteDefaulterStudent(temp.docs[i].id.toString());
                            getallDefaulters();
                            final snackText = SnackBar(content: Text("Delete Successful"));
                            ScaffoldMessenger.of(context).showSnackBar(snackText);
                          },
                          color: Color (0xFFEA4335),
                        ),
                      ],
                    ),
                  )
                ]
              )
            );
          }
      });
    });
  }

  void getAllStudents() async{
    rows.clear();
    fs.getAllStudents().then((temp){
      setState(() {
        rows.add(TableRow(
        children: [
          Container(
            height: 60,
            padding: EdgeInsets.only(left : 5, right : 5, bottom: 15, top : 15),
            child : Text(
              "GR No.",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold
              ),
            ),
          ),

          Container(
            height: 60,
            padding: EdgeInsets.only(left : 5, right : 5, bottom: 15, top : 15),
            child : Text(
              "Name",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold
              ),
            ),
          ),

          Container(
            height: 60,
            padding: EdgeInsets.only(left : 5, right : 5,bottom: 15, top : 15),
            child : Text(
              "Email",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold
              ),
            ),
          ),

          Container(
            height: 60,
            padding: EdgeInsets.only(left : 5, right : 5, bottom: 15, top : 15),
            child : Text(
              "Phone",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold
              ),
            ),
          ),

          Container(
            height: 60,
            padding: EdgeInsets.only(left : 5, right : 5, bottom: 15, top : 15),
            child : Text(
              "Year",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold
              ),
            ),
          ),

          Container(
            height: 60,
            padding: EdgeInsets.only(left : 5, right : 5, bottom: 15, top : 15),
            child : Center(
              child: Text(
                "Photo",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold
                ),
              ),
            )
          ),

          Container(
            height: 60,
            padding: EdgeInsets.only(left : 5, right : 5, bottom: 15, top : 15),
            child : Text(
              " ",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold
              ),
            ),
          ),

          Container(
            height: 60,
            padding: EdgeInsets.only(left : 5, right : 5, bottom: 15, top : 15),
            child : Text(
              " ",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold
              ),
            ),
          ),

          
          ]
        ));

          for (int i = 0; i < temp.docs.length; i++){
            rows.add(
              TableRow(
                children: [
                  Container(height: 60,
                    padding: EdgeInsets.only(left : 5, right : 5, bottom: 15, top : 15),
                    child : Text(
                      temp.docs[i].data()['GRno'].toString(),
                      style: TextStyle(
                        fontSize: 22,
                      ),
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.only(left : 5, right : 5, bottom: 15, top : 15),
                    child : Text(
                      temp.docs[i].data()['Name'].toString(),
                      style: TextStyle(
                        fontSize: 22,
                      ),
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.only(left : 5, right : 5, bottom: 15, top : 15),
                    child : Text(
                      temp.docs[i].data()['Email'].toString(),
                      style: TextStyle(
                        fontSize: 22,
                      ),
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.only(left : 5, right : 5, bottom: 15, top : 15),
                    child : Text(
                      temp.docs[i].data()['Phone'].toString(),
                      style: TextStyle(
                        fontSize: 22,
                      ),
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.only(left : 5, right : 5, bottom: 15, top : 15),
                    child : Text(
                      temp.docs[i].data()['Year'].toString(),
                      style: TextStyle(
                        fontSize: 22,
                      ),
                    ),
                  ),


                  if (temp.docs[i].data()['Photo'].toString() != "null")
                  Container(
                    padding: EdgeInsets.only(left : 5, right : 5, bottom: 15, top : 15),
                    child : Center(
                      child: IconButton(
                        icon: Icon(Icons.collections_outlined), 
                        onPressed: (){
                          js.context.callMethod('open', [temp.docs[i].data()['Photo'].toString()]);
                        },
                        color: Color(0XFF34A853),
                      ),
                    )
                  ),

                  if (temp.docs[i].data()['Photo'].toString() == "null")
                  Container(
                    child: Center(
                      child : Text(
                        "NA",
                        style: TextStyle(
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.only(left : 5, right : 5, bottom: 15, top : 15),
                    child : Center(
                      child: IconButton(
                        icon: Icon(Icons.edit_outlined), 
                        onPressed: (){
                          grnoController.text = temp.docs[i].data()['GRno'].toString();
                          nameController.text = temp.docs[i].data()['Name'].toString();
                          emailController.text = temp.docs[i].data()['Email'].toString();
                          phnoController.text = temp.docs[i].data()['Phone'].toString();
                          yearController.text = temp.docs[i].data()['Year'].toString();

                          showAddDialog(context, true);

                          
                        },
                        color: Color(0xFFEA4335),
                      ),
                    )
                  ),

                  Container(
                    padding: EdgeInsets.only(left : 5, right : 5, bottom: 15, top : 15),
                    child : Center(
                      child: IconButton(
                        icon: Icon(Icons.delete_outline), 
                        onPressed: () async{
                          await fs.deleteStudentDatabase(temp.docs[i].data()['GRno'].toString());
                          await fs.deleteDefaulterStudent(temp.docs[i].data()['GRno'].toString());
                          final snackText = SnackBar(content: Text("Delete Successful"));
                          ScaffoldMessenger.of(context).showSnackBar(snackText);
                          getAllStudents();
                        },
                        color: Color(0xFFEA4335),
                      ),
                    )
                  ),
                ]
              )
            );
          }
        
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf6f6f6),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left : 25, right: 25),
              height: 80,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Color(0xFF707070)),
                ),
                color: Colors.white
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[                  
                  Container(
                    child: Row(
                    children :  <Widget>[ 
                      Container(
                        child: Image.asset("lib/logo_text.png", height: 60,)
                      ),
                      Container(
                        margin: EdgeInsets.only(left : 40),
                        child: TextButton(
                          child: Text(
                            "Dashboard".toUpperCase(),
                            style: TextStyle(
                              color: dashBoardPressed?Color(0xFF2F84FB) : Colors.black,
                              fontSize: 22,
                            ),
                          ),
                          onPressed: (){
                            setState(() {
                              dashBoardPressed = true;
                              databasePressed = false;
                              defaultersPressed = false;
                            });
                          },
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(left : 40),
                        child: TextButton(
                          child: Text(
                            "Defaulters".toUpperCase(),
                            style: TextStyle(
                              color: defaultersPressed?Color(0xFF2F84FB) : Colors.black,
                              fontSize: 22,
                            ),
                          ),
                          onPressed: (){
                            getallDefaulters();
                            setState(() {
                              dashBoardPressed = false;
                              databasePressed = false;
                              defaultersPressed = true;
                            });
                          },
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(left : 40),
                        child: TextButton(
                          child: Text(
                            "Database".toUpperCase(),
                            style: TextStyle(
                              color: databasePressed?Color(0xFF2F84FB) : Colors.black,
                              fontSize: 22,
                            ),
                          ),
                          onPressed: (){
                            getAllStudents();
                            setState(() {
                              dashBoardPressed = false;
                              databasePressed = true;
                              defaultersPressed = false;
                            });
                          },
                        ),
                      ),
                      ]
                    ),
                  ),

                  Container(
                    child: ElevatedButton(
                      onPressed: () async{
                        await FirebaseAuth.instance.signOut();
                        Navigator.pop(context);
                      },

                      child: Text(
                        "Sign Out".toUpperCase(),
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xFF2F84FB)
                        ),
                      ),

                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(100, 50),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(5),
                        ),
                        side: BorderSide(
                          color: Color(0xFF2F84FB)
                        ),
                        primary: Colors.white,
                        shadowColor: Colors.white
                      ),
                    ),
                  )
                ],
              ),
            ),

            if (dashBoardPressed)
            Text("dashboard"),

            if (defaultersPressed)
            Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left : 60, right : 60, top : 50),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xFF9F9F9F),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(0)),
                    color: Colors.white
                  ),
                  child: Table(
                    border: TableBorder(horizontalInside: BorderSide(width: 1, color: Color(0xFF9F9F9F), style: BorderStyle.solid)),
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    columnWidths: const <int, TableColumnWidth>{
                      0: FixedColumnWidth(250),
                      1: FlexColumnWidth(),
                      2: FlexColumnWidth(),
                      3: FixedColumnWidth(250),
                      4: FixedColumnWidth(130),
                    },

                    children: defaulterRows,
                  ),
                )
              ],
            ),

            if (databasePressed)
            Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right : 75, top: 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[

                      /*IconButton(
                        icon: Icon(Icons.add), 
                        onPressed: (){
                          setState(() {
                            databaseAddPressed = true;
                            databaseUpdatePressed = false;
                            showAddDialog(context);
                          });
                        },
                        color:  databaseAddPressed?Color(0xFF2F84FB) : Colors.black,
                      ),*/

                      ElevatedButton(
                        onPressed: (){
                          grnoController.text = "";
                          nameController.text = "";
                          emailController.text = "";
                          phnoController.text = "";
                          yearController.text = "";
                          imageController.text = "";
                          showAddDialog(context, false);
                        }, 
                        
                        child: Text(
                          "Add",
                          style: TextStyle(
                            fontSize: 22
                          ),
                        ),

                        style:  ElevatedButton.styleFrom(
                          primary: Color(0xFF2F84FB),
                          minimumSize: Size(100, 50)
                        ),
                      )
                    ],
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(left : 60, right : 60, top : 15),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xFF9F9F9F),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(0)),
                    color: Colors.white
                  ),
                  child: Table(
                    border: TableBorder(horizontalInside: BorderSide(width: 1, color: Color(0xFF9F9F9F), style: BorderStyle.solid)),
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    columnWidths: const <int, TableColumnWidth>{
                      0: FixedColumnWidth(150),
                      1: FlexColumnWidth(),
                      2: FlexColumnWidth(),
                      3: FlexColumnWidth(),
                      4: FixedColumnWidth(90),
                      5: FixedColumnWidth(90),
                      6: FixedColumnWidth(90),                      
                      7: FixedColumnWidth(90),
                    },

                    children: rows,
                  ),
                )
              ],
            )
          ],
        )
      ),
    );
  }
}