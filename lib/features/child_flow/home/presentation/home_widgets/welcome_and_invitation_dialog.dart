
part of'../../home.dart';

class WelcomeToTasesseDialog extends StatefulWidget {
  const WelcomeToTasesseDialog({super.key});
  @override
  State<WelcomeToTasesseDialog> createState() => _WelcomeToTasesseDialogState();
}

class _WelcomeToTasesseDialogState extends State<WelcomeToTasesseDialog> {
  late TextEditingController emailController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
  }

  @override
  dispose() {
    emailController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      contentPadding: EdgeInsets.zero,
      elevation: 5,
      actionsPadding: EdgeInsets.zero,
      buttonPadding: EdgeInsets.zero,
      iconPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      shape: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(
            AppConstants.appBorderRadiusR20.responsiveSize,
          )),
      content: BlocProvider(
        create: (context) => getIt<InvitationBloc>(),
        child: Container(
          width: AppReference.deviceIsTablet
              ? AppReference.deviceWidth(context) * 0.4
              : null,
          padding: EdgeInsets.all(AppPadding.p20.responsiveSize),
          decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius:
              BorderRadius.circular(AppConstants.appBorderRadiusR10)),
          child: BlocConsumer<InvitationBloc, InvitationState>(
            listener: (context, state) {
              switch (state.invitationState) {
                case RequestStates.loaded:
                  Navigator.pop(context);
                  Navigator.pop(context);
                  showSnackBar(
                      description: state.invitationMessage,
                      state: ToastStates.congrats,
                      context: context);
                  break;
                case RequestStates.error:
                  Navigator.pop(context);
                  Navigator.pop(context);
                  showSnackBar(
                      description: state.invitationMessage,
                      state: ToastStates.error,
                      context: context);
                  break;
                case RequestStates.loading:
                  showLoadingDialog(context);
                  break;
                default:
              }
            },
            builder: (context, state) {
              return Builder(builder: (context) {
                return Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: CustomInkWell(
                          onTap: () {
                            Navigator.pop(context);
                            context.read<GlobalBloc>().fromRegister = false;
                          },
                          child: SvgPicture.asset(
                            AppIconsAssets.sDeleteNotification,
                          ),
                        ),
                      ),
                      AppSize.s20.sizedBoxHeight,
                      Text("أهلا بك في تطبيق تأسيس !",
                          style: const AppTextStyle()
                              .balooBhaijaan2
                              .w500
                              .titleLarge22),
                      AppSize.s20.sizedBoxHeight,
                      SvgPicture.asset(AppIconsAssets.sGarland),
                      AppSize.s20.sizedBoxHeight,
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor.withOpacity(.1),
                          borderRadius: BorderRadius.circular(
                              AppConstants.appBorderRadiusR20.responsiveSize),
                        ),
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                      AppIconsAssets.sFriendDialog),
                                  AppSize.s10.sizedBoxWidth,
                                  Text(
                                    "عن طريق صديق",
                                    style: const AppTextStyle()
                                        .bodySmall12
                                        .copyWith(
                                        color: AppColors.primaryColor),
                                  ),
                                ],
                              ),
                              AppSize.s10.sizedBoxHeight,
                              Text(
                                "كود صديقك",
                                style: const AppTextStyle()
                                    .bodySmall12
                                    .copyWith(color: AppColors.primaryColor),
                              ),
                              TextFormFieldWidget(
                                  controller: emailController,
                                  keyboardType: TextInputType.text,
                                  inputAction: TextInputAction.done,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'من فضلك ادخل كود الدعوة';
                                    }
                                    return null;
                                  },
                                  onFieldSubmitted: (v) {}),
                            ],
                          ).paddingBody(),
                        ),
                      ),
                      AppSize.s20.sizedBoxHeight,
                      DefaultButtonWidget(
                          textVerticalPadding: 2,
                          isExpanded: true,
                          label: "ارسال",
                          onPressed: () {
                            context.read<GlobalBloc>().fromRegister = false;
                            if (formKey.currentState!.validate()) {
                              context.read<InvitationBloc>().add(
                                  GetInvitationEvent(emailController.text));
                            }
                          }),
                    ]);
              });
            },
          ),
        ),
      ),
    );
  }
}