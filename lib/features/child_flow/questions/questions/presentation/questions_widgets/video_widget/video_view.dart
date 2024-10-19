part of 'video.dart';

class _ViewVideoWidget extends StatelessWidget {
  const _ViewVideoWidget({
    required VideoPlayerController videoPlayerController,
    required ChewieController? chewieController,
  })  : _videoPlayerController = videoPlayerController,
        _chewieController = chewieController;

  final VideoPlayerController _videoPlayerController;
  final ChewieController? _chewieController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppReference.deviceWidth(context),
      height: AppReference.deviceHeight(context) * 0.2.responsiveHeightRatio,
      child: AspectRatio(
        aspectRatio: _videoPlayerController.value.aspectRatio,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Chewie(controller: _chewieController!),
            _VideoControlsWidget(controller: _videoPlayerController),
            Align(
                alignment: Alignment.bottomCenter,
                child: _videoPlayerController.value.isPlaying
                    ? const SizedBox.shrink()
                    : _VideoProgressWidget(
                        videoPlayerController: _videoPlayerController)),
          ],
        ),
      ),
    );
  }
}
