import 'package:edi_project/homeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: <Widget>[
            Container(
              child: Image.asset("lib/login_page.png"),
            ),

            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFF707070)),
                  color: Colors.white
                ),
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Container(
                        child: Image.asset("lib/logo_login.png"),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),

                    Center(
                      child : Container(
                        child: Text(
                          "Sign in to your Account",
                          style: TextStyle(
                            fontSize: 35,
                            color: Color(0xFF707070),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 30,
                    ),

                    Container(
                      margin: EdgeInsets.only(left : 160),
                      child: Text(
                        "Username : ",
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF707070)
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 10,
                    ),

                    Center(
                      child: Container(
                        padding: EdgeInsets.only(left : 10),
                        height: 42,
                        width: 390,
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xFF707070)),
                          color: Color(0xFFF6F6F6)
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter username",
                          ),
                          keyboardType: TextInputType.name,
                          controller: emailController,
                          textAlignVertical: TextAlignVertical.center,
                        )
                      ),
                    ),

                    SizedBox(
                      height: 15,
                    ),

                    Container(
                      margin: EdgeInsets.only(left : 160),
                      child: Text(
                        "Password : ",
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF707070)
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 10,
                    ),
                    
                    Center(
                      child: Container(
                        padding: EdgeInsets.only(left : 10),
                        height: 42,
                        width: 390,
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xFF707070)),
                          color: Color(0xFFF6F6F6)
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter password"
                          ),
                          keyboardType: TextInputType.visiblePassword,
                          controller: passwordController,
                          textAlignVertical: TextAlignVertical.center,
                          obscureText: true,
                        )
                      ),
                    ),

                    SizedBox(
                      height: 15,
                    ),

                    Center(
                      child: Container(
                        child: ElevatedButton(
                          child: Text(
                            "Sign in".toUpperCase(),
                            style: TextStyle(
                              fontSize: 20,
                            ) ,
                          ),
                          onPressed: () async{
                            String email = emailController.text;
                            String password = passwordController.text;
                            try {
                              UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                                email: email,
                                password: password
                              );

                              print(userCredential.user);

                              emailController.text = "";
                              passwordController.text = "";

                              Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'user-not-found') {
                                print('No user found for that email.');
                              } else if (e.code == 'wrong-password') {
                                print('Wrong password provided for that user.');
                              }
                            }
                          },

                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFF2F84FB),
                            minimumSize: Size(403, 60),
                            shadowColor: Colors.white
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            )
          ],
        )
      ),
    );
  }
}