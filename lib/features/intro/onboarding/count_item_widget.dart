part of 'on_boarding.dart';

class CountItem extends StatelessWidget {
  final int count;
  final int target;

  const CountItem({super.key, required this.count, required this.target});

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) => Container(
        width:
        orientation == Orientation.portrait
            ? AppSize.s70.responsiveWidth
            : 120.responsiveHeight,
        height: orientation == Orientation.portrait
            ? AppSize.s30.responsiveHeight
            : AppSize.s100.responsiveWidth,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            AppSize.s20.responsiveSize,
          ),
          color: AppColors.textColor6,
        ),
        child: FittedBox(
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                text: '$count/',
                style: AppReference.deviceIsTablet ? const AppTextStyle().s14.w500.titleSmall18:const AppTextStyle().s20.w500.titleSmall18,
                children: [
                  TextSpan(
                    text: '$target',
                    style:  AppReference.deviceIsTablet ? const AppTextStyle().s14.w400.titleSmall18:const AppTextStyle().s16.w400.titleSmall18,
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
