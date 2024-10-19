import 'package:flutter/material.dart';
import 'package:my_portfolio/my_app/app_reference.dart';

class ResponsiveWidgetForTablet extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;

  const ResponsiveWidgetForTablet({
    super.key,
    required this.mobile,
    required this.tablet,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: AppReference.deviceIsTablet,
        replacement: mobile,
        child: tablet);
  }
}

class OrientationItem extends StatelessWidget {
  final Widget portraitWidget;
  final Widget landscapeWidget;

  const OrientationItem({
    super.key,
    required this.portraitWidget,
    required this.landscapeWidget,
  });

  @override
  Widget build(BuildContext context) {
    return AppReference.currentOrientation(context) == Orientation.portrait
        ? portraitWidget
        : landscapeWidget;
  }
}
