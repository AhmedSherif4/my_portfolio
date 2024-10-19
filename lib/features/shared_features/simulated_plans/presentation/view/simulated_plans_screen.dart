part of '../../simulated_plans.dart';


class SimulatedPlanScreen extends StatelessWidget {
  final SimulatedSubjectData simulatedSubjectData;
  const SimulatedPlanScreen({super.key, required this.simulatedSubjectData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const NafeesHeaderForAllChild(
              title: '',
            ).paddingBody(),
            Container(
              width: AppReference.deviceWidth(context),
              height: AppReference.deviceHeight(context) * 0.12.responsiveHeightRatio,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: AlignmentDirectional.topStart,
                  end: AlignmentDirectional.bottomCenter,
                  colors: [
                    Color(0xFFFFBE77),
                    Color(0xFFFFE5CA),
                  ], // Replace with your desired colors
                ),
              ),
              child: LayoutBuilder(builder: (context, constrains) {
                return Row(
                  children: [
                    SizedBox(
                      width: constrains.maxWidth * 0.22,
                      child: SvgPicture.asset(
                        AppImagesAssets.sNafes,
                      ),
                    ),
                    SizedBox(
                      width: constrains.maxWidth * 0.02,
                    ),
                    SizedBox(
                      width: constrains.maxWidth * 0.66,
                      child: Text(
                        'اختبارات نافس المحاكية',
                        style: const AppTextStyle()
                            .s14
                            .w600
                            .titleMedium20
                            .copyWith(
                          color: const Color(0xff58340D),
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
            AppSize.s30.sizedBoxHeight,
            Expanded(
              child: simulatedSubjectData.simulatedPlansList!.isNotEmpty?
       OrientationItem(
      portraitWidget: _SimulatedPlanPortraitView(simulatedPlansEntity: simulatedSubjectData.simulatedPlansList!,onTap: (planIndex){
      _goToSimulatedScreen(context,simulatedSubjectData.simulatedPlansList![planIndex],planIndex);
      },),
      landscapeWidget: _SimulatedPlanLandscapeView(simulatedPlansEntity: simulatedSubjectData.simulatedPlansList!,onTap: (planIndex){
      _goToSimulatedScreen(context,simulatedSubjectData.simulatedPlansList![planIndex],planIndex);
      },)
      ):  const EmptyListWidgets(
      message: 'لا يوجد اختبارات محاكية').paddingBody(),
            ),
          ],
        ),
      ),
    );
  }
  _goToSimulatedScreen(BuildContext context,SimulatedPlansEntity simulatedPlansEntity,int index) {
    RouteManager.rPushNamed(
        context: context,
        rName: AppRoutesNames.rSimulatedSubjectScreen,
        arguments: SimulatedSubjectData(
            playDuration: false,
            simulatedPlans: simulatedPlansEntity,
            index: index,
            childId: simulatedSubjectData.childId)
    );
  }
}


class _SimulatedPlanPortraitView extends StatelessWidget {
  const _SimulatedPlanPortraitView({
    required this.simulatedPlansEntity, required this.onTap,
  });

  final List<SimulatedPlansEntity> simulatedPlansEntity;
  final Function(int planIndex) onTap;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, planIndex) {
        return CustomInkWell(
          onTap: () {
            onTap(planIndex);
          },
          child:  SimulatedPlanWidget(simulatedPlansEntity:simulatedPlansEntity[planIndex]),);
      },
      separatorBuilder: (context, index) {
        return 10.sizedBoxHeight;
      },
      itemCount:simulatedPlansEntity.length,
    );
  }
}

class _SimulatedPlanLandscapeView extends StatelessWidget {
  const _SimulatedPlanLandscapeView({
    super.key,
    required this.simulatedPlansEntity, required this.onTap,
  });

  final List<SimulatedPlansEntity> simulatedPlansEntity;
  final Function(int planIndex) onTap;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: simulatedPlansEntity.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 30,
        crossAxisSpacing: 40,
        childAspectRatio: 8/2.5,
      ),
      itemBuilder: (context, planIndex) {
        return CustomInkWell(
          onTap: () {
            onTap(planIndex);
          },
          child: SimulatedPlanWidget(
            simulatedPlansEntity: simulatedPlansEntity[planIndex],
          ),);
      },
    );
  }
}

class SimulatedPlanWidget extends StatelessWidget {
  final SimulatedPlansEntity simulatedPlansEntity;
  const SimulatedPlanWidget({
    super.key, required this.simulatedPlansEntity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppReference.deviceWidth(context),
      padding: EdgeInsets.all(10.responsiveSize),
      decoration: AppConstants.containerDecoration(
          backgroundColor: const Color(0xFFFAFAFA)),
      child: LayoutBuilder(
        builder: (context, constrains) {
          {
            return Row(
              mainAxisAlignment:
              MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: constrains.maxWidth * 0.3,
                  child:  NullableNetworkImage(
                    imagePath: simulatedPlansEntity.img,
                    notHaveImage: simulatedPlansEntity.img == null,
                    width: 60,
                    height: 60,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(
                  width: constrains.maxWidth * 0.02,
                ),
                SizedBox(
                    width:
                    constrains.maxWidth * 0.46,
                    child: Text(
                      simulatedPlansEntity.name,
                      style:
                      const AppTextStyle()
                          .s16
                          .w600
                          .titleSmall18,
                    )),
                SizedBox(
                  width: constrains.maxWidth * 0.02,
                ),
                SizedBox(
                    width:
                    constrains.maxWidth * 0.2,
                    child: Text(
                      'اكتشف ←',
                      style:
                      const AppTextStyle()
                          .blue
                          .bodySmall12,
                    ))
              ],
            );
          }
        },
      ),
    );
  }
}
