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

<<<<<<< HEAD
import '../Islam/check.dart';
import '../Islam/navBar.dart';

=======
>>>>>>> origin/master
class Contacts extends StatefulWidget {
  const Contacts({super.key});

  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  User? user = FirebaseAuth.instance.currentUser;
      final String _auth= FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    final double screen_height = MediaQuery.of(context).size.height;
    final double screen_width = MediaQuery.of(context).size.width;

    return 
       Scaffold(
        appBar: AppBar(
          title: const Text('USER Contacts'),
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
                                ?.substring(0, 1) ??
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
<<<<<<< HEAD
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NavBar(),
                    ),
                  );
                },
                leading: const Icon(Icons.mosque),
                title: const Text('Islam'),
              ),
              ListTile(
=======
>>>>>>> origin/master
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
                return Padding(
                  padding: EdgeInsets.all(screen_width * 0.012),
                  child: GestureDetector(
                    onTap: (){
                      Get.to(ChatPage(User_name: data[index]["name"],receiverid: _auth));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(50)),
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Text(data[index]["name"][0]),
                        ),
                        title: Text(data[index]["name"]),
                        subtitle: Text(data[index]["phone"]),
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
          child: const Icon(Icons.add),
        ),
      );
    
  }
}
