part of '../../terms_and_conditions.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<TermsAndConditionsBloc>()..add(GetTermsAndConditionsEvent()),
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<TermsAndConditionsBloc, TermsAndConditionsState>(
            builder: (context, state) {
              switch (state.getTermsAndConditionsStates) {
                case RequestStates.loading:
                  return const LoadingShimmerList();
                case RequestStates.loaded:
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        textDirection: TextDirection.rtl,
                        children: [
                          const  Align(
                            alignment: AlignmentDirectional.centerEnd,
                            child: TextBackButton(),
                          ),
                          Text(
                            state.getTermsAndConditionsData.title,
                            style: AppTextStyle.titleLarge22,
                            textAlign: TextAlign.center,
                          ),
                          AppSize.s30.sizedBoxHeight,
                          Text(
                            state.getTermsAndConditionsData.content,
                            style: AppTextStyle.bodyLarge16,
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    ),
                  );
                case RequestStates.error:
                  return Center(
                    child: CustomErrorWidget(
                        errorMessage: state.getTermsAndConditionsMessage),
                  );
                default:
                  return const SizedBox.shrink();
              }
            },
          ),
        ).paddingBody(),
      ),
    );
  }
}
