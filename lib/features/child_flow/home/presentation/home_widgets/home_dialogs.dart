

part of '../../home.dart';

class CouponDialog extends StatelessWidget {
  final BannerEntityOutputs state;
  const CouponDialog({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      elevation: 5,
      actionsPadding: EdgeInsets.zero,
      buttonPadding: EdgeInsets.zero,
      iconPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      content: Container(
          width: AppReference.deviceIsTablet
              ? AppReference.deviceWidth(context) * 0.4
              : AppReference.deviceWidth(context) * 0.8,
          padding: EdgeInsets.all(AppPadding.p20.responsiveSize),
          decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(
                  AppConstants.appBorderRadiusR20.responsiveHeight)),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(AppImagesAssets.sCouponDialog),
                AppSize.s20.sizedBoxHeight,
                Text(state.text!,
                    style: const AppTextStyle()
                        .balooBhaijaan2
                        .w500
                        .black
                        .bodyLarge16),
                AppSize.s20.sizedBoxHeight,
                Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(AppPadding.p8.responsiveSize),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundColor,
                      borderRadius: BorderRadius.circular(
                          AppConstants.appBorderRadiusR20.responsiveSize),
                    ),
                    child: Text(
                      state.coupon!,
                    )),
                AppSize.s20.sizedBoxHeight,
                Row(
                  children: [
                    Expanded(
                        child: DefaultButtonWidget(
                            label: "نسخ الكوبون",
                            onPressed: () {
                              Clipboard.setData(
                                  ClipboardData(text: state.coupon!));
                              Navigator.pop(context);
                              showSnackBar(
                                  description: "لقد تم النسخ بنجاح",
                                  state: ToastStates.congrats,
                                  context: context);
                            })),
                    AppSize.s10.sizedBoxWidth,
                    Expanded(
                        child: DefaultButtonWidget(
                            buttonColor: AppColors.primaryColor.withOpacity(.1),
                            elevation: 0,
                            labelColor: AppColors.primaryColor,
                            label: "ليس الان",
                            onPressed: () {
                              Navigator.pop(context);
                            })),
                  ],
                ),
              ])),
    );
  }
}

class DiscountDialog extends StatelessWidget {
  final BannerEntityOutputs state;
  const DiscountDialog({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      elevation: 5,
      actionsPadding: EdgeInsets.zero,
      buttonPadding: EdgeInsets.zero,
      iconPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      content: Container(
          width: AppReference.deviceIsTablet
              ? AppReference.deviceWidth(context) * 0.4
              : AppReference.deviceWidth(context) * 0.8,
          padding: EdgeInsets.all(AppPadding.p20.responsiveSize),
          decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(
                  AppConstants.appBorderRadiusR20.responsiveHeight)),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                NullableNetworkImage(
                  height: AppReference.deviceHeight(context) * 0.3,
                  width: AppReference.deviceHeight(context),
                  imagePath: state.img,
                  notHaveImage: state.img == "",
                  fit: BoxFit.contain,
                ),
                AppSize.s20.sizedBoxHeight,
                Text(state.text!,
                    style: const AppTextStyle()
                        .balooBhaijaan2
                        .w500
                        .black
                        .bodyLarge16),
                if (state.type == "text") ...[
                  AppSize.s20.sizedBoxHeight,
                  DefaultButtonWidget(
                      textFontSize: AppSize.s10.responsiveSize,
                      buttonColor: AppColors.primaryColor.withOpacity(.1),
                      elevation: 0,
                      labelColor: AppColors.primaryColor,
                      label: "حسنا",
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ],
                if (state.type == "discount") ...[
                  AppSize.s20.sizedBoxHeight,
                  Row(
                    children: [
                      Expanded(
                          child: DefaultButtonWidget(
                              textFontSize: AppSize.s10.responsiveSize,
                              label: "إضافة اشتراك",
                              onPressed: () {
                                Navigator.pop(context);
                                RouteManager.rPushNamed(
                                    context: context,
                                    arguments: getIt<UserLocalDataSource>()
                                        .getUserData()!
                                        .userId,
                                    rName: AppRoutesNames.rCartScreen);
                              })),
                      AppSize.s10.sizedBoxWidth,
                      Expanded(
                          child: DefaultButtonWidget(
                              textFontSize: AppSize.s10.responsiveSize,
                              buttonColor:
                                  AppColors.primaryColor.withOpacity(.1),
                              elevation: 0,
                              labelColor: AppColors.primaryColor,
                              label: "ليس الان",
                              onPressed: () {
                                Navigator.pop(context);
                              })),
                    ],
                  ),
                ],
              ])),
    );
  }
}

class RatingDialog extends StatefulWidget {
  final String message;

  const RatingDialog({
    super.key,
    required this.message,
  });

