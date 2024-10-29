import 'package:flutter/material.dart';

import 'Screen_2.dart';

class PhoneNumber extends StatefulWidget {
  const PhoneNumber({super.key});

  @override
  State<PhoneNumber> createState() => _PhoneNumberState();
}

class _PhoneNumberState extends State<PhoneNumber> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
              appBar: AppBar(
                title: Text(
                  "Enter your Phone Number",
                  style: TextStyle(
                      color: Colors.green[700], fontWeight: FontWeight.bold),
                ),
                centerTitle: true,
                leading: Builder(builder: (context) {
                  return IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.green[800],
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => (Screen2())));
                    },
                  );
                }),
                backgroundColor: Colors.grey[100],
                elevation: 0.0,
              ),
              backgroundColor: Colors.grey[100],
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "WhatsApp will need to verify your Phone number",
                    style: TextStyle(fontSize: 15, color: Colors.green[700]),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Text("Pick Country",
                          style:
                              TextStyle(fontSize: 17, color: Colors.green[700]))),
                  SizedBox(height: 10,),
                  Row(children: [
                    Text("+92"),
                    // SizedBox(width: 10,),
                    TextField(showCursor: true,)
                  ],)
                ],
              )),
        ));
  }
}
