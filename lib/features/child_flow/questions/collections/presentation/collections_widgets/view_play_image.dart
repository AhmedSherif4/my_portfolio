import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../../config/resources/app_assets.dart';
import '../../../../../../my_app/app_reference.dart';

class ViewPlayImage extends StatelessWidget {
  const ViewPlayImage({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      AppImagesAssets.sCollectionPlay,
      width: AppReference.deviceWidth(context) * 0.7,
      height: AppReference.deviceHeight(context) * 0.15,
      alignment: Alignment.center,
    );
  }
}
