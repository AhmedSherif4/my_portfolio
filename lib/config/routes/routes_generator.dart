import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_portfolio/config/routes/coming_soon.dart';
import 'package:my_portfolio/core/enum/enum_generation.dart';
import 'package:my_portfolio/core/services/services_locator.dart';
import 'package:my_portfolio/core/shared_widget/image_pick/image_pick_view_model/image_pick_bloc.dart';
import 'package:my_portfolio/core/shared_widget/image_zoom.dart';
import 'package:my_portfolio/features/child_flow/challenge_screen/challenge_screen.dart';
import 'package:my_portfolio/features/child_flow/coupons/presentation/coupon_view_model/coupon_event.dart';
import 'package:my_portfolio/features/child_flow/exams/download_upload/data_to_go_upload_exam.dart';
import 'package:my_portfolio/features/child_flow/exams/download_upload/download_upload.dart';
import 'package:my_portfolio/features/child_flow/exams/download_upload/presentation/view_model/download_bloc.dart';
import 'package:my_portfolio/features/child_flow/exams/exams/data_to_go_exams.dart';
import 'package:my_portfolio/features/child_flow/exams/exams/exams.dart';
import 'package:my_portfolio/features/child_flow/home/home.dart';
import 'package:my_portfolio/features/child_flow/questions/collections/collections.dart';
import 'package:my_portfolio/features/child_flow/questions/levels/levels.dart';
import 'package:my_portfolio/features/child_flow/questions/levels/presentation/levels_screen/primary_child_level_screen.dart';
import 'package:my_portfolio/features/child_flow/questions/questions/questions.dart';
import 'package:my_portfolio/features/child_flow/questions/shared/data/go_to_question_parameter.dart';
import 'package:my_portfolio/features/institution_flow/home/presentation/view_model/institution_home_bloc.dart';
import 'package:my_portfolio/features/institution_flow/institutions_parent_details/institutions_parent_details_screen.dart';
import 'package:my_portfolio/features/intro/global/global_view_model/global_bloc.dart';
import 'package:my_portfolio/features/intro/splash/presentation/view/splash_screen.dart';
import 'package:my_portfolio/features/intro/welcome/welcome_screen.dart';
import 'package:my_portfolio/features/parent_flow/parent_child_details/parent_child_details_screen.dart';
import 'package:my_portfolio/features/shared_features/child_subscriptions/presentation/subscriptions_subjects/view/subscriptions_subjects_screen.dart';
import 'package:my_portfolio/features/shared_features/child_subscriptions/presentation/subscriptions_systems_screen/view/data_to_go_random_exams.dart';
import 'package:my_portfolio/features/shared_features/contact_us/presentations/view/contact_us_screen.dart';
import 'package:my_portfolio/features/shared_features/invitation/presentation/view_model/invitation_bloc.dart';
import 'package:my_portfolio/features/shared_features/more/more_view_model/more_bloc.dart';
import 'package:my_portfolio/features/shared_features/notification/presentation/view/notification_manager_screen.dart';
import 'package:my_portfolio/features/shared_features/notification/presentation/view/notification_screen.dart';
import 'package:my_portfolio/features/shared_features/notification/presentation/view/notifications_details_screen/notifications_details_screen.dart';
import 'package:my_portfolio/features/shared_features/notification/presentation/view_model/notification_bloc.dart';
import 'package:my_portfolio/features/shared_features/quran/presentation/quran_screens/quran_page_screen.dart';
import 'package:my_portfolio/features/shared_features/review/presentation/view/review_screen.dart';
import 'package:my_portfolio/features/shared_features/review/presentation/view_model/review_bloc.dart';
import 'package:my_portfolio/features/shared_features/review/presentation/view_model/review_event.dart';
import 'package:my_portfolio/features/shared_features/subscriptions_and_packages/receipt/presentation/receipt_view_model/coupon_bloc.dart';
import '../../core/shared_models/user/data/user_local_data_source/user_local_data_source.dart';
import '../../core/shared_models/user/user_entity/user_entity.dart';
import '../../features/auth/shared_screens/complete_profile_screen/complete_profile_screen.dart';
import '../../features/auth/shared_screens/complete_profile_screen/social_register_view_model/social_register_bloc.dart';
import '../../features/auth/shared_screens/forget_password/forget_password.dart';
import '../../features/auth/shared_screens/login/login.dart';
import '../../features/auth/shared_screens/sign_up/sign_up.dart';
import '../../features/auth/shared_screens/verification/verification.dart';
import '../../features/child_flow/auth/child_add_parent_ways/child_add_parent_ways.dart';
import '../../features/child_flow/auth/exist_parent/child_invite_sent_successfully/child_invite_sent_successfully.dart';
import '../../features/child_flow/auth/grade_choosing/grade_choosing.dart';
import '../../features/child_flow/coupons/presentation/coupon_view_model/coupon_bloc.dart';
import '../../features/child_flow/coupons/presentation/coupons_screen/coupons_screen.dart';
import '../../features/child_flow/exams/random_exams/random_exams.dart';
import '../../features/child_flow/questions/collections/presentation/collections_screen/primary_collections_screen.dart';
import '../../features/child_flow/questions/lessons/lessons.dart';
import '../../features/child_flow/questions/shared/data/go_to_questions_data.dart';
import '../../features/home_layout/home_layout.dart';
import '../../features/institution_flow/add_parent_or_child/add_child/add_child.dart';
import '../../features/institution_flow/add_parent_or_child/add_parent/view/add_parent_screen.dart';
import '../../features/institution_flow/add_parent_or_child/add_parent/view_model/add_parent_bloc.dart';
import '../../features/intro/onboarding/on_boarding.dart';
import '../../features/parent_flow/auth/parent_add_child_ways/parent_add_child_ways.dart';
import '../../features/parent_flow/auth/parent_invite_sent_successfully/parent_invite_sent_successfully.dart';
import '../../features/parent_flow/home/presentation/home_view_model/parent_home_bloc.dart';
import '../../features/shared_features/all_subscriptions/presentation/all_subscription_classroom/view/all_subscription_classroom_screen.dart';
import '../../features/shared_features/all_subscriptions/presentation/all_subscription_classroom/view/all_subscription_subjects_screen.dart';
import '../../features/shared_features/banner/presentation/view_model/banner_bloc.dart';
import '../../features/shared_features/banner/presentation/view_model/banner_event.dart';
import '../../features/shared_features/child_subscriptions/data/models/data_go_to_subscriptions_ques.dart';
import '../../features/shared_features/child_subscriptions/presentation/lesson_or_level/lesson_or_level_screen.dart';
import '../../features/shared_features/child_subscriptions/presentation/subscriptions_systems_screen/view/subscriptions_systems_screen.dart';
import '../../features/shared_features/child_subscriptions/presentation/subscriptions_systems_screen/view_model/subscription_systems_bloc.dart';
import '../../features/shared_features/child_subscriptions/presentation/subscriptions_systems_screen/view_model/subscription_systems_event.dart';
import '../../features/shared_features/contact_us/presentations/view_model/contact_us_bloc.dart';
import '../../features/shared_features/get_social_data/domain/entity/social_login_data_entity.dart';
import '../../features/shared_features/more/child_common_questions/child_common_questions.dart';
import '../../features/shared_features/more/child_settings/child_settings_screen.dart';
import '../../features/shared_features/more/invite_friend/invite_friend_screen.dart';
import '../../features/shared_features/more/parent_preview_for_child/parent_preview_for_child.dart';
import '../../features/shared_features/nafees_plans/nafees_plans.dart';
import '../../features/shared_features/packages_and_subscriptions/cart/domain/entity/cart_entity.dart';
import '../../features/shared_features/packages_and_subscriptions/cart/presentation/view/cart_screen.dart';
import '../../features/shared_features/packages_and_subscriptions/domain/entity/subject_subscriptions_entity.dart';
import '../../features/shared_features/packages_and_subscriptions/ios_review_flow/inapp_purchase_payment.dart';
import '../../features/shared_features/packages_and_subscriptions/ios_review_flow/sub_flow.dart';
import '../../features/shared_features/packages_and_subscriptions/new_subscriptions/new_subscriptions_screen.dart';
import '../../features/shared_features/packages_and_subscriptions/presentation/view_model/packages_and_subscriptions_bloc.dart';
import '../../features/shared_features/packages_and_subscriptions/presentation/view_model/packages_and_subscriptions_event.dart';
import '../../features/shared_features/packages_and_subscriptions/subject_subscriptions/presentation/view/new_subject_subscriptions_screen.dart';
import '../../features/shared_features/payment_successfully_for_nafees_and_simulated/presentation/view/payment_for_nafees_success_screen.dart';
import '../../features/shared_features/payment_successfully_for_nafees_and_simulated/presentation/view/required_data_after_nafees_payment.dart';
import '../../features/shared_features/profile/edit_profile/edit_profile.dart';
import '../../features/shared_features/profile/edit_profile/presentation/view/profile_screen/profile_screen.dart';
import '../../features/shared_features/quran/quran.dart';
import '../../features/shared_features/rank/presentation/rank_screen/rank_data.dart';
import '../../features/shared_features/rank/rank.dart';
import '../../features/shared_features/review/domain/entity/review_entity_outputs.dart';
import '../../features/shared_features/review/presentation/view/review_details/review_details_screen.dart';
import '../../features/shared_features/simulated_plans/simulated_plans.dart';
import '../../features/shared_features/statics/statics.dart';
import '../../features/shared_features/subjects_shared_features/subjects_shared_features.dart';
import '../../features/shared_features/subscriptions_and_packages/data/subject_data.dart';
import '../../features/shared_features/subscriptions_and_packages/free_grade_subscriptions/free_grade_subscriptions.dart';
import '../../features/shared_features/subscriptions_and_packages/free_subjects_subscriptions/free_subjects_subscriptions.dart';
import '../../features/shared_features/subscriptions_and_packages/free_subscriptions/free_subscriptions.dart';
import '../../features/shared_features/subscriptions_and_packages/free_term_subscriptions/free_term_subscriptions.dart';
import '../../features/shared_features/subscriptions_and_packages/receipt/presentation/receipt_screen/required_data_after_payment.dart';
import '../../features/shared_features/subscriptions_and_packages/payment_successfully/presentation/view/payment_success_screen.dart';
import '../../features/shared_features/subscriptions_and_packages/receipt/presentation/receipt_screen/receipt_screen.dart';
import '../../features/shared_features/subscriptions_and_packages/receipt/presentation/receipt_view_model/coupon_event.dart';
import '../../features/shared_features/subscriptions_and_packages/subscription_subjects/view/subscriptions_and_packages_subjects_screen.dart';
import '../../features/shared_features/terms_and_conditions/terms_and_conditions.dart';
import '../../features/shared_features/un_link/un_link.dart';
import '../../features/shared_logic/classrooms_logic/classrooms_logic.dart';
import 'routes_names.dart';
import 'un_defined_route.dart';

