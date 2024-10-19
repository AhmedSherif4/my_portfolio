part of 'video.dart';

class VideoWidget extends StatefulWidget {
  final bool isAnswerVideo;
  final String source;
  final Duration? startAt;
  final VoidCallback reachedTheEnd;

  const VideoWidget({
    super.key,
    required this.source,
    this.startAt,
    required this.reachedTheEnd,
    this.isAnswerVideo = false,
  });

  @override
  State<StatefulWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    initializePlayer();

    _videoPlayerController.seekTo(widget.startAt ?? Duration.zero);
    _videoPlayerController.addListener(() {
      if (_videoPlayerController.value.isCompleted) {
        widget.reachedTheEnd;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  Future<void> initializePlayer() async {
    _videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.source));
    await _videoPlayerController.initialize();
    _createChewieController();
    setState(() {});
  }

  void _createChewieController() {
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: widget.isAnswerVideo ? false : true,
      looping: false,
      hideControlsTimer: const Duration(milliseconds: 500),
      allowMuting: false,
      allowPlaybackSpeedChanging: false,
      draggableProgressBar: false,
      allowFullScreen: true,
      deviceOrientationsAfterFullScreen: [
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
      placeholder: Container(
        width: double.infinity,
        height: double.infinity,
        color: AppColors.secondaryColor,
      ),
      startAt: widget.startAt ?? Duration.zero,
      zoomAndPan: false,
      showControls: false,
      autoInitialize: true,
    );
    // _chewieController?.addListener(() {
    //   if (_chewieController!.isFullScreen) {
    //     SystemChrome.setPreferredOrientations([
    //       DeviceOrientation.landscapeRight,
    //       DeviceOrientation.landscapeLeft,
    //     ]);
    //   } else {
    //     SystemChrome.setPreferredOrientations([
    //       DeviceOrientation.portraitUp,
    //       DeviceOrientation.portraitDown,
    //     ]);
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    bool isInitialized = _chewieController != null &&
        _chewieController!.videoPlayerController.value.isInitialized;
    return Center(
      child: isInitialized
          ? _ViewVideoWidget(
              videoPlayerController: _videoPlayerController,
              chewieController: _chewieController)
          : const _LoadingVideoWidget(),
    );
  }
}
