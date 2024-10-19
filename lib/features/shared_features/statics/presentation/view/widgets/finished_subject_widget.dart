part of '../../../statics.dart';


class FinishedSubjectWidget extends StatelessWidget {
  final GetStaticsParam? staticsParam;

  const FinishedSubjectWidget({super.key, this.staticsParam});

  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
      onTap: AppReference.userIsGuest() ? (){
        AppReference.guestDialogMustLogin(context);
      }: () {
        if (staticsParam == null) {
          RouteManager.rPushNamed(
              context: context,
              rName: AppRoutesNames.rSubjectsViewFotStaticsScreen,
              arguments: GetStaticsParam(
                systemId: getIt<UserLocalDataSource>().getUserData()!.systemId!,
                stageId: getIt<UserLocalDataSource>()
                    .getUserData()!
                    .stageId!,
                termId:
                getIt<UserLocalDataSource>().getUserData()!.termId!,
                classRoomId: getIt<UserLocalDataSource>()
                    .getUserData()!
                    .classroomId!,
                pathId: getIt<UserLocalDataSource>().getUserData()!.pathId,
              ));
        } else {
          final update = staticsParam;
          RouteManager.rPushNamed(
            context: context,
            rName: AppRoutesNames.rSubjectsViewFotStaticsScreen,
            arguments: update,
          );
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.responsiveSize,vertical: 5.responsiveSize),
        decoration: AppConstants.containerDecoration(
          backgroundColor: AppColors.white
        ),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: SvgPicture.asset(
                AppIconsAssets.sIdea3,
                fit: BoxFit.contain,
                width: double.infinity,
              ),
            ),
            10.sizedBoxHeight,
            FittedBox(
              child: Text(
                AppStrings.subjects125,
                style: AppReference.themeData.textTheme.titleLarge!.copyWith(
                  fontSize:  14,
                ),
              ),
            ),
            Expanded(
              child: TextWithIconButton(
                onTap: AppReference.userIsGuest()?(){
                  AppReference.guestDialogMustLogin(context);
                } : () {
                  if (staticsParam == null) {
                    RouteManager.rPushNamed(
                        context: context,
                        rName: AppRoutesNames.rSubjectsViewFotStaticsScreen,
                        arguments: GetStaticsParam(
                          systemId: getIt<UserLocalDataSource>().getUserData()!.systemId!,
                          stageId: getIt<UserLocalDataSource>()
                              .getUserData()!
                              .stageId!,
                          termId:
                          getIt<UserLocalDataSource>().getUserData()!.termId!,
                          classRoomId: getIt<UserLocalDataSource>()
                              .getUserData()!
                              .classroomId!,
                          pathId: getIt<UserLocalDataSource>().getUserData()!.pathId,
                        ));
                  } else {
                    final update = staticsParam;
                    RouteManager.rPushNamed(
                      context: context,
                      rName: AppRoutesNames.rSubjectsViewFotStaticsScreen,
                      arguments: update,
                    );
                  }
                },
                text: AppStrings.more,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
