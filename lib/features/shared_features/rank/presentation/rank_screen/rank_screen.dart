part of '../../rank.dart';


class RankScreen extends StatelessWidget {
  final RankData rankData;

  const RankScreen({super.key, required this.rankData});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<RankBloc>()
        ..add(
          GotSubjectsForRank(
            subjectParameters: ParameterGoToQuestions(
                systemId: rankData.systemId,
                stageId: rankData.stageId,
                classRoomId: rankData.classroomId,
                termId: rankData.termId,
                pathId: rankData.pathId ?? 0,
                userId: rankData.childId),
          ),
        ),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: BlocListener<RankBloc, RankState>(
              listener: (context, state) {
                if (state.rankStates == RequestStates.loaded) {
                  switch (state.rankType) {
                    case RankType.classroom:
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ViewUserRank(
                              rankData: rankData.copyWith(
                                  rankType: RankType.classroom),
                              title: "الترتيب العام",
                            );
                          },
                        ),
                      );
                    case RankType.term:
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return ViewUserRank(
                              rankData: rankData.copyWith(rankType: RankType.term),
                              title: "ترتيبي حسب الصف",
                            );
                          }));
                    case RankType.subject:
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ViewUserRank(
                              rankData: rankData.copyWith(
                                rankType: RankType.subject,
                                subjectId: state.specificSubjectID,
                              ),
                              title: "ترتيبي حسب المادة",
                            );
                          },
                        ),
                      );
                    default:
                  }
                }
              },
              child: ResponsiveWidgetForTablet(
                mobile: _RankScreenPortraitView(rankData: rankData),
                tablet: OrientationItem(
                  portraitWidget: _RankScreenPortraitView(rankData: rankData),
                  landscapeWidget: _RankScreenLandscapeView(rankData: rankData),
                ),
              ),
            ),
          ),
        ).paddingBody(),
      ),
    );
  }
}

class _RankScreenLandscapeView extends StatelessWidget {
  const _RankScreenLandscapeView({
    required this.rankData,
  });

  final RankData rankData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HeaderForMore(
          title: AppStrings.arrange,
        ),
        AppSize.s80.sizedBoxHeight,
        SizedBox(
          width: AppReference.deviceWidth(context) * 0.65,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: AppReference.deviceWidth(context) * 0.4,
                child: Column(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          height: AppSize.s60.responsiveHeightRatio,
                          decoration: BoxDecoration(
                            color: AppColors.secondaryColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(
                                AppConstants.appBorderRadiusR10.responsiveSize,
                              ),
                              topRight: Radius.circular(

                                AppConstants.appBorderRadiusR20.responsiveSize,
                              ),
                              bottomLeft: Radius.circular(
                                AppConstants.appBorderRadiusR10.responsiveSize,
                              ),

                            ),
                          ),
                          child: Row(
                            children: [
                              AppSize.s50.sizedBoxWidth,
                              Text(rankData.className ??getIt<UserLocalDataSource>().getUserData()!.classroomName ?? '',
                                style: const AppTextStyle().balooBhaijaan2.white.w700.bodySmall12.copyWith(
                                    fontSize: AppFontSize.sp10.responsiveFontSize
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: SvgPicture.asset(AppIconsAssets.sIdea4,height: AppSize.s70,))
                      ],
                    ),
                    AppSize.s20.sizedBoxHeight,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(AppIconsAssets.sAttentionPlease),
                        AppSize.s10.sizedBoxWidth,
                        Text("هذا الترتيب هو ترتيبك مع باقي أصدقائك بداخل التطبيق",
                          style: const AppTextStyle().balooBhaijaan2.w700.bodySmall12.copyWith(
                              fontSize: AppFontSize.sp10.responsiveFontSize
                          ),
                        ),
                      ],
                    ),
                    AppSize.s20.sizedBoxHeight,
                  ],
                ),
              ),
              _RankingByTermWidget(
                rankData: rankData,
              ),
              AppSize.s20.sizedBoxHeight,
              _RankingByClassroomsWidget(rankData: rankData),
              AppSize.s20.sizedBoxHeight,
              _RankingBySubjectsWidget(rankData: rankData,width: AppReference.deviceWidth(context) * 0.6,),

            ],
          ),
        ),


      ],
    );
  }
}

class _RankScreenPortraitView extends StatelessWidget {
  const _RankScreenPortraitView({
    required this.rankData,
  });

