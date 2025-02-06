import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  late String senderId;

  @override
  void initState() {
    super.initState();
    senderId = _auth.currentUser!.uid;
  }

  Future<void> sendMessage() async {
    if (messageController.text.trim().isEmpty) return;

    final String message = messageController.text.trim();
    final Timestamp timestamp = Timestamp.now();

    List<String> ids = [senderId, widget.receiverid];
    ids.sort();
    String chatroomID = ids.join('_');

    final messageData = {
      'message': message,
      'senderID': senderId,
      'receiverID': widget.receiverid,
      'timestamp': timestamp,
    };

    // Save the message to Firestore
    await FirebaseFirestore.instance
        .collection('Chat_Rooms')
        .doc(chatroomID)
        .collection('messages')
        .add(messageData);

    // Clear the input field
    messageController.clear();
  }

  Stream<QuerySnapshot> getMessages() {
    List<String> ids = [senderId, widget.receiverid];
    ids.sort();
    String chatroomID = ids.join('_');

    return FirebaseFirestore.instance
        .collection('Chat_Rooms')
        .doc(chatroomID)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Icon(Icons.call)
        ],
        backgroundColor: Colors.green,
        title: Text(
          widget.User_name,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: getMessages(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text("Error loading messages: ${snapshot.error}"),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final messages = snapshot.data!.docs;

                if (messages.isEmpty) {
                  return const Center(child: Text("No messages yet."));
                }

                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final isSender = message['senderID'] == senderId;
 
                    return Align(
                      alignment:
                          isSender ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color:
                              isSender ? Colors.green[100] : Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(message['message']),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 224, 222, 222),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: messageController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: 'Type a message...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: sendMessage,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
