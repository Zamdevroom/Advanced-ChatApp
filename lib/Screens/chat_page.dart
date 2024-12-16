import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wa_business/Screens/messages.dart';

class ChatPage extends StatefulWidget {
  final String User_name;
  final String receiverid;

  ChatPage({super.key, required this.User_name, required this.receiverid});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController messageController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> SendMessage(String ReceiverID, String message) async {
    final String CurrentUserID = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    Messages newMessage = Messages(
      message: message,
      receiverID: ReceiverID,
      senderEmail: currentUserEmail,
      senderID: CurrentUserID,
      timestamp: timestamp,
    );

    List<String> ids = [CurrentUserID, ReceiverID];
    ids.sort();
    String chatroomID = ids.join('_');

    await FirebaseFirestore.instance
        .collection('Chat_Rooms')
        .doc(chatroomID)
        .collection('messages') // Fixed collection name
        .add(newMessage.toMap());
  }

  Stream<QuerySnapshot> GetMessages(String userID, String otherUserID) {
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatroomID = ids.join('_');

    return FirebaseFirestore.instance
        .collection('Chat_Rooms')
        .doc(chatroomID)
        .collection("messages") // Fixed collection name
        .orderBy("timestamp", descending: false) // Fixed field name
        .snapshots();
  }

  void send_Message() async {
    if (messageController.text.isNotEmpty) {
      await SendMessage(widget.receiverid, messageController.text);
      print('Messages Sent..');
      messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          widget.User_name,
          overflow: TextOverflow.ellipsis,
        ),
        centerTitle: true,
        leading: SizedBox(
          width: 70,
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Get.back();
                },
              ),
              const SizedBox(width: 20),
              CircleAvatar(
                radius: 23,
                child: Text(
                  widget.User_name[0].toUpperCase(),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(child: _buildMessages()), // Message List
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(color:  Color.fromARGB(255, 224, 222, 222)),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: messageController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10)),
                        hintText: 'Type...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: send_Message,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

Widget _buildMessages() {
  String senderId = _auth.currentUser!.uid;
  return StreamBuilder<QuerySnapshot>(
    stream: GetMessages(senderId, widget.receiverid),
    builder: (context, snapshot) {
      if (snapshot.hasError) {
        return Center(child: Text("Error loading messages: ${snapshot.error}"));
      }
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
      }

      // Check for empty messages
      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
        return Center(child: Text("No messages yet. Start the conversation!"));
      }

      final messageWidgets = snapshot.data!.docs.map((doc) {
        return _buildMessageItem(doc);
      }).toList();

      return ListView(
        children: messageWidgets, // Display messages in fetched order
      );
    },
  );
}

Widget _buildMessageItem(DocumentSnapshot doc) {
  Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Align(
      alignment: data["senderID"] == _auth.currentUser!.uid
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        decoration: BoxDecoration(
          color: data["senderID"] == _auth.currentUser!.uid
              ? Colors.green
              : Colors.grey,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(10),
        child: Text(
          data["message"], // Fixed field reference
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
  );
}


}
