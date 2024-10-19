part of '../../nafees_plans.dart';


class NafeesPlanScreen extends StatelessWidget {
  final int childId;
  const NafeesPlanScreen({super.key, required this.childId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<NafeesBloc>()..add(GetNafeesPlansEvent(childId: childId)),
      child: Scaffold(
        body: SafeArea(
          child: Container(
            height: AppReference.deviceHeight(context),
            width: AppReference.deviceWidth(context),
            decoration:  BoxDecoration(
                image: AppReference.childIsPrimary()?const DecorationImage(
                  image:  AssetImage(AppImagesAssets.sPrimaryChildBackground),
                  fit: BoxFit.fill,
                ):null),
            child: PlansScreen(childId: childId),
          ),
        ),
      ),
    );
  }
}

class PlansScreen extends StatelessWidget {
  const PlansScreen({
    super.key,
    required this.childId,
  });

  final int childId;

  @override
  Widget build(BuildContext context) {
    return Column(
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
          child: BlocBuilder<NafeesBloc, NafeesState>(
            builder: (context, state) {
              switch (state.getNafeesPlansState) {
                case RequestStates.loading:
                  return const LoadingShimmerList(height: 100);
                case RequestStates.loaded:
                  if (state.nafeesPlans.isNotEmpty) {
                    return OrientationItem(
                        portraitWidget: _NafeesPlanPortraitView(nafeesPlansEntity: state.nafeesPlans,onTap: (planIndex){
                          _goToNafeesScreen(context,state.nafeesPlans[planIndex],planIndex);
                        },),
                        landscapeWidget: _NafeesPlanLandscapeView(nafeesPlansEntity: state.nafeesPlans,onTap: (planIndex){
                          _goToNafeesScreen(context,state.nafeesPlans[planIndex],planIndex);
                        },)
                    );
                  } else {
                    return const EmptyListWidgets(
                        message: 'No Nafees Plans');
                  }
                case RequestStates.error:
                  return CustomErrorWidget(
                      errorMessage: state.getNafeesPlansMessage);
                default:
                  return Container();
              }
            },
          ).paddingBody(),
        ),
      ],
    );
  }
  _goToNafeesScreen(BuildContext context,NafeesPlansEntity nafeesPlansEntity,int index) {
    RouteManager.rPushNamed(
      context: context,
      rName: AppRoutesNames.rNafeesSubjectScreen,
     arguments: NafeesSubjectData(
         playDuration: false,
         nafeesPlans: nafeesPlansEntity,
         index: index,
         childId: childId)
    );
  }
}

class _NafeesPlanPortraitView extends StatelessWidget {
  const _NafeesPlanPortraitView({
    required this.nafeesPlansEntity, required this.onTap,
  });

  final List<NafeesPlansEntity> nafeesPlansEntity;
  final Function(int planIndex) onTap;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, planIndex) {
        return CustomInkWell(
          onTap: () {
            onTap(planIndex);
          },
          child:  NafeesPlanWidget(nafeesPlansEntity:nafeesPlansEntity[planIndex]),);
      },
      separatorBuilder: (context, index) {
        return 10.sizedBoxHeight;
      },
      itemCount:nafeesPlansEntity.length,
    );
  }
}

class _NafeesPlanLandscapeView extends StatelessWidget {
  const _NafeesPlanLandscapeView({
    super.key,
    required this.nafeesPlansEntity, required this.onTap,
  });

  final List<NafeesPlansEntity> nafeesPlansEntity;
  final Function(int planIndex) onTap;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: nafeesPlansEntity.length,
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
          child: NafeesPlanWidget(
            nafeesPlansEntity: nafeesPlansEntity[planIndex],
          ),);
      },
    );
  }
}

class NafeesPlanWidget extends StatelessWidget {
  final NafeesPlansEntity nafeesPlansEntity;
  const NafeesPlanWidget({
    super.key, required this.nafeesPlansEntity,
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
                    imagePath: nafeesPlansEntity.img,
                    notHaveImage: nafeesPlansEntity.img == null,
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
                      nafeesPlansEntity.name,
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
