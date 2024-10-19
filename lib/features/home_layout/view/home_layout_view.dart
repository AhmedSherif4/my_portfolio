part of '../home_layout.dart';


class HomeLayoutView extends StatefulWidget {
  const HomeLayoutView({
    super.key,
  });

  @override
  State<HomeLayoutView> createState() => _HomeLayoutViewState();
}

class _HomeLayoutViewState extends State<HomeLayoutView> {
   bool isInstitutionChild = false;
   bool onBannerStatus = false;



  List<BottomNavBarItemWidget> childItems({
    required BoxConstraints constrains,
    required BuildContext context,
  }) =>
      [
        BottomNavBarItemWidget(
          onTap: () {
              context.read<HomeLayoutBloc>().add(ChangeBottomNavBarIndexEvent(0));
          },
          isSelected:
              context.read<HomeLayoutBloc>().state.index == 0 ? true : false,
          label: AppStrings.homeTitle,
          imageIconPath: AppIconsAssets.sHomeIcon,
          constrains: constrains,
        ),
        BottomNavBarItemWidget(
          onTap: () {
   if(context.read<SharedSubjectsBloc>().state.subjects.isNotEmpty) {
     context.read<HomeLayoutBloc>().add(ChangeBottomNavBarIndexEvent(1));
   }
          },
          isSelected:
              context.read<HomeLayoutBloc>().state.index == 1 ? true : false,
          label: AppStrings.staticsTitle,
          imageIconPath: AppIconsAssets.sStatisticsIcon,
          constrains: constrains,
        ),
         if(!isInstitutionChild)
        BottomNavBarItemWidget(
          onTap: () {
            context.read<HomeLayoutBloc>().add(ChangeBottomNavBarIndexEvent(2));
          },
          isSelected:
          context.read<HomeLayoutBloc>().state.index == 2 ? true : false,
          label: AppStrings.subscription,
          imageIconPath: AppIconsAssets.sSubscriptionIcon,
          constrains: constrains,
        ),
        BottomNavBarItemWidget(
          onTap: () {
            context.read<HomeLayoutBloc>().add(ChangeBottomNavBarIndexEvent(isInstitutionChild ? 2 :3));
          },
          isSelected:
              context.read<HomeLayoutBloc>().state.index == (isInstitutionChild ? 2 :3) ? true : false,
          label: AppStrings.quranTitle,
          imageIconPath: AppIconsAssets.sQuranIcon,
          constrains: constrains,
        ),
        BottomNavBarItemWidget(
          onTap: () {
            context.read<HomeLayoutBloc>().add(ChangeBottomNavBarIndexEvent(isInstitutionChild ? 3 : 4));
          },
          isSelected:
              context.read<HomeLayoutBloc>().state.index == (isInstitutionChild ? 3 : 4) ? true : false,
          label: AppStrings.more,
          imageIconPath: AppImagesAssets.sMore,
          constrains: constrains,
        ),
      ];

  List<BottomNavBarItemWidget> parentAndInstitutionsItems({
    required BoxConstraints constrains,
    required BuildContext context,end
  }) =>
      [
        BottomNavBarItemWidget(
          onTap: () {
            context.read<HomeLayoutBloc>().add(ChangeBottomNavBarIndexEvent(0));
          },
          isSelected:
              context.read<HomeLayoutBloc>().state.index == 0 ? true : false,
          label: AppStrings.homeTitle,
          imageIconPath: AppIconsAssets.sHomeIcon,
          constrains: constrains,
          widthRatio: 0.4,
        ),
        BottomNavBarItemWidget(
          onTap: () {
            context.read<HomeLayoutBloc>().add(ChangeBottomNavBarIndexEvent(1));
          },
          isSelected:
              context.read<HomeLayoutBloc>().state.index == 1 ? true : false,
          label: AppStrings.quranTitle,
          imageIconPath: AppIconsAssets.sQuranIcon,
          constrains: constrains,
        ),
        BottomNavBarItemWidget(
          onTap: () {
            context.read<HomeLayoutBloc>().add(ChangeBottomNavBarIndexEvent(2));
          },
          isSelected:
              context.read<HomeLayoutBloc>().state.index == 2 ? true : false,
          label: AppStrings.more,
          imageIconPath: AppImagesAssets.sMore,
          constrains: constrains,
          widthRatio: 0.4,
        ),
      ];

  bool isExit = false;

  @override
  void initState() {
    super.initState();

    NotificationSetup.setupInteractedMessage();
    AppAnalytics.viewHomeScreenLogEvent();
    if (AppReference.userIsChild()) {
      isInstitutionChild =
          getIt<UserLocalDataSource>().getUserData()!.childInstitutionId != null
              ? true
              : false;
      AppTimeData.setStartTime(DateTime.now());
    }

    _getGuestWelcomeDialog();


  }

  @override
  void didChangeDependencies() async {
    // if(await getIt<BaseLocalDataSource>()
    //     .getDataFromLocal<bool>(labelKey: AppKeys.showcaseViewed)??true){
    //   if(AppReference.userIsGuest()){
    //     print("guest0000000000");
    //     showDialog(context: context,
    //         builder: (dialogContext)=>const GuestWelcomeDialog());
    //   }
    // }
    if(AppReference.userIsParent()){
      await NotificationSetup.messagingPermission.subscribeToTopic("parents");
    }else if (AppReference.userIsInstitution()){
      await NotificationSetup.messagingPermission.subscribeToTopic("institutions");
    }else{
      await NotificationSetup.messagingPermission.subscribeToTopic("children");
    }

    super.didChangeDependencies();

  }

   Future<bool> _getBannerStatus() async {
     return await getIt<HomeLocalDataSource>().getShowBanner();
   }

