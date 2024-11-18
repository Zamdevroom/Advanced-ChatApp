import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
  import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wa_business/Screens/Login_screen.dart';

class SignupScreen extends StatefulWidget{
  final String name;
  final String Email;
  final int Phonenumber;
  final String password;

  SignupScreen({super.key,required this.Email,required this.Phonenumber,required this.name,required this.password});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController namecontroller= TextEditingController();

    TextEditingController emailcontroller= TextEditingController();

  TextEditingController phonecontroller= TextEditingController();

    TextEditingController passwordcontroller= TextEditingController();

  final _formKey = GlobalKey<FormState>(); 

 var _obsecure= true;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> createUserWithEmailAndPassword(String name, String email, String password, String phoneNumber) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'name': name,
          'email': email,
          'phoneNumber': phoneNumber,
        });
        return user.uid;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The email address is already in use.');
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Signup'),backgroundColor: Colors.green,
      ),
      body: 
      Form(
        key: _formKey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: namecontroller,
                    validator: (value) {
                      if(value!.isEmpty){
                       return 'Enter Email';
                      }
                      else if(
                        value.contains('@')
                      ){
                         return 'Enter valid email address';
                      }
                    },
                    decoration: InputDecoration(hintText: 'Name',labelText: 'Enter Name',border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black),borderRadius: BorderRadius.circular(20))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: emailcontroller,
                    validator: (value) {
                      if(value!.isEmpty){
                       return 'Enter Name';
                      }},
                    decoration: InputDecoration(hintText: 'abc@.com',labelText: 'Enter Email',border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black),borderRadius: BorderRadius.circular(20) )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: phonecontroller,
                     validator: (value) {
                      if(value!.isEmpty){
                       return 'Enter PhoneNumber';
                      }},
                    decoration: InputDecoration(hintText: '0333',labelText: 'Enter PhoneNumber',border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black),borderRadius: BorderRadius.circular(20))),
                  ),
                ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      obscuringCharacter: '*',
                      obscureText: _obsecure,
                      controller: passwordcontroller,
                      decoration: InputDecoration(border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black,),borderRadius: BorderRadius.circular(20)),
                        labelText: 'Enter password',
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _obsecure = !_obsecure;
                            });
                          },
                          icon: _obsecure ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
                        ),
                      ),
                    ),
                  ),
            
                Padding(
                  padding: const EdgeInsets.only(left: 100,right: 100),
                  child: ElevatedButton(onPressed: (){
                    
                    createUserWithEmailAndPassword(namecontroller.text, emailcontroller.text, passwordcontroller.text, phonecontroller.text);
                    namecontroller.clear();
                    emailcontroller.clear();
                    passwordcontroller.clear();
                    phonecontroller.clear();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Signup successful")));
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>  ));
                  }, child: Text("SignUp"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 90),
                  child: Row(
                    children: [
                      Text('Already have an account?'),
                      TextButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen(email: '', password: '')));
                      }, child: Text("Login"))
                      
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      )
      ,
    );
  }
}