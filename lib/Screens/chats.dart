import 'package:flutter/material.dart';
import 'chart_details.dart';

class Chats extends StatefulWidget {
  const Chats({super.key});

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.message,
            color: Colors.white,
          ),
          backgroundColor: Colors.green[900],
          onPressed: () {},
        ),
        body: Container(
          child: ListView.builder(
              itemCount: chatData.length,
              itemBuilder: (context, i) {
                return Column(
                  children: [
                    Divider(
                      height: 10.0,
                    ),
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blueGrey,
                        backgroundImage: AssetImage(
                            chatData[i].avatar ?? "Screens/heart_image.png"),
                      ),
                      title: Text(
                        chatData[i].name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        chatData[i].message,
                        style: TextStyle(color: Colors.grey, fontSize: 15.0),
                      ),
                      trailing: Text(
                        chatData[i].time,
                        style: TextStyle(fontSize: 14.0, color: Colors.grey),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => chart_details()));
                      },
                    ),
                  ],
                );
              }),
        ),
      );
  }
}

class chatsModel {
  final String name;
  final String message;
  final String time;
  final String avatar;

  chatsModel(
      {required this.name,
      required this.message,
      required this.time,
      required this.avatar});
}

List<chatsModel> chatData = [
  chatsModel(
      name: "Hamza",
      message: "How are you?",
      time: "10:20 pm",
      avatar: "Screens/hamza.png"),
  chatsModel(
      name: "Hassan",
      message: "I am fine?",
      time: "10:22 pm",
      avatar: "Screens/hamza.png"),
  chatsModel(
      name: "Maryam",
      message: "oye kia kar raha ho?",
      time: "12:15 pm",
      avatar: "Screens/hamza.png"),
  chatsModel(
      name: "Hamza",
      message: "How are you?",
      time: "10:20 pm",
      avatar: "Screens/hamza.png"),
  chatsModel(
      name: "Hassan",
      message: "I am fine?",
      time: "10:22 pm",
      avatar: "Screens/heart_image.png"),
  chatsModel(
      name: "Maryam",
      message: "oye kia kar raha ho?",
      time: "12:15 pm",
      avatar: "Screens/hamza.png"),
  chatsModel(
      name: "Hamza",
      message: "How are you?",
      time: "10:20 pm",
      avatar: "Screens/hamza.png"),
  chatsModel(
      name: "Hassan",
      message: "I am fine?",
      time: "10:22 pm",
      avatar: "Screens/hamza.png"),
  chatsModel(
      name: "Maryam",
      message: "oye kia kar raha ho?",
      time: "12:15 pm",
      avatar: "Screens/hamza.png"),
  chatsModel(
      name: "Hamza",
      message: "How are you?",
      time: "10:20 pm",
      avatar: "Screens/hamza.png"),
  chatsModel(
      name: "Hassan",
      message: "I am fine?",
      time: "10:22 pm",
      avatar: "Screens/hamza.png"),
  chatsModel(
      name: "Maryam",
      message: "oye kia kar raha ho?",
      time: "12:15 pm",
      avatar: "Screens/hamza.png"),
];
