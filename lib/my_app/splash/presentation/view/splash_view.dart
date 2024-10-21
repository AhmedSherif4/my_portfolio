part of '../../splash_screen.dart';

class SplashScreen extends StatefulWidget {
  final String? path;
  final String? id;

  const SplashScreen({super.key, this.path, this.id});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController scaleController;
  late Animation<double> scaleAnimation;

  double _opacity = 0;
  bool _value = true;
  bool onBoardingStatus = false;

  late UserEntity? userData;

  @override
  void initState() {
    super.initState();
    // context.read<GlobalBloc>().add(GetInfoDataEvent());
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ]);
    scaleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    // ..addStatusListener(
    //   (status) async {
    //     if (status == AnimationStatus.completed) {
    //       await AppRequirementSetup.initialFutures();
    //       // onBoardingStatus = await _getOnBoardingStatus();
    //       // userData = await _getUserData();
    //     }
    //   },
    // );

    scaleAnimation =
        Tween<double>(begin: 0.0, end: 12).animate(scaleController);

    Timer(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _opacity = 1.0;
          _value = false;
        });
      }
    });
    Timer(
      const Duration(seconds: 1),
      () {
        if (mounted) {
          setState(() {
            scaleController.forward();
          });
        }
      },
    );
    Timer(
      const Duration(seconds: 3),
      () {
        if (mounted) {
          _goToHomeScreen(context);
        }
      },
    );
  }

  @override
  void dispose() {
    scaleController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              const SplashConnectionAlert(),
              Center(
                child: AnimatedOpacity(
                  curve: Curves.fastLinearToSlowEaseIn,
                  duration: const Duration(seconds: 2),
                  opacity: _opacity,
                  child: AnimatedContainer(
                    curve: Curves.fastLinearToSlowEaseIn,
                    duration: const Duration(seconds: 2),
                    height: _value ? 50.responsiveHeight : 100.responsiveHeight,
                    width: _value ? 50.responsiveWidth : 200.responsiveWidth,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryColor.withOpacity(.2),
                          // blurRadius: 100,
                          // spreadRadius: 10,
                        ),
                      ],
                      color: AppColors.primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Container(
                        width: AppReference.deviceWidth(context),
                        height: AppReference.deviceHeight(context),
                        decoration: const BoxDecoration(
                            color: AppColors.primaryColor,
                            shape: BoxShape.circle),
                        child: AnimatedBuilder(
                          animation: scaleAnimation,
                          builder: (_, child) => Transform.scale(
                            scale: scaleAnimation.value,
                            child: Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SvgPicture.asset(
                AppImagesAssets.sLogo,
                height: AppConstants.appLogoHeight.responsiveHeight,
                width: AppConstants.appLogoWidth.responsiveWidth,
                fit: BoxFit.fill,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
