part of'../../../home.dart';


class PrimaryChildSubjectsBuilder extends StatelessWidget {
  const PrimaryChildSubjectsBuilder({super.key,});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SharedSubjectsBloc, SharedSubjectsState>(
      builder: (context, state) {
        switch (state.getSubjectsState) {
          case RequestStates.loading:
            return const PrimaryChildSubjectsLoading();
          case RequestStates.loaded:
            if (state.subjects.isEmpty) {
              return const EmptyListWidgets(message: AppStrings.noSubjectsNow);
            } else {
              return ResponsiveWidgetForTablet(
                mobile: OrientationItem(
                  portraitWidget: GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    childAspectRatio: AppReference.deviceWidth(context) /
                        (AppReference.deviceHeight(context) * 0.4),
                    crossAxisSpacing: 20.responsiveWidth,
                    mainAxisSpacing: 20.responsiveHeight,
                    children: List.generate(
                      state.subjects.length,
                      (index) {
                        return SubjectItem(
                          subject: state.subjects[index],
                          onTap: () {
                            context.read<HomeBloc>().goToLessonScreen(
                                  isPrimary: true,
                                  context: context,
                                  subject: state.subjects[index],
                                  user: getIt<UserLocalDataSource>().getUserData()!,
                                );
                          },
                        ).animateRightLeft(
                            isFromStart: index % 2 == 0 ? true : false,
                            duration: AppConstants.animationTime);
                      },
                    ),
                  ),
                  landscapeWidget: GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 3,
                    childAspectRatio: AppReference.deviceWidth(context) /
                        (AppReference.deviceHeight(context)),
                    crossAxisSpacing: 10.responsiveWidth,
                    mainAxisSpacing: 15.responsiveHeight,
                    children: List.generate(
                      state.subjects.length,
                      (index) {
                        return SubjectItem(
                          subject: state.subjects[index],
                          onTap: () {
                            context.read<HomeBloc>().goToLessonScreen(
                                  isPrimary: true,
                                  context: context,
                                  subject: state.subjects[index],
                                  user: getIt<UserLocalDataSource>().getUserData()!,
                                );
                          },
                        ).animateSlideTopToNormal(
                            duration: AppConstants.animationTime);
                      },
                    ),
                  ),
                ),
                tablet: OrientationItem(
                  portraitWidget:  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    childAspectRatio: AppReference.deviceWidth(context) /
                        (AppReference.deviceHeight(context) * 0.5),
                    crossAxisSpacing: 10.responsiveWidth,
                    mainAxisSpacing: 15.responsiveHeight,
                    children: List.generate(
                      state.subjects.length,
                          (index) {
                        return SubjectItem(
                          subject: state.subjects[index],
                          onTap: () {
                            context.read<HomeBloc>().goToLessonScreen(
                              isPrimary: true,
                              context: context,
                              subject: state.subjects[index],
                              user: getIt<UserLocalDataSource>().getUserData()!
                            );
                          },
                        ).animateRightLeft(
                            isFromStart: index % 2 == 0 ? true : false,
                            duration: AppConstants.animationTime);
                      },
                    ),
                  ),
                  landscapeWidget: SizedBox(
                    height: AppReference.deviceHeight(context) * 0.22,
                    child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, index) =>
                        AppSize.s10.sizedBoxWidth,
                        itemCount: state.subjects.length,
                        itemBuilder: (context, index) {
                          return SubjectItem(
                            subject: state.subjects[index],
                            onTap: () {
                              context.read<HomeBloc>().goToLessonScreen(
                                isPrimary: true,
                                context: context,
                                subject: state.subjects[index],
                                user: getIt<UserLocalDataSource>().getUserData()!,
                              );
                            },
                          );
                          // .animateSlideTopToNormal(
                          // duration: AppConstants.animationTime);
                        }
                    ),
                  ),
                ),
              );
            }
          case RequestStates.error:
            return CustomErrorWidget(errorMessage: state.getSubjectsStateMessage);
          default:
            return const SizedBox();
        }
      },
    );
  }
}

class SubjectItem extends StatelessWidget {
  final SubjectsEntity subject;
  final Function() onTap;

  const SubjectItem({
    super.key,
    required this.subject,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SubjectItemForPrimaryChild(
      itemColor: HexColor.fromHex(
        subject.itemColor.isEmpty
            ? AppConstants.primaryColorHexCode
            : subject.itemColor,
      ),
      onTap: onTap,
      notHaveImage: subject.subjectImg.isEmpty,
      imagePath: subject.subjectImg,
      subjectName: subject.subjectName,
    );
  }
}
