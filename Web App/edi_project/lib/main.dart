import 'package:edi_project/loginScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      home : LoginScreen(),
      debugShowCheckedModeBanner: false,
    )
  );
}
