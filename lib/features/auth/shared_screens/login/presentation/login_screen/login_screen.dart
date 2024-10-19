part of '../../login.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final GlobalKey<FormState> _formKey;
  late final FocusNode _emailFocusNode;
  late final FocusNode _passwordFocusNode;
  UsersType userType = UsersType.child;
  SocialLoginDataEntity socialLoginDataEntity = const SocialLoginDataEntity(
    displayName: '',
    email: '',
    photoUrl: '',
    socialId: '',
  );
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ContactUsBloc>()..add(GetContactUsEvent()),
      child: GestureDetector(
        onTap: () {
         // FocusScope.of(context).hasPrimaryFocus.log();
          if (!FocusScope.of(context).hasPrimaryFocus) {
            FocusScope.of(context).unfocus();
          }
          _emailFocusNode.unfocus();
          _passwordFocusNode.unfocus();
        },
        child: Scaffold(
          body: BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              switch (state.loginStates) {
                case RequestStates.loading:
                  showLoadingDialog(context);
                case RequestStates.loaded:
                  Navigator.of(context).pop();
                  AppAnalytics.loginLogEvent();
                  _checkUserIsChild(state.loginMessage);
                case RequestStates.error:
                  Navigator.of(context).pop();
                  showSnackBar(
                      description: state.loginMessage,
                      state: ToastStates.error,
                      context: context);
                default:
              }

              switch (state.socialLoginStates) {
                case RequestStates.loading:
                  showLoadingDialog(context);
                case RequestStates.loaded:
                  Navigator.of(context).pop();
                  _checkUserIsChild(state.loginMessage);
                case RequestStates.error:
                  Navigator.of(context).pop();
                  RouteManager.rPushNamed(
                    context: context,
                    rName: AppRoutesNames.rCompleteProfileScreen,
                    arguments: socialLoginDataEntity,
                  );
                default:
              }


            },
            child: SafeArea(
              child: ResponsiveWidgetForTablet(
                mobile: OrientationItem(
                  portraitWidget: LoginPortraitView(
                      formKey: _formKey,
                      goToForgetPasswordScreen: _goToForgetPasswordScreen,
                      login: _login,
                      onDataLoaded: (value) {
                        socialLoginDataEntity = value;
                       // socialLoginDataEntity.log();
                        context
                            .read<LoginBloc>()
                            .add(SocialLoginEvent(socialId: value.socialId));
                      },
                      onChanged:(value){
                        userType = value;
                      },
                      emailController: _emailController,
                      passwordFocusNode: _passwordFocusNode,
                      emailFocusNode: _emailFocusNode,
                      passwordController: _passwordController),
                  landscapeWidget: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                         Align(
                            alignment: AlignmentDirectional.centerEnd,
                            child: const TextBackButton().paddingBody()),
                        const LoginTextSignIn(),
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: SingleChildScrollView(
                                  physics: const BouncingScrollPhysics(),
                                  child: Column(
                                    children: [
                                      GetSocialView(
                                        isAgree: true,
                                        isLogin: true,
                                        onDataLoaded: (value) {
                                          socialLoginDataEntity = value;
                                          context
                                              .read<LoginBloc>()
                                              .add(SocialLoginEvent(socialId: value.socialId));
                                        },
                                      ),
                                      AppSize.s10.sizedBoxHeight,
                                      PhoneInputFiled(
                                        label: AppStrings.phone,
                                        phoneController: _emailController,
                                        nextFocusNode: _passwordFocusNode,
                                        phoneFocusNode: _emailFocusNode,
                                      ),
                                      PasswordInputFiled(
                                        passwordController:
                                            _passwordController,
                                        passwordFocusNode:
                                            _passwordFocusNode,
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional.topStart,
                                        child: TextButtonWidget(
                                          text: AppStrings.forgetPassword,
                                          onPressed:
                                              _goToForgetPasswordScreen,
                                        ),
                                      ),
                                      AppSize.s6.sizedBoxHeight,

                                      CustomDropdown(onChanged: (value) {
                                          userType = value;
                                      },),
                                      AppSize.s30.sizedBoxHeight,
                                      Center(
                                        child: DefaultButtonWidget(
                                          label: AppStrings.login,
                                          onPressed: _login,
                                        ),
                                      ),
                                      AppSize.s10.sizedBoxHeight,
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SvgPicture.asset(AppImagesAssets.sSmartphone),
                                          const Expanded(child:  ContactUsWidgetInLoginScreen()),
                                        ],
                                      ),
                                      const FittedBox(
                                          child: DonNtHaveAccount()),
                                    ],
                                  ).paddingBody(),
                                ),
                              ),
                              Expanded(
                                child: ImageWidget(
                                  height:
                                      AppReference.deviceHeight(context) *
                                          0.8,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                tablet:OrientationItem(
                  portraitWidget: LoginPortraitView(
                      formKey: _formKey,
                      goToForgetPasswordScreen: _goToForgetPasswordScreen,
                      login: _login,
                      onDataLoaded: (value) {
                        socialLoginDataEntity = value;
                        //socialLoginDataEntity.log();
                        context
                            .read<LoginBloc>()
                            .add(SocialLoginEvent(socialId: value.socialId));
                      },
                      onChanged:(value){
                        userType = value;
                      },
                      emailController: _emailController,
                      passwordFocusNode: _passwordFocusNode,
                      emailFocusNode: _emailFocusNode,
                      passwordController: _passwordController),
                  landscapeWidget: Center(
                    child: SizedBox(
                      width: AppReference.deviceWidth(context)*.35,
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Align(
                                  alignment: AlignmentDirectional.centerEnd,
                                  child: TextBackButton()),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Expanded(child:  LoginTextSignIn()),
                                  ImageWidget(
                                    height: AppReference.deviceHeight(context) *
                                        0.35.responsiveHeight,
                                  ),

                                ],
                              ),
                              Center(
                                child: Text(
                                  AppStrings.signInWithSocial2,
                                  style: AppTextStyle.bodyMedium14,
                                ),
                              ),
                              AppSize.s10.sizedBoxHeight,

                              Center(
                                child: GetSocialView(
                                  isAgree: true,
                                  isLogin: true,
                                  onDataLoaded: (value) {
                                    socialLoginDataEntity = value;
                                    context
                                        .read<LoginBloc>()
                                        .add(SocialLoginEvent(socialId: value.socialId));
                                  },
                                ),
                              ),
                              AppSize.s16.sizedBoxHeight,
                              PhoneInputFiled(
                                label: AppStrings.phone,
                                phoneController: _emailController,
                                nextFocusNode: _passwordFocusNode,
                                phoneFocusNode: _emailFocusNode,
                              ),
                              PasswordInputFiled(
                                passwordController: _passwordController,
                                passwordFocusNode: _passwordFocusNode,
                              ),
                              AppSize.s6.sizedBoxHeight,
                              TextButtonWidget(
                                text: AppStrings.forgetPassword,
                                fontSize: 14,
                                onPressed: _goToForgetPasswordScreen,
                              ),
                              AppSize.s14.sizedBoxHeight,
                              CustomDropdown(onChanged: (value) {
                                userType = value;
                              },),
                              AppSize.s20.sizedBoxHeight,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(AppImagesAssets.sSmartphone),
                                  const Expanded(child:  ContactUsWidgetInLoginScreen()),
                                ],
                              ),
                              AppSize.s20.sizedBoxHeight,
                              SizedBox(
                                width: AppReference.deviceWidth(context) * 0.3,
                                height: 65.responsiveHeight,
                                child: DefaultButtonWidget(
                                  textFontSize: AppFontSize.sp14,
                                  label: AppStrings.login,
                                  onPressed: _login,
                                ),
                              ),
                              AppSize.s10.sizedBoxHeight,
                              const DonNtHaveAccount(),
                              AppSize.s10.sizedBoxHeight,
                            ],
                          ).paddingBody(),
                        ),
                      ),
                    ),
                  ),
                )
              ),
            ),
          ),
        ),
      ),
    );
  }

  _login() {
    if (_emailController.text.isEmpty) {
      showSnackBar(
          description: AppStrings.loginMailRequired,
          state: ToastStates.warning,
          context: context);
    } else if (_formKey.currentState!.validate()) {
      context.read<LoginBloc>().add(LoggedIn(
            email: _emailController.text,
            password: _passwordController.text,
            userType: userType,
          ));
    }
  }

  _goToForgetPasswordScreen() {
    RouteManager.rPushNamed(
      context: context,
      rName: AppRoutesNames.rForgotPasswordScreen,
    );
  }

  void _checkChildHaveStageOrNot(loginMessage) {
    if (context.read<LoginBloc>().userData.stageId != 0) {
      _checkChildIsBlockedOrNot(loginMessage);
    } else {
      Navigator.pushReplacementNamed(
        context,
        AppRoutesNames.rGradeChoosingScreen,
        arguments: false,
      );
    }
  }

  void _checkUserIsChild(String loginMessage) {
    if (context.read<LoginBloc>().userData.type == UsersType.child.name) {
      _checkChildHaveStageOrNot(loginMessage);
    } else {
      showSnackBar(
        description: loginMessage,
        state: ToastStates.congrats,
        context: context,
      );
      _goToHome();
    }
  }

  void _checkChildIsBlockedOrNot(String loginMessage) {
    if (context.read<LoginBloc>().userData.lock == "yes") {
      showSnackBar(
          description: context.read<LoginBloc>().userData.lockMessage ??
              AppStrings.contactWithOwner,
          state: ToastStates.error,
          context: context);
      return;
    } else {
      showSnackBar(
        description: loginMessage,
        state: ToastStates.congrats,
        context: context,
      );
      _goToHome();
    }
  }

  void _goToHome() {
    RouteManager.rPushNamedAndRemoveUntil(
        context: context,
        rName: AppRoutesNames.rHomeLayoutView,
        arguments: context.read<LoginBloc>().userData);
  }

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _passwordFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    _emailFocusNode.dispose();
    super.dispose();
  }
}

