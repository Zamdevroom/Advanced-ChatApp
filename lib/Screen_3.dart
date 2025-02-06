// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:wa_business/Screens/chart_details.dart';
// import 'camera.dart';
// import 'chats.dart';

// class Screen3 extends StatefulWidget {
//   const Screen3({super.key});

//   @override
//   State<Screen3> createState() => _Screen3State();
// }

// class _Screen3State extends State<Screen3> with SingleTickerProviderStateMixin {
//   late TabController _tabController;

//   final List<Tab> topTabs = <Tab>[
//     Tab(icon: Icon(Icons.camera_alt)),
//     Tab(text: "CHATS"),
//     Tab(text: "GROUPS"),
//     Tab(text: "OPEN ROOM"),
//   ];

//   String? currentUserId;

//   @override
//   void initState() {
//     _tabController = TabController(length: 4, initialIndex: 1, vsync: this)
//       ..addListener(() {
//         setState(() {});
//       });
//     super.initState();
//     getCurrentUserId(); // Fetch the current user ID when the screen is initialized
//   }

//   Future<void> getCurrentUserId() async {
//     User? user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       setState(() {
//         currentUserId =
//             user.uid; // Set the currentUserId if the user is authenticated
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     // If currentUserId is null, show loading
//     if (currentUserId == null) {
//       return Scaffold(
//         body: Center(
//             child:
//                 CircularProgressIndicator()), // Show loading while fetching user ID
//       );
//     }

//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: "WhatsApp",
//       theme: ThemeData(
//         primaryColor: Colors.green,
//         fontFamily: 'Roboto',
//       ),
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text(
//             "WhatsApp",
//             style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
//           ),
//           actions: [
//             IconButton(
//               onPressed: () {},
//               icon: Icon(Icons.search, size: 28),
//             ),
//             IconButton(
//               onPressed: () {},
//               icon: Icon(Icons.more_vert, size: 28),
//             ),
//           ],
//           backgroundColor: Colors.green,
//           elevation: 4,
//           bottom: TabBar(
//             controller: _tabController,
//             indicator: BoxDecoration(
//               color: Colors.white, // The indicator color
//             ),
//             indicatorSize: TabBarIndicatorSize
//                 .tab, // Ensures the indicator spans the full tab
//             labelColor: Colors.green, // Text color for selected tab
//             unselectedLabelColor:
//                 Colors.white.withOpacity(0.7), // Unselected text color
//             labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
//             tabs: topTabs,
//           ),
//         ),
//         body: TabBarView(
//           controller: _tabController,
//           children: [
//             Camera(),
//             UsersScreen(
//                 currentUserId:
//                     currentUserId!), // Pass currentUserId to UsersScreen
//           ],
//         ),
//         floatingActionButton: FloatingActionButton(
//           backgroundColor: Colors.green,
//           onPressed: () {},
//           child: Icon(Icons.chat, color: Colors.white, size: 28),
//         ),
//       ),
//     );
//   }
// }
