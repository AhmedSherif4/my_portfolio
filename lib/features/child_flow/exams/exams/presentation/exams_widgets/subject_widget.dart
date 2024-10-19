part of '../../exams.dart';

class _SubjectsWidget extends StatelessWidget {
  const  _SubjectsWidget({
    required this.dataToGoExams,
  });

  final DataToGoExams dataToGoExams;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppReference.isPortrait(context) ?  AppReference.deviceHeight(context) * 0.13 :  AppReference.deviceHeight(context) * 0.25,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: dataToGoExams.subjects.length,
        itemBuilder: (context, index) {
          return _SingleSubjectWidget(
            dataToGoExams: dataToGoExams,
            index: index,
          );
        },
      ),
    );
  }
}

class _SingleSubjectWidget extends StatelessWidget {
  const _SingleSubjectWidget({
    required this.dataToGoExams,
    required this.index,
  });

  final DataToGoExams dataToGoExams;
  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExamsBloc, ExamsState>(
      builder: (context, state) {
        final bool isSelected = state.selectedSubject == index;
        return CustomInkWell(
          onTap: () {
            if (!isSelected) {
              context.read<ExamsBloc>().add(
                    GetExamsOfThatSubject(
                      systemId: dataToGoExams.user.systemId!,
                      pathId: dataToGoExams.user.pathId,
                      classroomId: dataToGoExams.user.classroomId!,
                      subjectId: dataToGoExams.subjects[index].subjectId,
                      stageId: dataToGoExams.user.stageId!,
                      termId: dataToGoExams.user.termId!,
                      selectedIndex: index,
                    ),
                  );
            }
          },
          child: Container(
            width: AppReference.deviceWidth(context) * 0.27,
            margin: EdgeInsets.only(right: AppPadding.p10.responsiveWidth),
            padding: EdgeInsets.all(AppPadding.p8.responsiveSize),
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border.all(
                color: (isSelected && dataToGoExams.isPrimary)
                    ? AppColors.primaryColor
                    : (isSelected && !dataToGoExams.isPrimary)
                        ? AppColors.primaryColor2
                        : (!isSelected && dataToGoExams.isPrimary)
                            ? AppColors.primaryColor2
                            : AppColors.primaryColor,
                width: 2.responsiveSize,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(index % 2 == 0
                    ? 0
                    : AppConstants.appBorderRadiusR20.responsiveSize),
                topRight: Radius.circular(
                    AppConstants.appBorderRadiusR20.responsiveSize),
                bottomLeft: Radius.circular(
                    AppConstants.appBorderRadiusR20.responsiveSize),
                bottomRight: Radius.circular(index % 2 != 0
                    ? 0
                    : AppConstants.appBorderRadiusR20.responsiveSize),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                NullableNetworkImage(
                  imagePath:
                      (dataToGoExams.subjects[index].subjectImg.isEmpty ||
                              dataToGoExams.subjects[index].subjectImg == '')
                          ? AppImagesAssets.sBook
                          : dataToGoExams.subjects[index].subjectImg,
                  width: 50.responsiveWidth,
                  height: 50.responsiveHeight,
                  fit: BoxFit.contain,
                  notHaveImage:
                      dataToGoExams.subjects[index].subjectImg.isEmpty,
                ),
                Flexible(
                  child: Text(
                    dataToGoExams.subjects[index].subjectName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style:
                        const AppTextStyle().bodySmall12.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}


class SubjectsWidget extends StatelessWidget {
  const SubjectsWidget({super.key,
    required this.dataToGoExams,
  });

  final DataToGoExams dataToGoExams;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppReference.deviceHeight(context) * 0.13.responsiveHeightRatio,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: dataToGoExams.subjects.length,
        itemBuilder: (context, index) {
          return SingleSubjectWidget(
            dataToGoExams: dataToGoExams,
            index: index,
          );
        },
      ),
    );
  }
}

class SingleSubjectWidget extends StatelessWidget {
  const SingleSubjectWidget({super.key,
    required this.dataToGoExams,
    required this.index,
  });

  final DataToGoExams dataToGoExams;
  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SharedSubjectsBloc, SharedSubjectsState>(
  builder: (context, state) {
    final bool isSelected = state.selectedSubject == index;
    return CustomInkWell(
      onTap: () {
        if (!isSelected) {
          context.read<SharedSubjectsBloc>()
              .add(GetIdOfThatSubject(
              subjectId: dataToGoExams.subjects[index].subjectId,
              selectedIndex: index
          ));
          context.read<RandomExamsBloc>().add(
            GetAllRandomExamsOfThatSubject(
              allRandomExamInputs:
              AllRandomExamInputs(
                subjectId:dataToGoExams.subjects[index].subjectId,
               childId: dataToGoExams.user.userId,
              ),
              selectedIndex: index
            )
          );
        }
      },
      child: Container(
        width: AppReference.deviceWidth(context) * 0.3,
        margin: EdgeInsets.only(right: AppPadding.p10.responsiveWidth),
        padding: EdgeInsets.all(AppPadding.p8.responsiveSize),
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(
            color: (isSelected && dataToGoExams.isPrimary)
                ? AppColors.primaryColor
                : (isSelected && !dataToGoExams.isPrimary)
                ? AppColors.primaryColor2
                : (!isSelected && dataToGoExams.isPrimary)
                ? AppColors.primaryColor2
                : AppColors.primaryColor,
            width: 2.responsiveSize,
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(index % 2 == 0
                ? 0
                : AppConstants.appBorderRadiusR20.responsiveSize),
            topRight: Radius.circular(
                AppConstants.appBorderRadiusR20.responsiveSize),
            bottomLeft: Radius.circular(
                AppConstants.appBorderRadiusR20.responsiveSize),
            bottomRight: Radius.circular(index % 2 != 0
                ? 0
                : AppConstants.appBorderRadiusR20.responsiveSize),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            NullableNetworkImage(
              imagePath:
              (dataToGoExams.subjects[index].subjectImg.isEmpty ||
                  dataToGoExams.subjects[index].subjectImg == '')
                  ? AppImagesAssets.sBook
                  : dataToGoExams.subjects[index].subjectImg,
              width: 50.responsiveWidth,
              height: 50.responsiveHeight,
              fit: BoxFit.contain,
              notHaveImage:
              dataToGoExams.subjects[index].subjectImg.isEmpty,
            ),
            Flexible(
              child: Text(
                dataToGoExams.subjects[index].subjectName,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style:
                const AppTextStyle().bodySmall12.copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  },
);
  }
}
