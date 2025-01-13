import 'package:flutter/material.dart';

class Calls extends StatefulWidget {
  const Calls({super.key});

  @override
  State<Calls> createState() => _CallsState();
}

class _CallsState extends State<Calls> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green[900],
          child: Icon(
            Icons.call,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        body: Container(
          child: ListView.builder(
              itemCount: callData.length,
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
                            callData[i].avatar ?? "lib/Images/heart_image.png"),
                      ),
                      title: Text(
                        callData[i].name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Row(
                        children: [
                          Container(
                            child: callData[i].calltype,
                          ),
                          Text(
                            callData[i].time,
                            style:
                                TextStyle(fontSize: 14.0, color: Colors.grey),
                          ),
                        ],
                      ),
                      trailing: Icon(
                        Icons.call,
                        color: Colors.green,
                      ),
                      onTap: () {},
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}

class callModel {
  final String name;
  final String time;
  final String avatar;
  final Icon calltype;

  callModel(
      {required this.name,
      required this.time,
      required this.avatar,
      required this.calltype});

  static Icon callReceived = Icon(
    Icons.call_received,
    size: 18,
    color: Colors.green[800],
  );
  static Icon callDailled = Icon(
    Icons.call_missed,
    size: 18,
    color: Colors.red[800],
  );
}

List<callModel> callData = [
  callModel(
      name: "Hamza",
      time: "10:20 pm",
      avatar: "lib/Images/hamza.png",
      calltype: callModel.callDailled),
  callModel(
      name: "Hassan",
      time: "10:22 pm",
      avatar: "lib/Images/hamza.png",
      calltype: callModel.callReceived),
  callModel(
      name: "Maryam",
      time: "12:15 pm",
      avatar: "lib/Images/hamza.png",
      calltype: callModel.callDailled),
  callModel(
      name: "Hamza",
      time: "10:20 pm",
      avatar: "lib/Images/hamza.png",
      calltype: callModel.callReceived),
  callModel(
      name: "Hassan",
      time: "10:22 pm",
      avatar: "lib/Images/heart_image.png",
      calltype: callModel.callDailled),
  callModel(
      name: "Maryam",
      time: "12:15 pm",
      avatar: "lib/Images/hamza.png",
      calltype: callModel.callReceived),
  callModel(
      name: "Hamza",
      time: "10:20 pm",
      avatar: "lib/Images/hamza.png",
      calltype: callModel.callDailled),
  callModel(
      name: "Hassan",
      time: "10:22 pm",
      avatar: "lib/Images/hamza.png",
      calltype: callModel.callReceived),
  callModel(
      name: "Maryam",
      time: "12:15 pm",
      avatar: "lib/Images/hamza.png",
      calltype: callModel.callDailled),
  callModel(
      name: "Hamza",
      time: "10:20 pm",
      avatar: "lib/Images/hamza.png",
      calltype: callModel.callReceived),
  callModel(
      name: "Hassan",
      time: "10:22 pm",
      avatar: "lib/Images//hamza.png",
      calltype: callModel.callDailled),
  callModel(
      name: "Maryam",
      time: "12:15 pm",
      avatar: "lib/Images/hamza.png",
      calltype: callModel.callReceived),
];
