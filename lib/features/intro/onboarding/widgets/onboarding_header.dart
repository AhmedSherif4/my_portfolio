part of '../on_boarding.dart';



class AppBarWidget extends StatelessWidget {
  final int pageCount;

  final Function() backStep;

  const AppBarWidget({
    super.key,
    required this.pageCount,
    required this.backStep,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FittedBox(
          child: TextButtonWidget(
            text: AppStrings.skip,
            fontSize: 14,
            onPressed: () {
              getIt<OnBoardingLocalData>()
                  .saveOnBoardingValue(isShowed: true)
                  .then((value) {
                RouteManager.rPushNamedAndRemoveUntil(
                    context: context, rName: AppRoutesNames.rWelcome);
              });
            },
          ),
        ),
        const Spacer(),
        CountItem(count: pageCount + 1, target: 5),
        Spacer(
          flex: pageCount > 0 ? 1 : 2,
        ),
        if (pageCount > 0)
          FittedBox(
            child: TextButtonWidget(
              fontSize: 14,
              text: AppStrings.backToPreviousStep,
              textColor: AppColors.primaryColor2,
              onPressed: backStep,
            ),
          ),
      ],
    );
  }
}
