part of '../../collections.dart';

class ChildCollectionsScreen extends StatelessWidget {
  final DataToGoQuestions data;

  const ChildCollectionsScreen({super.key, required this.data});

  _backToLevelScreen(context){
    RouteManager.rPushNamedAndRemoveUntil(context: context, rName: AppRoutesNames.rChildLevelScreen,arguments: data);
  }



  @override
  Widget build(BuildContext context) {
    AppAnalytics.viewGroupScreenLogEvent();
    return BlocProvider(
      create: (context) => getIt<CollectionsBloc>()
        ..add(
          GetCollectionsEvent(
            parameters: ParameterGoToQuestions(
              subjectId: data.subjectId,
              stageId: data.stageId,
              classRoomId: data.classRoomId,
              termId: data.termId,
              levelId: data.levelId,
              systemId: data.systemId,
              pathId: data.pathId,
            ),
          ),
        ),
      child: PopScope(
        canPop: false,
        onPopInvoked: (value){
          _backToLevelScreen(context);
        },
        child: Scaffold(
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                HeaderForTermsAndLevelsAndGroup(
                  backTo: (){
                    _backToLevelScreen(context);
                  },
                ),
                AppSize.s26.sizedBoxHeight,
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        LevelNameWidgetInCollectionScreen(
                          currentLevel: data.levelName,
                          levelColor: data.levelColor,
                        ),
                        AppSize.s40.sizedBoxHeight,
                        Align(
                          alignment: AlignmentDirectional.topStart,
                          child: Text(
                            AppStrings.levelCollection,
                            textAlign: TextAlign.start,
                            style: AppTextStyle.titleLarge22,
                          ),
                        ),
                        AppSize.s40.sizedBoxHeight,
                        ChildCollectionBuilder(data: data),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ).paddingBody(),
        ),
      ),
    );
  }
}
