
part of'../../home.dart';

class AdviceItemBuilder extends StatelessWidget {
  final GlobalKey two;

  const AdviceItemBuilder({super.key, required this.two});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        switch (state.getPuzzleAndAdviceState) {
          case RequestStates.loading:
            return LoadingShimmerStructure(
              height: 20.responsiveHeight,
            );
          case RequestStates.loaded:
            return Showcase(
              key: two,
              tooltipPosition: TooltipPosition.bottom,
              tooltipPadding: EdgeInsets.all(AppPadding.p10.responsiveSize),
              description: AppStrings.adviceHint,
              disableDefaultTargetGestures: true,
              child: CustomInkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AdviceDialog(
                      message: state.puzzleAndAdviceEntity.advice,
                    ),
                  );
                },
                child: TextWithBackGroundColor(
                  text: state.puzzleAndAdviceEntity.advice,
                  fontSize:  AppFontSize.sp14,
                  textColor: AppColors.textColor,
                  maxLine: AppReference.deviceIsTablet ?1 : null,
                  backgroundColor: AppColors.white,
                ),
              ),
            );
          case RequestStates.error:
            return CustomErrorWidget(
                errorMessage: state.puzzleAndAdviceMessage);
          default:
            return const SizedBox();
        }
      },
    );
  }
}
