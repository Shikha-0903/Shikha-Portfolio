import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class ProjectVideoPlayer extends StatefulWidget {
  final String videoPath;
  final bool autoPlay;
  final double width;
  final double height;

  const ProjectVideoPlayer({
    Key? key,
    required this.videoPath,
    this.autoPlay = false,
    this.width = 300,
    this.height = 500,
  }) : super(key: key);

  @override
  _ProjectVideoPlayerState createState() => _ProjectVideoPlayerState();
}

class _ProjectVideoPlayerState extends State<ProjectVideoPlayer> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  bool _isInitialized = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    try {
      _videoPlayerController = VideoPlayerController.asset(widget.videoPath);
      await _videoPlayerController.initialize();

      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        autoPlay: widget.autoPlay,
        looping: false,
        materialProgressColors: ChewieProgressColors(
          playedColor: Theme.of(context).primaryColor,
          handleColor: Theme.of(context).primaryColor,
          backgroundColor: Colors.grey.shade300,
          bufferedColor: Theme.of(context).primaryColor.withOpacity(0.5),
        ),
        showControls: true,
        showOptions: false,
        aspectRatio: _videoPlayerController.value.aspectRatio,
        errorBuilder: (context, errorMessage) {
          return Center(
            child: Text(
              errorMessage,
              style: const TextStyle(color: Colors.white),
            ),
          );
        },
        placeholder: Container(
          color: Colors.black,
          child: const Center(child: CircularProgressIndicator()),
        ),
      );

      setState(() {
        _isInitialized = true;
      });
    } catch (e) {
      setState(() {
        _hasError = true;
      });
      debugPrint('Error initializing video player: $e');
    }
  }

  Future<void> jumpToPosition(Duration position) async {
    if (_isInitialized && !_hasError) {
      debugPrint('Attempting to jump to: ${position.inSeconds} seconds');
      await _videoPlayerController.seekTo(position);
      await _videoPlayerController.play(); // Ensure video plays after jumping
      debugPrint('Jumped to: ${_videoPlayerController.value.position.inSeconds} seconds');
    }
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      return SizedBox(
        width: widget.width,
        height: widget.height,
        child: const Center(
          child: Text(
            'Error loading video',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }

    if (!_isInitialized) {
      return SizedBox(
        width: widget.width,
        height: widget.height,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Column(
      children: [
        SizedBox(
          width: widget.width,
          height: widget.height,
          child: Chewie(controller: _chewieController!),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
