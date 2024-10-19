import 'package:flutter/material.dart';
import '../../config/resources/app_constants.dart';
import '../api/end_points.dart';
import 'cached_network_image.dart';

class NullableNetworkImage extends StatelessWidget {
  final String? imagePath;
  final bool notHaveImage;
  final double? width;
  final double? height;
  final BoxFit fit;

  const NullableNetworkImage(
      {super.key,
      required this.imagePath,
      required this.notHaveImage,
      this.width,
      this.height,
      required this.fit});

  @override
  Widget build(BuildContext context) {
    return notHaveImage
        ? SizedBox(
            width: width,
            height: height,
            child: const FittedBox(
              fit: BoxFit.contain,
              child: Icon(Icons.error_outline_outlined),
            ))
        : ClipRRect(
            borderRadius:
                BorderRadius.circular(AppConstants.appBorderRadiusR10),
            child: BaseCachedNetworkImage(
              imgUrl: imagePath!.contains('http')
                  ? imagePath!
                  : EndPoints.imagePath(imagePath!),
              height: height,
              width: width,
              fit: fit,
            ),
          );
  }
}
