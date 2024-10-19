part of '../../forget_password.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController mailOrPhoneController = TextEditingController();
  SendType sendType = SendType.phone;
  UsersType userType = UsersType.child;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgetPasswordBloc, ForgetPasswordState>(
      listener: (context, state) {
        switch (state.forgetPasswordStates) {
          case RequestStates.loading:
            showLoadingDialog(context);
          case RequestStates.loaded:
            Navigator.of(context).pop();
            showSnackBar(
              context: context,
              description: state.forgetPasswordMessage,
              state: ToastStates.congrats,
            );
          case RequestStates.error:
            Navigator.of(context).pop();
            showSnackBar(
              context: context,
              description: state.forgetPasswordMessage,
              state: ToastStates.error,
            );
          default:
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: ResponsiveWidgetForTablet(
              mobile: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: TextBackButton(),
                  ),
                  Text(
                    AppStrings.forgetPasswordTitle,
                    style: const AppTextStyle().balooBhaijaan2.w400.displayMedium30,
                  ),
                  AppSize.s14.sizedBoxHeight,
                  Text(
                    AppStrings.forgetPasswordDescription,
                    style: AppTextStyle.bodyLarge16,
                  ),
                  AppSize.s14.sizedBoxHeight,
                  OrientationItem(
                    portraitWidget: ForgetPasswordPortraitView(
                        formKey: formKey,
                        onChanged: (value) {
                          userType = value;
                        },
                        mailOrPhoneController: mailOrPhoneController),
                    landscapeWidget: Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Column(
                              children: [
                                Form(
                                    key: formKey,
                                    child:PhoneInputFiled(
                                      label: AppStrings.phone,
                                            phoneController:
                                                mailOrPhoneController,
                                          )),
                                AppSize.s20.sizedBoxHeight,
                                // SelectTypeOfUser(onChanged: (value) {
                                //   userType = value;
                                // }),
                                CustomDropdown(onChanged: (value) {
                                  userType = value;
                                },),
                              ],
                            )),
                        AppSize.s10.sizedBoxWidth,
                        Expanded(
                          child: SvgPicture.asset(
                            AppImagesAssets.sForgetPasswordImage,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ],
                    ),
                  ),
                  AppSize.s50.sizedBoxHeight,
                  ForgetPasswordButton(formKey: formKey, mailOrPhoneController: mailOrPhoneController, userType: userType),
                ],
              ).paddingBody(),
              tablet: OrientationItem(
                portraitWidget: Column(
                  children: [
                    ForgetPasswordPortraitView(
                        formKey: formKey,
                        onChanged: (value) {
                          userType = value;
                        },
                        mailOrPhoneController: mailOrPhoneController),
                    AppSize.s50.sizedBoxHeight,
                    ForgetPasswordButton(formKey: formKey, mailOrPhoneController: mailOrPhoneController, userType: userType),
                  ],
                ).paddingBody(),
                landscapeWidget: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: TextBackButton(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center ,
                      children: [
                        SizedBox(
                          width: AppReference.deviceWidth(context) * 0.3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              SvgPicture.asset(
                                AppImagesAssets.sForgetPasswordImage,
                                width: AppReference.deviceWidth(context) * 0.5,
                                height: AppReference.deviceHeight(context) *
                                    0.15.responsiveHeightRatio,
                              ),

                            ],
                          ).paddingBody(),
                        ),
                        AppSize.s60.sizedBoxWidth,
                        SizedBox(
                          width: AppReference.deviceWidth(context) * 0.4,
                          height: AppReference.deviceHeight(context) * 0.9,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                AppStrings.forgetPasswordTitle,
                                style: const AppTextStyle().balooBhaijaan2.w700.titleLarge22.copyWith(
                                  fontSize: AppFontSize.sp26.responsiveFontSize,
                                ),
                              ),
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  AppStrings.forgetPasswordDescription,
                                  style: const AppTextStyle().titleSmall18,
                                ),
                              ),
                              AppSize.s14.sizedBoxHeight,
                              AppSize.s30.sizedBoxHeight,
                              Form(
                                  key: formKey,
                                  child:  PhoneInputFiled(
                                    label: AppStrings.phone,
                                    phoneController:
                                    mailOrPhoneController,
                                  )),
                              AppSize.s20.sizedBoxHeight,
                              // SelectTypeOfUser(onChanged: (value) {
                              //   userType = value;
                              // }),
                              CustomDropdown(onChanged: (value) {
                                userType = value;
                              },),
                              AppSize.s50.sizedBoxHeight,
                              ForgetPasswordButton(formKey: formKey, mailOrPhoneController: mailOrPhoneController, userType: userType),
                            ],
                          ).paddingBody(),
                        ),
                      ],
                    ),
                  ],
                ).paddingBody(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ForgetPasswordButton extends StatelessWidget {
  const ForgetPasswordButton({
    super.key,
    required this.formKey,
    required this.mailOrPhoneController,
    required this.userType,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController mailOrPhoneController;
  final UsersType userType;

  @override
  Widget build(BuildContext context) {
    return DefaultButtonWidget(
      label: AppStrings.send,
      onPressed: () {
        if (formKey.currentState!.validate()) {
          context.read<ForgetPasswordBloc>().add(
            SentEmailForForgettingPassword(
              email: mailOrPhoneController.text,
              userType: userType,
              sendType: SendType.phone,
            ),
          );
        }
      },
    );
  }
}

class ForgetPasswordPortraitView extends StatelessWidget {
  const ForgetPasswordPortraitView({
    super.key,
    required this.formKey,
    required this.mailOrPhoneController, required this.onChanged,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController mailOrPhoneController;
  final Function(UsersType) onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          AppImagesAssets.sForgetPasswordImage,
          width: AppReference.deviceWidth(context) * 0.5,
          height: AppReference.deviceHeight(context) *
              0.15.responsiveHeightRatio,
        ),
        AppSize.s30.sizedBoxHeight,
        Column(
          children: [
            AppSize.s30.sizedBoxHeight,
            Form(
                key: formKey,
                child:  PhoneInputFiled(
                  label: AppStrings.phone,
                        phoneController:
                            mailOrPhoneController,
                      )),
          ],
        ),
        AppSize.s20.sizedBoxHeight,
        // SelectTypeOfUser(onChanged: (value) {
        //   onChanged(value);
        // }),
        CustomDropdown(onChanged: (value) {
          onChanged(value);
        },),
      ],
    );
  }
}