  @override
  State<RatingDialog> createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  TextEditingController controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  double rating = 1.0;
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<ReviewBloc>(),
      child: Builder(builder: (context) {
        return BlocListener<ReviewBloc, ReviewState>(
          listener: (context, state) {
            switch (state.addReviewState) {
              case RequestStates.loading:
                showLoadingDialog(context);
                break;
              case RequestStates.loaded:
                RouteManager.rPopRoute(context);
                RouteManager.rPopRoute(context);
                showSnackBar(
                    description: state.addReviewMessage,
                    state: ToastStates.congrats,
                    context: context);
                RouteManager.rPushReplacementNamed(
                  context: context,
                  rName: AppRoutesNames.rReviewScreen,
                );
                break;
              case RequestStates.error:
                RouteManager.rPopRoute(context);
                showSnackBar(
                    description: state.addReviewMessage,
                    state: ToastStates.error,
                    context: context);
                break;
              default:
            }
          },
          child: AlertDialog(
            scrollable: true,
            contentPadding: EdgeInsets.zero,
            elevation: 5,
            actionsPadding: EdgeInsets.zero,
            buttonPadding: EdgeInsets.zero,
            iconPadding: EdgeInsets.zero,
            insetPadding: EdgeInsets.zero,
            titlePadding: EdgeInsets.zero,
            content: Container(
              padding: EdgeInsets.all(AppPadding.p20.responsiveSize),
              width: !AppReference.isPortrait(context)
                  ? AppReference.deviceWidth(context) * 0.4
                  : AppReference.deviceWidth(context) * 0.8,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      AppConstants.appBorderRadiusR20.responsiveSize),
                  color: AppColors.backgroundColor),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      CustomInkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: SvgPicture.asset(
                          AppImagesAssets.sPuzzleAndAdviceCancel,
                          height: AppSize.s26.responsiveHeight,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "قيم تأسيس !",
                            style: const AppTextStyle().titleLarge22.copyWith(
                                fontSize: AppFontSize.sp24.responsiveFontSize,
                                fontWeight: AppFontWeight.regular2W500),
                          ),
                          AppSize.s10.sizedBoxWidth,
                          SvgPicture.asset(
                            AppIconsAssets.sRatingReview,
                            height: AppSize.s26.responsiveHeight,
                          ),
                        ],
                      ),
                      const Spacer(),
                    ],
                  ),
                  (AppSize.s10).sizedBoxHeight,
                  Text(
                    "أخبرنا عن رأيك بالتطبيق ..",
                    style: const AppTextStyle().titleLarge22.copyWith(
                        color: AppColors.textColor5,
                        fontSize: AppFontSize.sp16.responsiveFontSize,
                        fontWeight: AppFontWeight.regular2W500),
                  ),
                  (AppSize.s10).sizedBoxHeight,
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      "رأيك",
                      style: const AppTextStyle()
                          .bodySmall12
                          .copyWith(fontWeight: AppFontWeight.regular2W500),
                    ),
                  ),
                  (AppSize.s10).sizedBoxHeight,
                  Form(
                    key: _formKey,
                    child: TextFormFieldWidget(
                        horizontalPadding: 20,
                        verticalPadding: 20,
                        maxLine: 5,
                        controller: controller,
                        keyboardType: TextInputType.text,
                        inputAction: TextInputAction.done,
                        validator: (value) {
                          if (value!.isEmpty || value == " ") {
                            return "من فضلك قم بإضافة تقييم";
                          }
                          return null;
                        },
                        onFieldSubmitted: (v) {}),
                  ),
                  (AppSize.s10).sizedBoxHeight,
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      "كم من خمسة ؟",
                      style: const AppTextStyle()
                          .bodySmall12
                          .copyWith(fontWeight: AppFontWeight.regular2W500),
                    ),
                  ),
                  (AppSize.s10).sizedBoxHeight,
                  RatingBar(
                    initialRating: 1,
                    maxRating: 5,
                    ratingWidget: RatingWidget(
                        full: SvgPicture.asset(AppIconsAssets.sRatingStarFill),
                        half: SvgPicture.asset(AppIconsAssets.sRatingStarFill),
                        empty:
                            SvgPicture.asset(AppIconsAssets.sRatingStarEmpty)),
                    onRatingUpdate: (value) {
                      setState(() {
                        rating = value;
                      });
                    },
                  ),
                  (AppSize.s30).sizedBoxHeight,
                  DefaultButtonWidget(
                    label: 'أضف التقييم !',
                    textVerticalPadding: 2,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<ReviewBloc>().add(AddReviewDataEvent(
                                addReviewInputs: AddReviewInputs(
                              reviewText: controller.text,
                              starsNum: rating.toInt(),
                            )));
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
