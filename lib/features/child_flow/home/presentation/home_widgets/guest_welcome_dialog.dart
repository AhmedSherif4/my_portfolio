
part of'../../home.dart';

class GuestWelcomeDialog extends StatelessWidget {
  const GuestWelcomeDialog({super.key});
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
        width: !AppReference.isPortrait(context)
            ? AppReference.deviceWidth(context) * 0.4
            : AppReference.deviceWidth(context)*.8,
        padding: EdgeInsets.all(AppPadding.p20.responsiveSize),
        decoration: BoxDecoration(
           gradient: AppGradientColors.guestDialogGradient,
            borderRadius:
            BorderRadius.circular(AppConstants.appBorderRadiusR10)),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: CustomInkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: SvgPicture.asset(
                    AppImagesAssets.sPuzzleAndAdviceCancel,
                  ),
                ),
              ),
              SvgPicture.asset(AppImagesAssets.sDiscount50),
              AppSize.s20.sizedBoxHeight,
              Text("أهلاً بك في تأسيس! عرض حصري خاص بك، اشترك الآن واحصل على خصومات تصل إلى 50% وهذا لفترة محدودة.",
                  textAlign: TextAlign.center,
                  style: const AppTextStyle()
                      .balooBhaijaan2.white
                      .w700
                      .bodyLarge16),
              AppSize.s20.sizedBoxHeight,
              DefaultButtonWidget(
                  textVerticalPadding: AppReference.isPortrait(context)?2:6,
                  buttonColor: AppColors.white,
                  labelColor: AppColors.primaryColor,
                  isExpanded: true,
                  label: "سجل الآن !",
                  borderColor: AppColors.primaryColor2,
                  onPressed: () {
                   RouteManager.rPushNamedAndRemoveUntil(
                     context: context,
                     rName: AppRoutesNames.rSignUpScreen,
                   );
                  }),
            ]),
      ),
    );
  }
}