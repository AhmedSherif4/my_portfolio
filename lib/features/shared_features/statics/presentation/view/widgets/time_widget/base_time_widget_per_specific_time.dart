part of '../../../../statics.dart';


class BaseTimeWidgetForTimeInApplicationScreen extends StatelessWidget {
  final String specificTime;
  final String mTime;
  final String hTime;

  const BaseTimeWidgetForTimeInApplicationScreen(
      {super.key,
      required this.specificTime,
      required this.mTime,
      required this.hTime});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppReference.deviceHeight(context) * 0.06.responsiveHeightRatio,
      width: AppReference.deviceWidth(context),
      padding: EdgeInsets.symmetric(
          vertical: 8.responsiveSize, horizontal: 20.responsiveSize),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(30.responsiveSize),
        border: Border.all(width: 1, color: AppColors.backgroundColor),
        boxShadow: [AppShadow.appBoxShadow()],
      ),
      child: LayoutBuilder(builder: (context, constrains) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: constrains.maxWidth * 0.4,
              child: TextWithBackGroundColor(
                verticalPadding: 0,
                isOneLine: true,
                text: specificTime,
                textColor: AppColors.textColor,
                fontSize: 14,
                backgroundColor:AppColors.textColor6
                   // HexColor.fromHex('#1B3D6F33').withOpacity(0.05),
              ),
            ),
            SizedBox(
              width: constrains.maxWidth * 0.25,
              child: TextWithBackGroundColor(
                verticalPadding: 0,
                text: hTime,
                isOneLine: true,
                textColor: AppColors.textColor,
                backgroundColor: AppColors.backgroundColor,
              ),
            ),
            SizedBox(
              width: constrains.maxWidth * 0.25,
              child: TextWithBackGroundColor(
                verticalPadding: 0,
                isOneLine: true,
                text: mTime,
                textColor: AppColors.textColor,
                backgroundColor: AppColors.backgroundColor,
              ),
            )
          ],
        );
      }),
    );
  }
}