  final RankData rankData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HeaderForMore(
          title: AppStrings.arrange,
        ),
        AppSize.s30.sizedBoxHeight,
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: AppSize.s26.responsiveHeightRatio,
              decoration: BoxDecoration(
                color: AppColors.secondaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(
                    AppConstants.appBorderRadiusR10.responsiveSize,
                  ),
                  topRight: Radius.circular(
                    AppConstants.appBorderRadiusR20.responsiveSize,
                  ),
                  bottomLeft: Radius.circular(
                    AppConstants.appBorderRadiusR10.responsiveSize,
                  ),

                ),
              ),
              child: Row(
                children: [
                  AppSize.s50.sizedBoxWidth,
                  Text(rankData.className ?? getIt<UserLocalDataSource>().getUserData()!.classroomName ?? '',
                    style: const AppTextStyle().balooBhaijaan2.white.w700.bodySmall12,
                  ),
                ],
              ),
            ),
            Positioned(
                bottom: 0,
                right: 0,
                child: SvgPicture.asset(AppIconsAssets.sIdea4))
          ],
        ),
        AppSize.s20.sizedBoxHeight,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(AppIconsAssets.sAttentionPlease),
            AppSize.s10.sizedBoxWidth,
            Text("هذا الترتيب هو ترتيبك مع باقي أصدقائك بداخل التطبيق",
              style: const AppTextStyle().balooBhaijaan2.w700.bodySmall12,
            ),
          ],
        ),
        AppSize.s20.sizedBoxHeight,
        _RankingByTermWidget(rankData: rankData),
        AppSize.s20.sizedBoxHeight,

        _RankingByClassroomsWidget(rankData: rankData),
        _RankingBySubjectsWidget(rankData: rankData),
      ],
    );
  }
}

class _RankingByTermWidget extends StatelessWidget {
  const _RankingByTermWidget({
    required this.rankData,
  });

  final RankData rankData;

  @override
  Widget build(BuildContext context) {
    return ListTileWidget(
      title: 'الترتيب العام',
      icon: AppIconsAssets.sRanking,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return ViewUserRank(
                rankData: rankData.copyWith(
                  rankType: RankType.classroom,
                ),
                title: "الترتيب العام",

              );
            },
          ),
        );
      },
    );
  }
}

class _RankingByClassroomsWidget extends StatelessWidget {
  const _RankingByClassroomsWidget({
    required this.rankData,
  });

  final RankData rankData;

  @override
  Widget build(BuildContext context) {
    return ListTileWidget(
      title: 'ترتيبي حسب الصف',
      icon: AppIconsAssets.sRanking,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return ViewUserRank(
                rankData: rankData.copyWith(
                  rankType: RankType.term,
                ),
                title: "ترتيبي حسب الصف",
              );
            },
          ),
        );
      },
    );
  }
}

class _RankingBySubjectsWidget extends StatelessWidget {
  const _RankingBySubjectsWidget({
    required this.rankData, this.width,
  });

  final RankData rankData;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(
        horizontal: AppPadding.p20.responsiveWidth,
        vertical: AppPadding.p10.responsiveHeight,
      ),
      child: Container(
        width: width ?? AppReference.deviceWidth(context),
        decoration:  BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(AppConstants.appBorderRadiusR20)
        ),
        child: ExpansionTile(

            collapsedShape: const ContinuousRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))
            ),
            shape: const ContinuousRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))
            ),
            title:  Row(
              children: [
                SvgPicture.asset(AppIconsAssets.sStar2),
                AppSize.s10.sizedBoxWidth,
                Text(
                  'ترتيبي حسب المواد',
                  style: const AppTextStyle().balooBhaijaan2.w600.black.bodyLarge16,
                ),
              ],
            ),
            children: <Widget>[
              BlocBuilder<RankBloc, RankState>(
                builder: (context, state) {
                  switch (state.userSubjectsState) {
                    case RequestStates.loading:
                      return const LoadingShimmerList();
                    case RequestStates.loaded:
                      if (state.userSubjects!.isEmpty) {
                        return SizedBox(
                          height: AppReference.deviceHeight(context) * .4,
                          child: const Center(
                            child: EmptyListWidgets(
                                message: "حتى تستطيع رؤية ترتيبك حسب المواد يجب عليك الاشتراك أولا"),
                          ),
                        );
                      } else {
                        return ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return ListTileWidget(
                              buttonColor: const Color(0xFFFDE1A7),
                              icon: AppIconsAssets.sRanking,
                              title: state.userSubjects![index].subjectName,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return ViewUserRank(
                                        rankData: rankData.copyWith(
                                          rankType: RankType.subject,
                                          subjectId: state
                                              .userSubjects![index]
                                              .subjectId,
                                        ),
                                        title: "ترتيبي حسب المادة",

                                      );
                                    },
                                  ),
                                );
                              },
                            );
                          },
                          separatorBuilder: (context, index) => AppSize.s10.sizedBoxHeight,
                          itemCount: state.userSubjects!.length,
                        );
                      }
                    case RequestStates.error:
                      return ErrorWidget(state.rankMessage);
                    default:
                      return const SizedBox.shrink();
                  }
                },
              ),]),
      ),
    );
  }
}

