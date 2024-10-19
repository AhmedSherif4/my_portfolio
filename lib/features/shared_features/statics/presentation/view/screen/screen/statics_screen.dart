part of '../../../../statics.dart';


class StaticsScreen extends StatelessWidget {
  final GetStaticsParam getStaticsParam;

  const StaticsScreen({super.key, required this.getStaticsParam});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime yesterday = DateTime.now().subtract(const Duration(days:1));
    return BlocProvider(
      create: (context) => getIt<StaticsBloc>()
        ..add(GetTimeInAppEvent(timeInAppInputs:
            TimeInAppInputs(startDate: yesterday, endDate: now, childId: getStaticsParam.childId??getIt<UserLocalDataSource>().getUserData()!.userId)))
        ..add(GetLessonsStaticsEvent(lessonsStaticsParam: getStaticsParam))
        ..add(GetBestSubjectsEvent(bestSubjectsParm: getStaticsParam)),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const TextBackButton(),
              Expanded(child: ChildStaticsScreen(getStaticsParam: getStaticsParam)),
            ],
          ),
        ).paddingBody(),
      ),
    );
  }
}
