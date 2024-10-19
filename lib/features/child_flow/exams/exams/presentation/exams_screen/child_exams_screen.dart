part of '../../exams.dart';

class ChildExamsScreen extends StatelessWidget {
  final DataToGoExams dataToGoExams;

  const ChildExamsScreen({
    super.key,
    required this.dataToGoExams,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          dataToGoExams.isPrimary ? AppColors.textColor4 : AppColors.white,
      body: SafeArea(
        child: Container(
          height: AppReference.deviceHeight(context),
          decoration: BoxDecoration(
            image: dataToGoExams.isPrimary
                ? const DecorationImage(
                    image: AssetImage(AppImagesAssets.sPrimaryChildBackground),
                    fit: BoxFit.fill,
                  )
                : null,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const HeaderForTermsAndLevelsAndGroup(
                    title: AppStrings.examsTitle),
                _TitleWidget(isPrimary: dataToGoExams.isPrimary),
                if (dataToGoExams.subjects.isEmpty)
                  Center(
                      child: Text(
                    AppStrings.notSubscription,
                    style: AppTextStyle.titleLarge22,
                  )),
                if (dataToGoExams.subjects.isNotEmpty)
                  BlocBuilder<ExamsBloc, ExamsState>(
                    builder: (context, state) {
                      return switch (state.getExamsRequestState) {
                        RequestStates.loading => const _ExamLoadingView(),
                        RequestStates.loaded => Column(
                            children: [
                              _SubjectsWidget(
                                dataToGoExams: dataToGoExams,
                              ).animateFlipVertical(),
                              if (state.exams.isEmpty) 100.sizedBoxHeight,
                              if (state.exams.isEmpty)
                                const EmptyListWidgets(
                                    message: AppStrings.noExamsYet),
                              if (state.exams.isNotEmpty)
                                _ExamsWidget(
                                  isPrimary: dataToGoExams.isPrimary,
                                ).animateRightLeft(),
                            ],
                          ),
                        RequestStates.error => _ErrorView(
                            state: state, dataToGoExams: dataToGoExams),
                        _ => const SizedBox.shrink(),
                      };
                    },
                  ),
              ],
            ).paddingBody(),
          ),
        ),
      ),
    );
  }
}

class _ExamLoadingView extends StatelessWidget {
  const _ExamLoadingView();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        HomeHeaderLoading(),
        ContentShimmer(),
        TitleShimmer(),
        BannerShimmer(),
        TitleShimmer(),
        LoadingShimmerList(count: 3),
      ],
    );
  }
}

class _ErrorView extends StatelessWidget {
  final ExamsState state;
  final DataToGoExams dataToGoExams;

  const _ErrorView({
    required this.state,
    required this.dataToGoExams,
  });

  @override
  Widget build(BuildContext context) {
    if (state.getExamsErrorMessage == AppStrings.noInternetConnection) {
      return CustomErrorWidget(
        errorMessage: AppStrings.noInternetConnection,
        image: AppImagesAssets.sNoInternetConnection,
        onRefresh: () async {
          context.read<ExamsBloc>().add(
                GetExamsOfThatSubject(
                  subjectId: dataToGoExams.subjects[0].subjectId,
                  stageId: dataToGoExams.user.stageId!,
                  termId: dataToGoExams.user.termId!,
                  classroomId: dataToGoExams.user.classroomId!,
                  systemId: dataToGoExams.user.systemId!,
                  pathId: dataToGoExams.user.pathId,
                  selectedIndex: 0,
                ),
              );
        },
      );
    } else {
      return CustomErrorWidget(
        errorMessage: state.getExamsErrorMessage,
        onRefresh: () async {
          context.read<ExamsBloc>().add(
                GetExamsOfThatSubject(
                  subjectId: dataToGoExams.subjects[0].subjectId,
                  stageId: dataToGoExams.user.stageId!,
                  termId: dataToGoExams.user.termId!,
                  systemId: dataToGoExams.user.systemId!,
                  pathId: dataToGoExams.user.pathId,
                  classroomId: dataToGoExams.user.classroomId!,
                  selectedIndex: 0,
                ),
              );
        },
      );
    }
  }
}
