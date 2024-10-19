import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_portfolio/config/resources/app_text_style.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';
import 'package:my_portfolio/config/routes/route_manager.dart';
import 'package:my_portfolio/config/routes/routes_names.dart';
import 'package:my_portfolio/core/services/services_locator.dart';
import 'package:my_portfolio/core/shared_widget/text_back_button.dart';
import 'package:my_portfolio/features/institution_flow/add_parent_or_child/add_parent/domain/use_case/add_parent_use_case.dart';
import 'package:my_portfolio/features/institution_flow/add_parent_or_child/add_parent/view_model/add_parent_bloc.dart';
import '../../../../../config/resources/app_strings.dart';
import '../../../../../config/resources/app_values.dart';
import '../../../../../core/base_widgets/loading_widget.dart';
import '../../../../../core/base_widgets/snackbar_widget.dart';
import '../../../../../core/enum/enum_generation.dart';
import '../../../../../core/shared_models/user/data/user_local_data_source/user_local_data_source.dart';
import '../../../../../core/shared_widget/button_widget.dart';
import '../../../../../core/shared_widget/image_pick/image_pick_view_model/image_pick_bloc.dart';
import '../../../../../core/shared_widget/image_pick/pick_image_inkwell/pick_image_ink_well.dart';
import '../../../../../core/shared_widget/select_gender.dart';
import '../../../../../core/shared_widget/text_form_field.dart';
import '../../../../../core/validation/app_validation.dart';
import '../../../../auth/shared_screens/sign_up/sign_up.dart';

class InstitutionAddParentScreen extends StatefulWidget {
  const InstitutionAddParentScreen({super.key});

  @override
  State<InstitutionAddParentScreen> createState() =>
      _InstitutionAddParentScreenState();
}

