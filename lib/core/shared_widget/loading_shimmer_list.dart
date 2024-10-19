import 'package:flutter/material.dart';
import 'package:my_portfolio/config/resources/app_values.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';

import '../base_widgets/loading_shimmer_widget.dart';

class LoadingShimmerList extends StatelessWidget {
  final int count;
  final double height;

  const LoadingShimmerList({
    super.key,
    this.count = 4,
    this.height = 45,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => LoadingShimmerStructure(
        width: double.infinity,
        height: height.responsiveHeight,
      ),
      separatorBuilder: (context, index) => SizedBox(
        height: AppSize.s14.responsiveHeight,
      ),
      itemCount: count,
    );
  }
}

