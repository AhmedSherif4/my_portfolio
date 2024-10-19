part of '../../verification.dart';

class VerificationScreen extends StatefulWidget {
  final Map<String, dynamic> arguments;

  const VerificationScreen({super.key, required this.arguments});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  late final SignUpParameter signUpParameter;
  late final SendVerificationCodeParameter sendVerificationCodeParams;

  @override
  void initState() {
    super.initState();
    signUpParameter = widget.arguments['signUpParameter'];
    sendVerificationCodeParams =
        widget.arguments['sendVerificationCodeParameter'];
  }

  String code = '';
  bool reSend = false;

  void _checkCodeIsValid(bool isValid) {
    if (isValid) {
      context
          .read<VerificationBloc>()
          .add(SignedUp(signUpParameter: signUpParameter));
    } else {
      Navigator.pop(context);
      showSnackBar(
          description: AppStrings.verificationCodeIsNotCorrect,
          state: ToastStates.error,
          context: context);
    }
  }

  void _checkUserTypeThenNavigateToNextScreen() {
    switch (signUpParameter.type.name) {
      case AppKeys.childKey:
        RouteManager.rPushNamedAndRemoveUntil(
          context: context,
          rName: AppRoutesNames.rGradeChoosingScreen,
          arguments: false,
        );
      case AppKeys.parentKey:
        RouteManager.rPushNamedAndRemoveUntil(
          context: context,
          rName: AppRoutesNames.rParentAddChildWays,
        );

      case AppKeys.institutionKey:
        RouteManager.rPushNamedAndRemoveUntil(
          context: context,
          rName: AppRoutesNames.rHomeLayoutView,
          arguments: context.read<VerificationBloc>().userData,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<VerificationBloc, VerificationState>(
        listener: (context, state) {
          switch (state.checkVerificationStates) {
            case RequestStates.loading:
              showLoadingDialog(context);
            case RequestStates.loaded:
              _checkCodeIsValid(state.isCodeVerified);
            case RequestStates.error:
              Navigator.of(context).pop();
              showSnackBar(
                  description: state.checkVerificationErrorMessage,
                  state: ToastStates.error,
                  context: context);
            default:
          }

          switch (state.resendVerificationCodeStates) {
            case RequestStates.loading:
              showLoadingDialog(context);
            case RequestStates.loaded:
              Navigator.of(context).pop();
              showSnackBar(
                  description: state.resendVerificationCodeMessage,
                  state: ToastStates.info,
                  context: context);
            case RequestStates.error:
              Navigator.of(context).pop();
              showSnackBar(
                  description: state.resendVerificationCodeMessage,
                  state: ToastStates.error,
                  context: context);
            default:
          }

          switch (state.signUpStates) {
            case RequestStates.loaded:
              Navigator.pop(context);
              AppAnalytics.signUpLogEvent();
              showSnackBar(
                description: state.signUpMessage,
                state: ToastStates.info,
                context: context,
              );
              _checkUserTypeThenNavigateToNextScreen();
            case RequestStates.error:
              Navigator.pop(context);
              showSnackBar(
                  description: state.signUpMessage,
                  state: ToastStates.error,
                  context: context);
            default:
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: ResponsiveWidgetForTablet(
              mobile: VerificationPortraitView(
                sendVerificationCodeParams: sendVerificationCodeParams,
                signUpParameter: signUpParameter,
              ),
              tablet: OrientationItem(
                portraitWidget: VerificationPortraitView(
                  sendVerificationCodeParams: sendVerificationCodeParams,
                  signUpParameter: signUpParameter,
                ),
                landscapeWidget: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AppSize.s10.sizedBoxHeight,
                      const Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: TextBackButton()),
                      AppSize.s30.sizedBoxHeight,
                      Text(
                        AppStrings.verificationTitle,
                        style: AppReference.deviceIsTablet
                            ? const AppTextStyle().w600.titleLarge22.copyWith(
                                  fontSize: AppFontSize.sp40.responsiveFontSize,
                                )
                            : AppReference.themeData.textTheme.displayLarge,
                        textAlign: TextAlign.center,
                      ),
                      AppSize.s20.sizedBoxHeight,
                      Text(
                          AppStrings.verificationDescriptionForTablet(
                              signUpParameter.emailOrPhone),
                          style: AppReference.deviceIsTablet
                              ? const AppTextStyle().w600.titleSmall18
                              : AppReference.themeData.textTheme.bodyLarge,
                          textAlign: TextAlign.center),
                      AppSize.s20.sizedBoxHeight,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                PinCodeFieldWidget(onComplete: (value) {
                                  code = value;
                                }),
                                AppSize.s40.sizedBoxHeight,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppStrings.didNotReceiveCodeYet,
                                      style: AppReference.deviceIsTablet
                                          ? const AppTextStyle()
                                              .w800
                                              .titleMedium20
                                              .copyWith(
                                                fontSize: AppFontSize
                                                    .sp14.responsiveFontSize,
                                              )
                                          : AppReference
                                              .themeData.textTheme.bodyMedium,
                                    ),
                                    StatefulBuilder(
                                      builder: (context, setBuilderState) {
                                        return Row(
                                          children: [
                                            TextButtonWidget(
                                              withDecoration: true,
                                              fontSize: AppFontSize
                                                  .sp10.responsiveFontSize,
                                              text: AppStrings.resendCode,
                                              onPressed: reSend
                                                  ? () {
                                                      context
                                                          .read<
                                                              VerificationBloc>()
                                                          .add(VerificationCodeResent(
                                                              sendVerificationCodeParams:
                                                                  sendVerificationCodeParams));
                                                      setBuilderState(() {
                                                        reSend = false;
                                                      });
                                                    }
                                                  : () {},
                                            ),
                                            if (!reSend)
                                              TimerToResend(
                                                canSend: (canSend) {
                                                  setBuilderState(() {
                                                    reSend = canSend;
                                                  });
                                                },
                                              ),
                                          ],
                                        );
                                      },
                                    ),
                                  ],
                                ),
                                AppSize.s40.sizedBoxHeight,
                                Center(
                                  child: SizedBox(
                                    width: AppReference.deviceWidth(context) *
                                        0.45,
                                    child: DefaultButtonWidget(
                                      label: AppStrings.verification,
                                      onPressed: () async {
                                        getIt<BaseAppSecurityData>()
                                            .deleteToken()
                                            .then((value) {
                                          if (context.mounted) {
                                            context
                                                .read<VerificationBloc>()
                                                .add(
                                                  VerificationCodeChecked(
                                                    signUpParameter:
                                                        signUpParameter,
                                                    code: code,
                                                    email: signUpParameter
                                                        .emailOrPhone,
                                                  ),
                                                );
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SvgPicture.asset(
                            AppImagesAssets.sFinger,
                            height: AppReference.deviceHeight(context) *
                                0.2.responsiveHeightRatio,
                          ),
                        ],
                      ),
                    ],
                  ).paddingBody(),
                ),
              ),
            ),
          ),
        ));
  }
}

