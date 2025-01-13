import 'package:flutter/material.dart';
import 'package:wa_business/Firebase.dart';
import 'package:wa_business/Screens/contacts.dart';

class AddContacts extends StatefulWidget {
  const AddContacts({super.key});

  @override
  State<AddContacts> createState() => _AddContacts();
}

class _AddContacts extends State<AddContacts> {
  TextEditingController new_name=TextEditingController();
  TextEditingController new_phone=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          
          title: Text('Add contacts'),
        
        ),
        body: Column(
          children: [
            TextFormField(
                    controller: new_name,
                    
                    decoration: InputDecoration(labelText: 'Enter Name',border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black),borderRadius: BorderRadius.circular(20) )),
                  ),
                  TextFormField(
                    controller: new_phone,
                    
                    decoration: InputDecoration(labelText: 'Enter PhoneNumber',border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black),borderRadius: BorderRadius.circular(20) )),
                  ),
                  ElevatedButton(onPressed: (){
                    Firebase().AddContact(new_name.text, new_phone.text);
                  }, child: Text('Create'))
          ],
        ),
    );
  }
}