class ViewUserRank extends StatelessWidget {
  final RankData rankData;
  final String title;

  const ViewUserRank({
    super.key,
    required this.rankData,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<RankBloc>()
        ..add(switch (rankData.rankType!) {
          RankType.classroom => GotUserRankClassroom(
            systemID: rankData.systemId,
            stageID: rankData.stageId,
            classroomID: rankData.classroomId,
            pageNumber: 1,
          ),
          RankType.term => GotUserRankTerm(
            systemID: rankData.systemId,
            stageID: rankData.stageId,
            classroomID: rankData.classroomId,
            termID: rankData.termId,
            pathID: rankData.pathId ?? 0,
            pageNumber: 1,
          ),
          RankType.subject => GotUserRankSubject(
            systemID: rankData.systemId,
            pathID: rankData.pathId ?? 0,
            subjectID: rankData.subjectId!,
            classroomID: rankData.classroomId,
            stageID: rankData.stageId,
            termID: rankData.termId,
            pageNumber: 1,
          ),
        }),
      child: Scaffold(
        backgroundColor: AppColors.primary2,
        body: SafeArea(
          child: Column(
            children: [
               HeaderForMore(title: title,
                textColor: AppColors.white,

              ),
              AppSize.s20.sizedBoxHeight,
              Expanded(
                child: ResponsiveWidgetForTablet(
                    mobile: Column(children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            height: AppReference.deviceWidth(context) * 0.08,
                            width:AppReference.deviceWidth(context) * 0.6,
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor2,
                              borderRadius: BorderRadius.circular(AppConstants.appBorderRadiusR20.responsiveSize),
                              border: Border.all(color: Colors.green, width: 4),
                            ),
                            child: Center(
                              child: Text("دوري تأسيس",style: const AppTextStyle().balooBhaijaan2.w800.bodySmall12.copyWith(
                                  color: AppColors.backgroundColor
                              ),),
                            ),
                          ),
                          Positioned(
                              left: -40,
                              bottom: -16.responsiveHeightRatio,
                              child:SvgPicture.asset(
                                AppImagesAssets.sCrown,
                                height: AppSize.s90.responsiveHeightRatio,))
                        ],
                      ),
                      AppSize.s20.sizedBoxHeight,
                      Expanded(
                        child:
                        BlocBuilder<RankBloc, RankState>(builder: (context, state) {
                          if (state.ranks.isEmpty) {
                            if (state.rankStates == RequestStates.error) {
                              return ErrorWidget(state.rankMessage);
                            } else {
                              return const LoadingShimmerList();
                            }
                          } else {
                            return NotificationListener<ScrollNotification>(
                              onNotification: (notification) {
                                if (notification.metrics.pixels ==
                                    notification.metrics.maxScrollExtent &&
                                    notification is ScrollUpdateNotification &&
                                    !state.isLastPage) {
                                  BlocProvider.of<RankBloc>(context)
                                      .add(switch (rankData.rankType!) {
                                    RankType.classroom => GotUserRankClassroom(
                                      systemID: rankData.systemId,
                                      stageID: rankData.stageId,
                                      classroomID: rankData.classroomId,
                                      pageNumber: BlocProvider.of<RankBloc>(context).nextPage,
                                    ),
                                    RankType.term => GotUserRankTerm(
                                      systemID: rankData.systemId,
                                      stageID: rankData.stageId,
                                      classroomID: rankData.classroomId,
                                      termID: rankData.termId,
                                      pathID: rankData.pathId ?? 0,
                                      pageNumber: BlocProvider.of<RankBloc>(context).nextPage,
                                    ),
                                    RankType.subject => GotUserRankSubject(
                                      systemID: rankData.systemId,
                                      pathID: rankData.pathId ?? 0,
                                      subjectID: rankData.subjectId!,
                                      classroomID: rankData.classroomId,
                                      stageID: rankData.stageId,
                                      termID: rankData.termId,
                                      pageNumber: BlocProvider.of<RankBloc>(context).nextPage,
                                    ),
                                  });
                                }
                                return true;
                              },
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    ListView.separated(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount: state.ranks.length,
                                      separatorBuilder: (context, index) => AppSize.s10.sizedBoxHeight,
                                      itemBuilder: (context, index) {
                                        return RankItemWidget(
                                          name: state.ranks[index].name,
                                          pointCount: state.ranks[index].points,
                                          rank: index + 1,
                                          rankColor: (index < 3) && (state.ranks[index].points > 0)
                                              ? AppColors.primaryColor2
                                              : AppColors.white,
                                          rankColorLabel: (index < 3) && (state.ranks[index].points > 0)
                                              ? AppColors.white:AppColors.textColor,
                                        );
                                      },
                                      //controller: _scrollController,
                                    ),
                                    AppSize.s20.sizedBoxHeight,
                                    if (state.rankStates == RequestStates.loading)...[
                                      const CircularProgressIndicator(),
                                      AppSize.s20.sizedBoxHeight,]
                
                                  ],
                                ),
                              ),
                            );
                          }
                        }),
                      ),
                    ],),
                    tablet: OrientationItem(
                      portraitWidget:Column(children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              height: AppSize.s36.responsiveHeight,
                              width:AppReference.deviceWidth(context) * 0.6,
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor2,
                                borderRadius: BorderRadius.circular(AppConstants.appBorderRadiusR20.responsiveSize),
                                border: Border.all(color: Colors.green, width: 4),
                              ),
                              child: Center(
                                child: Text("دوري تأسيس",style: const AppTextStyle().balooBhaijaan2.w800.bodySmall12.copyWith(
                                    color: AppColors.backgroundColor
                                ),),
                              ),
                            ),
                            Positioned(
                                left: -40,
                                bottom: -16,
                                child:SvgPicture.asset(
                                  AppImagesAssets.sCrown,
                                  height: AppSize.s90.responsiveHeight,))
                          ],
                        ),
                        AppSize.s20.sizedBoxHeight,
                        Expanded(
                          child:
                          BlocBuilder<RankBloc, RankState>(builder: (context, state) {
                            if (state.ranks.isEmpty) {
                              if (state.rankStates == RequestStates.error) {
                                return ErrorWidget(state.rankMessage);
                              } else {
                                return const LoadingShimmerList();
                              }
                            } else {
                              return NotificationListener<ScrollNotification>(
                                onNotification: (notification) {
                                  if (notification.metrics.pixels ==
                                      notification.metrics.maxScrollExtent &&
                                      notification is ScrollUpdateNotification &&
                                      !state.isLastPage) {
                                    BlocProvider.of<RankBloc>(context)
                                        .add(switch (rankData.rankType!) {
                                      RankType.classroom => GotUserRankClassroom(
                                        systemID: rankData.systemId,
                                        stageID: rankData.stageId,
                                        classroomID: rankData.classroomId,
                                        pageNumber: BlocProvider.of<RankBloc>(context).nextPage,
                                      ),
                                      RankType.term => GotUserRankTerm(
                                        systemID: rankData.systemId,
                                        stageID: rankData.stageId,
                                        classroomID: rankData.classroomId,
                                        termID: rankData.termId,
                                        pathID: rankData.pathId ?? 0,
                                        pageNumber: BlocProvider.of<RankBloc>(context).nextPage,
                                      ),
                                      RankType.subject => GotUserRankSubject(
                                        systemID: rankData.systemId,
                                        pathID: rankData.pathId ?? 0,
                                        subjectID: rankData.subjectId!,
                                        classroomID: rankData.classroomId,
                                        stageID: rankData.stageId,
                                        termID: rankData.termId,
                                        pageNumber: BlocProvider.of<RankBloc>(context).nextPage,
                                      ),
                                    });
                                  }
                                  return true;
                                },
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      ListView.separated(
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemCount: state.ranks.length,
                                        separatorBuilder: (context, index) => AppSize.s10.sizedBoxHeight,
                                        itemBuilder: (context, index) {
                                          return RankItemWidget(
                                            name: state.ranks[index].name,
                                            pointCount: state.ranks[index].points,
                                            rank: index + 1,
                                            rankColor: (index < 3) && (state.ranks[index].points > 0)
                                                ? AppColors.primaryColor2
                                                : AppColors.white,
                                            rankColorLabel: (index < 3) && (state.ranks[index].points > 0)
                                                ? AppColors.white:AppColors.textColor,
                                          );
                                        },
                                        //controller: _scrollController,
                                      ),
                                      AppSize.s20.sizedBoxHeight,
                                      if (state.rankStates == RequestStates.loading)...[
                                        const CircularProgressIndicator(),
                                        AppSize.s20.sizedBoxHeight,]

                                    ],
                                  ),
                                ),
                              );
                            }
                          }),
                        ),
                      ],) ,
                      landscapeWidget: SizedBox(
                        width: AppReference.deviceWidth(context) * 0.4,
                        child: Column(children: [
                          SizedBox(
                            width: AppReference.deviceWidth(context) * 0.3,
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  height: AppSize.s70.responsiveHeight,
                                  width:AppReference.deviceWidth(context) * 0.6,
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryColor2,
                                    borderRadius: BorderRadius.circular(AppConstants.appBorderRadiusR20.responsiveSize),
                                    border: Border.all(color: Colors.green, width: 4),
                                  ),
                                  child: Center(
                                    child: Text("دوري تأسيس",style: const AppTextStyle().balooBhaijaan2.w800.bodySmall12.copyWith(
                                        color: AppColors.backgroundColor
                                    ),),
                                  ),
                                ),
                                Positioned(
                                    left: -40,
                                    bottom: -16,
                                    child:SvgPicture.asset(
                                      AppImagesAssets.sCrown,
                                      height: 140.responsiveHeight,))
                              ],
                            ),
                          ),
                          AppSize.s20.sizedBoxHeight,
                          SizedBox(
                            height: AppReference.deviceHeight(context) * 0.65,
                            child: BlocBuilder<RankBloc, RankState>(builder: (context, state) {
                              if (state.ranks.isEmpty) {
                                if (state.rankStates == RequestStates.error) {
                                  return ErrorWidget(state.rankMessage);
                                } else {
                                  return const LoadingShimmerList();
                                }
                              } else {
                                return NotificationListener<ScrollNotification>(
                                  onNotification: (notification) {
                                    if (notification.metrics.pixels ==
                                        notification.metrics.maxScrollExtent &&
                                        notification is ScrollUpdateNotification &&
                                        !state.isLastPage) {
                                      BlocProvider.of<RankBloc>(context)
                                          .add(switch (rankData.rankType!) {
                                        RankType.classroom => GotUserRankClassroom(
                                          systemID: rankData.systemId,
                                          stageID: rankData.stageId,
                                          classroomID: rankData.classroomId,
                                          pageNumber: BlocProvider.of<RankBloc>(context).nextPage,
                                        ),
                                        RankType.term => GotUserRankTerm(
                                          systemID: rankData.systemId,
                                          stageID: rankData.stageId,
                                          classroomID: rankData.classroomId,
                                          termID: rankData.termId,
                                          pathID: rankData.pathId ?? 0,
                                          pageNumber: BlocProvider.of<RankBloc>(context).nextPage,
                                        ),
                                        RankType.subject => GotUserRankSubject(
                                          systemID: rankData.systemId,
                                          pathID: rankData.pathId ?? 0,
                                          subjectID: rankData.subjectId!,
                                          classroomID: rankData.classroomId,
                                          stageID: rankData.stageId,
                                          termID: rankData.termId,
                                          pageNumber: BlocProvider.of<RankBloc>(context).nextPage,
                                        ),
                                      });
                                    }
                                    return true;
                                  },
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        ListView.separated(
                                          shrinkWrap: true,
                                          physics: const NeverScrollableScrollPhysics(),
                                          itemCount: state.ranks.length,
                                          separatorBuilder: (context, index) => AppSize.s10.sizedBoxHeight,
                                          itemBuilder: (context, index) {
                                            return RankItemWidget(
                                              name: state.ranks[index].name,
                                              pointCount: state.ranks[index].points,
                                              rank: index + 1,
                                              rankColor: (index < 3) && (state.ranks[index].points > 0)
                                                  ? AppColors.primaryColor2
                                                  : AppColors.white,
                                              rankColorLabel: (index < 3) && (state.ranks[index].points > 0)
                                                  ? AppColors.white:AppColors.textColor,
                                            );
                                          },
                                          //controller: _scrollController,
                                        ),
                                        AppSize.s20.sizedBoxHeight,
                                        if (state.rankStates == RequestStates.loading)...[
                                          const CircularProgressIndicator(),
                                          AppSize.s20.sizedBoxHeight,]

                                      ],
                                    ),
                                  ),
                                );
                              }
                            }),
                          ),
                        ],),
                      ),
                    )),
              )

            ],
          ),
        ).paddingBody(),
      ),
    );
  }
}