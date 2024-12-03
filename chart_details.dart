import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wa_business/Screens/chats.dart';

class UsersScreen extends StatelessWidget {
  final String currentUserId;

  const UsersScreen({Key? key, required this.currentUserId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
        backgroundColor: Colors.green,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          List<QueryDocumentSnapshot> docs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> user =
                  docs[index].data() as Map<String, dynamic>;

              String recipientId = user['uid'];
              String recipientName = user['name'] ?? 'Unknown User';
              String? profileImageUrl = user[
                  'profileImageUrl']; // Assuming profileImageUrl is the field storing the image URL

              // Exclude the current user from the list
              if (recipientId == currentUserId) {
                return const SizedBox.shrink(); // Skip the current user
              }

              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatsScreen(
                        currentUserId: currentUserId,
                        recipientId: recipientId,
                        recipientName: recipientName,
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      // Display image if available, otherwise show a fallback letter
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.green,
                        backgroundImage: profileImageUrl != null
                            ? NetworkImage(
                                profileImageUrl) // Load image from URL
                            : null, // No image case
                        child: profileImageUrl == null
                            ? Text(
                                recipientName[0]
                                    .toUpperCase(), // Display first letter of the name as fallback
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              )
                            : null, // No fallback when image is present
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              recipientName,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 5),
                            // You can add more styling here if needed
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
