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
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;

  bool _isInitialized = false;
  bool _hasError = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    try {
      _videoPlayerController = VideoPlayerController.network(widget.videoPath);
      await _videoPlayerController!.initialize();

      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController!,
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
        aspectRatio: _videoPlayerController!.value.aspectRatio > 0
            ? _videoPlayerController!.value.aspectRatio
            : 16 / 9,
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
        _errorMessage = e.toString();
      });
      debugPrint('Error initializing video player: $e');
    }
  }

  Future<void> jumpToPosition(Duration position) async {
    if (_isInitialized && !_hasError && _videoPlayerController != null) {
      debugPrint('Attempting to jump to: ${position.inSeconds} seconds');
      await _videoPlayerController!.seekTo(position);
      await _videoPlayerController!.play();
      debugPrint('Jumped to: ${_videoPlayerController!.value.position.inSeconds} seconds');
    }
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  Widget buildChewiePlayer() {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Chewie(controller: _chewieController!),
    );
  }

  Widget buildErrorWidget() {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Center(
        child: Text(
          _errorMessage ?? 'Error loading video',
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget buildLoadingWidget() {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: const Center(child: CircularProgressIndicator()),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError) return buildErrorWidget();
    if (!_isInitialized) return buildLoadingWidget();

    return Column(
      children: [
        buildChewiePlayer(),
        const SizedBox(height: 10),
      ],
    );
  }
}
