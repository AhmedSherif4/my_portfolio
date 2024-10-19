part of '../../questions.dart';

class _CountQuestions extends StatelessWidget {
  final int count;
  final int target;

  const _CountQuestions({required this.count, required this.target});

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) => Container(
        margin: EdgeInsetsDirectional.only(
          top: AppPadding.p10.responsiveHeight,
        ),
        padding: EdgeInsets.all(AppPadding.p4.responsiveSize),
        width: 50.responsiveWidth,
        height: 25.responsiveHeight,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.responsiveSize),
          color: AppColors.textColor6,
        ),
        child: FittedBox(
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                text: '$count',
                style: AppReference.themeData.textTheme.titleSmall!.copyWith(
                  fontFamily: 'NewFont',
                  color: AppColors.successColor,
                  fontWeight: FontWeight.w800,
                  height: 1,
                ),
                children: [
                  TextSpan(
                    text: '/$target',
                    style: AppReference.themeData.textTheme.bodyLarge!.copyWith(
                      fontFamily: 'NewFont',
                      color: AppColors.primaryColor2,
                      fontWeight: FontWeight.w800,
                      height: 1,
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
