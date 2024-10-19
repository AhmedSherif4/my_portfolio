part of '../challenge_screen.dart';

class ChildCardChallengeWidget extends StatelessWidget {
  final String title;
  final String description;
  final String image;

  const ChildCardChallengeWidget({
    super.key,
    required this.title,
    required this.description,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: AppPadding.p12.responsiveSize,
      ),margin: EdgeInsets.symmetric(
        vertical: AppPadding.p12.responsiveSize,
      ),
      width: AppReference.deviceIsTablet
          ? AppReference.deviceWidth(context) * 0.4
          : AppReference.deviceWidth(context) * 0.8,
      height: AppReference.deviceHeight(context) * 0.16.responsiveHeightRatio,
      decoration: ShapeDecoration(
        color: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              AppConstants.appBorderRadiusR25.responsiveSize),
        ),
      ),
      child: LayoutBuilder(builder: (context, constraints) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: constraints.maxWidth * 0.3,
              height: constraints.maxHeight * 0.7,
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: AppPadding.p10.responsiveWidth,
                ),
                child: SvgPicture.asset(
                  image,
                ),
              ),
            ),
            SizedBox(
              width: constraints.maxWidth * 0.55,
              child: LayoutBuilder(
                builder: (context, constrains) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: constrains.maxHeight * 0.5,
                        child: Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                            title,
                            textAlign: TextAlign.start,
                            style: AppReference.themeData.textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.textColor2,
                            ),
                          ),
                        ),
                      ),
                      (constrains.maxHeight * 0.08).sizedBoxHeight,
                      SizedBox(
                        height: constrains.maxHeight * 0.4,
                        child: Text(
                          description,
                          textAlign: TextAlign.start,
                          style: const AppTextStyle().s10.bodyMedium14.copyWith(
                            color: AppColors.textColor2,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  );
                }
              ),
            ),
            SizedBox(
              width: constraints.maxWidth * 0.15,
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                size: 18.responsiveSize,
                color: AppColors.textColor2,
              ),
            ),
          ],
        );
      }),
    );
  }
}
