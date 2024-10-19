part of '../challenge_screen.dart';

class PrimaryCardChallengeWidget extends StatelessWidget {
  final Color colorOfBody;
  final Color colorOfBorder;
  final String title;
  final String description;
  final String image;

  const PrimaryCardChallengeWidget({super.key,
    required this.colorOfBody,
    required this.colorOfBorder,
    required this.title,
    required this.description,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: AppPadding.p10.responsiveSize,
      ),
      width:  AppReference.deviceWidth(context) * 0.8,
      height: AppReference.deviceHeight(context) * 0.2.responsiveHeightRatio ,
      decoration: ShapeDecoration(
        color: colorOfBody,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: AppPadding.p6.responsiveWidth ,
            color: colorOfBorder,
          ),
          borderRadius: BorderRadius.circular(
              AppConstants.appBorderRadiusR20.responsiveSize),
        ),
      ),
      child: LayoutBuilder(builder: (context, constraints) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: constraints.maxWidth * 0.3,
              height: constraints.maxHeight * 0.6,
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: AppPadding.p10.responsiveSize,
                ),
                padding: EdgeInsets.all(AppPadding.p10.responsiveSize),
                decoration: const ShapeDecoration(
                  color: AppColors.warningColor,
                  shape: CircleBorder(),
                ),
                child: SvgPicture.asset(
                  image,
                ),
              ),
            ),
            SizedBox(
              width: constraints.maxWidth * 0.55,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    title,
                    style:
                        AppReference.themeData.textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.white,
                    ),
                  ),
                  Text(
                    description,
                    style:
                        AppReference.themeData.textTheme.bodyMedium!.copyWith(
                      color: AppColors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: constraints.maxWidth * 0.15,
              child: Icon(
                Icons.arrow_forward_rounded,
                color: AppColors.white,
                size: 30.responsiveSize,
              ),
            ),
          ],
        );
      }),
    );
  }
}
