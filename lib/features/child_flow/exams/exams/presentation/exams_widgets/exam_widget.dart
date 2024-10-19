part of '../../exams.dart';

class _ExamsWidget extends StatelessWidget {
  final bool isPrimary;

  const _ExamsWidget({
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExamsBloc, ExamsState>(
      builder: (context, state) {
        return AppReference.deviceIsTablet && !AppReference.isPortrait(context)
            ? GridView.builder(
                gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 0, crossAxisCount: 3,
                    childAspectRatio: AppReference.deviceWidth(context) * 0.8 /(AppReference.deviceHeight(context) * 0.5 ),
                    mainAxisSpacing: 0),
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: state.exams.length,
                itemBuilder: (context, index) {
                  return Hero(
                    tag: state.exams[index].id,
                    child: _SingleExamWidget(
                        name: state.exams[index].name,
                        dataToGoUploadScreen: DataToGoUploadExam(
                          examEntity: state.exams[index],
                          index: index,
                          isPrimary: isPrimary,
                        )),
                  );
                },
              )
            : ListView.builder(
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: state.exams.length,
                itemBuilder: (context, index) {
                  return Hero(
                    tag: state.exams[index].id,
                    child: _SingleExamWidget(
                        name: state.exams[index].name,
                        dataToGoUploadScreen: DataToGoUploadExam(
                          examEntity: state.exams[index],
                          index: index,
                          isPrimary: isPrimary,
                        )),
                  );
                },
              );
      },
    );
  }
}

class _SingleExamWidget extends StatelessWidget {
  final String name;
  final DataToGoUploadExam dataToGoUploadScreen;

