part of '../challenge_screen.dart';

class TextWithRocketWidget extends StatelessWidget {
  const TextWithRocketWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 65.responsiveHeight,
      width: AppReference.deviceWidth(context) * 0.8,
      child: LayoutBuilder(builder: (context, constraints) {
        return Row(
          children: [
            SizedBox(
              height: constraints.maxHeight,
              width: constraints.maxWidth * 0.9,
              child: CustomPaint(
                painter: ShapeOfTextPainter(),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppPadding.p16.responsiveSize,
                  ),
                  alignment: Alignment.centerRight,
                  child: Text(
                    AppStrings.collectPointsAndConfirmYourValuableInformation,
                    style: AppReference.themeData.textTheme.bodyMedium!.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: constraints.maxHeight,
              width: constraints.maxWidth * 0.1,
              child: SvgPicture.asset(
                AppImagesAssets.sRocket,
                height: 30.responsiveHeightRatio,
                width: 60.responsiveWidth,
              ),
            ),
          ],
        );
      }),
    );
  }
}
