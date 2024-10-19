part of'../../../home.dart';


class ChildSubjectsBuilder extends StatefulWidget {
  const ChildSubjectsBuilder({super.key, required this.userData});
  final UserEntity userData;

  @override
  State<ChildSubjectsBuilder> createState() => _ChildSubjectsBuilderState();
}

class _ChildSubjectsBuilderState extends State<ChildSubjectsBuilder> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SharedSubjectsBloc, SharedSubjectsState>(
      builder: (context, state) {
        switch (state.getSubjectsState) {
          case RequestStates.loading:
            return const LoadingShimmerList();
          case RequestStates.loaded:
            if (state.subjects.isEmpty) {
              return const EmptyListWidgets(message: AppStrings.noSubjectsNow);
            } else {
              return AppReference.deviceIsTablet
                  ? OrientationItem(
                      portraitWidget: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return BaseListTile(
                            title: state.subjects[index].subjectName,
                            imageBoxFit: BoxFit.contain,
                            onTap: () {
                              context.read<HomeBloc>().goToLessonScreen(
                                    isPrimary: false,
                                    context: context,
                                    subject: state.subjects[index],
                                    user: widget.userData,
                                  );
                            },
                            backgroundColor:
                                state.subjects[index].itemColor.isEmpty
                                    ? AppConstants.primaryColorHexCode
                                    : state.subjects[index].itemColor,
                            isHaveDescription: false,
                            titleStyle: const AppTextStyle().bodyLarge16,
                            notHaveImage:
                                state.subjects[index].subjectImg.isEmpty,
                            imagePath: state.subjects[index].subjectImg,
                          );
                        },
                        separatorBuilder: (context, index) => SizedBox(
                          height: AppSize.s10.responsiveHeight,
                        ),
                        itemCount: state.subjects.length,
                      ),
                      landscapeWidget: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: AppSize.s10.responsiveHeight,
                          crossAxisSpacing: AppSize.s10.responsiveWidth,
                          childAspectRatio: 12 / 2,
                        ),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return BaseListTile(
                            title: state.subjects[index].subjectName,
                            imageBoxFit: BoxFit.contain,
                            onTap: () {
                              context.read<HomeBloc>().goToLessonScreen(
                                    isPrimary: false,
                                    context: context,
                                    subject: state.subjects[index],
                                    user: widget.userData,
                                  );
                            },
                            backgroundColor:
                                state.subjects[index].itemColor.isEmpty
                                    ? AppConstants.primaryColorHexCode
                                    : state.subjects[index].itemColor,
                            isHaveDescription: false,
                            titleStyle: const AppTextStyle().bodyLarge16,
                            notHaveImage:
                                state.subjects[index].subjectImg.isEmpty,
                            imagePath: state.subjects[index].subjectImg,
                          );
                        },
                        itemCount: state.subjects.length,
                      ))
                  : ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return BaseListTile(
                          title: state.subjects[index].subjectName,
                          imageBoxFit: BoxFit.contain,
                          onTap: () {
                            context.read<HomeBloc>().goToLessonScreen(
                                  isPrimary: false,
                                  context: context,
                                  subject: state.subjects[index],
                                  user: widget.userData,
                                );
                          },
                          backgroundColor:
                              state.subjects[index].itemColor.isEmpty
                                  ? AppConstants.primaryColorHexCode
                                  : state.subjects[index].itemColor,
                          isHaveDescription: false,
                          titleStyle: const AppTextStyle().bodyLarge16,
                          notHaveImage:
                              state.subjects[index].subjectImg.isEmpty,
                          imagePath: state.subjects[index].subjectImg,
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(
                        height: AppSize.s10.responsiveHeight,
                      ),
                      itemCount: state.subjects.length,
                    );
            }
          case RequestStates.error:
            return CustomErrorWidget(
                errorMessage: state.getSubjectsStateMessage);
          default:
            return const SizedBox();
        }
      },
    );
  }
}
