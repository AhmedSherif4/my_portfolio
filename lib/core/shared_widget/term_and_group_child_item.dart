import 'package:flutter/material.dart';
import 'package:my_portfolio/config/resources/app_text_style.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';
import 'package:my_portfolio/core/shared_widget/custom_inkwell.dart';

import '../../my_app/app_reference.dart';

class TermAndGroupForChildItem extends StatelessWidget {
  final CustomPainter painter;
  final String text;
  final Function() onTap;

  const TermAndGroupForChildItem(
      {super.key,
      required this.text,
      required this.painter,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
      onTap: onTap,
      child: CustomPaint(
        size: Size(
            AppReference.deviceWidth(context),
            (AppReference.deviceWidth(context) * 0.17088607594936708)
                .toDouble()),
        painter: painter,
        child: SizedBox(
          width: AppReference.deviceWidth(context),
          height:
              AppReference.deviceHeight(context) * 0.06.responsiveHeightRatio,
          child: Padding(
            padding: EdgeInsetsDirectional.only(
              start: AppReference.deviceWidth(context) * 0.15,
            ),
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: FittedBox(
                child: Text(
                  text,
                  style: const AppTextStyle().balooBhaijaan2.w800.white.bodyMedium14,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
