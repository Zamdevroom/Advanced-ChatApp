import 'package:flutter/material.dart';
import 'call.dart';
import 'camera.dart';
import 'chats.dart';
import 'status.dart';

class Screen3 extends StatefulWidget {
  const Screen3({super.key});

  @override
  State<Screen3> createState() => _Screen3State();
}

class _Screen3State extends State<Screen3> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  final List<Tab> topTabs = <Tab>[
    Tab(icon: Icon(Icons.camera_alt)),
    Tab(
      text: "CHATS",
    ),
    Tab(
      text: "STATUS",
    ),
    Tab(
      text: "CALLS",
    )
  ];

  @override
  void initState() {
    _tabController = TabController(length: 4, initialIndex: 1, vsync: this)
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "WhatsApp",
        theme: ThemeData(primaryColor: Colors.green),
        home: Scaffold(
          appBar: AppBar(
            title: Text("WhatsApp"),
            actions: [IconButton(onPressed: () {},
                icon: Icon(Icons.search)),
              IconButton(onPressed: () {},
                  icon: Icon(Icons.more_vert)),
            ],
            backgroundColor: Colors.green,
            bottom: TabBar(
              controller: _tabController,
              indicatorColor: Colors.white,
              tabs: topTabs,
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              Camera(),
              Chats(),
              Status(),
              Calls(),
            ],
          ),
        ));
  }
}
