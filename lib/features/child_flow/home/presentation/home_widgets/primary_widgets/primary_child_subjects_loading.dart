part of'../../../home.dart';


class PrimaryChildSubjectsLoading extends StatelessWidget {
  const PrimaryChildSubjectsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return OrientationItem(
        portraitWidget: GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          childAspectRatio: AppReference.deviceWidth(context) /
              (AppReference.deviceHeight(context) * 0.5),
          crossAxisSpacing: 10.responsiveWidth,
          mainAxisSpacing: 15.responsiveHeight,
          children: List.generate(
            5,
            (index) {
              return const LoadingShimmerStructure();
            },
          ),
        ),
        landscapeWidget: GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 3,
          childAspectRatio: AppReference.deviceWidth(context) /
              (AppReference.deviceHeight(context)),
          crossAxisSpacing: 10.responsiveWidth,
          mainAxisSpacing: 15.responsiveHeight,
          children: List.generate(
            5,
            (index) {
              return const LoadingShimmerStructure();
            },
          ),
        ));
  }
}
