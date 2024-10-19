part of '../../simulated_plans.dart';

class SimulatedCategoriesScreen extends StatelessWidget {
  final int childId;
  const SimulatedCategoriesScreen({super.key, required this.childId,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(
              children: [
                const HeaderForMore(
                  title: AppStrings.simulatedTest,
                ).paddingBody(),
                BlocBuilder<SimulatedBloc, SimulatedState>(
  builder: (context, state) {
    switch(state.getSimulatedPlansState) {
      case RequestStates.loading:
        return const LoadingShimmerList();
      case RequestStates.loaded:
        return Expanded(
          child: OrientationItem(
            portraitWidget: ListView.builder(
                itemCount: state.simulatedPlans.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
              return _SimulatedCategoriesWidget(title: state.simulatedPlans[index].name,
                img: state.simulatedPlans[index].img??"",
                childId:childId ,
                simulatedPlansList: state.simulatedPlans[index].categories,
              ).paddingBody();
            }),
            landscapeWidget: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.simulatedPlans.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 40,
                childAspectRatio: 4/2.5,
              ),
              itemBuilder: (context, planIndex) {
                return _SimulatedCategoriesWidget(title: state.simulatedPlans[planIndex].name,
                  img: state.simulatedPlans[planIndex].img??"",
                  simulatedPlansList: state.simulatedPlans[planIndex].categories,
                  childId:childId ,
                ).paddingBody();
              },
            ),
          ),
        );

      case RequestStates.error:
        return CustomErrorWidget(errorMessage: state.getSimulatedPlansMessage);
      default:
        return const SizedBox.shrink();
    }

  },
)
              ],
            )),
      );
  }
}

class _SimulatedCategoriesWidget extends StatelessWidget {
  final String title;
  final String img;
  final int childId;
  final List<SimulatedPlansEntity> simulatedPlansList;
  const _SimulatedCategoriesWidget({
    super.key, required this.title, required this.img, required this.simulatedPlansList, required this.childId,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            NullableNetworkImage(
                imagePath: img ,
                height: AppReference.deviceHeight(context) * 0.03.responsiveHeightRatio,
                width: AppReference.deviceWidth(context) * 0.1,
                notHaveImage: img.isEmpty||img=="" ? true : false,
                fit: BoxFit.contain),
            AppSize.s10.sizedBoxWidth,
            Text(
              title,
              style: AppTextStyle.titleSmall18,
            ),
          ],
        ),
        AppSize.s20.sizedBoxHeight,
        ListView.builder(
            itemCount: simulatedPlansList.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return  CustomInkWell(
                  onTap: (){
                    RouteManager.rPushNamed(
                        context: context,
                        rName: AppRoutesNames.rSimulatedSubjectScreen,
                        arguments: SimulatedSubjectData(
                            playDuration: false,
                            simulatedPlans: simulatedPlansList[index],
                            index: index,
                            childId:childId)
                    );

                  },
                  child: NafeesSecondaryExamWidget(title: simulatedPlansList[index].name,).animateRightLeft());
            }),
      ],
    );
  }
}

class NafeesSecondaryExamWidget extends StatelessWidget {
  final String title;
  const NafeesSecondaryExamWidget({
    super.key, required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: AppPadding
            .p10.responsiveSize,),
      padding: EdgeInsets.all(AppPadding.p10.responsiveSize,),
      width: AppReference.deviceIsTablet ? AppReference.deviceWidth(context) * 0.4
          : AppReference.deviceWidth(context),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius:
        BorderRadius.circular(
            AppConstants
                .appBorderRadiusR20
                .responsiveSize),
      ),
      child: LayoutBuilder(builder:
          (context, constraints) {
        return Row(
          mainAxisAlignment:
          MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(width: constraints.maxWidth * 0.75,
              child: Text(
                title,
                style: AppReference
                    .themeData
                    .textTheme
                    .bodySmall!
                    .copyWith(
                  fontWeight:
                  FontWeight
                      .w700,
                  color: AppColors
                      .black,
                ),
              ),
            ),
            SizedBox(
              width: constraints
                  .maxWidth *
                  0.15,
              child: Icon(
                Icons
                    .arrow_forward_ios_rounded,
                color:
                AppColors.primaryColor,
                size: 20
                    .responsiveSize,
              ),
            ),
          ],
        );
      }),
    );
  }
}

