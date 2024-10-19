import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_portfolio/config/resources/app_assets.dart';
import 'package:my_portfolio/config/resources/app_colors.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';
import 'package:my_portfolio/my_app/app_reference.dart';

class AudioPlayerWidget extends StatefulWidget {
  final bool isAnswerAudio;
  final String source;

  const AudioPlayerWidget({
    super.key,
    required this.source,
    this.isAnswerAudio = false,
  });

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  Duration _duration = const Duration();
  Duration _position = const Duration();

  @override
  void initState() {
    super.initState();

    _audioPlayer.onDurationChanged.listen((Duration duration) {
      setState(() {
        _duration = duration;
      });
    });

    _audioPlayer.onPositionChanged.listen((Duration position) {
      setState(() {
        _position = position;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    String formattedPosition =
        '${_position.inMinutes.remainder(60).toString().padLeft(2, '0')}:${(_position.inSeconds.remainder(60)).toString().padLeft(2, '0')}';
    if (widget.isAnswerAudio) {
      return LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: constraints.maxHeight * 0.7,
                child: AnimatedSwitcher(
                  duration: const Duration(seconds: 1),
                  reverseDuration: const Duration(seconds: 1),
                  transitionBuilder: (child, animation) => ScaleTransition(
                    scale: animation,
                    child: child,
                  ),
                  child: IconButton(
                    onPressed: () {
                      if (_isPlaying) {
                        _audioPlayer.pause();
                      } else {
                        _audioPlayer.play(UrlSource(widget.source));
                      }
                      setState(() {
                        _isPlaying = !_isPlaying;
                      });
                    },
                    icon: _isPlaying
                        ? SvgPicture.asset(
                            AppIconsAssets.sPause,
                            height: 40.responsiveSize,
                            width: 40.responsiveSize,
                            semanticsLabel: 'pause',
                          )
                        : SvgPicture.asset(
                            AppIconsAssets.sPlayArrow,
                            height: 40.responsiveSize,
                            width: 40.responsiveSize,
                            semanticsLabel: 'play',
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
                height: constraints.maxHeight * 0.3,
                child: Slider(
                  activeColor: AppColors.primaryColor,
                  value: _position.inSeconds.toDouble(),
                  min: 0.0,
                  max: _duration.inSeconds.toDouble(),
                  // allowedInteraction: SliderInteraction.tapOnly,
                  onChanged: (_) {},
                ),
              ),
            ],
          );
        },
      );
    } else {
      return Container(
        width: AppReference.deviceWidth(context) * 0.7,
        height: AppReference.deviceHeight(context) *
            (AppReference.isPortrait(context) ? 0.2 : 0.37) *
            0.25,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.white,
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: constraints.maxWidth * 0.15,
                  height: constraints.maxHeight * 0.7,
                  child: AnimatedSwitcher(
                    duration: const Duration(seconds: 1),
                    reverseDuration: const Duration(seconds: 1),
                    transitionBuilder: (child, animation) => ScaleTransition(
                      scale: animation,
                      child: child,
                    ),
                    child: IconButton(
                      onPressed: () {
                        if (_isPlaying) {
                          _audioPlayer.pause();
                        } else {
                          _audioPlayer.play(UrlSource(widget.source));
                        }
                        setState(() {
                          _isPlaying = !_isPlaying;
                        });
                      },
                      icon: _isPlaying
                          ? SvgPicture.asset(
                              AppIconsAssets.sPause,
                              height: 40.responsiveSize,
                              width: 40.responsiveSize,
                              semanticsLabel: 'pause',
                            )
                          : SvgPicture.asset(
                              AppIconsAssets.sPlayArrow,
                              height: 40.responsiveSize,
                              width: 40.responsiveSize,
                              semanticsLabel: 'play',
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
                  width: constraints.maxWidth * 0.65,
                  height: constraints.maxHeight * 0.7,
                  child: Slider(
                    activeColor: AppColors.primaryColor,
                    value: _position.inSeconds.toDouble(),
                    min: 0.0,
                    max: _duration.inSeconds.toDouble(),
                    // allowedInteraction: SliderInteraction.tapOnly,
                    onChanged: (_) {},
                  ),
                ),
                SizedBox(
                  width: constraints.maxWidth * 0.2,
                  height: constraints.maxHeight * 0.7,
                  child: Text(
                    formattedPosition,
                    style: AppReference.themeData.textTheme.bodyLarge!.copyWith(
                      color: AppColors.black,
                      fontWeight: FontWeight.w600,
                      height: 1.7,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    _audioPlayer.dispose();
  }
}