   Future<void> _getGuestWelcomeDialog() async {
     if(await getIt<BaseLocalDataSource>()
         .getDataFromLocal<bool>(labelKey: AppKeys.showcaseViewed)==true){
       if(AppReference.userIsGuest()){

           showDialog(context: context,
             builder: (dialogContext)=>const GuestWelcomeDialog());
       }
     }   }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BannerBloc, BannerState>(
      listener: (context, state)async {

        onBannerStatus=await _getBannerStatus();
        if(await getIt<BaseLocalDataSource>().getDataFromLocal<bool>(labelKey: AppKeys.showcaseViewed)??true){
          if(!onBannerStatus) {
            if (state.bannerState == RequestStates.loaded) {
              if(state.banner.type != "" && state.banner.type == "coupon") {

                showDialog(
                    context: context,
                    builder: (dialogContext) => CouponDialog(
                      state: state.banner,
                    )
                ).then(
                        (value) async {
                      await getIt<HomeLocalDataSource>().saveShowBanner(value: true);
                    });
              }else if(state.banner.type != "" && (state.banner.type == "discount" ||state.banner.type == "text")){
                showDialog(
                    context: context,
                    builder: (dialogContext) => DiscountDialog(
                      state: state.banner,
                    )
                ).then(
                        (value) async {
                      await getIt<HomeLocalDataSource>().saveShowBanner(value: true);
                    });
              }
            }
          }
          // if(AppReference.userIsGuest()){
          //   showDialog(context: context,
          //       builder: (dialogContext)=>const GuestWelcomeDialog());
          // }

        }

      },builder: (context, bState) {
        return BlocBuilder<HomeLayoutBloc, HomeLayoutState>(
          builder: (context, state) {
            switch (state.appFlowState) {
              case HomeLayoutStatesEnum.homeLayoutInitState:
                return const SizedBox();
              case HomeLayoutStatesEnum.appFlowState:
                return ShowCaseWidget(
                  enableAutoScroll: true,
                    onFinish: () {
                      getIt<BaseLocalDataSource>().saveDataInLocal<bool>(
                        labelKey: AppKeys.showcaseViewed,
                        data: true,
                        expirationDuration: const Duration(days: 365),
                      );
                      if(AppReference.userIsGuest()){
                        showDialog(context: context,
                            builder: (dialogContext)=>const GuestWelcomeDialog());
                      }
                      if(context.read<GlobalBloc>().fromRegister==true&&context.read<GlobalBloc>().state.appVersionModel.invitationStatus==true) {
                        showDialog(context: context,
                            builder: (dialogContext)=>const WelcomeToTasesseDialog());
                      }
                      if(!onBannerStatus&&context.read<GlobalBloc>().fromRegister==false) {
                        if (bState.bannerState == RequestStates.loaded) {
                          if(bState.banner.type != "" && bState.banner.type == "coupon") {
                            showDialog(
                                context: context,
                                builder: (dialogContext) => CouponDialog(
                                  state: bState.banner,
                                )
                            ).then(
                                    (value) async {
                                  await getIt<HomeLocalDataSource>().saveShowBanner(value: true);
                                });
                          }else if(bState.banner.type != "" && (bState.banner.type == "discount" ||bState.banner.type == "text")){
                            showDialog(
                                context: context,
                                builder: (dialogContext) => DiscountDialog(
                                  state: bState.banner,
                                )
                            ).then(
                                    (value) async {
                                  await getIt<HomeLocalDataSource>().saveShowBanner(value: true);
                                });
                          }
                        }
                      }

                    },
                    builder: (context)=>Builder(
                      builder: (context) => PopScope(
                        canPop: AppReference.userIsGuest()?true:false,
                        onPopInvoked: (value) async {
                          if(!AppReference.userIsGuest()) {
                            showDialog(
                              context: context,
                              builder: (context) => ExitAndUpdateDialog(
                                withImage: true,
                                title: AppStrings.exist,
                                imagePath: AppIconsAssets.sExist,
                                message: AppStrings.wantToExist,
                                confirm: (bool wantExit) {
                                  isExit = wantExit;
                                },
                              ),
                            ).then((value) {
                              if (isExit) {
                                if (AppReference.userIsChild()) {
                                  context
                                      .read<GlobalBloc>()
                                      .add(const SendTimeInAppEvent());
                                  SystemNavigator.pop();

                                } else {
                                  SystemNavigator.pop();
                                }
                              }
                            });
                          }
                        },
                        child: Scaffold(
                          body: SafeArea(
                            child: context
                                .read<HomeLayoutBloc>()
                                .state
                                .appFlow[state.index],
                          ),
                          bottomNavigationBar: SafeArea(
                            child: Material(
                              color: AppColors.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusDirectional.only(
                                  topStart: Radius.circular(AppConstants.appBorderRadiusR10.responsiveSize),
                                  topEnd: Radius.circular(AppConstants.appBorderRadiusR10.responsiveSize),
                                ),
                                side: const BorderSide(
                                  width: 1.5,
                                  color: AppColors.primaryColor,
                                  style: BorderStyle.solid,
                                ),
                              ),
                              child: SizedBox(
                                height:AppReference.deviceIsTablet&&!AppReference.isPortrait(context)? AppReference.deviceHeight(context) * 0.04.responsiveHeightRatio:AppReference.deviceHeight(context) * 0.075.responsiveHeightRatio,
                                width: AppReference.deviceWidth(context),
                                child:
                                LayoutBuilder(builder: (context, constrains) {
                                  return Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: state.userType == UsersType.child
                                        ? childItems(
                                        constrains: constrains,
                                        context: context)
                                        : parentAndInstitutionsItems(
                                        constrains: constrains,
                                        context: context),
                                  );
                                }),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ));
              default:
                return const SizedBox.shrink();
            }
          },
        );
      },
    );
  }
}



