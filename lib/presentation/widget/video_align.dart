import 'package:flutter/material.dart';
import 'package:port/presentation/widget/project_video.dart';

class VideoAlign extends StatefulWidget {
  final String videopath;
  final String data;
  const VideoAlign({super.key,required this.videopath,required this.data});

  @override
  State<VideoAlign> createState() => _VideoAlignState();
}

class _VideoAlignState extends State<VideoAlign> {

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          ProjectVideoPlayer(videoPath: widget.videopath),
          Text(widget.data,style: TextStyle(color: Colors.white),)
        ],
      ),
    );
  }
}
