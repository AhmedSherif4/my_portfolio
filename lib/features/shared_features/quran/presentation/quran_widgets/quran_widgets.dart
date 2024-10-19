part of '../../quran.dart';

class _AudioWidgetForQuran extends StatefulWidget {
  final bool isPlaying;
  final VoidCallback onPressed;

  const _AudioWidgetForQuran({
    required this.onPressed,
    required this.isPlaying,
  });

  @override
  State<_AudioWidgetForQuran> createState() => _AudioWidgetForQuranState();
}

class _AudioWidgetForQuranState extends State<_AudioWidgetForQuran> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: constraints.maxHeight * 0.35,
              child: FittedBox(
                child: Text(
                  'اضغط هنا للاستماع الى الآية',
                  style: const AppTextStyle().blue.bodyLarge16,
                ),
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.6,
              child: AnimatedSwitcher(
                duration: const Duration(seconds: 1),
                reverseDuration: const Duration(seconds: 1),
                transitionBuilder: (child, animation) => ScaleTransition(
                  scale: animation,
                  child: child,
                ),
                child: IconButton(
                  onPressed: widget.onPressed,
                  icon: widget.isPlaying
                      ? SvgPicture.asset(
                          AppIconsAssets.sPause,
                          height: 40.responsiveSize,
                          width: 40.responsiveSize,
                          semanticsLabel: 'pause',
                        )
                      : SvgPicture.asset(
                          AppIconsAssets.sPlayArrow,
                          height: 40.responsiveSize,
                          width: 40.responsiveSize,
                          semanticsLabel: 'play',
                        ),
                  style: IconButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: const CircleBorder(),
                    backgroundColor: Colors.black.withOpacity(0.3),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

showTafseerDialog({
  required BuildContext context,
  required String descriptionText,
}) {
  showDialog(
    context: context,
    builder: (context) => TafseerDialog(
      descriptionText: descriptionText,
    ),
  );
}

class TafseerDialog extends StatelessWidget {
  final String? descriptionText;

  const TafseerDialog({
    super.key,
    this.descriptionText,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      content: Container(
        width: AppReference.deviceWidth(context) * 0.8,
        constraints: BoxConstraints(
          maxHeight:
              AppReference.deviceHeight(context) * 0.6.responsiveHeightRatio,
          minHeight:
              AppReference.deviceHeight(context) * 0.3.responsiveHeightRatio,
        ),
        padding: EdgeInsets.all(10.responsiveSize),
        decoration: BoxDecoration(
          color: AppColors.primary2,
          border: Border.all(
            color: AppColors.primaryColor,
            width: 3.responsiveSize,
          ),
          borderRadius: BorderRadius.all(Radius.circular(20.responsiveSize)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: AppReference.deviceHeight(context) *
                    0.08.responsiveHeightRatio,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppStrings.explainAyah,
                          style: const AppTextStyle().black.bodyLarge16,
                        ),
                        SvgPicture.asset(
                          AppIconsAssets.sExclamation,
                        ),
                      ],
                    ),
                    Divider(
                      color: AppColors.primary2,
                      thickness: 5.responsiveSize,
                      endIndent: 20,
                      indent: 20,
                    ),
                  ],
                ),
              ),
              Text(
                '$descriptionText',
                style: const AppTextStyle().black.bodyLarge16,
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AyaWithTafseerDialog extends StatelessWidget {
  final String? descriptionText;
  final Function()? onAddPressed,onMinasPressed;

  const AyaWithTafseerDialog({
    super.key,
    this.descriptionText, this.onAddPressed, this.onMinasPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      content: Container(
        width: AppReference.deviceWidth(context) * 0.8,
        constraints: BoxConstraints(
          maxHeight:
          AppReference.deviceHeight(context) * 0.6.responsiveHeightRatio,
          minHeight:
          AppReference.deviceHeight(context) * 0.3.responsiveHeightRatio,
        ),
        padding: EdgeInsets.all(10.responsiveSize),
        decoration: BoxDecoration(
          color: AppColors.primary2,
          border: Border.all(
            color: AppColors.primaryColor,
            width: 3.responsiveSize,
          ),
          borderRadius: BorderRadius.all(Radius.circular(20.responsiveSize)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: AppReference.deviceHeight(context) *
                    0.09.responsiveHeightRatio,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.responsiveSize),
                          ),
                          width: AppReference.deviceWidth(context) * 0.110,
                          child: IconButton.filled(
                            onPressed:onMinasPressed,
                            style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all(AppColors.primaryColor),
                                shadowColor: WidgetStateProperty.all(Colors.transparent),
                                elevation: WidgetStateProperty.all(0)
                            ),
                            icon: const Icon(
                              Icons.arrow_back_ios_rounded,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppStrings.explainAyah,
                              style: const AppTextStyle().black.bodyLarge16,
                            ),
                            SvgPicture.asset(
                              AppIconsAssets.sExclamation,
                            ),
                          ],
                        ),
                        const SizedBox(width: 10,),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.responsiveSize),
                          ),
                          width: AppReference.deviceWidth(context) * 0.110,
                          child: IconButton.filled(
                            onPressed: onAddPressed,
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(AppColors.primaryColor),
                              shadowColor: WidgetStateProperty.all(Colors.transparent),
                            ),
                            icon: const Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: AppColors.primary2,
                      thickness: 5.responsiveSize,
                      endIndent: 20,
                      indent: 20,
                    ),
                  ],
                ),
              ),
              Text(
                '$descriptionText',
                style: const AppTextStyle().black.bodyLarge16,
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}