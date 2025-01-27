import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wa_business/Screens/contacts.dart'; // Ensure this is the correct path for the Contacts screen

class LoginScreen extends StatefulWidget {
  String email;
  String password;

  LoginScreen({super.key, required this.email, required this.password});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  bool isLoading = false;
  var _obsecure = true;

  Future<void> signIn() async {
    setState(() {
      isLoading = true;
    });

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: emailcontroller.text.trim(),
        password: passwordcontroller.text,
      );

      setState(() {
        isLoading = false;
      });

      // Navigate to contacts screen after successful login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Contacts()),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login Successful')),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = false;
      });

      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No user found for that email.')),
        );
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid password')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed: ${e.message}')),
        );
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 231, 225, 225),
      appBar: AppBar(
        title: Text('Login Screen'),
        backgroundColor: Colors.green,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter Email';
                    } else if (!value.contains('@')) {
                      return 'Enter a valid email address';
                    }
                    return null;
                  },
                  controller: emailcontroller,
                  decoration: InputDecoration(
                    labelText: 'Enter Email',
                    hintText: '@gmail.com',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: passwordcontroller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter Password';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    labelText: 'Enter password',
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obsecure = !_obsecure;
                        });
                      },
                      icon: _obsecure
                          ? Icon(Icons.visibility)
                          : Icon(Icons.visibility_off),
                    ),
                  ),
                  obscureText: _obsecure,
                  obscuringCharacter: '*',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      signIn();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please fill all fields')),
                      );
                    }
                  },
                  child: isLoading
                      ? CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Text('Log In'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
