part of 'video.dart';

class _VideoControlsWidget extends StatelessWidget {
  final VideoPlayerController controller;

  const _VideoControlsWidget({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () {
          controller.value.isPlaying ? controller.pause() : controller.play();
        },
      );
}
