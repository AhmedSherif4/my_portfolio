class QuestionSharedFunction {
  const QuestionSharedFunction._internal();

  static const QuestionSharedFunction _instance =
      QuestionSharedFunction._internal();

  factory QuestionSharedFunction() => _instance;

  static bool checkIsFirstItem({
    required int index,
  }) {
    if (index == 0) {
      return true;
    } else {
      return false;
    }
  }

  static bool isCompleted({
    required int userQuestionPoints,
    required int skipQuestionPoints,
  }) {
    if (userQuestionPoints >= skipQuestionPoints) {
      return true;
    } else {
      return false;
    }
  }

  static bool checkIsLock({
    required int index,
    required int userQuestionPoints,
    required int skipQuestionPoints,
  }) {
    if (checkIsFirstItem(
      index: index,
    )) {
      return false;
    } else {
      return !isCompleted(
        userQuestionPoints: userQuestionPoints,
        skipQuestionPoints: skipQuestionPoints,
      );
    }
  }

  static bool checkIsFirstUnit({required int unitIndex}) {
    if (unitIndex == 0) {
      return true;
    } else {
      return false;
    }
  }

  static bool lockUnitsLessons({
    required int unitIndex,
    required int lessonIndex,
    required int userQuestionPoints,
    required int skipQuestionPoints,
  }) {
    if (checkIsFirstUnit(unitIndex: unitIndex)) {
      if (checkIsFirstItem(
        index: lessonIndex,
      )) {
        return false;
      } else {
        return !isCompleted(
          userQuestionPoints: userQuestionPoints,
          skipQuestionPoints: skipQuestionPoints,
        );
      }
    } else {
      return !isCompleted(
        userQuestionPoints: userQuestionPoints,
        skipQuestionPoints: skipQuestionPoints,
      );
    }
  }
}
