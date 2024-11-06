import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wa_business/Screens/Login_screen.dart';

class contacts extends StatefulWidget {
  const contacts({super.key});

  @override
  State<contacts> createState() => _contactsState();
}

class _contactsState extends State<contacts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('contacts')),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(child: 
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  child: Text(FirebaseAuth.instance.currentUser!.email.toString()[0]),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(FirebaseAuth.instance.currentUser!.email.toString())
              ],
            )),
            ListTile(
                 onTap: (){FirebaseAuth.instance.signOut;
                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("LogOut"),));
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen(email: '', password: '')));
                 },
                 leading: Icon(Icons.logout),
                 title: Text('Logout'),
            )
          ],
        ),
      ),
      body: StreamBuilder(stream: FirebaseFirestore.instance.collection('contacts').snapshots(), builder:       (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
        if(snapshot.hasError){
          return Text("something went wrong");
        }
        if(snapshot.connectionState==ConnectionState.waiting){
          return CircularProgressIndicator();
        }
        else{
            return snapshot.data!.docs.length == 0
                ? Center(
                    child: Text("No Contacts Found ..."),
                  )
                : ListView(
                    children: snapshot.data!.docs
                        .map((DocumentSnapshot document) {
                          Map<String, dynamic> data =
                              document.data()! as Map<String, dynamic>;
                          return ListTile(
                          
                            leading: CircleAvatar(child: Text(data["name"][0])),
                            title: Text(data["name"]),
                            subtitle: Text(data["phone"]),
                            
                              
                            
                              
                              
                            );
                          
                        })
                        .toList()
                        .cast(),
                  );
        }
      })
    );
  }
}