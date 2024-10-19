part of '../../on_boarding.dart';


class PortraitView extends StatelessWidget {
  final int pageCount;
  final bool isLast;
  final Function() nextOrLastOnTap;
  final Function(int) onPageChanged;
  final PageController pageController;
  final Function() backStep;

  const PortraitView(
      {super.key,
      required this.pageCount,
      required this.isLast,
      required this.nextOrLastOnTap,
      required this.onPageChanged,
      required this.pageController,
      required this.backStep});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBarWidget(
          backStep: backStep,
          pageCount: pageCount,
        ),
        const Spacer(),
        Expanded(
          flex: 5,
          child: ImageWidget(
            pageController: pageController,
            pageCount: pageCount,
            onPageChanged: onPageChanged,

          ),
        ),
        20.sizedBoxHeight,
        Center(
          child: DefaultButtonWidget(
            label: isLast ? AppStrings.welcomeEndText : AppStrings.next,
            onPressed: nextOrLastOnTap,
          ),
        ),
      ],
    ).paddingBody(
      start: 20,
      end: 20,
      bottom: 20,
      top: 20,
    );
  }
}
