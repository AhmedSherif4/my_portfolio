import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../base_widgets/loading_shimmer_widget.dart';

class BaseCachedNetworkImage extends StatelessWidget {
  final double? height;
  final double? width;
  final String imgUrl;
  final BoxFit fit;

  const BaseCachedNetworkImage({
    super.key,
    this.height,
    this.width,
    required this.imgUrl,
    required this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        imageUrl: imgUrl,
        fit: fit,
        height: height,
        width: width,
        placeholder: (context, url) => const LoadingShimmerStructure(),
        errorWidget: (context, url, error) => SizedBox(
            width: width,
            height: height,
            child: const FittedBox(
              fit: BoxFit.contain,
              child: Icon(Icons.error_outline_outlined),
            )));
  }
}
