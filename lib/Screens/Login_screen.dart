import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wa_business/Screens/contacts.dart';
import 'package:wa_business/chart_details.dart';



class LoginScreen extends StatefulWidget{
  String email;
  String password;
LoginScreen({super.key,required this.email,required this.password});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>(); 

TextEditingController emailcontroller=TextEditingController();

TextEditingController passwordcontroller=TextEditingController();

 var _obsecure=true;

  Future<void> signIn() async {
    try
 {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailcontroller.text,
        password: 
 passwordcontroller.text,
      );
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Contacts()));
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('login Successful')));


    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('No User exists')));

        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Invalid password')));
        print('Wrong password provided.');
      }
    }
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 231, 225, 225),
      appBar: AppBar(title: Text('Login Screen'),backgroundColor: Colors.green,),
      body: 
        Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                     validator: (value) {
                      if(value!.isEmpty){
                       return 'Enter Email';
                      }
                      else if(
                        value.contains('@')
                      ){
                         return 'Enter valid email address';
                      }},
                  controller: emailcontroller,
                  decoration: InputDecoration(labelText: 'Enter Email',hintText: '@gmail.com',border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black,),borderRadius: BorderRadius.circular(20))),
                  ),
                ),
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: TextFormField(
                    controller: passwordcontroller,
                    decoration: InputDecoration(border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black,),borderRadius: BorderRadius.circular(20)),labelText: 'Enter password',suffixIcon:IconButton(onPressed: (){
                         
                            setState(() {
                              _obsecure = !_obsecure;
                            });
                          
                      
                    }, icon: _obsecure? Icon(Icons.visibility): Icon(Icons.visibility_off)) ),
                    obscureText: _obsecure,
                    obscuringCharacter: '*',
                  ),
             ),
              ElevatedButton(onPressed: (){
                signIn();
                emailcontroller.clear();
                passwordcontroller.clear();
                if(_formKey.currentState!.validate()){
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login successful")));

                    }
                    else{
                                          ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please fill all fields')),
                    );

                    }
                // Navigator.push(context, MaterialPageRoute(builder: (context) => ));
              }, child: Text('LogIn'))
              ],
            ),
          ),
        )
      
    );
  }
}
  


