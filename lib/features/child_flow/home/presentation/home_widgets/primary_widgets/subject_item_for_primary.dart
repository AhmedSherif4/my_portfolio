part of'../../../home.dart';


class SubjectItemForPrimaryChild extends StatelessWidget {
  final Function() onTap;
  final String imagePath;
  final bool notHaveImage;
  final String subjectName;
  final Color itemColor;

  const SubjectItemForPrimaryChild({
    super.key,
    required this.onTap,
    required this.imagePath,
    required this.subjectName,
    required this.notHaveImage,
    required this.itemColor,
  });

  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
      onTap: onTap,
      child: Container(
        width: AppReference.deviceIsTablet?AppReference.deviceWidth(context) * 0.15:null,
        padding: EdgeInsets.symmetric(
          horizontal: AppPadding.p10.responsiveSize,
          vertical: AppPadding.p4.responsiveSize,
        ),
        decoration: BoxDecoration(
          color: itemColor,
          borderRadius: BorderRadius.circular(
              AppConstants.appBorderRadiusR15.responsiveSize),
        ),
        child: Column(
          children: [
            Expanded(
              child: FittedBox(
                child: Text(
                  subjectName,
                  style: const AppTextStyle().white.bodyLarge16,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: NullableNetworkImage(
                imagePath: imagePath,
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.contain,
                notHaveImage: notHaveImage,
              ),
            ),
            Expanded(
              child: Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: FittedBox(
                  child: Text(
                    AppStrings.discoverNow,
                    style: const AppTextStyle().white.w600.bodyLarge16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
