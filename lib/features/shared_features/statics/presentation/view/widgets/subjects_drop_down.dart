part of '../../../statics.dart';



class StudyingDropDownForStaticsScreen extends StatefulWidget {
  final GetStaticsParam? lessonParameters;
  final Function(SubjectsEntity?) currentSubject;

  const StudyingDropDownForStaticsScreen(
      {super.key, this.lessonParameters, required this.currentSubject});

  @override
  State<StudyingDropDownForStaticsScreen> createState() =>
      _StudyingDropDownForLessonsinStaticsScreenState();
}

class _StudyingDropDownForLessonsinStaticsScreenState
    extends State<StudyingDropDownForStaticsScreen> {
  late SubjectsEntity item;

  @override
  void initState() {
    super.initState();
    _checkRoute();
  }

  void _checkRoute() {
    if (widget.lessonParameters != null) {
      item = widget.lessonParameters!.allSubjects.first;
      widget.currentSubject(
        widget.lessonParameters!.allSubjects.first,
      );
    } else {
      if (context.read<SharedSubjectsBloc>().state.subjects.isNotEmpty) {
        item = context.read<SharedSubjectsBloc>().state.subjects.first;

        widget.currentSubject(item);
        if (AppReference.userIsChild()) {
          context.read<StaticsBloc>().add(GetLessonsStaticsEvent(
                lessonsStaticsParam: GetStaticsParam(
                  systemId:
                      getIt<UserLocalDataSource>().getUserData()!.systemId!,
                  stageId: getIt<UserLocalDataSource>().getUserData()!.stageId!,
                  termId: getIt<UserLocalDataSource>().getUserData()!.termId!,
                  classRoomId:
                      getIt<UserLocalDataSource>().getUserData()!.classroomId!,
                  pathId: getIt<UserLocalDataSource>().getUserData()!.pathId,
                ).copyWith(
                  subjectId: item.subjectId,
                ),
              ));
        }
      }
    }
  }

  List<SubjectsEntity> _list() {
    if (widget.lessonParameters != null) {
      return widget.lessonParameters!.allSubjects;
    } else {
      if (context.read<SharedSubjectsBloc>().state.getSubjectsState ==
          RequestStates.loaded) {
        return context.read<SharedSubjectsBloc>().state.subjects;
      } else {
        return [];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.lessonParameters == null
        ? (context.read<SharedSubjectsBloc>().state.subjects.isEmpty &&
                AppReference.userIsChild())
            ? const SizedBox.shrink()
            : DefaultDropDownButton<SubjectsEntity>(
                studyingData: _list(),
                selectedItem: item,
                onChange: (selectedSubject) {
                  setState(() {
                    item = selectedSubject!;
                    widget.currentSubject(selectedSubject);
                  });
                  if (widget.lessonParameters != null) {
                    final updateWithID = widget.lessonParameters!
                        .copyWith(subjectId: item.subjectId);
                    context.read<StaticsBloc>().add(GetLessonsStaticsEvent(
                          lessonsStaticsParam: updateWithID,
                        ));
                  } else {
                    context.read<StaticsBloc>().add(
                          GetLessonsStaticsEvent(
                            lessonsStaticsParam: GetStaticsParam(
                              systemId: getIt<UserLocalDataSource>()
                                  .getUserData()!
                                  .systemId!,
                              stageId: getIt<UserLocalDataSource>()
                                  .getUserData()!
                                  .stageId!,
                              termId: getIt<UserLocalDataSource>()
                                  .getUserData()!
                                  .termId!,
                              classRoomId: getIt<UserLocalDataSource>()
                                  .getUserData()!
                                  .classroomId!,
                              pathId: getIt<UserLocalDataSource>()
                                  .getUserData()!
                                  .pathId,
                              subjectId: item.subjectId,
                            ),
                          ),
                        );
                  }
                },
                displayText: (subject) => subject.subjectName,
              )
        : DefaultDropDownButton<SubjectsEntity>(
            studyingData: _list(),
            selectedItem: item,
            onChange: (selectedSubject) {
              setState(() {
                item = selectedSubject!;
                widget.currentSubject(selectedSubject);
              });
              if (widget.lessonParameters != null) {
                final updateWithID = widget.lessonParameters!
                    .copyWith(subjectId: item.subjectId);
                context.read<StaticsBloc>().add(GetLessonsStaticsEvent(
                      lessonsStaticsParam: updateWithID,
                    ));
              } else {
                context.read<StaticsBloc>().add(
                      GetLessonsStaticsEvent(
                        lessonsStaticsParam: GetStaticsParam(
                          systemId: getIt<UserLocalDataSource>()
                              .getUserData()!
                              .systemId!,
                          stageId: getIt<UserLocalDataSource>()
                              .getUserData()!
                              .stageId!,
                          termId: getIt<UserLocalDataSource>()
                              .getUserData()!
                              .termId!,
                          classRoomId: getIt<UserLocalDataSource>()
                              .getUserData()!
                              .classroomId!,
                          pathId: getIt<UserLocalDataSource>()
                              .getUserData()!
                              .pathId,
                          subjectId: item.subjectId,
                        ),
                      ),
                    );
              }
            },
            displayText: (subject) => subject.subjectName,
          );
  }
}
