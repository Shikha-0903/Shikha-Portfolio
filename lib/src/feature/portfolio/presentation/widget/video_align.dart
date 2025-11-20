import 'package:flutter/material.dart';
import 'package:port/src/feature/portfolio/presentation/widget/project_video.dart';

class VideoAlign extends StatefulWidget {
  final String videopath;
  final String data;
  const VideoAlign({super.key, required this.videopath, required this.data});

  @override
  State<VideoAlign> createState() => _VideoAlignState();
}

class _VideoAlignState extends State<VideoAlign> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          ProjectVideoPlayer(videoPath: widget.videopath),
          Text(
            widget.data,
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
}
