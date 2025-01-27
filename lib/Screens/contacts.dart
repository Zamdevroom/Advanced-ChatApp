import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:wa_business/Firebase.dart';
import 'package:wa_business/Screens/Login_screen.dart';
import 'package:wa_business/Screens/add_contacts.dart';
import 'package:get/get.dart';
import 'package:wa_business/Screens/chat_page.dart';
import 'package:wa_business/Screens/chats.dart';
import 'package:share_plus/share_plus.dart';

class Contacts extends StatefulWidget {
  const Contacts({super.key});

  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  User? user = FirebaseAuth.instance.currentUser;
      final String _auth= FirebaseAuth.instance.currentUser!.uid;
      void InviteUser(){
        Share.share('check out my website https://example.com');
        
      }
  @override
  Widget build(BuildContext context) {
    final double screen_height = MediaQuery.of(context).size.height;
    final double screen_width = MediaQuery.of(context).size.width;

    return 
       Scaffold(
        backgroundColor: const Color.fromARGB(255, 176, 175, 175),
        appBar: AppBar(
          title: const Text(' Contacts'),
          backgroundColor: Colors.green,
          actions: [
            Icon(Icons.group_add,)
          ],
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      child: Text(
                        FirebaseAuth.instance.currentUser?.email
                                ?.substring(0, 1).toUpperCase() ??
                            "?",
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      FirebaseAuth.instance.currentUser?.email ?? "No Email",
                    ),
                  ],
                ),
              ),
              ListTile(
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Logged Out")),
                  );
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          LoginScreen(email: '', password: ''),
                    ),
                  );
                },
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
              ),
            ],
          ),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("users")
              .doc(user!.uid)
              .collection("contacts")
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              print("Error: ${snapshot.error}");
              return const Center(
                child: Text("Something went wrong"),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              print("Loading data...");
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              print("No contacts found");
              return const Center(
                child: Text("No Contacts Found ..."),
              );
            }

            final data = snapshot.data!.docs;

            return ListView.builder(
  itemCount: data.length,
  itemBuilder: (context, index) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(screen_width * 0.012),
        child: GestureDetector(
          onTap: () {
            try {
              Get.to(ChatPage(
                User_name: data[index]["name"],
                receiverid: data[index]["uid"],
              ));}
            
                 catch(e){      Get.snackbar('Error', 'User not found',duration: Duration(seconds: 2),backgroundColor: const Color.fromARGB(255, 108, 241, 124),snackPosition: SnackPosition.BOTTOM,mainButton: TextButton(onPressed: (){InviteUser();} , child: Text('Invite')));
                 }
            
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(50),
            ),
            child: ListTile(
              leading: CircleAvatar(
                child: Text(data[index]["name"][0]),
              ),
              title: Text(data[index]["name"]),
              // subtitle: Text(data[index]["phoneNumber"]),
            ),
          ),
        ),
      ),
    );
  },
);

          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddContacts()),
            );
          },
          child: const Icon(Icons.person_add),
        ),
      );
    
  }
}
