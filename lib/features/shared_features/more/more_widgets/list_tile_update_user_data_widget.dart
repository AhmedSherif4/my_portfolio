part of 'more_widgets.dart';

class ListTileUpdateUserDataWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool withEdit;
  final bool withAdd;
  final bool withCopy;
  final String? routeTo;

  const ListTileUpdateUserDataWidget({
    super.key,
    required this.title,
    required this.subtitle,
    this.withEdit = false,
    this.withAdd = false,
    this.withCopy = false,
    this.routeTo,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height:
                AppReference.deviceHeight(context) * 0.06.responsiveHeightRatio,
            width: AppReference.deviceWidth(context),
            padding: EdgeInsets.symmetric(
                horizontal: AppPadding.p10.responsiveWidth),
            decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(
                    AppConstants.appBorderRadiusR20.responsiveSize)),
            child: LayoutBuilder(builder: (context, constrains) {
              return Row(
                children: [
                  Container(
                    height: constrains.maxHeight * 0.7,
                    width: constrains.maxWidth * 0.2,
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(AppPadding.p6.responsiveSize),
                    decoration: ShapeDecoration(
                      color: AppColors.backgroundColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            AppConstants.appBorderRadiusR20.responsiveSize),
                      ),
                    ),
                    child: FittedBox(
                      child: Text(
                        title,
                        style: AppTextStyle.bodySmall12,
                      ),
                    ),
                  ),
                  (constrains.maxWidth * 0.04).sizedBoxWidth,
                  SizedBox(
                    width: constrains.maxWidth * 0.4,
                    child: Text(
                      subtitle,
                      style: AppTextStyle.bodySmall12,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
        AppSize.s6.sizedBoxWidth,
        if (withEdit)
          CustomInkWell(
            onTap: (){
              RouteManager.rPushNamed(
                context: context,
                rName: routeTo!,
                arguments: DataToGoToEditProfileScreen(
                  title: title,
                  oldData: subtitle,
                ),
              );
            },
            child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(AppPadding.p10.responsiveSize),
                decoration: ShapeDecoration(
                  color: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        AppConstants.appBorderRadiusR20.responsiveSize),
                  ),
                ),
                child: Text(
                  withAdd?"إضافة":
                  AppStrings.edit,
                  style: const AppTextStyle().bodySmall12.copyWith(
                    color: AppColors.white,
                  ),
                ),),
          ),
        if(withCopy)
          CustomInkWell(
            onTap: (){
              Clipboard.setData(ClipboardData(text: subtitle));
              showSnackBar(
                description: "تم نسخ الكود",
                state: ToastStates.congrats,
                context: context,
              );
            },
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(AppPadding.p10.responsiveSize),
              decoration: ShapeDecoration(
                color: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      AppConstants.appBorderRadiusR20.responsiveSize),
                ),
              ),
              child: Text(
                AppStrings.copy,
                style: const AppTextStyle().bodySmall12.copyWith(
                  color: AppColors.white,
                ),
              ),),
          ),

      ],
    );
  }
}