  const _SingleExamWidget({
    required this.name,
    required this.dataToGoUploadScreen,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          RouteManager.rPushNamed(
            context: context,
            rName: AppRoutesNames.rChildDownloadUploadScreen,
            arguments: dataToGoUploadScreen,
          ).then((value) {
            if (context.mounted){
              context.read<ExamsBloc>().add(
                  GetExamsOfThatSubject(
                    subjectId: dataToGoUploadScreen.examEntity.subjectId,
                    stageId: dataToGoUploadScreen.examEntity.stageId,
                    termId: dataToGoUploadScreen.examEntity.termId,
                    classroomId: dataToGoUploadScreen.examEntity.classroomId,
                    selectedIndex: dataToGoUploadScreen.index,
                    systemId: dataToGoUploadScreen.examEntity.systemId,
                    pathId: dataToGoUploadScreen.examEntity.pathId,
                  ),
                );}
          });
        },
        child: Container(
            padding: dataToGoUploadScreen.isPrimary
                ? EdgeInsets.symmetric(
                    vertical: AppPadding.p6.responsiveHeight,
                    horizontal: AppPadding.p10.responsiveWidth,
                  )
                : EdgeInsets.symmetric(
                    vertical: AppPadding.p20.responsiveHeight,
                    horizontal: AppPadding.p30.responsiveWidth,
                  ),
            margin: EdgeInsets.all(
             AppPadding.p10.responsiveSize,
            ),
            width: AppReference.deviceWidth(context) * 0.7,
            decoration: dataToGoUploadScreen.isPrimary
                ? ShapeDecoration(
                    color: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 3.responsiveWidth,

                        color: AppColors.primary2,
                      ),
                      borderRadius: BorderRadius.circular(
                          AppReference.deviceIsTablet ? AppConstants.appBorderRadiusR15.responsiveSize:AppConstants.appBorderRadiusR25.responsiveSize),
                    ),
                  )
                : BoxDecoration(
                    color: AppColors.textColor6,
                    borderRadius: BorderRadius.circular(
                        AppConstants.appBorderRadiusR20.responsiveSize),

                  ),
            child: dataToGoUploadScreen.isPrimary
                ? LayoutBuilder(builder: (context, constraints) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (dataToGoUploadScreen.examEntity.result.isMark ==
                            "yes")
                          Padding(
                            padding: EdgeInsets.only(
                                left: AppPadding.p10.responsiveWidth),
                            child: Icon(
                              Icons.check_circle_outline_rounded,
                              size: 16.responsiveSize,
                              color: AppColors.successColor,
                            ),
                          ),
                        SizedBox(
                          width: constraints.maxWidth * 0.55,
                          child: Text(
                            name,
                            style: AppReference.deviceIsTablet ?

                            AppReference.themeData.textTheme.bodySmall!
                                .copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.white,
                            ):AppReference.themeData.textTheme.bodyLarge!
                                .copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: constraints.maxWidth * 0.15,
                          child: Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: AppColors.white,
                            size: 16.responsiveSize,
                          ),
                        ),
                      ],
                    );
                  })
                : Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      if (dataToGoUploadScreen.examEntity.result.isMark ==
                          "yes")
                        Padding(
                          padding: EdgeInsets.only(
                              left: AppPadding.p10.responsiveWidth),
                          child: Icon(
                            Icons.check_circle_outline_rounded,
                            size: 16.responsiveSize,
                            color: AppColors.successColor,
                          ),
                        ),
                      Expanded(
                        child: Text(
                          name,
                          style: AppTextStyle.titleSmall18,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 16.responsiveSize,
                        color: AppColors.textColor2,
                      ),
                    ],
                  )));
  }
}
// class _SingleExamWidgetOld extends StatelessWidget {
//   final String name;
//   final DataToGoUploadExam dataToGoUploadScreen;
//
//   const _SingleExamWidget({
//     required this.name,
//     required this.dataToGoUploadScreen,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         RouteManager.rPushNamed(
//           context: context,
//           rName: AppRoutesNames.rChildDownloadUploadScreen,
//           arguments: dataToGoUploadScreen,
//         ).then((value) {
//           context.read<ExamsBloc>().add(
//                 GetExamsOfThatSubject(
//                   subjectId: dataToGoUploadScreen.examEntity.subjectId,
//                   stageId: dataToGoUploadScreen.examEntity.stageId,
//                   termId: dataToGoUploadScreen.examEntity.termId,
//                   classroomId: dataToGoUploadScreen.examEntity.classroomId,
//                   selectedIndex: dataToGoUploadScreen.index,
//                   systemId: dataToGoUploadScreen.examEntity.systemId,
//                   pathId: dataToGoUploadScreen.examEntity.pathId,
//                 ),
//               );
//         });
//       },
//       child: Container(
//         padding: EdgeInsets.symmetric(
//           vertical: AppPadding.p20.responsiveHeight,
//           horizontal: AppPadding.p30.responsiveWidth,
//         ),
//         margin: EdgeInsets.all(
//           AppPadding.p16.responsiveSize,
//         ),
//         width: AppReference.deviceWidth(context) * 0.7,
//         decoration: BoxDecoration(
//           gradient: dataToGoUploadScreen.isPrimary
//               ? AppGradientColors.blueGradient
//               : null,
//           color: !dataToGoUploadScreen.isPrimary ? AppColors.white : null,
//           borderRadius: BorderRadius.circular(
//               AppConstants.appBorderRadiusR20.responsiveSize),
//           boxShadow: [
//             AppShadow.filledBoxShadow(),
//           ],
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: <Widget>[
//             if (dataToGoUploadScreen.examEntity.result.isMark == "yes")
//               Padding(
//                 padding: EdgeInsets.only(left: AppPadding.p10.responsiveWidth),
//                 child: Icon(
//                   Icons.check_circle_outline_rounded,
//                   size: ResponsiveManager.calculateSize(16, 12),
//                   color: AppColors.green,
//                 ),
//               ),
//             Text(
//               name,
//               style: AppReference.themeData.textTheme.bodyLarge!.copyWith(
//                   color:
//                       dataToGoUploadScreen.isPrimary ? AppColors.white : null),
//             ),
//             const Spacer(),
//             Icon(
//               Icons.arrow_forward_ios_rounded,
//               size: ResponsiveManager.calculateSize(16, 12),
//               color: dataToGoUploadScreen.isPrimary
//                   ? AppColors.white
//                   : AppColors.gray07,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
