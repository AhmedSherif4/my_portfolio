part of'../../home.dart';


class HomeHeaderLoading extends StatelessWidget {
  const HomeHeaderLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return LoadingShimmerStructure(
      width: AppReference.deviceWidth(context),
      height: AppReference.deviceHeight(context) * 0.06.responsiveHeightRatio,
    );
  }
}
