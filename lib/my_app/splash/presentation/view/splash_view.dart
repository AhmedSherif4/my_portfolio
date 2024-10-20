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
    )

      ..addStatusListener(
        (status) async {
          if (status == AnimationStatus.completed) {

          await AppRequirementSetup.initialFutures();
            // onBoardingStatus = await _getOnBoardingStatus();
            // userData = await _getUserData();
            _goToHomeScreen(context);


          }
        },
      );

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
    Timer(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          scaleController.forward();
        });
      }
    });
  }

  @override
  void dispose() {
    scaleController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    AppReference.getDeviceInfo(context);
    super.didChangeDependencies();
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: BlocBuilder<GlobalBloc, GlobalState>(builder: (context, state
          ){
            switch (state.infoState){
              case RequestStates.loading:
                return SvgPicture.asset(
                  AppImagesAssets.sLogoDay,
                  height: 150.responsiveHeight,
                  width: 150.responsiveWidth,
                  fit: BoxFit.fitWidth,
                );
              case RequestStates.loaded:
                return state.infoModel.splashView?
                Container(
                  color: AppColors.primaryColor,
                  height: AppReference.deviceHeight(context),
                  width: AppReference.deviceWidth(context),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      Stack(
                        alignment: Alignment.center,
                        children: [
                          const SplashConnectionAlert(),
                          Column(
                            children: [
                              AppSize.s20.sizedBoxHeight,
                              SvgPicture.asset(
                                AppImagesAssets.sDayLogo,
                                height: AppConstants.appLogoHeight.responsiveHeight,
                                width: AppConstants.appLogoWidth.responsiveWidth,
                                fit: BoxFit.fill,
                              ),
                              SizedBox(
                                height: AppReference.deviceHeight(context)*0.15,
                              ),
                              // 150.sizedBoxHeight,
                              SvgPicture.asset(
                                AppImagesAssets.sLogoDay,
                                height: 150.responsiveHeight,
                                width: 150.responsiveWidth,
                                fit: BoxFit.fitWidth,
                              ),
                            ],
                          ),
                        ],
                      ),
                      AppSize.s20.sizedBoxHeight,



                      const Spacer(),
                      Image.asset(
                          AppReference.isPortrait(context)? AppImagesAssets.sMobileDay:AppImagesAssets.sTabletDay,
                          width: double.infinity,
                          fit: BoxFit.fitWidth),
                      // SvgPicture.asset(
                      //   AppImagesAssets.sMobileDay,
                      //   height: AppConstants.appLogoHeight.responsiveHeight,
                      //   width: AppReference.deviceWidth(context),
                      //   fit: BoxFit.fill,
                      // ),
                    ],
                  ),
                )
                    :Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    Stack(
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
                              height: _value
                                  ? 50.responsiveHeight
                                  : 100.responsiveHeight,
                              width:
                              _value ? 50.responsiveWidth : 200.responsiveWidth,
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
                                  width: AppReference.deviceWidth(context) ,
                                  height: AppReference.deviceHeight(context) ,
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
                          AppImagesAssets.sLogoDay,
                          height: AppConstants.appLogoHeight.responsiveHeight,
                          width: AppConstants.appLogoWidth.responsiveWidth,
                          fit: BoxFit.fill,
                        ),
                      ],
                    ),
                    AppSize.s20.sizedBoxHeight,
                    Text(
                      AppStrings
                          .ourGoalIsToCreateAGenerationThatMastersWhatItLearns,
                      style: AppReference.themeData.textTheme.bodyLarge!.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                  ],
                );
              case RequestStates.error:
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    Stack(
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
                              height: _value
                                  ? 50.responsiveHeight
                                  : 100.responsiveHeight,
                              width:
                              _value ? 50.responsiveWidth : 200.responsiveWidth,
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
                                  width: AppReference.deviceWidth(context) ,
                                  height: AppReference.deviceHeight(context) ,
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
                          AppImagesAssets.sSplashImage,
                          height: AppConstants.appLogoHeight.responsiveHeight,
                          width: AppConstants.appLogoWidth.responsiveWidth,
                          fit: BoxFit.fill,
                        ),
                      ],
                    ),
                    AppSize.s20.sizedBoxHeight,
                    Text(
                      AppStrings
                          .ourGoalIsToCreateAGenerationThatMastersWhatItLearns,
                      style: AppReference.themeData.textTheme.bodyLarge!.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                  ],
                );
              default :
                return  SvgPicture.asset(
                  AppImagesAssets.sLogoDay,
                  height: 150.responsiveHeight,
                  width: 150.responsiveWidth,
                  fit: BoxFit.fitWidth,
                );
            }
          },),
        ),
      ),
    );
  }
}









