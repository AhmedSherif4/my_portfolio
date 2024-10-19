part of '../../../edit_profile.dart';

class EditProfileScreen extends StatefulWidget {
  final DataToGoToEditProfileScreen data;

  const EditProfileScreen({
    super.key,
    required this.data,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late final TextEditingController controller;
  late GenderType genderType;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.data.oldData);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocListener<EditProfileBloc, EditProfileState>(
            listener: (context, state) {
              switch (state.editStates) {
                case RequestStates.loading:
                  showLoadingDialog(context);
                case RequestStates.loaded:
                  Navigator.of(context).pop();
                  showSnackBar(
                      description: state.editMessage,
                      state: ToastStates.congrats,
                      context: context);
                  Navigator.popUntil(context, (route) => route.isFirst);
                case RequestStates.error:
                  Navigator.of(context).pop();
                  showSnackBar(
                      description: state.editMessage,
                      state: ToastStates.error,
                      context: context);
                default:
              }
            },
            child: Column(
              children: [
                const HeaderForMore(
                  title: AppStrings.edit,
                ).paddingBody(),
                ResponsiveWidgetForTablet(
                  mobile: Column(
                    children: [
                      const _EditProfileScreenBanner(
                        height: AppSize.s50,
                      ),
                      AppSize.s50.sizedBoxHeight,
                      if (widget.data.title == AppStrings.gender)
                        SelectGender(
                          onGenderSelected: (value) {
                            genderType = value;
                          },
                        ),
                      if (widget.data.title != AppStrings.gender)
                        _EditCustomTextFormField(
                            controller: controller, widget: widget),
                      AppSize.s50.sizedBoxHeight,
                      DefaultButtonWidget(
                        label: AppStrings.save,
                        onPressed: () {
                          _saveEditProfile();
                        },
                      ),
                    ],
                  ),
                  tablet: OrientationItem(
                    portraitWidget: Column(
                      children: [
                        const _EditProfileScreenBanner(
                          height: AppSize.s50,
                        ),
                        AppSize.s50.sizedBoxHeight,
                        if (widget.data.title == AppStrings.gender)
                          SelectGender(
                            onGenderSelected: (value) {
                              genderType = value;
                            },
                          ),
                        if (widget.data.title != AppStrings.gender)
                          _EditCustomTextFormField(
                              controller: controller, widget: widget),
                        AppSize.s50.sizedBoxHeight,
                        DefaultButtonWidget(
                            label: AppStrings.save,
                            onPressed: () {
                              _saveEditProfile();
                            }),
                      ],
                    ),
                    landscapeWidget: Row(
                      children: [
                        const _EditProfileScreenBanner(
                          height: 120,
                        ),
                        AppSize.s50.sizedBoxWidth,
                        SizedBox(
                          width: AppReference.deviceWidth(context) * 0.4,
                          child: Column(
                            children: [
                              if (widget.data.title == AppStrings.gender)
                                SelectGender(
                                  onGenderSelected: (value) {
                                    genderType = value;
                                  },
                                ),
                              if (widget.data.title != AppStrings.gender)
                                _EditCustomTextFormField(
                                    controller: controller, widget: widget),
                              AppSize.s50.sizedBoxHeight,
                              DefaultButtonWidget(
                                  label: AppStrings.save,
                                  onPressed: () {
                                    _saveEditProfile();
                                  }),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ).paddingBody(),
    );
  }

  void _saveEditProfile() {
    switch (widget.data.title) {
      case AppStrings.gender:
        context.read<EditProfileBloc>().add(
              EditProfile(
                gender: genderType.name,
              ),
            );
        break;
      case AppStrings.name:
        context.read<EditProfileBloc>().add(
              EditProfile(
                name: controller.text,
              ),
            );
      case AppStrings.email:
        context.read<EditProfileBloc>().add(
              EditProfile(
                email: controller.text,
              ),
            );
      case AppStrings.phone:
        context.read<EditProfileBloc>().add(
              EditProfile(
                phone: controller.text,
              ),
            );
      default:
    }
  }
}

class _EditProfileScreenBanner extends StatelessWidget {
  final double height;
  const _EditProfileScreenBanner({required this.height});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: SvgPicture.asset(
        AppIconsAssets.pEditProfileScreenLogo,
        height: height.responsiveHeight,
        width: height.responsiveWidth,
      ),
    ).paddingBody(start: 50);
  }
}

class _EditCustomTextFormField extends StatelessWidget {
  const _EditCustomTextFormField({
    required this.controller,
    required this.widget,
  });

  final TextEditingController controller;
  final EditProfileScreen widget;

  @override
  Widget build(BuildContext context) {
    return TextFormFieldWidget(
      controller: controller,
      keyboardType: TextInputType.text,
      inputAction: TextInputAction.done,
      label: widget.data.title,
      onFieldSubmitted: (_) {},
      validator: switch (widget.data.title) {
        AppStrings.email => AppValidation.emailValidation(),
        AppStrings.phone => AppValidation.phoneValidation(),
        AppStrings.name => AppValidation.nameValidation(),
        _ => null,
      },
    );
  }
}
