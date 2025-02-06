import 'package:flutter/material.dart';
import 'chats.dart';
import 'message_page.dart';
import 'Screen_3.dart';
import 'DropDownSheet.dart';

class chart_details extends StatefulWidget {
  const chart_details({super.key});

  @override
  State<chart_details> createState() => _chart_detailsState();
}

class _chart_detailsState extends State<chart_details> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          leading:  Builder(
            builder: (context) {
              return IconButton(onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => (Screen3())));
              }, icon: Icon(Icons.arrow_back_sharp));
            }
          ),
          titleSpacing: 0.0,
          title: Row(
            children: [
              CircleAvatar(
                radius: 17,
                backgroundImage: AssetImage("lib/Images/hamza.png"),
              ),
              Padding(
                padding: EdgeInsets.only(left: 6.0),
                child: Text("Hamza"),
              )
            ],
          ),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.video_call)),
            IconButton(onPressed: () {}, icon: Icon(Icons.call)),
            PopupMenuButton<String>(
              onSelected: (value) {
                // Handle the selected option
                print('Selected: $value');
              },
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem<String>(
                    value: 'view_contact',
                    child: Text('View Contact'),
                  ),
                  PopupMenuItem<String>(
                    value: 'media',
                    child: Text('Media'),
                  ),
                  PopupMenuItem<String>(
                    value: 'links_docs',
                    child: Text('Links and Docs'),
                  ),
                  PopupMenuItem<String>(
                    value: 'search',
                    child: Text('Search'),
                  ),
                  PopupMenuItem<String>(
                    value: 'mute_notification',
                    child: Text('Mute Notification'),
                  ),
                  PopupMenuItem<String>(
                    value: 'walpaper',
                    child: Text('Wallpaper'),
                  ),
                  // Add more options as needed
                ];
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(child: message_page()),
            Container(
              padding: EdgeInsets.only(),
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Flexible(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: Colors.black, width: 1)),
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.emoji_emotions_outlined,
                                color: Colors.grey,
                              )),
                          Flexible(
                            child: TextFormField(
                                minLines: 1,
                                maxLines: 5,
                                showCursor: true,
                                decoration:
                                    InputDecoration(hintText: "Message")),
                          ),
                          IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return AttachFileOptions();
                                },
                              );
                            },
                            icon: Icon(
                              Icons.attachment_outlined,
                              color: Colors.grey,
                            ),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.camera_alt_rounded,
                                color: Colors.grey,
                              ))
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  FloatingActionButton(
                    onPressed: () {},
                    child: Icon(
                      Icons.mic_sharp,
                      color: Colors.white,
                    ),
                    backgroundColor: Colors.green[900],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

