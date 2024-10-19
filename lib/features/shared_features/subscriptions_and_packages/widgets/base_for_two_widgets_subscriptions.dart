import 'package:flutter/material.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';


class BaseForTwoWidgetsSubscriptions extends StatelessWidget {
  final Widget widget1;
  final Widget widget2;
  final Color backgroundColor;
  const BaseForTwoWidgetsSubscriptions({
    super.key,
    required this.widget1,
    required this.widget2,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 20.responsiveSize,
        vertical: 10.responsiveSize,
      ),
      padding: EdgeInsets.all(5.responsiveSize),
      decoration: ShapeDecoration(
        color: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.responsiveSize),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          widget1,
          widget2,
        ],
      ),
    );
  }
}