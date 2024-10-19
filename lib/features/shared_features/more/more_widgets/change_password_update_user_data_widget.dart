part of 'more_widgets.dart';

class ChangePasswordUpdateUserDataWidget extends StatelessWidget {
  final String title;
  final String icon;
  final String routeTo;

  const ChangePasswordUpdateUserDataWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.routeTo,
  });

  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
      onTap: () {
        RouteManager.rPushNamed(context: context, rName: routeTo);
      },
      child: Container(
        padding: EdgeInsetsDirectional.symmetric(
          horizontal: AppPadding.p20.responsiveWidth,
          vertical: AppPadding.p10.responsiveHeight,
        ),
        height: AppReference.deviceHeight(context) * 0.06.responsiveHeightRatio,
        decoration: ShapeDecoration(
          color: AppColors.primaryColor.withOpacity(0.1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                AppConstants.appPaddingR20.responsiveSize),
          ),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
            ),
            AppSize.s20.sizedBoxWidth,
            Text(
              title,
              style: const AppTextStyle().blue.w600.bodyMedium14,
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios,
              color: AppColors.primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
