import 'package:flutter/material.dart';

class Status extends StatefulWidget {
  const Status({super.key});

  @override
  State<Status> createState() => _StatusState();
}

class _StatusState extends State<Status> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green[900],
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        body: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blueGrey,
                backgroundImage: AssetImage("Screens/heart_image.png"),
              ),
              title: Text(
                "My Status",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "Tap to add status update",
                style: TextStyle(color: Colors.grey, fontSize: 15.0),
              ),
              onTap: () {},
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Recent updates",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Flexible(
                child: ListView.builder(
              itemCount: statusData.length,
              itemBuilder: (context, i) => Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blueGrey,
                      backgroundImage: AssetImage(
                          statusData[i].avatar ?? "Screens/heart_image.png"),
                    ),
                    title: Text(
                      statusData[i].name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      statusData[i].time,
                      style: TextStyle(color: Colors.grey, fontSize: 15.0),
                    ),
                    onTap: () {},
                  ),
                  Divider(
                    height: 10.0,
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}

class statusModel {
  final String name;
  final String time;
  final String avatar;

  statusModel({required this.name, required this.time, required this.avatar});
}

List<statusModel> statusData = [
  statusModel(
    name: "Hamza",
    time: "10:20 pm",
    avatar: "Screens/hamza.png",
  ),
  statusModel(
    name: "Hassan",
    time: "10:22 pm",
    avatar: "Screens/hamza.png",
  ),
  statusModel(
    name: "Maryam",
    time: "12:15 pm",
    avatar: "Screens/hamza.png",
  ),
  statusModel(
    name: "Hamza",
    time: "10:20 pm",
    avatar: "Screens/hamza.png",
  ),
  statusModel(
    name: "Hassan",
    time: "10:22 pm",
    avatar: "Screens/heart_image.png",
  ),
  statusModel(
    name: "Maryam",
    time: "12:15 pm",
    avatar: "Screens/hamza.png",
  ),
  statusModel(
    name: "Hamza",
    time: "10:20 pm",
    avatar: "Screens/hamza.png",
  ),
  statusModel(
    name: "Hassan",
    time: "10:22 pm",
    avatar: "Screens/hamza.png",
  ),
  statusModel(
    name: "Maryam",
    time: "12:15 pm",
    avatar: "Screens/hamza.png",
  ),
  statusModel(
    name: "Hamza",
    time: "10:20 pm",
    avatar: "Screens/hamza.png",
  ),
  statusModel(
    name: "Hassan",
    time: "10:22 pm",
    avatar: "Screens/hamza.png",
  ),
  statusModel(
    name: "Maryam",
    time: "12:15 pm",
    avatar: "Screens/hamza.png",
  ),
];