class AppRouteGenerator {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutesNames.rSplashScreen:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) {
            return const SplashScreen();
          },
        );
      case AppRoutesNames.rLoginScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<LoginBloc>(),
            child: const LoginScreen(),
          ),
        );

      case AppRoutesNames.rCouponsScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<CouponsBloc>()
              ..add(GetCoupons(
                  childId: getIt<UserLocalDataSource>().getUserData()!.userId)),
            child: const CouponsScreen(),
          ),
        );
      case AppRoutesNames.rWelcome:
        return MaterialPageRoute(
          builder: (_) => const WelcomeScreen(),
        );

      case AppRoutesNames.rSubjectsViewFotStaticsScreen:
        final staticsData = settings.arguments as GetStaticsParam;
        return MaterialPageRoute(
          builder: (_) => SubjectsViewFotStaticsScreen(data: staticsData),
        );
      case AppRoutesNames.rTimeInAppScreen:
        final int childId = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<StaticsBloc>(),
            child: TimeDetailsScreen(
              childId: childId,
            ),
          ),
        );

      case AppRoutesNames.rSignUpScreen:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<SignUpBloc>(),
              ),
              BlocProvider(
                create: (context) => getIt<LoginBloc>(),
              ),
              BlocProvider(
                create: (context) => getIt<VerificationBloc>(),
              ),
              BlocProvider(
                create: (context) =>
                    getIt<ContactUsBloc>()..add(GetContactUsEvent()),
              ),
            ],
            child: const SignUpScreen(),
          ),
        );
      case AppRoutesNames.rForgotPasswordScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<ForgetPasswordBloc>(),
            child: const ForgetPasswordScreen(),
          ),
        );
      case AppRoutesNames.rOnBoardingScreen:
        return MaterialPageRoute(
          builder: (_) => const OnBoardingScreen(),
        );
      case AppRoutesNames.rVerificationScreen:
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<VerificationBloc>(),
            child: VerificationScreen(
              arguments: arguments,
            ),
          ),
        );
      case AppRoutesNames.rGradeChoosingScreen:
        final bool fromUpdateData = settings.arguments as bool;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) =>
                getIt<GradeChoosingBloc>()..add(GetSystemEvent()),
            child: GradeChoosingScreen(fromUpdateData: fromUpdateData),
          ),
        );
      case AppRoutesNames.rParentAddChildWays:
        return MaterialPageRoute(
          builder: (_) => const ParentAddChildWays(),
        );
      case AppRoutesNames.rChildAddParentWays:
        final fromParentsScreen = settings.arguments as bool;
        return MaterialPageRoute(
          builder: (_) =>
              ChildAddParentWays(fromParentsScreen: fromParentsScreen),
        );
      case AppRoutesNames.rParentAddExistChildScreen:
        final String? username = settings.arguments as String?;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<UnLinkBloc>(),
            child:  ParentAddExistChildScreen(username: username),
          ),
        );

      case AppRoutesNames.rParentAddNewChildScreen:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<UnLinkBloc>(),
              ),
              BlocProvider(
                create: (context) => getIt<GradeChoosingBloc>(),
              ),
            ],
            child: const ParentAddNewChildScreen(),
          ),
        );

      case AppRoutesNames.rComingSoon:
        return MaterialPageRoute(
          builder: (_) => const ComingSoon(),
        );

      case AppRoutesNames.rParentInviteSentSuccessfully:
        final String discountMessage = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) =>
              ParentInviteSentSuccessfully(discountMessage: discountMessage),
        );
      case AppRoutesNames.rCompleteProfileScreen:
        SocialLoginDataEntity arguments =
            settings.arguments as SocialLoginDataEntity;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<SocialRegisterBloc>(),
            child:
                CompleteProfileScreen(socialLoginDataEntity: arguments),
          ),
        );
      case AppRoutesNames.rChildAddExistParentScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<UnLinkBloc>(),
            child: const ChildAddExistParentScreen(),
          ),
        );
      case AppRoutesNames.rChildInviteSentSuccessfully:
        return MaterialPageRoute(
          builder: (_) => const ChildInviteSentSuccessfully(),
        );
      case AppRoutesNames.rChildAddNewParentScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => getIt<UnLinkBloc>(),
                  child: const ChildAddNewParentScreen(),
                ));

      case AppRoutesNames.rLevelStaticsScreen:
        final levelParameters = settings.arguments as GetStaticsParam;
        return MaterialPageRoute(
          builder: (_) => LevelStaticsScreen(levelParameters: levelParameters),
        );

      case AppRoutesNames.rFailsSkillsScreen:
        final GetFailsSkillsWithQuestionsParameters skillsParameters =
            settings.arguments as GetFailsSkillsWithQuestionsParameters;
        return MaterialPageRoute(
          builder: (_) =>
              FailsSkillsScreen(subjectsAndChildId: skillsParameters),
        );

      case AppRoutesNames.rFailsSuccessSkillsScreen:
        final skillsParameters =
            settings.arguments as GetFailsSkillsWithQuestionsParameters;
        return MaterialPageRoute(
          builder: (_) =>
              FailSuccessSkillsScreen(getFailsSkillsWithQuestionsParameters: skillsParameters),
        );

      case AppRoutesNames.rSkillsQuestionScreen:
        final GetFailsSkillsWithQuestionsParameters questionsFails = settings.arguments as GetFailsSkillsWithQuestionsParameters;
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
  providers: [
    BlocProvider(
            create: (context) => getIt<SkillStaticsBloc>(),),

  ],
  child: SkillsQuestionScreen(getFailsSkillsWithQuestionsParameters: questionsFails,),
),
        );



      case AppRoutesNames.rStaticsScreen:
        final staticsParm = settings.arguments as GetStaticsParam;
        return MaterialPageRoute(
          builder: (_) => StaticsScreen(getStaticsParam: staticsParm),
        );

      case AppRoutesNames.rMyPointsDetailsScreen:
        return MaterialPageRoute(
          builder: (_) => const MyPointsDetailsScreen(),
        );

      case AppRoutesNames.rInviteFriendScreen:
        return MaterialPageRoute(
          builder: (_) => const InviteFriendScreen(),
        );

      case AppRoutesNames.rHomeLayoutView:
        final UserEntity userData = getIt<UserLocalDataSource>().getUserData()!;
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<EditProfileBloc>(),
              ),
              BlocProvider(
                create: (context) => getIt<PackagesAndSubscriptionsBloc>(),
              ),
              BlocProvider(
                create: (context) => getIt<HomeLayoutBloc>()
                  ..add(
                    GetUserTypeEvent(
                        userType: userData.type,
                        inReview: BlocProvider.of<GlobalBloc>(context).state.appVersionModel.appVersion !=2
                    ),
                  ),
              ),
              if (userData.type != UsersType.child.name)
                BlocProvider(
                  create: (context) => getIt<NotificationBloc>()
                    ..add(
                      const GetAllNotificationEvent(pageNumber: 1),
                    ),
                ),
              if (userData.type == UsersType.parent.name)
                BlocProvider(
                  create: (context) => getIt<ParentHomeBloc>()
                    ..add(
                      const GetAllChildForParentEvent(),
                    ),
                ),
              if (userData.type == UsersType.institution.name)
                BlocProvider(
                  create: (context) => getIt<InstitutionHomeBloc>()
                    ..add(
                      GetAllParentsForInstitutionEvent(),
                    ),
                ),
              if (userData.type == UsersType.child.name) ...[
                BlocProvider(
                    create: (_) => getIt<HomeBloc>()
                      ..add(const GotPuzzleAndAdviceEvent())),
                BlocProvider(
                  create: (context) => getIt<SharedSubjectsBloc>()
                    ..add(
                      GetSharedSubjectsEvent(
                        parameter: ParameterGoToQuestions(
                            systemId: userData.systemId ?? 0,
                            stageId: userData.stageId!,
                            classRoomId: userData.classroomId!,
                            termId: userData.termId!,
                            pathId: userData.pathId ?? 0,
                            subjectType: SubjectType.public),
                      ),
                    ),
                ),
              ],
              if (userData.type == UsersType.child.name)
                BlocProvider(
                  create: (context) => getIt<StaticsBloc>()
                    ..add(GetTimeInAppEvent(
                      timeInAppInputs: TimeInAppInputs(
                        startDate: DateTime.now(),
                        endDate:
                            DateTime.now().subtract(const Duration(days: 1)),
                        childId: userData.userId,
                      ),
                    ))
                    ..add(GetBestSubjectsEvent(
                        bestSubjectsParm: GetStaticsParam(
                      systemId: userData.systemId!,
                      stageId: userData.stageId!,
                      classRoomId: userData.classroomId!,
                      termId: userData.termId!,
                      pathId: userData.pathId,
                    ))),
                ),
              BlocProvider(
                  create: (context) => getIt<GradeChoosingBloc>()
                    ..add(GetSystemEvent())
                   ),
              BlocProvider(
                create: (context) => getIt<BannerBloc>()..add(GetBannerEvent()),
              ),
              BlocProvider(
                create: (context) => getIt<InvitationBloc>(),
              ),
              BlocProvider(
                create: (context) => getIt<MoreBloc>(),
              ),
            ],
            child: const HomeLayoutView(),
          ),
        );
      case AppRoutesNames.rLessonScreen:
        final DataToGoQuestions subjectIdAndIsPrimary =
            settings.arguments as DataToGoQuestions;
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) {
            return LessonsScreen(
              data: subjectIdAndIsPrimary,
            );
          },
        );

      case AppRoutesNames.rPrimaryLevelScreen:
        final DataToGoQuestions levelParameter =
            settings.arguments as DataToGoQuestions;
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) {
            return PrimaryChildLevelsScreen(
              data: levelParameter,
            );
          },
        );

      case AppRoutesNames.rChildLevelScreen:
        final DataToGoQuestions data = settings.arguments as DataToGoQuestions;
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) {
            return ChildLevelsScreen(
              data: data,
            );
          },
        );

      case AppRoutesNames.rSubjectsSubscriptionScreen:
        final getSubjectParameters = settings.arguments as GoToSubjectData;
        return MaterialPageRoute(
          builder: (_) =>
              SubjectsSubscriptionScreen(goToSubjectData: getSubjectParameters),
        );
      case AppRoutesNames.rPaymentSuccessScreen:
        final paymentData = settings.arguments as RequiredDataAfterPayment;
        return MaterialPageRoute(
          builder: (_) => PaymentSuccessScreen(paymentData: paymentData),
        );


      case AppRoutesNames.rPaymentSuccessForNafeesScreen:
        final paymentData = settings.arguments as RequiredDataAfterNafeesPayment;
        return MaterialPageRoute(
          builder: (_) => PaymentSuccessForNafeesScreen(paymentData: paymentData),
        );

      case AppRoutesNames.rFreeSubscriptionsScreen:
        final userData = settings.arguments as UserEntity;
        return MaterialPageRoute(
          builder: (_) => FreeSubscriptionsScreen(userData: userData),
        );
      case AppRoutesNames.rFreeGradeSubscriptionsScreen:
        final userData = settings.arguments as UserEntity;

        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<FreeGradeSubscriptionsBloc>()
              ..add(const GetSystemsFreeGrade()),
            child: FreeGradeSubscriptionsScreen(userData: userData),
          ),
        );
      case AppRoutesNames.rCartScreen:
        final childData = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) =>
                    getIt<CouponBloc>()..add(const GetPaymentDataEvent()),
              ),
              BlocProvider(
                create: (context) => getIt<PackagesAndSubscriptionsBloc>(),
              ),
              BlocProvider.value(
                value:getIt<HomeLayoutBloc>(),
              ),
            ],
            child: CartScreen(userID: childData),
          ),
        );
      case AppRoutesNames.rReceiptScreen:
        final cartData = settings.arguments as CartEntity;
        return MaterialPageRoute(
          builder: (_) => CouponScreen(cartData: cartData),
        );

      case AppRoutesNames.rInAppPurchasePayment:
        final ClassroomForCartEntity classroomForCartEntity = settings.arguments as ClassroomForCartEntity;
        return MaterialPageRoute(
        builder: (_)=>
          InAppPurchasePayment(classroomForCartEntity),
        );

      case AppRoutesNames.rSubFLow:
        return MaterialPageRoute(
        builder: (_)=>
          const SubFLow(),
        );

      case AppRoutesNames.rFreeTermSubscriptionsScreen:
        final userData = settings.arguments as UserEntity;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<FreeTermSubscriptionsBloc>()
              ..add(const GetSystemFreeTermSubscriptionsEvent()),
            child: FreeTermSubscriptionsScreen(userData: userData),
          ),
        );
      case AppRoutesNames.rFreeSubjectsSubscriptionsScreen:
        final userData = settings.arguments as UserEntity;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<FreeSubjectsSubscriptionsBloc>()
              ..add(const GetSystemFreeSubjectsEvent()),
            child: FreeSubjectsSubscriptionsScreen(userData: userData),
          ),
        );


      case AppRoutesNames.rUpdateNotificationScreen:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) {
            return BlocProvider.value(
              value: getIt<NotificationBloc>(),
              child: const NotificationManagerScreen(),
            );
          },
        );

      case AppRoutesNames.rNotificationDetailsScreen:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) {
            return const NotificationsDetailsScreen();
          },
        );

      case AppRoutesNames.rReviewDetailsScreen:
        final ReviewEntityOutputs reviewEntityOutputs =
            settings.arguments as ReviewEntityOutputs;
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) {
            return BlocProvider(
              create: (context) => getIt<ReviewBloc>(),
              child: ReviewDetailsScreen(
                reviewEntityOutputs: reviewEntityOutputs,
              ),
            );
          },
        );

      case AppRoutesNames.rRankScreen:
        final rankData = settings.arguments as RankData;
        return MaterialPageRoute(
            builder: (_) => RankScreen(rankData: rankData));

      case AppRoutesNames.rReviewScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (context) => getIt<ReviewBloc>()
                  ..add(
                    GetAllReviewDataEvent(),
                  ),
                child: const ReviewScreen()));

      case AppRoutesNames.rNotificationScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => getIt<NotificationBloc>()
                    ..add(
                      const GetAllNotificationEvent(pageNumber: 1),
                    )
                    ..add(ReadAllNotificationEvent()),
                  child: const NotificationScreen(),
                ));
      case AppRoutesNames.rChildHomeScreen:
        return MaterialPageRoute(builder: (_) => const AllChildHomeScreen());
      case AppRoutesNames.rInstitutionAddParentScreen:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<AddParentBloc>(),
              ),
              BlocProvider(
                create: (context) => getIt<SignUpBloc>(),
              ),
              BlocProvider(
                create: (context) => getIt<ImagePickBloc>(),
              ),
            ],
            child: const InstitutionAddParentScreen(),
          ),
        );
      case AppRoutesNames.rInstitutionAddChildScreen:
        final parentId = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<InstitutionAddChildBloc>(),
              ),
              BlocProvider(
                create: (context) => getIt<SignUpBloc>(),
              ),
              BlocProvider(
                create: (context) => getIt<ImagePickBloc>(),
              ),
              BlocProvider(
                create: (context) =>
                    getIt<GradeChoosingBloc>()..add(GetSystemEvent()),
              ),
            ],
            child: InstitutionAddChildScreen(
              parentId: parentId,
            ),
          ),
        );
      case AppRoutesNames.rPrimaryCollectionsScreen:
        final parameter = settings.arguments as DataToGoQuestions;
        return MaterialPageRoute(
          builder: (_) => PrimaryCollectionsScreen(data: parameter),
        );
      case AppRoutesNames.rChildCollectionsScreen:
        final parameter = settings.arguments as DataToGoQuestions;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<LevelsBloc>(),
            child: ChildCollectionsScreen(data: parameter),
          ),
        );
      case AppRoutesNames.rQuestionsScreen:
        final DataToGoQuestions data = settings.arguments as DataToGoQuestions;
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<QuestionsBloc>()
                  ..add(
                    GetQuestions(
                      ParameterGoToQuestions(
                        stageId: data.stageId,
                        classRoomId: data.classRoomId,
                        termId: data.termId,
                        isGeneralQuestion: data.isGeneralQuestions,
                        groupId: data.groupId,
                        lessonId: data.lessonId,
                        levelId: data.levelId,
                        subjectId: data.subjectId,
                        systemId: data.systemId,
                        pathId: data.pathId,
                      ).copyWith(isFromNafees: data.isFromNafees),
                    ),
                  ),
              ),
              BlocProvider(
                create: (context) => getIt<LessonsBloc>(),
              ),
              BlocProvider(
                create: (context) => getIt<CollectionsBloc>(),
              ),
            ],
            child: QuestionsScreen(data: data),
          ),
        );

      case AppRoutesNames.rPrimaryChildChallengeScreen:
        DataToGoExams arguments = settings.arguments as DataToGoExams;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<SharedSubjectsBloc>()
              ..add(
                GetSharedSubjectsEvent(
                  parameter: ParameterGoToQuestions(
                    subjectType: SubjectType.subscriptions,
                    systemId: arguments.user.systemId!,
                    stageId: arguments.user.stageId!,
                    termId: arguments.termId ?? arguments.user.termId!,
                    pathId: arguments.pathId ?? arguments.user.pathId ?? 0,
                    classRoomId: arguments.user.classroomId!,
                  ),
                ),
              ),
            child: PrimaryChildChallengeScreen(
              dataToGoExams: arguments,
            ),
          ),
        );

      case AppRoutesNames.rRandomQuestionScreen:
        DataToGoExams arguments =
            settings.arguments as DataToGoExams;
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: getIt<RandomExamsBloc>()),
              BlocProvider(
                  create: (context) => getIt<SharedSubjectsBloc>()
                    ..add(GetSharedSubjectsEvent(
                        parameter: ParameterGoToQuestions(
                      systemId:
                          getIt<UserLocalDataSource>().getUserData()!.systemId!,
                      stageId:
                          getIt<UserLocalDataSource>().getUserData()!.stageId!,
                      classRoomId: getIt<UserLocalDataSource>()
                          .getUserData()!
                          .classroomId!,
                      termId:
                          getIt<UserLocalDataSource>().getUserData()!.termId!,
                    )))),
              // create: (context) => getIt<RandomExamsBloc>()),
            ],
            child: RandomQuestionScreen(
              dataToGoExams: arguments,
            ),
          ),
        );

      case AppRoutesNames.rPrimaryChildRandomExamsScreen:
        DataToGoExams arguments = settings.arguments as DataToGoExams;
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => getIt<SharedSubjectsBloc>()),
              BlocProvider(
                  create: (context) => getIt<RandomExamsBloc>()
                    ..add(GetAllRandomExamsOfThatSubject(
                        allRandomExamInputs: AllRandomExamInputs(
                          subjectId: arguments.subjects[0].subjectId,
                          childId: arguments.user.userId,
                        ),
                        selectedIndex: 0))),
            ],
            child: PrimaryChildRandomExamsScreen(
              dataToGoExams: arguments,
            ),
          ),
        );

      case AppRoutesNames.rRepeatQuestionScreen:
        DataToGoExams dataToGoExams = settings.arguments as DataToGoExams;
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: (context) => getIt<RandomExamsBloc>()
                    ..add(RepeatRandomExamsOfThatSubject(examId: dataToGoExams.examId!))),
              BlocProvider(
                  create: (context) => getIt<SharedSubjectsBloc>()
                    ..add(GetSharedSubjectsEvent(
                        parameter: ParameterGoToQuestions(
                      systemId:
                          getIt<UserLocalDataSource>().getUserData()!.systemId!,
                      stageId:
                          getIt<UserLocalDataSource>().getUserData()!.stageId!,
                      classRoomId: getIt<UserLocalDataSource>()
                          .getUserData()!
                          .classroomId!,
                      termId:
                          getIt<UserLocalDataSource>().getUserData()!.termId!,
                    )))),
            ],
            child: RepeatQuestionScreen(
              dataToGoExams: dataToGoExams,
            ),
          ),
        );

      case AppRoutesNames.rChildRandomExamsScreen:
        DataToGoExams arguments = settings.arguments as DataToGoExams;
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => getIt<SharedSubjectsBloc>()),
              BlocProvider(
                  create: (context) => getIt<RandomExamsBloc>()
                    ..add(GetAllRandomExamsOfThatSubject(
                        allRandomExamInputs: AllRandomExamInputs(
                          subjectId: arguments.subjects[0].subjectId,
                          childId: arguments.user.userId,
                        ),
                        selectedIndex: 0))),
            ],
            child: ChildRandomExamsScreen(
              dataToGoExams: arguments,
            ),
          ),
        );

      case AppRoutesNames.rChildChallengeScreen:
        DataToGoExams arguments = settings.arguments as DataToGoExams;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<SharedSubjectsBloc>()
              ..add(
                GetSharedSubjectsEvent(
                  parameter: ParameterGoToQuestions(
                    subjectType: SubjectType.subscriptions,
                    systemId: arguments.user.systemId!,
                    stageId: arguments.user.stageId!,
                    termId: arguments.termId ?? arguments.user.termId!,
                    pathId: arguments.pathId ?? arguments.user.pathId ?? 0,
                    classRoomId: arguments.user.classroomId!,
                  ),
                ),
              ),
            child: ChildChallengeScreen(
              dataToGoExams: arguments,
            ),
          ),
        );

      // case AppRoutesNames.rInAppPurchasePayment:
      //   final ClassroomForCartEntity classroomForCartEntity =
      //       settings.arguments as ClassroomForCartEntity;
      //   return MaterialPageRoute(
      //     builder: (_) => InAppPurchasePayment(classroomForCartEntity),
      //   );
      //
      // case AppRoutesNames.rSubFLow:
      //   return MaterialPageRoute(
      //     builder: (_) => SubFLow(),
      //   );

      case AppRoutesNames.rChildExamsScreen:
        DataToGoExams arguments = settings.arguments as DataToGoExams;
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) {
                if (arguments.subjects.isNotEmpty) {
                  return getIt<ExamsBloc>()
                    ..add(
                      GetExamsOfThatSubject(
                        systemId: arguments.user.systemId!,
                        subjectId: arguments.subjects[0].subjectId,
                        stageId: arguments.user.stageId!,
                        termId: arguments.user.termId!,
                        classroomId: arguments.user.classroomId!,
                        selectedIndex: 0,
                        pathId: arguments.user.pathId,
                      ),
                    );
                } else {
                  return getIt<ExamsBloc>();
                }
              }),
            ],
            child: ChildExamsScreen(
              dataToGoExams: arguments,
            ),
          ),
        );

      case AppRoutesNames.rChildDownloadUploadScreen:
        DataToGoUploadExam arguments = settings.arguments as DataToGoUploadExam;
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<DownloadUploadBloc>(),
              ),
              BlocProvider(
                create: (context) => getIt<DownloadBloc>(),
              ),
            ],
            child: ChildDownloadUploadScreen(
              dataToGoUploadScreen: arguments,
            ),
          ),
        );
      case AppRoutesNames.rChildAccountDetailsScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<EditProfileBloc>(),
            child: const ChildAccountDetailsScreen(),
          ),
        );
      case AppRoutesNames.rChildSettingsScreen:
        return MaterialPageRoute(
          builder: (_) =>  BlocProvider(
  create: (context) => getIt<MoreBloc>(),
  child: const ChildSettingsScreen(),
),
        );

      case AppRoutesNames.rChildCommonQuestionsScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<ChildCommonQuestionsBloc>()
              ..add(
                GetAllChildCommonQuestionsEvent(),
              ),
            child: const ChildCommonQuestionsScreen(),
          ),
        );
      case AppRoutesNames.rChangePasswordScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<EditProfileBloc>(),
            child: const ChangePasswordScreen(),
          ),
        );
      case AppRoutesNames.rParentPreviewForChildScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<ParentPreviewForChildBloc>(),
            child: const ParentPreviewForChildScreen(),
          ),
        );

      case AppRoutesNames.rContactUsScreen:
        return MaterialPageRoute(builder: (_) => const ContactUsScreen());

      case AppRoutesNames.rSubscriptionsSystemsScreen:
        final DataToGoRandomExams? dataToGoRandomExams = settings.arguments as DataToGoRandomExams?;
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => getIt<SubscriptionSystemsBloc>()
                        ..add(GetSystemsEvent(
                          childId: dataToGoRandomExams!.user.userId,
                          userEntity: dataToGoRandomExams.user,
                        )),
                    ),
                    BlocProvider(
                      create: (context) => getIt<SharedSubjectsBloc>(),
                    ),
                  ],
                  child: SubscriptionsSystemsScreen(
                    dataToGoRandomExams: dataToGoRandomExams,
                  ),
                ));

      case AppRoutesNames.rSubscriptionsSubjectsScreen:
        final DataGoToSubscriptionsQuestions data =
            settings.arguments as DataGoToSubscriptionsQuestions;
        return MaterialPageRoute(
            builder: (_) => SubscriptionsSubjectsScreen(data: data));

      case AppRoutesNames.rTermsAndConditionsScreen:
        return MaterialPageRoute(
            builder: (_) => const TermsAndConditionsScreen());

      case AppRoutesNames.rLessonOrLevelScreen:
        final DataToGoQuestions data = settings.arguments as DataToGoQuestions;
        return MaterialPageRoute(
            builder: (_) => LessonOrExamsScreen(data: data));

      case AppRoutesNames.rEditProfileScreen:
        final DataToGoToEditProfileScreen data =
            settings.arguments as DataToGoToEditProfileScreen;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<EditProfileBloc>(),
            child: EditProfileScreen(data: data),
          ),
        );

      case AppRoutesNames.rNewSubscriptionsScreen:
        final UserEntity? childId = settings.arguments as UserEntity?;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) =>
                      getIt<GradeChoosingBloc>()..add(GetSystemEvent()),
                  child: NewSubscriptionsScreen(
                    childData: childId,
                  ),
                ));

      case AppRoutesNames.rTermSubscriptionsScreen:
        final SubjectSubscriptionsInputs data =
            settings.arguments as SubjectSubscriptionsInputs;
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider(
                        create: (context) =>
                            getIt<PackagesAndSubscriptionsBloc>()
                              ..add(
                                GetSubjectSubscriptionsDataEvent(
                                    SubjectSubscriptionsInputs(
                                  classRoomId: data.classRoomId,
                                  pathId: data.pathId,
                                  childId: data.childId,
                                )),
                              )),
                  ],
                  child: TermSubscriptionsScreen(
                    data: data,
                  ),
                ));

      //Institutions Flow
      case AppRoutesNames.rInstitutionsParentDetails:
        final parentData = settings.arguments as UserEntity;
        return MaterialPageRoute(
            builder: (_) => InstitutionParentDetailsScreen(
                  userData: parentData,
                ));

      //Parent Flow

      case AppRoutesNames.rParentChildDetails:
        final childData = settings.arguments as UserEntity;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => getIt<SharedSubjectsBloc>()
                    ..add(GetSharedSubjectsEvent(
                        parameter: ParameterGoToQuestions(
                      systemId: childData.systemId!,
                      stageId: childData.stageId!,
                      classRoomId: childData.classroomId!,
                      termId: childData.termId!,
                      subjectType: SubjectType.subscriptions,
                      // isChild: false,
                      userId: childData.userId,
                    ))),
                  child: ParentChildDetailsScreen(
                    childData: childData,
                  ),
                ));

      //Shared Flow

      case AppRoutesNames.rAllSubscriptionClassroomScreen:
        final userData = settings.arguments as UserEntity;
        return MaterialPageRoute(
            builder: (_) => AllSubscriptionClassroomScreen(
                  userData: userData,
                ));

      case AppRoutesNames.rAllSubscriptionSubjectScreen:
        final subscriptionIds = settings.arguments as ParameterGoToQuestions;
        return MaterialPageRoute(
            builder: (_) => AllSubscriptionSubjectScreen(
                  subscriptionIds: subscriptionIds,
                ));

      case AppRoutesNames.rZoomImage:
        final widget = settings.arguments as MyPopImage;
        return MaterialPageRoute(
            builder: (_) => ZoomImageWidget(
                  widget: widget,
                ));

      //Nafees Flow
      case AppRoutesNames.rNafeesPlanScreen:
        final int childId = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => NafeesPlanScreen(
            childId: childId,
          ),
        );

      case AppRoutesNames.rNafeesSubjectScreen:
        final NafeesSubjectData data = settings.arguments as NafeesSubjectData;
        return MaterialPageRoute(
          builder: (_) =>  NafeesSubjectScreen(
            nafeesSubjectData: data,
          ),
        );

      case AppRoutesNames.rNafeesLessonScreen:
        return MaterialPageRoute(
          builder: (_) => NafeesLessonScreen(),
        );

        case AppRoutesNames.rNafeeseExamsScreen:
          final NafeesSubjectData data = settings.arguments as NafeesSubjectData;
          return MaterialPageRoute(
          builder: (_) =>  NafeeseExamsScreen(
            nafeesSubjectData: data,
          ),
        );

      case AppRoutesNames.rNafeesQuestionScreen:
        final NafeesSubjectData data = settings.arguments as NafeesSubjectData;
        return MaterialPageRoute(
          builder: (_) =>  BlocProvider.value(
  value: getIt<NafeesBloc>(),
  child: NafeesQuestionScreen(
    nafeesSubjectData: data,
          ),
),
        );
        
        case AppRoutesNames.rNafeesAnswerBuildScreen:
       final NafeesExamResults data = settings.arguments as NafeesExamResults;
        return MaterialPageRoute(
          builder: (_) =>  BlocProvider.value(
  value: getIt<NafeesBloc>()..add(GetNafeesModelAnswersEvent(modelId: data.id)),
  child: AnswerBuild(
    nafeesExamResults: data,
  ),
),
        );

        case AppRoutesNames.rSimulatedExamsScreen:
          final int childId = settings.arguments as int;
          return MaterialPageRoute(
          builder: (_) =>  BlocProvider(
            create: (context) => getIt<SimulatedBloc>()..add(GetSimulatedPlansEvent(childId: childId)),
  child: SimulatedCategoriesScreen(
            childId: childId,
          ),
),
        );

      case AppRoutesNames.rNafeesStaticsScreen:
        return MaterialPageRoute(
          builder: (_) => NafeesStaticsScreen(),
        );

      case AppRoutesNames.rSimulatedPlanScreen:
        final SimulatedSubjectData data = settings.arguments as SimulatedSubjectData;
        return MaterialPageRoute(
          builder: (_) => SimulatedPlanScreen(
            simulatedSubjectData: data,
          ),
        );

      case AppRoutesNames.rSimulatedSubjectScreen:
        final SimulatedSubjectData data = settings.arguments as SimulatedSubjectData;
        return MaterialPageRoute(
          builder: (_) =>  SimulatedSubjectScreen(
            simulatedSubjectData: data,
          ),
        );


      case AppRoutesNames.rSimulatedeExamsScreen:
        final SimulatedSubjectData data = settings.arguments as SimulatedSubjectData;
        return MaterialPageRoute(
          builder: (_) =>  SimulatedExamsScreen(
            simulatedSubjectData: data,
          ),
        );

      case AppRoutesNames.rSimulatedQuestionScreen:
        final SimulatedSubjectData data = settings.arguments as SimulatedSubjectData;
        return MaterialPageRoute(
          builder: (_) =>  BlocProvider.value(
            value: getIt<SimulatedBloc>(),
            child: SimulatedQuestionScreen(
              simulatedSubjectData: data,
            ),
          ),
        );

      case AppRoutesNames.rSimulatedAnswerBuildScreen:
        final SimulatedExamResults data = settings.arguments as SimulatedExamResults;
        return MaterialPageRoute(
          builder: (_) =>  BlocProvider.value(
            value: getIt<SimulatedBloc>()..add(GetSimulatedModelAnswersEvent(modelId: data.id)),
            child: SimulatedAnswerBuild(
              simulatedExamResults: data,
            ),
          ),
        );
      case AppRoutesNames.rJuzScreen:
        return MaterialPageRoute(
          builder: (_) => const JuzScreen(),
        );
      case AppRoutesNames.rSurahScreen:
        final typeOfSelection = settings.arguments as TypeOfSelection;
        return MaterialPageRoute(
          builder: (_) => SurahScreen(
            typeOfSelection: typeOfSelection,
          ),
        );
      case AppRoutesNames.rQuranViewScreen:
        final QuranParameter data = settings.arguments as QuranParameter;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<QuranBloc>()
              ..add(GetQuranAudioEvent(quranParameter: data)),
            child: QuranViewScreen(data: data),
          ),
        );
      case AppRoutesNames.rQuranPageScreen:
        final pageNumber = settings.arguments as int;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => getIt<QuranBloc>()
                    ..add(
                      GetQuranPageEvent(
                        pageNumber: pageNumber,
                      ),
                    ),
                  child: QuranPageScreen(
                    pageNumber: pageNumber,
                  ),
                ));
      default:
        return unDefinedRoute();
    }
  }
}
