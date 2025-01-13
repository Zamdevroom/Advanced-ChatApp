import 'package:flutter/material.dart';
import 'package:wa_business/Islam/VideosScreen/screens/video_screen.dart';
import 'package:wa_business/Islam/VideosScreen/unitConverter.dart';

import '../models/channel_model.dart';
import '../services/api_service.dart';

class HomeScreen extends StatefulWidget {
  final String channel_id;
  final String cover;
  const HomeScreen({super.key, required this.channel_id, required this.cover});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Channel? _channel;
  bool _isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initChannel();
  }

  _initChannel() async {
    Channel channel = await ApiServices.instance
        .fetchChannel(channelId: widget.channel_id);
    setState(() {
      _channel = channel;
    });
  }

  _buildProfileInfo() {
    return Container(
      height: 180.0,
      decoration: BoxDecoration(
        // color: Colors.white,
      ),
      child: Column(
        children: [
          Expanded(child: Card(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(widget.cover, fit: BoxFit.cover,)))),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 30.0,
                    backgroundImage: NetworkImage(_channel!.profilePictureUrl),
                  ),
                  SizedBox(width: 12.0),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "${_channel?.title}",
                          style: TextStyle(
                            fontFamily: 'Amiri',
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          '${formatNumber(_channel!.subscriberCount)} Subscribers',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12.0,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          // Divider(),
        ],
      ),
    );
  }

  _buildVideo(Video video) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => VideoScreen(id: video.id, desc: video.description),
        ),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5),
        // padding: EdgeInsets.all(10.0),
        height: 110.0,
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image(
                width: 140.0,
                image: NetworkImage(video.thumbnailUrl),
                fit: BoxFit.fitHeight,
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  video.title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.0,
                    overflow: TextOverflow.fade,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _loadMoreVideos() async {
    _isLoading = true;
    List<Video> moreVideos = await ApiServices.instance
        .fetchVideosFromPlaylist(playlistId: _channel!.uploadPlaylistId);
    List<Video> allVideos = _channel!.videos..addAll(moreVideos);
    setState(() {
      _channel!.videos = allVideos;
    });
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _channel != null
          ? SafeArea(
            child: Column(
                    children: [
            _buildProfileInfo(),
            Expanded(
              child: NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollDetails) {
                  if (!_isLoading &&
                      _channel!.videos.length != int.parse(_channel!.videoCount) &&
                      scrollDetails.metrics.pixels ==
                          scrollDetails.metrics.maxScrollExtent) {
                    _loadMoreVideos();
                  }
                  return false;
                },
                child: ListView.builder(
                  itemCount: _channel!.videos.length,
                  itemBuilder: (BuildContext context, int index) {
                    Video video = _channel!.videos[index];
                    return _buildVideo(video);
                  },
                ),
              ),
            )
                    ],
                  ),
          ): Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            Theme.of(context).primaryColor, // Red
          ),
        ),
      ),
    );
  }
}
