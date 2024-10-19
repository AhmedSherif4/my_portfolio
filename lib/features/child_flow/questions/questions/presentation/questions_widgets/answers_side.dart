part of '../../questions.dart';

class _AnswersSide extends StatelessWidget {
  final QuestionEntity currentQuestion;
  final bool isAdult;

  const _AnswersSide({
    required this.currentQuestion,
    this.isAdult = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnswerBuilder(
          currentQuestion: currentQuestion,
          isAdult: isAdult,
        ),
        AppSize.s10.sizedBoxHeight,
      ],
    );
  }
}

class AnswerBuilder extends StatelessWidget {
  final QuestionEntity currentQuestion;
  final bool isAdult;

  const AnswerBuilder(
      {super.key, required this.currentQuestion, required this.isAdult});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: SingleChildScrollView(
        child: BlocBuilder<QuestionsBloc, QuestionsState>(
          builder: (context, state) {
            List<Map<String, dynamic>> answersData = [
              {
                'text': currentQuestion.select1Text,
                'type': currentQuestion.select1Type,
                'file': currentQuestion.select1File,
                'number': 1,
              },
              {
                'text': currentQuestion.select2Text,
                'type': currentQuestion.select2Type,
                'file': currentQuestion.select2File,
                'number': 2,
              },
              {
                'text': currentQuestion.select3Text,
                'type': currentQuestion.select3Type,
                'file': currentQuestion.select3File,
                'number': 3,
              },
              {
                'text': currentQuestion.select4Text,
                'type': currentQuestion.select4Type,
                'file': currentQuestion.select4File,
                'number': 4,
              },
            ];

            return Column(
              children: answersData
                  .map(
                    (answer) => (answer['text'] != null ||
                            answer['type'] != null)
                        ? AnswerItemWidget(
                            answer: answer,
                            isAdult: isAdult,
                            correctAnswerColorWithShowHint: (answer['number'] == BlocProvider.of<QuestionsBloc>(context).correctSelect &&
                                    state.isHintShown)
                                ? AppColors.primaryColor2
                                : null,
                            selectedIndex: state.selectedAnswerIndex,
                            onTap: () {
                              context.read<QuestionsBloc>().add(
                                    SelectAnswer(
                                      answerIndex: answer['number'] as int,
                                      selectedIndex: answer['number'] as int,
                                    ),
                                  );
                            },
                          )
                        : const SizedBox.shrink(),
                  )
                  .toList(),
            );
          },
        ),
      ),
    );
  }
}

class AnswerBuilderForTeacher extends StatelessWidget {
  final QuestionEntity currentQuestion;
  final bool isAdult;

  const AnswerBuilderForTeacher(
      {super.key, required this.currentQuestion, required this.isAdult});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: SingleChildScrollView(
          child: BlocSelector<RandomExamsBloc, RandomExamsState,
              Map<String, String>>(selector: (state) {
        return state.selectedAnswers;
      }, builder: (context, selectedAnswersState) {
        List<Map<String, dynamic>> answersData = [
          {
            'text': currentQuestion.select1Text,
            'type': currentQuestion.select1Type,
            'file': currentQuestion.select1File,
            'number': 1,
          },
          {
            'text': currentQuestion.select2Text,
            'type': currentQuestion.select2Type,
            'file': currentQuestion.select2File,
            'number': 2,
          },
          {
            'text': currentQuestion.select3Text,
            'type': currentQuestion.select3Type,
            'file': currentQuestion.select3File,
            'number': 3,
          },
          {
            'text': currentQuestion.select4Text,
            'type': currentQuestion.select4Type,
            'file': currentQuestion.select4File,
            'number': 4,
          },
        ];
        return Column(
          children: answersData
              .map(
                (answer) => (answer['text'] != null || answer['type'] != null)
                    ? AnswerItemWidget2(
                        answer: answer,
                        isAdult: isAdult,
                        correctAnswerColorWithShowHint: null,
                        selectedIndex: context
                                .read<RandomExamsBloc>()
                                .state
                                .selectedAnswers
                                .keys
                                .contains(currentQuestion.id.toString()) &&
                            context
                                        .read<RandomExamsBloc>()
                                        .state
                                        .selectedAnswers[
                                    currentQuestion.id.toString()] ==
                                answer['number'].toString(),
                        // selectedIndex:context.read<RandomExamsBloc>().state.selectedAnswers[currentQuestion.id.toString()] == answer['number'].toString() ?
                        //   context.read<RandomExamsBloc>().state.selectedAnswer : 0,
                        onTap: () {
                          context.read<RandomExamsBloc>().add(
                                UpdateRandomExamsQuestionsAnswersEvent(
                                  questionId: currentQuestion.id.toString(),
                                  childAnswer: answer['number'].toString(),
                                  selectedAnswer: answer['number'] as int,
                                ),
                              );
                        },
                      )
                    : const SizedBox.shrink(),
              )
              .toList(),
        );
      })),
    );
  }
}

class AnswerBuilderForSkills extends StatelessWidget {
  final QuestionEntity currentQuestion;
  final bool isAdult;

