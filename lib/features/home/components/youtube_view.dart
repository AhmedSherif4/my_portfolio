import 'package:flutter/material.dart';
import 'package:my_portfolio/my_app/app_reference.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class YoutubeViewWidget extends StatefulWidget {
  const YoutubeViewWidget({super.key});

  @override
  State<YoutubeViewWidget> createState() => _YoutubeViewWidgetState();
}

class _YoutubeViewWidgetState extends State<YoutubeViewWidget> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      params: YoutubePlayerParams(
        mute: true,
        showControls: true,
        showFullscreenButton: true,
      ),
    );
    _controller.loadVideo(
      'https://www.youtube.com/watch?v=POaRgDcVYAk&list=PLufvxT6cSSNmBNiY7z46VFrhme4_osUml&index=3&t=1994s',
      /*list: [
      'POaRgDcVYAk&list=PLufvxT6cSSNmBNiY7z46VFrhme4_osUml&index=3&t=1974s',
      'f3NAlnreKqg&list=PLufvxT6cSSNmBNiY7z46VFrhme4_osUml&index=5&t=7s',
      '__ifTjxKTcU&list=PLufvxT6cSSNmBNiY7z46VFrhme4_osUml&index=5&t=1113s',
      'mtiAM_u8nM8&list=PLufvxT6cSSNmBNiY7z46VFrhme4_osUml&index=6',
      'wCoC92Se5bk&list=PLufvxT6cSSNmBNiY7z46VFrhme4_osUml&index=8',
      'tQ0vsNG4i6k&list=PLufvxT6cSSNmBNiY7z46VFrhme4_osUml&index=9&t=20s',
    ]*/
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppReference.deviceWidth(context) * 0.7,
      height: AppReference.deviceHeight(context) * 0.7,
      child: YoutubePlayer(
        controller: _controller,
        aspectRatio: 16 / 9,
      ),
    );
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}
