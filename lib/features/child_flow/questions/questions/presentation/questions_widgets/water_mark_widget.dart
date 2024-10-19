part of '../../questions.dart';

class WaterMarkWidget extends StatelessWidget {
  const WaterMarkWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: AppReference.currentOrientation(context) == Orientation.portrait
          ? 45
          : 0,
      child: Text(
        context.read<QuestionsBloc>().userName,
        style: AppReference.themeData.textTheme.displayLarge!.copyWith(
          color: Colors.black.withOpacity(0.05),
          fontSize: AppFontSize.sp50.responsiveFontSize,
        ),
      ),
    );
  }
}