  const AnswerBuilderForSkills(
      {super.key, required this.currentQuestion, required this.isAdult});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: SingleChildScrollView(
        child: BlocBuilder<SkillStaticsBloc, SkillStaticsState>(
          builder: (context, state) {
            List<Map<String, dynamic>> answersData = [
              {
                'text': currentQuestion.select1Text,
                'type': currentQuestion.select1Type,
                'file': currentQuestion.select1File,
                'number': 1,
              },
              {
                'text': currentQuestion.select2Text,
                'type': currentQuestion.select2Type,
                'file': currentQuestion.select2File,
                'number': 2,
              },
              {
                'text': currentQuestion.select3Text,
                'type': currentQuestion.select3Type,
                'file': currentQuestion.select3File,
                'number': 3,
              },
              {
                'text': currentQuestion.select4Text,
                'type': currentQuestion.select4Type,
                'file': currentQuestion.select4File,
                'number': 4,
              },
            ];

            return Column(
              children: answersData
                  .map(
                    (answer) => (answer['text'] != null ||
                            answer['type'] != null)
                        ? AnswerItemWidget(
                            answer: answer,
                            isAdult: isAdult,
                            correctAnswerColorWithShowHint: (answer['number'] ==
                                        BlocProvider.of<SkillStaticsBloc>(
                                                context)
                                            .correctSelect &&
                                    BlocProvider.of<SkillStaticsBloc>(context)
                                        .state
                                        .isHintShown)
                                ? AppColors.primaryColor2
                                : null,
                            selectedIndex: state.selectedAnswerIndex,
                            onTap: () {
                              context.read<SkillStaticsBloc>().add(
                                    SelectAnswerForSkills(
                                      answerIndex: answer['number'] as int,
                                      selectedIndex: answer['number'] as int,
                                    ),
                                  );
                            },
                          )
                        : const SizedBox.shrink(),
                  )
                  .toList(),
            );
          },
        ),
      ),
    );
  }
}

class AnswerBuilderForNafees extends StatelessWidget {
  final NafeesQuestionEntity currentQuestion;
  final bool isAdult;

  const AnswerBuilderForNafees(
      {super.key, required this.currentQuestion, required this.isAdult});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: SingleChildScrollView(
          child: BlocSelector<NafeesBloc, NafeesState,
              Map<String, String>>(selector: (state) {
            return state.selectedAnswers;
          }, builder: (context, selectedAnswersState) {
            return Column(
              children: currentQuestion.answers.isNotEmpty
                    ? List.generate(currentQuestion.answers.length, (index) {
                      return AnswerItemForNafeesWidget(
                        answer: currentQuestion.answers[index],
                        isAdult: isAdult,
                        correctAnswerColorWithShowHint: null,
                        selectedIndex: context
                            .read<NafeesBloc>()
                            .state
                            .selectedAnswers
                            .keys
                            .contains(currentQuestion.id.toString()) &&
                            context
                                .read<NafeesBloc>()
                                .state
                                .selectedAnswers[
                            currentQuestion.id.toString()] ==
                                currentQuestion.answers[index].id.toString(),
                        // selectedIndex:context.read<RandomExamsBloc>().state.selectedAnswers[currentQuestion.id.toString()] == answer['number'].toString() ?
                        //   context.read<RandomExamsBloc>().state.selectedAnswer : 0,
                        onTap: () {
                          context.read<NafeesBloc>().add(
                            UpdateNafeesExamsQuestionsAnswersEvent(
                              questionId: currentQuestion.id.toString(),
                              childAnswer: currentQuestion.answers[index].id.toString(),
                              selectedAnswer: currentQuestion.answers[index].id,
                            ),
                          );
                        },
                      );
                    })
                    : [],
            );
          })),
    );
  }
}
class AnswerBuilderForSimulated extends StatelessWidget {
  final SimulatedQuestionEntity currentQuestion;
  final bool isAdult;

  const AnswerBuilderForSimulated(
      {super.key, required this.currentQuestion, required this.isAdult});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: SingleChildScrollView(
          child: BlocSelector<SimulatedBloc, SimulatedState,
              Map<String, String>>(selector: (state) {
            return state.selectedAnswers;
          }, builder: (context, selectedAnswersState) {
            return Column(
              children: currentQuestion.answers.isNotEmpty
                    ? List.generate(currentQuestion.answers.length, (index) {
                      return AnswerItemForSimulatedWidget(
                        answer: currentQuestion.answers[index],
                        isAdult: isAdult,
                        correctAnswerColorWithShowHint: null,
                        selectedIndex: context
                            .read<SimulatedBloc>()
                            .state
                            .selectedAnswers
                            .keys
                            .contains(currentQuestion.id.toString()) &&
                            context
                                .read<SimulatedBloc>()
                                .state
                                .selectedAnswers[
                            currentQuestion.id.toString()] ==
                                currentQuestion.answers[index].id.toString(),
                        // selectedIndex:context.read<RandomExamsBloc>().state.selectedAnswers[currentQuestion.id.toString()] == answer['number'].toString() ?
                        //   context.read<RandomExamsBloc>().state.selectedAnswer : 0,
                        onTap: () {
                          context.read<SimulatedBloc>().add(
                            UpdateSimulatedExamsQuestionsAnswersEvent(
                              questionId: currentQuestion.id.toString(),
                              childAnswer: currentQuestion.answers[index].id.toString(),
                              selectedAnswer: currentQuestion.answers[index].id,
                            ),
                          );
                        },
                      );
                    })
                    : [],
            );
          })),
    );
  }
}
