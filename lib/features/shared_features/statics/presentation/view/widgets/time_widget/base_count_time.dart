part of '../../../../statics.dart';


class BaseCountTimeItem extends StatelessWidget {
  final String time;
  final String timeType;
  final double width;
  final double height;


  const BaseCountTimeItem({
    super.key,
    required this.time,
    required this.timeType,
     this.width=AppSize.s40,
     this.height=AppSize.s50,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height:height.responsiveHeight ,
          width: width.responsiveWidth,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.backgroundColor,
            borderRadius: BorderRadius.circular(AppConstants.appBorderRadiusR15.responsiveSize),
          ),
          child: FittedBox(
            child: Text(
              time,
              textAlign: TextAlign.center,
              style: AppReference.themeData.textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        5.sizedBoxHeight,
        Text(
          timeType,
          style: const AppTextStyle().s11.w600.bodyMedium14,
        ),
      ],
    );
  }
}
