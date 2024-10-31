import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';

import '../../../config/resources/app_assets.dart';
import '../../../my_app/app_reference.dart';

class ChatIconLottieWidget extends StatefulWidget {
  const ChatIconLottieWidget({super.key});

  @override
  State<ChatIconLottieWidget> createState() => _ChatIconLottieWidgetState();
}

class _ChatIconLottieWidgetState extends State<ChatIconLottieWidget>
    with TickerProviderStateMixin {
  late final AnimationController _lottieController;

  @override
  void initState() {
    super.initState();

    _lottieController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
  }

  @override
  void dispose() {
    _lottieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _lottieController
      ..reset()
      ..repeat();
    return Lottie.asset(
      AppLottieAssets.sChat2,
      controller: _lottieController,
      width: AppReference.deviceWidth(context) * 0.3,
      height: AppReference.deviceHeight(context) * 0.5,
    );
  }
}

class GetInTouchLottieWidget extends StatefulWidget {
  final String lottieAssert;

  const GetInTouchLottieWidget({super.key, required this.lottieAssert});

  @override
  State<GetInTouchLottieWidget> createState() => _GetInTouchLottieWidgetState();
}

class _GetInTouchLottieWidgetState extends State<GetInTouchLottieWidget>
    with TickerProviderStateMixin {
  // late final AnimationController _lottieController;

  @override
  void initState() {
    super.initState();

    // _lottieController = AnimationController(
    //   vsync: this,
    //   duration: const Duration(seconds: 3),
    // );
  }

  @override
  void dispose() {
    // _lottieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // _lottieController
    //   ..reset()
    //   ..repeat();
    return SizedBox(
      width: 20.responsiveWidth,
      height: 100.responsiveHeight,
      child: Lottie.asset(
        widget.lottieAssert,
        // controller: _lottieController,
      ),
    );
  }
}
