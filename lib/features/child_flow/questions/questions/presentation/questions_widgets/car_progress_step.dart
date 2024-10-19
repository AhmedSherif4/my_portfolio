part of '../../questions.dart';

class CarProgressStep extends StatelessWidget {
  final double progressStep;

  const CarProgressStep({
    super.key,
    required this.progressStep,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppReference.deviceHeight(context) * 0.15.responsiveHeightRatio,
      child: LayoutBuilder(
        builder: (context, constraints) => CustomPaint(
          painter: RoadQuestionsPainter(),
          child: Container(
            alignment: Alignment(((progressStep * 2) - 1), -1),
            child: SvgPicture.asset(
              AppImagesAssets.sCarQuestions,
              height: constraints.maxHeight * 0.8,
            ),
          ),
        ),
      ),
    );
  }
}
