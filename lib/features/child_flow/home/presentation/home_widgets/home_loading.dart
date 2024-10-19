part of'../../home.dart';


class HomeLoadingWidget extends StatelessWidget {
  const HomeLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LoadingShimmerStructure(
        width: double.infinity,
        height: AppReference.deviceHeight(context) * 0.06.responsiveHeightRatio,
        ),

          AppSize.s16.sizedBoxHeight,
           LoadingShimmerStructure(
            height: 100.responsiveHeight,
          ),
          AppSize.s8.sizedBoxHeight,
          const LoadingShimmerStructure(
            height: 20,
            width: 250,
          ),
          AppSize.s8.sizedBoxHeight,
          LoadingShimmerStructure(
            height: AppReference.deviceHeight(context) *
                0.15.responsiveHeightRatio,
          ),
          AppSize.s26.sizedBoxHeight,
          SizedBox(
            height: AppReference.deviceHeight(context) *
                0.2.responsiveHeightRatio,
            width: AppReference.deviceWidth(context),
            child: Row(
              children: [
                const Expanded(child: LoadingShimmerStructure()),
                AppSize.s4.sizedBoxWidth,
                const Expanded(
                  child: LoadingShimmerStructure(),
                ),
              ],
            ),
          ),

          AppSize.s26.sizedBoxHeight,
          LoadingShimmerStructure(
            height: AppReference.deviceHeight(context) *
                0.12.responsiveHeightRatio,
          ),
          AppSize.s26.sizedBoxHeight,
          SizedBox(
            height: AppReference.deviceHeight(context) *
                0.2.responsiveHeightRatio,
            width: AppReference.deviceWidth(context),
            child: Row(
              children: [
                const Expanded(child: LoadingShimmerStructure()),
                AppSize.s4.sizedBoxWidth,
                const Expanded(
                  child: LoadingShimmerStructure(),
                ),
              ],
            ),
          ),
          AppSize.s26.sizedBoxHeight,
          LoadingShimmerStructure(
            height: AppReference.deviceHeight(context) * 0.1,
          )
        ],
      ),
    );
  }
}


