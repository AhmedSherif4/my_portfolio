import 'package:flutter/material.dart';
import 'package:my_portfolio/config/resources/app_values.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';
import 'package:my_portfolio/config/routes/route_manager.dart';
import 'package:my_portfolio/config/routes/routes_names.dart';
import 'package:my_portfolio/core/shared_widget/custom_inkwell.dart';

class MyPopImage extends StatefulWidget {
  const MyPopImage(
      {super.key,
      required this.image,
      required this.imageWidget,
      required this.tappedWidget});
  final String image;
  final Widget imageWidget;
  final Widget tappedWidget;
  @override
  State<MyPopImage> createState() => _MyPopImageState();
}

class _MyPopImageState extends State<MyPopImage> {
  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
        onTap: () {
          RouteManager.rPushNamed(
            context: context,
            rName: AppRoutesNames.rZoomImage,
            arguments: widget,
          );
          // Navigator.of(context).push(
          //   PageRouteBuilder(
          //     opaque: false,
          //     pageBuilder: (BuildContext context, a, _) {
          //       return ZoomImageWidget(widget: widget);
          //     },
          //   ),
          // );
        },
        child: widget.tappedWidget);
  }
}

class ZoomImageWidget extends StatelessWidget {
  const ZoomImageWidget({
    super.key,
    required this.widget,
  });

  final MyPopImage widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black.withOpacity(0.9),
      child: Column(
        children: [
          Align(
            alignment: AlignmentDirectional.topStart,
            child: GestureDetector(
              child: const Icon(
                Icons.close,
                color: Colors.white,
                size: 30,
              ).paddingBody(
                top: AppSize.s40,
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          Expanded(
              child: InteractiveViewer(
                  panEnabled: true, maxScale: 20, child: widget.imageWidget)),
        ],
      ),
    );
  }
}
