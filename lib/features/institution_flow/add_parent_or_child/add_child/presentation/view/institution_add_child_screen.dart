part of '../../add_child.dart';


class InstitutionAddChildScreen extends StatefulWidget {
  final int parentId;

  const InstitutionAddChildScreen({super.key, required this.parentId});

  @override
  State<InstitutionAddChildScreen> createState() =>
      _InstitutionAddChildScreenState();
}

class _InstitutionAddChildScreenState extends State<InstitutionAddChildScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: MultiBlocListener(
          listeners: [
            BlocListener<InstitutionAddChildBloc, InstitutionAddChildState>(
                listener: (context, state) {
              switch (state.institutionAddNewChildStates) {
                case RequestStates.loading:
                  showLoadingDialog(context);
                case RequestStates.loaded:
                  Navigator.pop(context);
                  Navigator.pop(context);
                  getIt.get<ParentHomeBloc>().add(GetAllChildForParentEvent(parentId: widget.parentId));

                  showSnackBar(
                      description: state.institutionAddNewChildMessage,
                      state: ToastStates.congrats,
                      context: context,);
                case RequestStates.error:
                  Navigator.pop(context);
                  showSnackBar(
                      description: state.institutionAddNewChildMessage,
                      state: ToastStates.error,
                      context: context);
                default:
              }
            }),
          ],
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
              _nameFocusNode.unfocus();
              _emailFocusNode.unfocus();
              _passwordFocusNode.unfocus();
              _confirmPasswordFocusNode.unfocus();
              _phoneFocusNode.unfocus();
            },
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      const Spacer(),
                      Text(
                        AppStrings.addYourChilds,
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
                          PhoneInputFiled(
                              label: AppStrings.phone,
                              phoneController: _phoneController,
                              phoneFocusNode: _phoneFocusNode,
                              nextFocusNode: _emailFocusNode),
                          AppSize.s10.sizedBoxHeight,
                          EmailInputFiled(
                            emailController: _emailController,
                            emailFocusNode: _emailFocusNode,
                            nextFocusNode: _nameFocusNode,
                            isLoginScreen: true,

                          ),
                          AppSize.s10.sizedBoxHeight,                          NameInputFiled(
                              nameController: _nameController,
                              nameFocusNode: _nameFocusNode,
                              nextFocusNode: _passwordFocusNode),
                          PasswordInputFiled(
                            passwordController: _passwordController,
                            passwordFocusNode: _passwordFocusNode,
                            nextFocusNode: _confirmPasswordFocusNode,
                          ),
                          ConfirmPasswordInputFiled(
                              confirmPasswordController: _confirmPasswordController,
                              confirmPasswordFocusNode: _confirmPasswordFocusNode),
                          AppSize.s10.sizedBoxHeight,
                          SelectGender(onGenderSelected: (value) {
                            setState(() {
                              genderType = value;
                            });
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
                          BlocBuilder<GradeChoosingBloc, GradeChoosingState>(
                              builder: (context, state) {
                                switch (state.getSystemState) {
                                  case RequestStates.loading:
                                    return LoadingShimmerStructure(
                                      height: 40.responsiveHeight,
                                    );
                                  case RequestStates.loaded:
                                    return DefaultDropDownButton<StudyingModel>(
                                      studyingData: state.systems,
                                      selectedItem: state.currentSystem,
                                      displayText: (system) => system.name,
                                      onChange: (value) {
                                        state.currentSystem == value
                                            ? null
                                            : context
                                            .read<GradeChoosingBloc>()
                                            .add(ChangeSystemEvent(value!));
                                        // selectedStage = value as StudyingModel;
                                      },
                                    );
                                  default:
                                    return const SizedBox();
                                }
                              }),
                          20.0.sizedBoxHeight,
                          BlocBuilder<GradeChoosingBloc, GradeChoosingState>(
                              builder: (context, state) {
                                switch (state.getStagesState) {
                                  case RequestStates.loading:
                                    return LoadingShimmerStructure(
                                      height: 40.responsiveHeight,
                                    );
                                  case RequestStates.loaded:
                                    return DefaultDropDownButton<StudyingModel>(
                                      studyingData: state.stages,
                                      selectedItem: state.currentStage,
                                      displayText: (stages) => stages.name,
                                      onChange: (value) {
                                        state.currentStage == value
                                            ? null
                                            : context
                                            .read<GradeChoosingBloc>()
                                            .add(ChangeStageEvent(value!));
                                        // selectedStage = value as StudyingModel;
                                      },
                                    );
                                  default:
                                    return const SizedBox();
                                }
                              }),
                          20.0.sizedBoxHeight,
                          BlocBuilder<GradeChoosingBloc, GradeChoosingState>(
                              builder: (context, state) {
                                switch (state.getClassRoomsState) {
                                  case RequestStates.loading:
                                    return LoadingShimmerStructure(
                                      height: 40.responsiveHeight,
                                    );
                                  case RequestStates.loaded:
                                    return DefaultDropDownButton<StudyingModel>(
                                      studyingData: state.classRooms,
                                      selectedItem: state.currentClassRoom,
                                      displayText: (classroom) => classroom.name,
                                      onChange: (value) {
                                        state.currentClassRoom == value
                                            ? null
                                            : context
                                            .read<GradeChoosingBloc>()
                                            .add(ChangeClassRoomEvent(value!));
                                        // selectedStage = value as StudyingModel;
                                      },
                                    );
                                  default:
                                    return const SizedBox();
                                }
                              }),
                          20.0.sizedBoxHeight,
                          BlocBuilder<GradeChoosingBloc, GradeChoosingState>(
                              builder: (context, state) {
                                switch (state.getTermsState) {
                                  case RequestStates.loading:
                                    return LoadingShimmerStructure(
                                      height: 40.responsiveHeight,
                                    );
                                  case RequestStates.loaded:
                                    return DefaultDropDownButton<StudyingModel>(
                                      studyingData: state.terms,
                                      selectedItem: state.currentTerm,
                                      displayText: (term) => term.name,
                                      onChange: (value) {
                                        context
                                            .read<GradeChoosingBloc>()
                                            .add(ChangeTermEvent(value!));
                                        // selectedStage = value as StudyingModel;
                                      },
                                    );
                                  default:
                                    return const SizedBox();
                                }
                              }),
                          20.0.sizedBoxHeight,
                          BlocBuilder<GradeChoosingBloc, GradeChoosingState>(
                              builder: (context, state) {
                                switch (state.getPathsState) {
                                  case RequestStates.loading:
                                    return LoadingShimmerStructure(
                                      height: 40.responsiveHeight,
                                    );
                                  case RequestStates.loaded:
                                    return state.paths.isEmpty ? const SizedBox.shrink() : DefaultDropDownButton<StudyingModel>(
                                      studyingData: state.paths,
                                      selectedItem: state.currentPath,
                                      displayText: (path) => path.name,
                                      onChange: (value) {
                                        context
                                            .read<GradeChoosingBloc>()
                                            .add(ChangePathEvent(value!));
                                        // selectedStage = value as StudyingModel;
                                      },
                                    );
                                  default:
                                    return const SizedBox();
                                }
                              }),
                          AppSize.s20.sizedBoxHeight,
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: AppPadding.p30.responsiveWidth),
                            child: DefaultButtonWidget(
                              label: AppStrings.addChildNow,
                              isExpanded: true,
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  if (_passwordController.text !=
                                      _confirmPasswordController.text) {
                                    showSnackBar(
                                      description: AppStrings.confirmPasswordNotCorrect,
                                      state: ToastStates.warning,
                                      context: context,
                                    );
                                  } else {
                                    context.read<InstitutionAddChildBloc>().add(
                                          InstitutionAddNewChildEvent(
                                              addChildParameter:
                                                  InstitutionAddChildParameter(
                                                    systemId: context.read<GradeChoosingBloc>().state.currentSystem.id,
                                                      pathId: context.read<GradeChoosingBloc>().state.currentPath.id,
                                                      parentId: widget.parentId,
                                                      stageId: context.read<GradeChoosingBloc>().state.currentStage.id,
                                                      classroomId: context.read<GradeChoosingBloc>().state.currentClassRoom.id,
                                                      termId: context.read<GradeChoosingBloc>().state.currentTerm.id,
                                                      sendType: SendType.phone,
                                                      phone: _phoneController.text,
                                                      password: _passwordController.text.toString(),
                                                      name: _nameController.text.toString(),
                                                      emailOrPhone: _emailController.text.toString(),
                                                      gendar: genderType.name,
                                                      img: context.read<ImagePickBloc>().imageFile ==
                                                          null
                                                          ? ''
                                                          : context
                                                          .read<ImagePickBloc>()
                                                          .imageFile!
                                                          .path)),
                                        );
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
          ),
        ),
      ).paddingBody(),
    );
  }
}