class _InstitutionAddParentScreenState
    extends State<InstitutionAddParentScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailOrPhoneController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  late final FocusNode _nameFocusNode;
  late final FocusNode _emailFocusNode;
  late final FocusNode _passwordFocusNode;
  late final FocusNode _confirmPasswordFocusNode;
  late final FocusNode _phoneFocusNode;

  late final GlobalKey<FormState> _formKey;

  GenderType genderType = GenderType.male;
  SendType sendType = SendType.email;
  bool isValidImage = true;
  bool isObscureText = true;
  bool isObscureTextForConfirmPassword = true;
  File file = File('');
  String errorMessage = "";

  //ToDo: should Refactor this part of the code
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailOrPhoneController = TextEditingController();
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
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AddParentBloc, AddParentState>(listener: (context, state) {
          switch (state.addNewParentStates) {
            case RequestStates.loading:
              showLoadingDialog(context);
            case RequestStates.loaded:
              Navigator.pop(context);
              showSnackBar(
                description: state.addNewParentMessage,
                state: ToastStates.congrats,
                context: context,
              );
              RouteManager.rPushNamedAndRemoveUntil(
                  context: context,
                  rName: AppRoutesNames.rHomeLayoutView,
                  arguments: getIt<UserLocalDataSource>().getUserData()!);
            case RequestStates.error:
              Navigator.pop(context);
              showSnackBar(
                  description: state.addNewParentMessage,
                  state: ToastStates.error,
                  context: context);
            default:
          }
        }),
      ],
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();

          _nameFocusNode.requestFocus();
          _emailFocusNode.requestFocus();
          _passwordFocusNode.requestFocus();
          _confirmPasswordFocusNode.requestFocus();
          _phoneFocusNode.requestFocus();

        },
        child: Scaffold(
          body: SafeArea(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      const Spacer(),
                      Text(
                        AppStrings.addYourParents,
                        style: AppTextStyle.titleMedium20,
                      ),
                      const Spacer(),
                      const TextBackButton(),
                    ],
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          30.sizedBoxHeight,
                          StatefulBuilder(builder: (context, buildSetState) {
                            return Column(
                              children: [
                                  TextFormFieldWidget(
                                    topSizedBox: AppSize.s10,
                                    controller: _emailOrPhoneController,
                                    label: AppStrings.phone,
                                    keyboardType: TextInputType.number,
                                    validator: AppValidation.phoneNumberValidation(),
                                    onFieldSubmitted: (value) => FocusScope.of(context)
                                        .requestFocus(_nameFocusNode),
                                    focusNode: _phoneFocusNode,
                                    inputAction: TextInputAction.next,
                                  )
                              ],
                            );
                          }),
                          TextFormFieldWidget(
                            topSizedBox: AppSize.s10,
                            controller: _nameController,
                            label: AppStrings.name,
                            keyboardType: TextInputType.name,
                            validator: AppValidation.nameValidation(),
                            onFieldSubmitted: (value) =>
                                FocusScope.of(context).requestFocus(_passwordFocusNode),
                            focusNode: _nameFocusNode,
                            inputAction: TextInputAction.next,
                          ),
                          StatefulBuilder(builder: (context, setState) {
                            return TextFormFieldWidget(
                              topSizedBox: AppSize.s10,
                              controller: _passwordController,
                              label: AppStrings.password,
                              keyboardType: TextInputType.visiblePassword,
                              validator: AppValidation.passwordValidation(),
                              onFieldSubmitted: (value) => FocusScope.of(context)
                                  .requestFocus(_confirmPasswordFocusNode),
                              isObscureText: isObscureText,
                              focusNode: _passwordFocusNode,
                              inputAction: TextInputAction.next,
                              suffixIcon: isObscureText
                                  ? Icons.remove_red_eye_outlined
                                  : Icons.hide_source_outlined,
                              suffixIconOnPress: () {
                                setState(() {
                                  isObscureText = !isObscureText;
                                });
                              },
                            );
                          }),
                          StatefulBuilder(builder: (context, setState) {
                            return TextFormFieldWidget(
                              topSizedBox: AppSize.s10,
                              controller: _confirmPasswordController,
                              label: AppStrings.confirmPassword,
                              keyboardType: TextInputType.visiblePassword,
                              validator: AppValidation.passwordValidation(),
                              onFieldSubmitted: (value) =>
                                  FocusScope.of(context).unfocus(),
                              focusNode: _confirmPasswordFocusNode,
                              isObscureText: isObscureTextForConfirmPassword,
                              inputAction: TextInputAction.next,
                              bottomSizedBox: AppSize.s10,
                              suffixIcon: isObscureTextForConfirmPassword
                                  ? Icons.remove_red_eye_outlined
                                  : Icons.hide_source_outlined,
                              suffixIconOnPress: () {
                                setState(() {
                                  isObscureTextForConfirmPassword =
                                      !isObscureTextForConfirmPassword;
                                });
                              },
                            );
                          }),
                          AppSize.s10.sizedBoxHeight,
                          SelectGender(onGenderSelected: (value) {
                            genderType = value;
                          }),
                          AppSize.s10.sizedBoxHeight,
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
                          //const PickImageWidget(),
                          AppSize.s10.sizedBoxHeight,
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: AppPadding.p30.responsiveWidth),
                            child: DefaultButtonWidget(
                              label: AppStrings.addYourParents,
                              isExpanded: true,
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  if (_passwordController.text !=
                                      _confirmPasswordController.text) {
                                    showSnackBar(
                                      description:AppStrings.confirmPasswordNotCorrect,
                                      state: ToastStates.warning,
                                      context: context,
                                    );
                                  } else {
                                    BlocProvider.of<AddParentBloc>(context).add(
                                        AddNewParentEvent(
                                            addParentParameter: AddParentParameter(
                                                sendType: SendType.phone,
                                                password:
                                                    _passwordController.text.toString(),
                                                name: _nameController.text.toString(),
                                                emailOrPhone: _emailOrPhoneController
                                                    .text
                                                    .toString(),
                                                gendar: genderType.name,
                                                img: context
                                                    .read<ImagePickBloc>()
                                                    .imageFile ==
                                                    null
                                                    ? ''
                                                    : context
                                                    .read<ImagePickBloc>()
                                                    .imageFile!
                                                    .path)));
                                  }
                                } else if (!_formKey.currentState!.validate()) {
                                  showSnackBar(
                                    description: AppStrings.alarmForCompleteUserData,
                                    state: ToastStates.warning,
                                    context: context,
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ).paddingBody(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailOrPhoneController.dispose();
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
