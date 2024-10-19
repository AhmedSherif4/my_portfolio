part of'../../../random_exams.dart';


class AddNewRandomExamFloatingButton extends StatelessWidget {
  final DataToGoExams dataToGoExams;
  const AddNewRandomExamFloatingButton(
      {super.key, required this.dataToGoExams});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => AddNewRandomExamDialog(
            dataToGoExams: dataToGoExams,
          ),
        );
      },
      backgroundColor: AppColors.primaryColor2,
      child: const Icon(
        Icons.add,
        color: AppColors.white,
      ),
    );
  }
}
