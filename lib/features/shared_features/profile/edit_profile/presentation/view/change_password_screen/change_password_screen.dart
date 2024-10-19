part of '../../../edit_profile.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  late TextEditingController currentPasswordController;
  late TextEditingController newPasswordController;
  late TextEditingController confirmPasswordController;

  late GlobalKey<FormState> _formKey;


  late FocusNode currentPasswordFocus;
  late FocusNode newPasswordFocus;
  late FocusNode confirmPasswordFocus;

  @override
  void initState() {
    super.initState();
    currentPasswordController = TextEditingController();
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    currentPasswordFocus = FocusNode();
    newPasswordFocus = FocusNode();
    confirmPasswordFocus = FocusNode();
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    currentPasswordFocus.dispose();
    newPasswordFocus.dispose();
    confirmPasswordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocListener<EditProfileBloc, EditProfileState>(
            listener: (context, state) {
              switch (state.changePasswordStates) {
                case RequestStates.loading:
                  showLoadingDialog(context);
                case RequestStates.loaded:
                  Navigator.of(context).pop();
                  showSnackBar(
                    context: context,
                    description: state.changePasswordMessage,
                    state: ToastStates.congrats,
                  );
                  Navigator.popUntil(context, (route) => route.isFirst);
                default:
              }
            },
            child: Form(
              key:_formKey ,
              child: Column(
                children: [
                  const HeaderForMore(title: AppStrings.changePassword),
                  ResponsiveWidgetForTablet(
                    mobile: Column(
                      children: [
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Container(
                            padding: EdgeInsetsDirectional.all(
                                AppPadding.p20.responsiveSize),
                            child: SvgPicture.asset(
                              AppImagesAssets.sChangePassword,
                              height: AppReference.deviceHeight(context) *
                                  0.1.responsiveHeightRatio,
                            ),
                          ),
                        ),
                        PasswordInputFiled(
                          passwordController: currentPasswordController,
                          passwordFocusNode: currentPasswordFocus,
                          nextFocusNode: newPasswordFocus,
                          label: AppStrings.oldPassword,
                        ),

                        PasswordInputFiled(
                          passwordController: newPasswordController,
                          passwordFocusNode: newPasswordFocus,
                          nextFocusNode: confirmPasswordFocus,
                          label: AppStrings.newPassword,
                        ),

                        PasswordInputFiled(
                          passwordController: confirmPasswordController,
                          passwordFocusNode: confirmPasswordFocus,
                          label: AppStrings.confirmNewPassword,
                        ),

                        CustomInkWell(
                          onTap: () {
                            RouteManager.rPushNamed(
                              context: context,
                              rName: AppRoutesNames.rForgotPasswordScreen,
                            );
                          },
                          child: Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Text(
                              AppStrings.forgotPassword,
                              style:
                              const AppTextStyle().blue.w700.bodyMedium14.copyWith(
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.primaryColor,
                              ),
                            ),
                          ),
                        ),
                        AppSize.s20.sizedBoxHeight,
                        DefaultButtonWidget(
                          label: AppStrings.save,
                          onPressed: () {
                            if(!_formKey.currentState!.validate()) {
                              return;
                            }else{
                              context.read<EditProfileBloc>().add(
                                ChangePassword(
                                  oldPassword: currentPasswordController.text,
                                  newPassword: newPasswordController.text,
                                ),
                              );
                            }

                          },
                        ),
                      ],
                    ),
                    tablet: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topStart,
                          child: Container(
                            padding: EdgeInsetsDirectional.all(
                                AppPadding.p20.responsiveSize),
                            child: SvgPicture.asset(
                              AppImagesAssets.sChangePassword,
                              height: AppReference.deviceHeight(context) *
                                  0.1.responsiveHeightRatio,
                            ),
                          ),
                        ),
                        AppSize.s20.sizedBoxWidth,

                        SizedBox(
                          width: AppReference.deviceWidth(context) * 0.4,
                          child: Column(
                            children: [
                              PasswordInputFiled(
                                passwordController: currentPasswordController,
                                passwordFocusNode: currentPasswordFocus,
                                nextFocusNode: newPasswordFocus,
                                label: AppStrings.oldPassword,
                              ),

                              PasswordInputFiled(
                                passwordController: newPasswordController,
                                passwordFocusNode: newPasswordFocus,
                                nextFocusNode: confirmPasswordFocus,
                                label: AppStrings.newPassword,
                              ),

                              PasswordInputFiled(
                                passwordController: confirmPasswordController,
                                passwordFocusNode: confirmPasswordFocus,
                                label: AppStrings.confirmNewPassword,
                              ),

                              CustomInkWell(
                                onTap: () {
                                  RouteManager.rPushNamed(
                                    context: context,
                                    rName: AppRoutesNames.rForgotPasswordScreen,
                                  );
                                },
                                child: Align(
                                  alignment: AlignmentDirectional.centerStart,
                                  child: Text(
                                    AppStrings.forgotPassword,
                                    style:
                                    const AppTextStyle().blue.w700.bodyMedium14.copyWith(
                                      decoration: TextDecoration.underline,
                                      decorationColor: AppColors.primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                              AppSize.s20.sizedBoxHeight,
                              DefaultButtonWidget(
                                label: AppStrings.save,
                                onPressed: () {
                                  if(!_formKey.currentState!.validate()) {
                                    return;
                                  }else{
                                    context.read<EditProfileBloc>().add(
                                      ChangePassword(
                                        oldPassword: currentPasswordController.text,
                                        newPassword: newPasswordController.text,
                                      ),
                                    );
                                  }

                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ).paddingBody(),
    );
  }
}