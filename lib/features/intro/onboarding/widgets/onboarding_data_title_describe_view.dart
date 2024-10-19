part of '../on_boarding.dart';

class TitleWidget extends StatelessWidget {
  final int pageCount;

  const TitleWidget({super.key, required this.pageCount});

  @override
  Widget build(BuildContext context) {
    return Text(
      onBoardingPagesData[pageCount]['title'],
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
      style:const AppTextStyle().balooBhaijaan2.s22.w500.titleSmall18,
    );
  }
}

class DescriptionWidget extends StatelessWidget {
  final int pageCount;

  const DescriptionWidget({
    super.key,
    required this.pageCount,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      onBoardingPagesData[pageCount]['description'],
      style:const AppTextStyle().balooBhaijaan2.w500.bodyMedium14,
      textAlign: TextAlign.justify,
    );
  }
}