class TimerToResend extends StatefulWidget {
  final Function(bool) canSend;

  const TimerToResend({super.key, required this.canSend});

  @override
  State<TimerToResend> createState() => _TimerToResendState();
}

class _TimerToResendState extends State<TimerToResend> {
  int _secondsRemaining = 30;

  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    const duration = Duration(seconds: 1); // Change the duration as needed
    _timer = Timer.periodic(duration, (timer) {
      if (_secondsRemaining == 0) {
        _timer!.cancel();
        setState(() {
          widget.canSend(true);
        });
      } else {
        setState(() {
          _secondsRemaining--;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      ' $_secondsRemaining  ${AppStrings.second} ',
    );
  }
}

class VerificationPortraitView extends StatefulWidget {
  const VerificationPortraitView(
      {super.key,
      required this.signUpParameter,
      required this.sendVerificationCodeParams});
  final SignUpParameter signUpParameter;
  final SendVerificationCodeParameter sendVerificationCodeParams;
  @override
  State<VerificationPortraitView> createState() =>
      _VerificationPortraitViewState();
}

class _VerificationPortraitViewState extends State<VerificationPortraitView> {
  String code = '';
  bool reSend = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppSize.s10.sizedBoxHeight,
          const Align(
              alignment: AlignmentDirectional.centerEnd,
              child: TextBackButton()),
          AppSize.s30.sizedBoxHeight,
          Text(
            AppStrings.verificationTitle,
            style: AppReference.themeData.textTheme.displayLarge,
            textAlign: TextAlign.center,
          ),
          AppSize.s20.sizedBoxHeight,
          Text(
              AppStrings.verificationDescription(
                  widget.signUpParameter.emailOrPhone),
              style: AppReference.themeData.textTheme.bodyLarge,
              textAlign: TextAlign.center),
          AppSize.s20.sizedBoxHeight,
          SvgPicture.asset(
            AppImagesAssets.sFinger,
            height:
                AppReference.deviceHeight(context) * 0.2.responsiveHeightRatio,
          ),
          AppSize.s30.sizedBoxHeight,
          PinCodeFieldWidget(onComplete: (value) {
            code = value;
          }),
          AppSize.s58.sizedBoxHeight,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppStrings.didNotReceiveCodeYet,
                style: AppReference.themeData.textTheme.bodyMedium,
              ),
              StatefulBuilder(
                builder: (context, setBuilderState) {
                  return Row(
                    children: [
                      TextButtonWidget(
                        text: AppStrings.resendCode,
                        onPressed: reSend
                            ? () {
                                context.read<VerificationBloc>().add(
                                    VerificationCodeResent(
                                        sendVerificationCodeParams:
                                            widget.sendVerificationCodeParams));
                                setBuilderState(() {
                                  reSend = false;
                                });
                              }
                            : () {},
                      ),
                      if (!reSend)
                        TimerToResend(
                          canSend: (canSend) {
                            setBuilderState(() {
                              reSend = canSend;
                            });
                          },
                        ),
                    ],
                  );
                },
              ),
            ],
          ),
          AppSize.s26.sizedBoxHeight,
          DefaultButtonWidget(
            label: AppStrings.verification,
            onPressed: () async {
              getIt<BaseAppSecurityData>().deleteToken().then((value) {
    if (context.mounted){
    context.read<VerificationBloc>().add(
                      VerificationCodeChecked(
                        signUpParameter: widget.signUpParameter,
                        code: code,
                        email: widget.signUpParameter.emailOrPhone,
                      ),
                    );}
              });
            },
          ),
        ],
      ).paddingBody(),
    );
  }
}
