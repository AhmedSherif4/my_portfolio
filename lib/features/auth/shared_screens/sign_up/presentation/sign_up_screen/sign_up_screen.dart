part of '../.././sign_up.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  late final FocusNode _nameFocusNode;
  late final FocusNode _emailFocusNode;
  late final FocusNode _passwordFocusNode;
  late final FocusNode _confirmPasswordFocusNode;
  late final FocusNode _phoneFocusNode;

  late final GlobalKey<FormState> _formKey;

  bool isAgree = false;
  UsersType userType = UsersType.child;
  GenderType genderType = GenderType.male;
  SendType sendType = SendType.email;
  bool isValidImage = true;
  bool isObscureText = true;
  bool isObscureTextForConfirmPassword = true;
  File file = File('');
  String errorMessage = "";
  SocialLoginDataEntity socialLoginDataEntity = const SocialLoginDataEntity(
      displayName: '',
      email: '',
      photoUrl: '',
      socialId: '',
  );

  @override
  Widget build(BuildContext context) {
    final edgeZone = AppReference.deviceWidth(context) * 0.2;

    return GestureDetector(
      onHorizontalDragUpdate: (details) async {
        if (details.primaryDelta! > 0 && details.localPosition.dx < edgeZone) {
          RouteManager.rPopRoute(context);
        }
      },
      child: Scaffold(
        body:  MultiBlocListener(
            listeners: [
              BlocListener<SignUpBloc, SignUpState>(
                listener: (context, state) {
                  switch (state.sendVerificationCodeStates) {
                    case RequestStates.loading:
                      showLoadingDialog(context);
                    case RequestStates.loaded:
                      _goToVerificationScreen(context, state);
                    case RequestStates.error:
                      _errorCase(context, state);
                    default:
                  }
                },),
              BlocListener<LoginBloc, LoginState>(listener: (context, state){
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

              }),
            ],
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
                _emailFocusNode.unfocus();
                _passwordFocusNode.unfocus();
                _confirmPasswordFocusNode.unfocus();
                _nameFocusNode.unfocus();
                _phoneFocusNode.unfocus();
              },
              child: SafeArea(
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

                        ResponsiveWidgetForTablet(
                          mobile: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                 const _HeadWidget(),
                                 AppSize.s20.sizedBoxHeight,
                                 Center(
                                   child: Text(
                                     AppStrings.signInWithSocial2,
                                     style: AppTextStyle.bodyMedium14,
                                   ),
                                 ),
                                 AppSize.s10.sizedBoxHeight,
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

                                 NameInputFiled(
                                   nameController: _nameController,
                                   nameFocusNode: _nameFocusNode,
                                   nextFocusNode: _phoneFocusNode,
                                 ),
                                 AppSize.s20.sizedBoxHeight,
                                 const Align(
                                   alignment: Alignment.centerRight,
                                   child: Text(
                                     AppStrings.phone,
                                     textAlign: TextAlign.start,
                                   ),
                                 ),
                                 Row(
                                   mainAxisSize: MainAxisSize.min,
                                   mainAxisAlignment:
                                       MainAxisAlignment.start,
                                   crossAxisAlignment:
                                       CrossAxisAlignment.start,
                                   children: [
                                     Container(
                                         margin: EdgeInsets.symmetric(
                                           vertical:
                                               AppPadding.p10.responsiveSize,
                                         ),
                                         padding: EdgeInsets.symmetric(
                                           horizontal:
                                               AppPadding.p10.responsiveSize,
                                           vertical:
                                               AppPadding.p10.responsiveSize,
                                         ),
                                         decoration: BoxDecoration(
                                           color: AppColors.white,
                                           borderRadius:
                                               BorderRadius.circular(
                                                   AppConstants
                                                       .appBorderRadiusR20),
                                         ),
                                         child: Text("+966",
                                             style: AppReference
                                                 .themeData
                                                 .inputDecorationTheme
                                                 .hintStyle)),
                                     AppSize.s10.sizedBoxWidth,
                                     Expanded(
                                       child: PhoneInputFiled(
                                         phoneController:
                                             _phoneController,
                                         phoneFocusNode: _phoneFocusNode,
                                         nextFocusNode: _emailFocusNode,
                                       ),
                                     ),
                                   ],
                                 ),
                                 EmailInputFiled(
                                   emailController: _emailController,
                                   emailFocusNode: _emailFocusNode,
                                   nextFocusNode: _passwordFocusNode,
                                   isLoginScreen: true,
                                 ),

                              PasswordInputFiled(
                                passwordController: _passwordController,
                                passwordFocusNode: _passwordFocusNode,
                                nextFocusNode: _confirmPasswordFocusNode,
                              ),
                              ConfirmPasswordInputFiled(
                                confirmPasswordController:
                                    _confirmPasswordController,
                                confirmPasswordFocusNode:
                                    _confirmPasswordFocusNode,
                              ),
                              // SelectTypeOfUser(
                              //   onChanged: (value) {
                              //     setState(() {
                              //       userType = value;
                              //     });
                              //   },
                              // ),
                              CustomDropdown(onChanged: (value) {
                                setState(() {
                                        userType = value;
                                      });
                              },),
                              AppSize.s10.sizedBoxHeight,
                              Text(
                                AppStrings.hintForChildAccountOpenOneDevice,
                                style: AppReference
                                    .themeData.textTheme.bodyMedium!
                                    .copyWith(
                                  color: AppColors.textColor2,
                                  fontWeight: AppFontWeight.regular2W500,
                                ),
                              ),
                              AppSize.s16.sizedBoxHeight,
                              if(userType == UsersType.child||userType == UsersType.parent)...[
                              SelectGender(onGenderSelected: (value) {
                                genderType = value;
                              }),
                              AppSize.s16.sizedBoxHeight,],
                              PickImageInkWell(
                                onPickFile: (value) {
                                  file = value;
                                },
                                onErrorMessage: (value) {
                                  errorMessage = value;
                                },
                                pickImageWidget: PickImgWidget(
                                  pickImageErrorMessage: errorMessage,
                                ),
                                pickImageShape: PickImageShape.bottomSheet,
                                loadingPickImageWidget: const LoadingWidget(),
                                errorPickImageWidget: StatefulBuilder(
                                  builder: (context, sState) {
                                    return PickImgWidget(
                                      pickImageErrorMessage: errorMessage,
                                    );
                                  },
                                ),
                                loadedPickImageWidget: PickImgWidget(
                                  pickImageErrorMessage: errorMessage,
                                ),
                                permissionDialogMessage:
                                AppStrings.photoPermissionMessage,
                              ),
                              AppSize.s10.sizedBoxHeight,
                              TermsAndConditionView(isAgree: (bool value) {
                                isAgree = value;
                              }),
                              AppSize.s16.sizedBoxHeight,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                      AppImagesAssets.sSmartphone
                                  ),
                                  const   Expanded(child:  ContactUsWidgetInLoginScreen()),
                                 ],
                              ),
                              AppSize.s16.sizedBoxHeight,
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: AppPadding.p30.responsiveWidth),
                                child: DefaultButtonWidget(
                                  label: AppStrings.login,
                                  isExpanded: true,
                                  onPressed: () {
                                    _checkIfFieldsValidateNSendVerificationCode(context);
                                  },
                                ),
                              ),
                              AppSize.s16.sizedBoxHeight,
                              const _GoToLoginScreen(),
                            ],
                          ),
                          tablet: OrientationItem(
                            portraitWidget: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const _HeadWidget(),
                                AppSize.s20.sizedBoxHeight,
                                Center(
                                  child: Text(
                                    AppStrings.signInWithSocial2,
                                    style: AppTextStyle.bodyMedium14,
                                  ),
                                ),
                                AppSize.s10.sizedBoxHeight,

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
                                NameInputFiled(
                                  nameController: _nameController,
                                  nameFocusNode: _nameFocusNode,
                                  nextFocusNode: _phoneFocusNode,
                                ),
                                AppSize.s20.sizedBoxHeight,
                                const Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    AppStrings.phone,
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        margin: EdgeInsets.symmetric(
                                          vertical:
                                          AppPadding.p10.responsiveSize,
                                        ),
                                        padding: EdgeInsets.symmetric(
                                          horizontal:
                                          AppPadding.p10.responsiveSize,
                                          vertical:
                                          AppPadding.p10.responsiveSize,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.white,
                                          borderRadius:
                                          BorderRadius.circular(
                                              AppConstants
                                                  .appBorderRadiusR20),
                                        ),
                                        child: Text("+966",
                                            style: AppReference
                                                .themeData
                                                .inputDecorationTheme
                                                .hintStyle)),
                                    AppSize.s10.sizedBoxWidth,
                                    Expanded(
                                      child: PhoneInputFiled(
                                        phoneController:
                                        _phoneController,
                                        phoneFocusNode: _phoneFocusNode,
                                        nextFocusNode: _emailFocusNode,
                                      ),
                                    ),
                                  ],
                                ),
                                EmailInputFiled(
                                  emailController: _emailController,
                                  emailFocusNode: _emailFocusNode,
                                  nextFocusNode: _passwordFocusNode,
                                  isLoginScreen: true,
                                ),

                                PasswordInputFiled(
                                  passwordController: _passwordController,
                                  passwordFocusNode: _passwordFocusNode,
                                  nextFocusNode: _confirmPasswordFocusNode,
                                ),
                                ConfirmPasswordInputFiled(
                                  confirmPasswordController:
                                  _confirmPasswordController,
                                  confirmPasswordFocusNode:
                                  _confirmPasswordFocusNode,
                                ),
                                CustomDropdown(onChanged: (value) {
                                  setState(() {
                                    userType = value;
                                  });
                                },),
                                AppSize.s10.sizedBoxHeight,
                                Text(
                                  AppStrings.hintForChildAccountOpenOneDevice,
                                  style: AppReference
                                      .themeData.textTheme.bodyMedium!
                                      .copyWith(
                                    color: AppColors.textColor2,
                                    fontWeight: AppFontWeight.regular2W500,
                                  ),
                                ),
                                AppSize.s16.sizedBoxHeight,
                                if(userType == UsersType.child||userType == UsersType.parent)...[
                                  SelectGender(onGenderSelected: (value) {
                                    genderType = value;
                                  }),
                                  AppSize.s16.sizedBoxHeight,],
                                PickImageInkWell(
                                  onPickFile: (value) {
                                    file = value;
                                  },
                                  onErrorMessage: (value) {
                                    errorMessage = value;
                                  },
                                  pickImageWidget: PickImgWidget(
                                    pickImageErrorMessage: errorMessage,
                                  ),
                                  pickImageShape: PickImageShape.bottomSheet,
                                  loadingPickImageWidget: const LoadingWidget(),
                                  errorPickImageWidget: StatefulBuilder(
                                    builder: (context, sState) {
                                      return PickImgWidget(
                                        pickImageErrorMessage: errorMessage,
                                      );
                                    },
                                  ),
                                  loadedPickImageWidget: PickImgWidget(
                                    pickImageErrorMessage: errorMessage,
                                  ),
                                  permissionDialogMessage:
                                  AppStrings.photoPermissionMessage,
                                ),
                                AppSize.s10.sizedBoxHeight,
                                TermsAndConditionView(isAgree: (bool value) {
                                  isAgree = value;
                                }),
                                AppSize.s16.sizedBoxHeight,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                        AppImagesAssets.sSmartphone
                                    ),
                                    const ContactUsWidgetInLoginScreen(),
                                  ],
                                ),
                                AppSize.s16.sizedBoxHeight,
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: AppPadding.p30.responsiveWidth),
                                  child: DefaultButtonWidget(
                                    label: AppStrings.login,
                                    isExpanded: true,
                                    onPressed: () {
                                      _checkIfFieldsValidateNSendVerificationCode(context);
                                    },
                                  ),
                                ),
                                AppSize.s16.sizedBoxHeight,
                                const _GoToLoginScreen(),
                              ],
                            ),
                            landscapeWidget: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const _HeadWidgetForTablet(),
                                AppSize.s20.sizedBoxHeight,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: AppReference.deviceWidth(context) * 0.3,
                                      child: Column(
                                        children: [
                                          CustomDropdown(onChanged: (value) {
                                            setState(() {
                                              userType = value;
                                            });
                                          },),
                                          AppSize.s10.sizedBoxHeight,
                                          SelectGender(onGenderSelected: (value) {
                                            genderType = value;
                                          }),
                                          Text(
                                            AppStrings
                                                .hintForChildAccountOpenOneDevice,
                                            style:AppReference.deviceIsTablet?const AppTextStyle().w600.bodySmall12
                                                .copyWith(
                                              color: AppColors.textColor2,
                                              fontSize: 10.responsiveFontSize,
                                            ) :AppReference.themeData
                                                .textTheme.headlineSmall!
                                                .copyWith(
                                              color: AppColors.textColor2,
                                              fontWeight:
                                                  AppFontWeight.regular2W500,
                                            ),
                                          ),

                                          AppSize.s20.sizedBoxHeight,
                                          PickImageInkWell(
                                            onPickFile: (value) {
                                              file = value;
                                            },
                                            onErrorMessage: (value) {
                                              errorMessage = value;
                                            },
                                            pickImageWidget: PickImgWidget(
                                              pickImageErrorMessage: errorMessage,
                                            ),
                                            pickImageShape: PickImageShape.bottomSheet,
                                            loadingPickImageWidget: const LoadingWidget(),
                                            errorPickImageWidget: StatefulBuilder(
                                              builder: (context, sState) {
                                                return PickImgWidget(
                                                  pickImageErrorMessage: errorMessage,
                                                );
                                              },
                                            ),
                                            loadedPickImageWidget: PickImgWidget(
                                              pickImageErrorMessage: errorMessage,
                                            ),
                                            permissionDialogMessage:
                                            AppStrings.photoPermissionMessage,
                                          ),
                                          AppSize.s10.sizedBoxHeight,
                                          TermsAndConditionView(isAgree: (bool value) {
                                            isAgree = value;
                                          }),

                                        ],
                                      ),
                                    ),
                                    AppSize.s20.sizedBoxWidth,

                                    SizedBox(
                                      width: AppReference.deviceWidth(context) * 0.3,
                                      child: Column(
                                        children: [
                                          Text(AppStrings.signInWithSocial,
                                              style: AppTextStyle.bodyMedium14),
                                          AppSize.s20.sizedBoxHeight,
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
                                          NameInputFiled(
                                            nameController: _nameController,
                                            nameFocusNode: _nameFocusNode,
                                            nextFocusNode: _phoneFocusNode,
                                          ),
                                          AppSize.s20.sizedBoxHeight,
                                           Align(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              AppStrings.phone,
                                              textAlign: TextAlign.start,
                                              style: AppTextStyle.bodySmall12,
                                            ),
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                  margin: EdgeInsets.symmetric(
                                                    vertical:
                                                    AppPadding.p8.responsiveSize,
                                                  ),
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                    AppPadding.p10.responsiveSize,
                                                    vertical:
                                                    AppPadding.p4.responsiveSize,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: AppColors.white,
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        AppConstants
                                                            .appBorderRadiusR20.responsiveSize),
                                                  ),
                                                  child: Center(
                                                    child: Text("+966",
                                                        style: AppReference
                                                            .themeData
                                                            .inputDecorationTheme
                                                            .hintStyle),
                                                  )),
                                              AppSize.s10.sizedBoxWidth,
                                              Expanded(
                                                child: PhoneInputFiled(
                                                  phoneController:
                                                  _phoneController,
                                                  phoneFocusNode: _phoneFocusNode,
                                                  nextFocusNode: _emailFocusNode,
                                                ),
                                              ),
                                            ],
                                          ),
                                          PasswordInputFiled(
                                            passwordController: _passwordController,
                                            passwordFocusNode: _passwordFocusNode,
                                            nextFocusNode: _confirmPasswordFocusNode,
                                          ),
                                          ConfirmPasswordInputFiled(
                                            confirmPasswordController:
                                            _confirmPasswordController,
                                            confirmPasswordFocusNode:
                                            _confirmPasswordFocusNode,
                                          ),
                                          AppSize.s16.sizedBoxHeight,
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset(
                                                  AppImagesAssets.sSmartphone
                                              ),
                                              const Expanded(child: ContactUsWidgetInLoginScreen()),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),


                                  ],
                                ),
                                AppSize.s32.sizedBoxHeight,
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: AppPadding.p30.responsiveWidth),
                                  child: Center(
                                    child: SizedBox(
                                      width: AppReference.deviceWidth(context) * 0.3,
                                      height: 65.responsiveHeight,
                                      child: DefaultButtonWidget(
                                        textVerticalPadding: 2,
                                        label: AppStrings.login,
                                        onPressed: () {
                                          _checkIfFieldsValidateNSendVerificationCode(
                                              context);
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                AppSize.s16.sizedBoxHeight,
                                const _GoToLoginScreen(),

                              ],
                            ),
                          ),
                        ),
                      ],
                    ).paddingBody(),
                  ),
                ),
              ),
            )),
      ),
    );
  }


  void _errorCase(BuildContext context, SignUpState state) {
    Navigator.pop(context);
    showSnackBar(
      description: state.sendVerificationCodeMessage,
      state: ToastStates.error,
      context: context,
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
    context.read<GlobalBloc>().fromRegister = true;
    RouteManager.rPushNamedAndRemoveUntil(
        context: context,
        rName: AppRoutesNames.rHomeLayoutView,
        arguments: context.read<LoginBloc>().userData);
  }

  bool _checkUserIsChildSignup() {
    if (userType == UsersType.child) {
      return true;
    } else {
      return false;
    }
  }

  void _goToVerificationScreen(BuildContext context, SignUpState state) {
    Navigator.pop(context);
    showSnackBar(
      description: state.sendVerificationCodeMessage,
      state: ToastStates.congrats,
      context: context,
    );
    RouteManager.rPushNamed(
        context: context,
        rName: AppRoutesNames.rVerificationScreen,
        arguments: {
          "signUpParameter": SignUpParameter(
            name: _nameController.text,
            emailOrPhone: _phoneController.text,
            type: userType,
            gendar: genderType.name,
            sendType: SendType.phone,
            img: file.path,
            password: _passwordController.text,
          ),
          "sendVerificationCodeParameter": SendVerificationCodeParameter(
            emailOrPhone: _phoneController.text,
            sendType: SendType.phone,
            userType: userType,
          )
        });
  }

  void _checkIfFieldsValidateNSendVerificationCode(BuildContext context) {
    if (_formKey.currentState!.validate() && isAgree) {
      if (_passwordController.text != _confirmPasswordController.text) {
        showSnackBar(
          description: AppStrings.confirmPasswordNotCorrect,
          state: ToastStates.warning,
          context: context,
        );
      } else {
        _sendVerificationCode(context);
      }
    } else if (!isAgree) {
      showSnackBar(
        description: AppStrings.alarmForApplicationPoliciesAndPrivacy,
        state: ToastStates.warning,
        context: context,
      );
    } else if (!_formKey.currentState!.validate()) {
      showSnackBar(
        description: AppStrings.alarmForCompleteUserData,
        state: ToastStates.warning,
        context: context,
      );
    }
  }

  void _sendVerificationCode(BuildContext context) {
    bool confirmed = false;
    if (isValidImage) {
      if (_checkUserIsChildSignup()) {
        showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => DefaultAlertDialog(
            confirm: (value) {
              confirmed = value;
            },
            message: AppStrings.childAccountOpenOneDevice,
          ),
        ).then((value) {
          if (confirmed) {
            if (context.mounted){
            context.read<SignUpBloc>().add(
                  VerificationCodeSentEvent(
                    sendVerificationCodeParams: SendVerificationCodeParameter(
                      emailOrPhone: _phoneController.text,
                      sendType: SendType.phone,
                      userType: userType,
                    ),
                  ),
                );}
          }
        });
      } else {
        context.read<SignUpBloc>().add(
              VerificationCodeSentEvent(
                sendVerificationCodeParams: SendVerificationCodeParameter(
                  emailOrPhone: _phoneController.text,
                  sendType: SendType.phone,
                  userType: userType,
                ),
              ),
            );
      }
    } else {
      showSnackBar(
        description: AppStrings.chooseCorrectImage,
        state: ToastStates.warning,
        context: context,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _nameFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _confirmPasswordFocusNode = FocusNode();
    _phoneFocusNode = FocusNode();
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    _phoneFocusNode.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }
}