class LoginPortraitView extends StatelessWidget {
  const LoginPortraitView({
    super.key,
    required GlobalKey<FormState> formKey,
    required TextEditingController emailController,
    required FocusNode passwordFocusNode,
    required FocusNode emailFocusNode,
    required TextEditingController passwordController,
     required this.login,
    required this.goToForgetPasswordScreen,
    required this.onChanged,
    required this.onDataLoaded,

  }) : _formKey = formKey, _emailController = emailController, _passwordFocusNode = passwordFocusNode, _emailFocusNode = emailFocusNode, _passwordController = passwordController;

  final GlobalKey<FormState> _formKey;
  final TextEditingController _emailController;
  final FocusNode _passwordFocusNode;
  final FocusNode _emailFocusNode;
  final TextEditingController _passwordController;
  final Function() login;
  final Function() goToForgetPasswordScreen;
  final Function(UsersType) onChanged;
  final Function(SocialLoginDataEntity) onDataLoaded;


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Align(
                alignment: AlignmentDirectional.centerEnd,
                child: TextBackButton()),
            const LoginTextSignIn(),
            ImageWidget(
              height: AppReference.deviceHeight(context) *
                  0.25.responsiveHeightRatio,
            ),
            Center(
              child: Text(
                AppStrings.signInWithSocial2,
                style: AppTextStyle.bodyMedium14,
              ),
            ),

