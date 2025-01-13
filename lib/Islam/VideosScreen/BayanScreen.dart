import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:wa_business/Islam/VideosScreen/screens/home_screen.dart';

import 'models/channel_details.dart';

class BayanScreen extends StatelessWidget {
  final bool isBayan;
  const BayanScreen({super.key, required this.isBayan});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // Video content list

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
                (context, index) {
              final video = isBayan?Details.videocontent[index]:Details.reciterChannels[index];
              return InkWell(
                onTap: (){
                  Navigator.push(context, CupertinoPageRoute(builder: (_)=> HomeScreen(channel_id: video['channel_id'], cover: video['coverPic'],)));
                },
                child: Card(
                  elevation: 5,
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(size.width/26),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top half: Cover Picture
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(size.width/26),
                        ),
                        child: Image.network(
                          video['coverPic'],
                          height: size.height * 0.08,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),

                      // Bottom half: Profile Picture and Text
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: size.width/20, vertical: size.height/100),
                        child: Row(
                          children: [
                            // Profile Picture
                            CircleAvatar(
                              radius: size.width/16,
                              backgroundImage: NetworkImage(video['profilePic']),
                            ),
                            const SizedBox(width: 16), // Spacing between avatar and text
                            // Channel Name and Subscriber Count
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  video['channel'],
                                  style: TextStyle(
                                    fontSize: size.height/56,
                                    // fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.fade,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            childCount: isBayan?Details.videocontent.length:Details.reciterChannels.length,
          ),
        ),
      ],
    );
  }
}

// Placeholder for the video detail screen
class VideoDetailScreen extends StatelessWidget {
  final String channel;

  const VideoDetailScreen({super.key, required this.channel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(channel)),
      body: Center(
        child: Text(
          'Details for $channel',
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
