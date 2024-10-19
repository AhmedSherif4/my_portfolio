part of '../free_subscriptions.dart';

class FreeSubscriptionsScreen extends StatelessWidget {
  final UserEntity userData;
  const FreeSubscriptionsScreen({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
          children: [
             AppBarSubscriptionsWidget(
              childID: userData.userId ,
            ),
            NameGradeSubscriptionsWidget(
              userData: userData,
            ),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                AppStrings.howWouldULikeToSubscribe,
                style: const AppTextStyle().w600.s15.gray.bodyLarge16,
              ),
            ),
            GestureDetector(
              onTap: () {
                if(AppReference.userIsGuest()){
                  AppReference.guestDialogMustLogin(context);
                }else {
                  RouteManager.rPushNamed(
                    context: context,
                    rName: AppRoutesNames.rFreeGradeSubscriptionsScreen,
                    arguments: userData,
                  );
                }

              },
              child: const CardSubscriptionsWidget(
                title: AppStrings.annual,
                subtitle: AppStrings.annualDescription,
                imagePath: AppImagesAssets.sClassroomSubscriptionImage,
              ),
            ),
            GestureDetector(
              onTap: () {
                if(AppReference.userIsGuest()){
                  AppReference.guestDialogMustLogin(context);
                }else {
                  RouteManager.rPushNamed(
                      context: context,
                      rName: AppRoutesNames.rFreeTermSubscriptionsScreen,
                      arguments: userData);
                }

              },
              child: const CardSubscriptionsWidget(
                title: AppStrings.term,
                subtitle: AppStrings.termDescription,
                imagePath: AppImagesAssets.sTermSubscriptionImage,
              ),
            ),
            // go to subjects view
            GestureDetector(
              onTap: () {
                if(AppReference.userIsGuest()){
                  AppReference.guestDialogMustLogin(context);
                }else {
                  RouteManager.rPushNamed(
                    context: context,
                    rName: AppRoutesNames.rFreeSubjectsSubscriptionsScreen,
                    arguments: userData,);
                }
              },
              child: const CardSubscriptionsWidget(
                title: AppStrings.subjects,
                subtitle: AppStrings.subjectsDescription,
                imagePath: AppImagesAssets.sSubjectSubscriptionImage,
              ),
            ),
          ],
        )),
      ).paddingBody(),
    );
  }
}
