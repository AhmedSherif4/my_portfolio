part of 'on_boarding.dart';
class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController pageController = PageController();


  int pageCount = 0;
  bool isLast = false;

    _backStep() {
      pageController.previousPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.linearToEaseOut,
      );
    }

  void _checkLastIndexAndNavigationToLoginScreen() {
    if (isLast) {
      _goToLoginPage();
    } else {
      _forwardStep();
    }
  }

  void _goToLoginPage() {
    getIt<OnBoardingLocalData>()
        .saveOnBoardingValue(isShowed: true)
        .then((value) {
      RouteManager.rPushNamedAndRemoveUntil(
          context: context, rName: AppRoutesNames.rWelcome,
      );
    });
  }

  void _forwardStep() {
    pageController.nextPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOutQuad,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: OrientationItem(
          portraitWidget: PortraitView(
            pageCount: pageCount,
            isLast: isLast,
            nextOrLastOnTap: _checkLastIndexAndNavigationToLoginScreen,
            onPageChanged: onPageChanged,
            pageController: pageController,
            backStep: _backStep,
          ),
          landscapeWidget: LandScapeView(
            pageCount: pageCount,
            isLast: isLast,
            nextOrLastOnTap: _checkLastIndexAndNavigationToLoginScreen,
            onPageChanged: onPageChanged,
            pageController: pageController,
            backStep: _backStep,
          ),
        ),
      ),
    );
  }

  onPageChanged(int currentIndex) {
    setState(() {
      pageCount = currentIndex;
    });
    if (currentIndex == 4) {
      isLast = true;
    } else {
      isLast = false;
    }
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
