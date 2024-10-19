part of'../../home.dart';


class AdviceDialog extends StatelessWidget {
  final String message;

  const AdviceDialog({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      contentPadding: EdgeInsets.zero,
      elevation: 5,
      actionsPadding: EdgeInsets.zero,
      buttonPadding: EdgeInsets.zero,
      iconPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      shape: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(
            AppConstants.appBorderRadiusR20.responsiveSize,
          )),
      content: Container(
        padding: EdgeInsets.all(AppPadding.p20.responsiveSize),
        width: !AppReference.isPortrait(context)
            ? AppReference.deviceWidth(context) * 0.4
            : AppReference.deviceWidth(context) * 0.8,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              AppConstants.appBorderRadiusR20.responsiveSize,
            ),
            gradient: AppGradientColors.adviceGradient),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                CustomInkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: SvgPicture.asset(
                    AppImagesAssets.sPuzzleAndAdviceCancel,
                    height: AppReference.isPortrait(context)?
                    AppSize.s26.responsiveHeight:AppSize.s16.responsiveHeightRatio,
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "نصيحة اليوم",
                      style: AppReference.themeData.textTheme.titleSmall!
                          .copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    AppSize.s10.sizedBoxWidth,
                    SvgPicture.asset(
                      AppImagesAssets.sAdvice,
                      height: AppSize.s20.responsiveHeightRatio,
                    ),
                  ],
                ),
                const Spacer(),
              ],
            ),
            (AppSize.s10).sizedBoxHeight,
            Container(
              padding: EdgeInsets.all(AppPadding.p20.responsiveSize),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(
                    AppConstants.appBorderRadiusR20.responsiveSize),
              ),
              child: Text(
                message,
                style: const AppTextStyle().w600.bodyMedium14,
              ),
            ),
            (AppSize.s10).sizedBoxHeight,
            Row(
              children: [
                Expanded(
                  child: DefaultButtonWidget(
                    label: 'استفدت ؟',
                    textVerticalPadding:AppReference.isPortrait(context)? 0:6,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                AppSize.s10.sizedBoxWidth,
                Expanded(
                  child: DefaultButtonWidget(
                    label: 'لم أستفيد',
                    textVerticalPadding:AppReference.isPortrait(context)? 0:6,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
