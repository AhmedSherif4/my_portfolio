part of '../../questions.dart';

class _HeaderForQuestions extends StatelessWidget {
  final Function() reportQuestion;

  const _HeaderForQuestions({required this.reportQuestion});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppReference.deviceHeight(context) * 0.06.responsiveHeightRatio,
      child: LayoutBuilder(builder: (context, constrains) {
        return Row(
          children: [
            SvgPicture.asset(
              AppImagesAssets.sLogoWithoutName,
              width: constrains.maxWidth * 0.2,
              height: constrains.maxHeight * 0.7,
              fit: BoxFit.cover,
            ),
            AppSize.s10.sizedBoxWidth,
            TextWithBackGroundColor(
              backgroundColor: AppColors.primaryColor.withOpacity(.1),
              text: AppStrings.questions,
              width: constrains.maxWidth * 0.6,
              height: constrains.maxHeight * 0.7,
              verticalPadding: 0,
              textColor: AppColors.textColor4,
            ),
            const Spacer(),
            FittedBox(
                child: TextButtonWidget(text: 'تبليغ', onPressed: reportQuestion,),),
          ],
        );
      }),
    );
  }
}
