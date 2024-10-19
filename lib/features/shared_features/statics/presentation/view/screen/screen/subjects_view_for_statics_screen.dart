part of '../../../../statics.dart';


class SubjectsViewFotStaticsScreen extends StatelessWidget {
  final GetStaticsParam data;

  const SubjectsViewFotStaticsScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<StaticsBloc>()
        ..add(
          GetSubjectsForStaticsEvent(
            staticsParam: data,
          ),
        ),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const HeaderForMore(title: 'المواد المنجزة'),
              Expanded(
                child: BlocBuilder<StaticsBloc, StaticsState>(
                  builder: (context, state) {
                    switch (state.subjectsStates) {
                      case RequestStates.loading:
                        return  LoadingShimmerList(
                          height: AppSize.s30.responsiveHeight,
                        );
                      case RequestStates.loaded:
                        if (state.subjects.isNotEmpty) {
                          return Container(
                              padding: EdgeInsets.all(AppPadding.p20.responsiveSize),
                              width: AppReference.deviceWidth(context) * 0.9,
                              height: AppReference.deviceHeight(context) * 0.45,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(AppConstants.appBorderRadiusR20.responsiveSize),
                                color: Colors.white,
                              ),
                              child: ListView.separated(
                                itemBuilder: (context, index) => Row(
                                  children: [
                                    const Icon(
                                      Icons.check_circle,
                                      color: AppColors.successColor,
                                    ),
                                    15.sizedBoxWidth,
                                    Expanded(
                                      child: Text(
                                        state.subjects[index].subjectName,
                                        style: AppTextStyle.bodyLarge16
                                            .copyWith(fontSize: AppSize.s20),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                separatorBuilder: (context, index) =>
                                    AppSize.s10.sizedBoxHeight,
                                itemCount: state.subjects.length,
                              ));
                        } else {
                          return const EmptyListWidgets(
                              message: 'لا يوجد مواد منجزة حالياً');
                        }
                      case RequestStates.error:
                        return CustomErrorWidget(
                            errorMessage: state.subjectsErrorMessage);
                      default:
                        return const SizedBox();
                    }
                  },
                ),
              ),
            ],
          ),
        ).paddingBody(),
      ),
    );
  }
}
