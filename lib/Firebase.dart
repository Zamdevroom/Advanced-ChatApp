import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Firebase{
User? user= FirebaseAuth.instance.currentUser;
Future AddContact(String name,String Phone)async{
Map<String,dynamic> data={"name":name,"phone":Phone};
try{
  await FirebaseFirestore.instance.collection("users").doc(user!.uid).collection("contacts").add(data);
  print("successfully added");
}
catch(e){
  print(e.toString());
}
}
}