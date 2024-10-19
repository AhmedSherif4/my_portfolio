part of 'video.dart';

class _VideoProgressWidget extends StatelessWidget {
  const _VideoProgressWidget({
    required VideoPlayerController videoPlayerController,
  }) : _videoPlayerController = videoPlayerController;

  final VideoPlayerController _videoPlayerController;

  @override
  Widget build(BuildContext context) {
    Duration position = _videoPlayerController.value.position;
    String formattedPosition =
        '${position.inMinutes.remainder(60).toString().padLeft(2, '0')}:${(position.inSeconds.remainder(60)).toString().padLeft(2, '0')}';
    return LayoutBuilder(
      builder: (context, constraints) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: constraints.maxWidth * 0.55,
            height: constraints.maxHeight * 0.2.responsiveHeightRatio,
            child: VideoProgressIndicator(
              _videoPlayerController,
              allowScrubbing: false,
              padding: EdgeInsets.all(10.responsiveSize),
            ),
          ),
          SizedBox(
            width: constraints.maxWidth * 0.15,
            height: constraints.maxHeight * 0.15.responsiveHeightRatio,
            child: Text(
              formattedPosition,
              style: AppReference.themeData.textTheme.bodyLarge!.copyWith(
                color: AppColors.white,
                height: 1.5,
              ),
            ),
          ),
          SizedBox(
            width: constraints.maxWidth * 0.1,
            height: constraints.maxHeight * 0.2,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 50),
              reverseDuration: const Duration(milliseconds: 200),
              transitionBuilder: (child, animation) => ScaleTransition(
                scale: animation,
                child: child,
              ),
              child: IconButton(
                onPressed: () => _videoPlayerController.value.isPlaying
                    ? _videoPlayerController.pause()
                    : _videoPlayerController.play(),
                icon: Icon(
                  _videoPlayerController.value.isPlaying
                      ? Icons.pause
                      : Icons.play_arrow,
                  size: 20.responsiveSize,
                  semanticLabel: 'Play',
                  color: Colors.white,
                ),
                style: IconButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: const CircleBorder(),
                  backgroundColor: Colors.black.withOpacity(0.3),
                ),
              ),
            ),
          ),
          SizedBox(
            width: constraints.maxWidth * 0.1,
            height: constraints.maxHeight * 0.2,
            child: IconButton(
              onPressed: rewind5Seconds,
              style: IconButton.styleFrom(
                padding: EdgeInsets.zero,
                shape: const CircleBorder(),
                backgroundColor: Colors.black.withOpacity(0.3),
              ),
              icon: Icon(
                Icons.replay_5,
                color: Colors.white,
                size: 20.responsiveSize,
              ),
            ),
          ),

        ],
      ),
    );
  }

  Future rewind5Seconds() async => goToPosition(
      (currentPosition) => currentPosition - const Duration(seconds: 5));

  Future goToPosition(
    Duration Function(Duration currentPosition) builder,
  ) async {
    final currentPosition = await _videoPlayerController.position;
    final newPosition = builder(currentPosition ?? Duration.zero);

    await _videoPlayerController.seekTo(newPosition);
  }
}
