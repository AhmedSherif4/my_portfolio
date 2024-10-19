part of '../.././sign_up.dart';

class _GoToLoginScreen extends StatelessWidget {
  const _GoToLoginScreen();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppStrings.doYouHaveAccount,
          style: const AppTextStyle().balooBhaijaan2.w500.bodySmall12.copyWith(
            fontSize: AppReference.deviceIsTablet?AppFontSize.sp12.responsiveFontSize:AppFontSize.sp8.responsiveFontSize
          ),
        ),
        TextButtonWidget(
            text: AppStrings.registerNow2,
            weight: AppFontWeight.regular2W500,
            fontSize: AppReference.deviceIsTablet?AppFontSize.sp10.responsiveFontSize:AppFontSize.sp12.responsiveFontSize,
            withDecoration: true,
            onPressed: () {
              RouteManager.rPushNamed(
                context: context,
                rName: AppRoutesNames.rLoginScreen,
              );
            })
      ],
    );
  }
}

class _HeadWidget extends StatelessWidget {
  const _HeadWidget();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppReference.deviceHeight(context) * 0.20.responsiveHeightRatio,
      child: LayoutBuilder(builder: (context, constrains) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

            SizedBox(
              width: constrains.maxWidth * 0.12,
              child: SvgPicture.asset(
                AppImagesAssets.signUpPlanet,
              ),
            ),
            SizedBox(
              width: constrains.maxWidth * 0.4,
              child: SvgPicture.asset(
                AppImagesAssets.signUpPerson,
              ),
            ),
          ],
        );
      }),
    );
  }
}
class _HeadWidgetForTablet extends StatelessWidget {
  const _HeadWidgetForTablet();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppReference.deviceHeight(context) * 0.20.responsiveHeight,
      child: LayoutBuilder(builder: (context, constrains) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            SizedBox(
              width: constrains.maxWidth * 0.15,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    AppStrings.appNameArabic,
                    style:
                    const AppTextStyle().balooBhaijaan2
                        .w400
                        .titleLarge22
                        .copyWith(color: AppColors.primaryColor2,),
                  ),
                  Text(
                    AppStrings.newAccount,
                    style: const AppTextStyle().balooBhaijaan2.w500.titleLarge22,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: constrains.maxWidth * 0.05,
              child: SvgPicture.asset(
                AppImagesAssets.signUpPlanet,
              ),
            ),

            SizedBox(
              width: constrains.maxWidth * 0.12,
              child: SvgPicture.asset(
                AppImagesAssets.signUpPerson,
              ),
            ),
          ],
        );
      }),
    );
  }
}





class PickImgWidget extends StatelessWidget {
  const PickImgWidget({super.key, required this.pickImageErrorMessage});
  final String pickImageErrorMessage;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const ChooseImageTitle(),
        ChooseImageWidget(pickImageErrorMessage: pickImageErrorMessage),
      ],
    );
  }
}


class ChooseImageWidget extends StatelessWidget {
  final String pickImageErrorMessage;

  const ChooseImageWidget({super.key, required this.pickImageErrorMessage});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: AppReference.deviceWidth(context) * 0.27,
          height: AppReference.deviceHeight(context) * 0.12.responsiveHeightRatio,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1),
            image: DecorationImage(
              image: context.read<ImagePickBloc>().imageFile == null
                  ? const AssetImage(AppImagesAssets.pUploadImage)
                  : FileImage(context.read<ImagePickBloc>().imageFile!)
              as ImageProvider,
            ),
            borderRadius: BorderRadius.circular(
              AppConstants.appBorderRadiusR20.responsiveSize,
            ),
          ),
        ),
        AppSize.s10.sizedBoxHeight,
        Text(
          AppStrings.correctImageFormat,
          style: AppReference.themeData.textTheme.bodySmall!
              .copyWith(fontSize: 12.responsiveFontSize),
        ),
        Text(
          pickImageErrorMessage,
          style: AppReference.themeData.textTheme.bodySmall!
              .copyWith(color: Colors.red),
        ),
      ],
    );
  }
}

class ChooseImageTitle extends StatelessWidget {
  const ChooseImageTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      AppStrings.chooseYourImage,
      style: AppReference.deviceIsTablet?const AppTextStyle().w500.bodyMedium14:const AppTextStyle().w500.bodyLarge16,
    );
  }
}