            GetSocialView(
              isAgree: true,
              isLogin: true,
              onDataLoaded: (value) {
                onDataLoaded(value);
              },
            ),
            AppSize.s16.sizedBoxHeight,
            PhoneInputFiled(
              label: AppStrings.phone,
              phoneController: _emailController,
              nextFocusNode: _passwordFocusNode,
              phoneFocusNode: _emailFocusNode,
            ),

            PasswordInputFiled(
              passwordController: _passwordController,
              passwordFocusNode: _passwordFocusNode,
            ),
            AppSize.s6.sizedBoxHeight,
            TextButtonWidget(
              text: AppStrings.forgetPassword,
              fontSize: 14,
              onPressed: () {
                goToForgetPasswordScreen();
              },
            ),
            AppSize.s14.sizedBoxHeight,
            // SelectTypeOfUser(
            //   onChanged: (value) {
            //    onChanged(value);
            //   },
            // ),
            CustomDropdown(onChanged: (value) {
              onChanged(value);
            },),
            AppSize.s20.sizedBoxHeight,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(AppImagesAssets.sSmartphone),
                const Expanded(child:  ContactUsWidgetInLoginScreen()),
              ],
            ),
            AppSize.s20.sizedBoxHeight,
            Center(
              child: DefaultButtonWidget(
                label: AppStrings.login,
                onPressed: () {
                  login();
                },
              ),
            ),
            AppSize.s10.sizedBoxHeight,
            const DonNtHaveAccount(),
            AppSize.s10.sizedBoxHeight,
          ],
        ).paddingBody(),
      ),
    );
  }
}

