import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Firebase{
User? user= FirebaseAuth.instance.currentUser;
Future<void> AddContact(String name, String phoneNumber) async {
  try {
    // Query Firestore for the user by phone number
    QuerySnapshot query = await FirebaseFirestore.instance
        .collection('users')
        .where('phoneNumber', isEqualTo: phoneNumber)
        .get();

    if (query.docs.isEmpty) {
      print("User with phone number $phoneNumber not found.");
      Get.snackbar('Error', 'User not registered',snackPosition: SnackPosition.BOTTOM);
    }
        String contactUid = query.docs.first.id;

Map<String,dynamic> data={"name":name,"phoneNumber":phoneNumber, "uid": contactUid};

    // Add the contact with the UID
    FirebaseFirestore.instance.collection('users').doc(user!.uid).collection("contacts").add(data);

    // print("Contact added successfully!");
  } catch (e) {
    print("Error: ${e.toString()}");
  }
}
}