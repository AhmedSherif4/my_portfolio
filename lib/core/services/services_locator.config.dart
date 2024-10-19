// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i973;
import 'package:my_portfolio/config/base_local_data_source/base_local_data_source.dart'
    as _i616;
import 'package:my_portfolio/config/base_remote_data_source/base_remote_data_source.dart'
    as _i69;
import 'package:my_portfolio/config/base_repository/base_repository.dart'
    as _i499;
import 'package:my_portfolio/config/notification/notification_setup.dart'
    as _i676;
import 'package:my_portfolio/config/storages/secure_storage.dart' as _i742;
import 'package:my_portfolio/core/api/api_consumer.dart' as _i568;
import 'package:my_portfolio/core/api/dio_consumer.dart' as _i344;
import 'package:my_portfolio/core/api/interceptors.dart' as _i419;
import 'package:my_portfolio/core/api/network_info.dart' as _i571;
import 'package:my_portfolio/core/services/third_party_instance.dart' as _i139;
import 'package:my_portfolio/core/shared_models/user/data/user_local_data_source/user_local_data_source.dart'
    as _i850;
import 'package:my_portfolio/core/shared_widget/image_pick/image_pick_view_model/image_pick_bloc.dart'
    as _i941;
import 'package:my_portfolio/features/auth/shared_screens/complete_profile_screen/data/social_register_data_source/social_register_remote_data_source.dart'
    as _i353;
import 'package:my_portfolio/features/auth/shared_screens/complete_profile_screen/data/social_registetr_repository/social_register_repository.dart'
    as _i870;
import 'package:my_portfolio/features/auth/shared_screens/complete_profile_screen/domain/social_register_base_repository/social_register_base_repository.dart'
    as _i614;
import 'package:my_portfolio/features/auth/shared_screens/complete_profile_screen/domain/social_register_usecases/social_register_usecase.dart'
    as _i793;
import 'package:my_portfolio/features/auth/shared_screens/complete_profile_screen/social_register_view_model/social_register_bloc.dart'
    as _i908;
import 'package:my_portfolio/features/auth/shared_screens/forget_password/forget_password.dart'
    as _i711;
import 'package:my_portfolio/features/auth/shared_screens/login/domain/login_usecases/social_login_use_case.dart'
    as _i23;
import 'package:my_portfolio/features/auth/shared_screens/login/login.dart'
    as _i990;
import 'package:my_portfolio/features/auth/shared_screens/sign_up/sign_up.dart'
    as _i592;
import 'package:my_portfolio/features/auth/shared_screens/verification/verification.dart'
    as _i608;
import 'package:my_portfolio/features/child_flow/coupons/data/coupon_data_source/coupon_remote_data_source.dart'
    as _i71;
import 'package:my_portfolio/features/child_flow/coupons/data/coupon_repository/coupon_repository.dart'
    as _i1042;
import 'package:my_portfolio/features/child_flow/coupons/domain/coupon_base_repository/coupon_base_repository.dart'
    as _i140;
import 'package:my_portfolio/features/child_flow/coupons/domain/coupon_usecases/coupon_usecase.dart'
    as _i282;
import 'package:my_portfolio/features/child_flow/coupons/presentation/coupon_view_model/coupon_bloc.dart'
    as _i660;
import 'package:my_portfolio/features/child_flow/exams/download_upload/download_upload.dart'
    as _i712;
import 'package:my_portfolio/features/child_flow/exams/download_upload/presentation/view_model/download_bloc.dart'
    as _i13;
import 'package:my_portfolio/features/child_flow/exams/exams/exams.dart'
    as _i685;
import 'package:my_portfolio/features/child_flow/exams/random_exams/random_exams.dart'
    as _i211;
import 'package:my_portfolio/features/child_flow/home/data/home_data_source/home_local_data_source.dart'
    as _i707;
import 'package:my_portfolio/features/child_flow/home/home.dart' as _i277;
import 'package:my_portfolio/features/child_flow/questions/collections/collections.dart'
    as _i551;
import 'package:my_portfolio/features/child_flow/questions/lessons/lessons.dart'
    as _i528;
import 'package:my_portfolio/features/child_flow/questions/levels/levels.dart'
    as _i935;
import 'package:my_portfolio/features/child_flow/questions/questions/questions.dart'
    as _i926;
import 'package:my_portfolio/features/home_layout/home_layout.dart' as _i476;
import 'package:my_portfolio/features/institution_flow/add_parent_or_child/add_child/add_child.dart'
    as _i744;
import 'package:my_portfolio/features/institution_flow/add_parent_or_child/add_parent/data/remote_data/add_parent_remote_data.dart'
    as _i416;
import 'package:my_portfolio/features/institution_flow/add_parent_or_child/add_parent/data/repository/add_parent_repository_impl.dart'
    as _i571;
import 'package:my_portfolio/features/institution_flow/add_parent_or_child/add_parent/domain/repository/add_parent_repositoty.dart'
    as _i434;
import 'package:my_portfolio/features/institution_flow/add_parent_or_child/add_parent/domain/use_case/add_parent_use_case.dart'
    as _i448;
import 'package:my_portfolio/features/institution_flow/add_parent_or_child/add_parent/view_model/add_parent_bloc.dart'
    as _i908;
import 'package:my_portfolio/features/institution_flow/home/data/remote_data_source/institutions_remote_data_source.dart'
    as _i178;
import 'package:my_portfolio/features/institution_flow/home/data/repository/institution_repository_impl.dart'
    as _i723;
import 'package:my_portfolio/features/institution_flow/home/domain/repository/institution_repo.dart'
    as _i517;
import 'package:my_portfolio/features/institution_flow/home/domain/use_case/institution_use_case.dart'
    as _i572;
import 'package:my_portfolio/features/institution_flow/home/presentation/view_model/institution_home_bloc.dart'
    as _i44;
import 'package:my_portfolio/features/intro/global/data/global_data_source/global_remote_data_source.dart'
    as _i743;
import 'package:my_portfolio/features/intro/global/data/global_screen_repository/global_repository.dart'
    as _i987;
import 'package:my_portfolio/features/intro/global/domain/global_base_repository/global_base_repository.dart'
    as _i407;
import 'package:my_portfolio/features/intro/global/domain/global_usecases/global_usecase.dart'
    as _i326;
import 'package:my_portfolio/features/intro/global/global_view_model/global_bloc.dart'
    as _i158;
import 'package:my_portfolio/features/intro/onboarding/on_boarding.dart'
    as _i156;
import 'package:my_portfolio/features/intro/splash/data/splash_data_source/splash_remote_data_source.dart'
    as _i361;
import 'package:my_portfolio/features/intro/splash/data/splash_screen_repository/splash_repository.dart'
    as _i427;
import 'package:my_portfolio/features/intro/splash/domain/splash_base_repository/splash_base_repository.dart'
    as _i837;
import 'package:my_portfolio/features/intro/splash/domain/splash_usecases/check_token_usecase.dart'
    as _i543;
import 'package:my_portfolio/features/intro/splash/presentation/splash_view_model/splash_bloc.dart'
    as _i1001;
import 'package:my_portfolio/features/parent_flow/auth/parent_add_new_child/data/parent_add_new_child_data_source/parent_add_new_child_remote_data_source.dart'
    as _i1034;
import 'package:my_portfolio/features/parent_flow/auth/parent_add_new_child/data/parent_add_new_child_repository/parent_add_new_child_repository.dart'
    as _i335;
import 'package:my_portfolio/features/parent_flow/auth/parent_add_new_child/domain/parent_add_new_child_base_repository/parent_add_new_child_base_repository.dart'
    as _i543;
import 'package:my_portfolio/features/parent_flow/auth/parent_add_new_child/domain/parent_add_new_child_usecases/parent_add_new_child_usecase.dart'
    as _i745;
import 'package:my_portfolio/features/parent_flow/home/data/data_source/remote/parent_home_remote_data_source.dart'
    as _i968;
import 'package:my_portfolio/features/parent_flow/home/data/repositories/parent_home_repo_impl.dart'
    as _i946;
import 'package:my_portfolio/features/parent_flow/home/domain/repositories/parent_home_repo.dart'
    as _i46;
import 'package:my_portfolio/features/parent_flow/home/domain/use_cases/parent_use_case.dart'
    as _i911;
import 'package:my_portfolio/features/parent_flow/home/presentation/home_view_model/parent_home_bloc.dart'
    as _i430;
import 'package:my_portfolio/features/shared_features/all_subscriptions/data/remote_data_source/all_subbscription_rempte_data_source.dart'
    as _i727;
import 'package:my_portfolio/features/shared_features/all_subscriptions/data/repository/all_subscription_repository_impl.dart'
    as _i833;
import 'package:my_portfolio/features/shared_features/all_subscriptions/domain/repository/all_subbscription_repo.dart'
    as _i833;
import 'package:my_portfolio/features/shared_features/all_subscriptions/domain/use_case/all_subscription_use_case.dart'
    as _i1010;
import 'package:my_portfolio/features/shared_features/all_subscriptions/presentation/all_subscription_classroom/view_model/all_subscription_bloc.dart'
    as _i978;
import 'package:my_portfolio/features/shared_features/banner/data/remote_data_source/banner_remote_data_source.dart'
    as _i235;
import 'package:my_portfolio/features/shared_features/banner/data/repository/banner_repository.dart'
    as _i364;
import 'package:my_portfolio/features/shared_features/banner/domain/repository/banner_repository.dart'
    as _i665;
import 'package:my_portfolio/features/shared_features/banner/domain/usecase/get_banner_usecase.dart'
    as _i102;
import 'package:my_portfolio/features/shared_features/banner/presentation/view_model/banner_bloc.dart'
    as _i555;
import 'package:my_portfolio/features/shared_features/child_subscriptions/data/child_subscriptions_data_source/child_subscriptions_remote_data_source.dart'
    as _i57;
import 'package:my_portfolio/features/shared_features/child_subscriptions/data/child_subscriptions_repository/child_subscriptions_repository.dart'
    as _i639;
import 'package:my_portfolio/features/shared_features/child_subscriptions/domain/child_subscriptions_base_repository/child_subscriptions_base_repository.dart'
    as _i80;
import 'package:my_portfolio/features/shared_features/child_subscriptions/domain/child_subscriptions_usecases/get_child_subscription_systems_usecase.dart'
    as _i717;
import 'package:my_portfolio/features/shared_features/child_subscriptions/domain/child_subscriptions_usecases/get_child_subscriptions_classrooms_use_case.dart'
    as _i1020;
import 'package:my_portfolio/features/shared_features/child_subscriptions/domain/child_subscriptions_usecases/get_child_subscriptions_paths_use_case.dart'
    as _i1060;
import 'package:my_portfolio/features/shared_features/child_subscriptions/domain/child_subscriptions_usecases/get_child_subscriptions_stages_use_case.dart'
    as _i327;
import 'package:my_portfolio/features/shared_features/child_subscriptions/domain/child_subscriptions_usecases/get_child_subscriptions_subjects_use_case.dart'
    as _i508;
import 'package:my_portfolio/features/shared_features/child_subscriptions/domain/child_subscriptions_usecases/get_child_subscriptions_terms_use_case.dart'
    as _i1004;
import 'package:my_portfolio/features/shared_features/child_subscriptions/presentation/subscriptions_systems_screen/view_model/subscription_systems_bloc.dart'
    as _i746;
import 'package:my_portfolio/features/shared_features/contact_us/data/contact_us_data_source/contact_us_local_data_sourcec.dart'
    as _i423;
import 'package:my_portfolio/features/shared_features/contact_us/data/contact_us_data_source/contact_us_remote_data_source.dart'
    as _i178;
import 'package:my_portfolio/features/shared_features/contact_us/data/contact_us_repository/contact_us_repository.dart'
    as _i254;
import 'package:my_portfolio/features/shared_features/contact_us/domain/contact_us_base_repository/contact_us_base_repository.dart'
    as _i231;
import 'package:my_portfolio/features/shared_features/contact_us/domain/contact_us_usecases/contact_us_usecase.dart'
    as _i662;
import 'package:my_portfolio/features/shared_features/contact_us/presentations/view_model/contact_us_bloc.dart'
    as _i757;
import 'package:my_portfolio/features/shared_features/get_social_data/data/get_social_remote_data_source/get_social_remote_data_source.dart'
    as _i684;
import 'package:my_portfolio/features/shared_features/get_social_data/data/get_social_repository/get_social_repository_impl.dart'
    as _i941;
import 'package:my_portfolio/features/shared_features/get_social_data/domain/get_social_base_repository/get_social_base_repository.dart'
    as _i841;
import 'package:my_portfolio/features/shared_features/get_social_data/domain/use_cases/get_apple_data.dart'
    as _i1011;
import 'package:my_portfolio/features/shared_features/get_social_data/domain/use_cases/get_google_data.dart'
    as _i445;
import 'package:my_portfolio/features/shared_features/get_social_data/presentation/get_social_data_view_model/get_social_data_bloc.dart'
    as _i547;
import 'package:my_portfolio/features/shared_features/invitation/data/remote_data_source/invitation_remote_data_source.dart'
    as _i580;
import 'package:my_portfolio/features/shared_features/invitation/data/repository/invitation_repository.dart'
    as _i658;
import 'package:my_portfolio/features/shared_features/invitation/domain/repository/invitation_repository.dart'
    as _i541;
import 'package:my_portfolio/features/shared_features/invitation/domain/usecase/invitation_usecase.dart'
    as _i401;
import 'package:my_portfolio/features/shared_features/invitation/presentation/view_model/invitation_bloc.dart'
    as _i522;
import 'package:my_portfolio/features/shared_features/more/child_common_questions/child_common_questions.dart'
    as _i350;
import 'package:my_portfolio/features/shared_features/more/data/more_data_source/more_remote_data_source.dart'
    as _i293;
import 'package:my_portfolio/features/shared_features/more/data/more_screen_repository/more_repository.dart'
    as _i412;
import 'package:my_portfolio/features/shared_features/more/domain/global_base_repository/more_base_repository.dart'
    as _i46;
import 'package:my_portfolio/features/shared_features/more/domain/more_usecases/more_usecase.dart'
    as _i533;
import 'package:my_portfolio/features/shared_features/more/more_view_model/more_bloc.dart'
    as _i187;
import 'package:my_portfolio/features/shared_features/more/parent_preview_for_child/parent_preview_for_child.dart'
    as _i231;
import 'package:my_portfolio/features/shared_features/nafees_plans/nafees_plans.dart'
    as _i448;
import 'package:my_portfolio/features/shared_features/notification/data/remote_data_source/notification_remote_data_source.dart'
    as _i848;
import 'package:my_portfolio/features/shared_features/notification/data/repository/notification_repository_impl.dart'
    as _i262;
import 'package:my_portfolio/features/shared_features/notification/domain/repository/notification_repository.dart'
    as _i813;
import 'package:my_portfolio/features/shared_features/notification/domain/use_case/notification_use_case.dart'
    as _i234;
import 'package:my_portfolio/features/shared_features/notification/presentation/view_model/notification_bloc.dart'
    as _i861;
import 'package:my_portfolio/features/shared_features/packages_and_subscriptions/cart/data/remote_data_source/cart_remote_data_source.dart'
    as _i85;
import 'package:my_portfolio/features/shared_features/packages_and_subscriptions/cart/data/repository/cart_repository.dart'
    as _i60;
import 'package:my_portfolio/features/shared_features/packages_and_subscriptions/cart/domain/repository/cart_repository.dart'
    as _i791;
import 'package:my_portfolio/features/shared_features/packages_and_subscriptions/cart/domain/usecase/delete_all_data_in_cart.dart'
    as _i269;
import 'package:my_portfolio/features/shared_features/packages_and_subscriptions/cart/domain/usecase/view_cart_usecase.dart'
    as _i64;
import 'package:my_portfolio/features/shared_features/packages_and_subscriptions/cart/presentation/view_model/cart_bloc.dart'
    as _i173;
import 'package:my_portfolio/features/shared_features/packages_and_subscriptions/data/remote_data_source/subject_subscription_remote_data_source.dart'
    as _i107;
import 'package:my_portfolio/features/shared_features/packages_and_subscriptions/data/repository/subject_subcription_repository.dart'
    as _i305;
import 'package:my_portfolio/features/shared_features/packages_and_subscriptions/domain/repository/subject_subscriptions_repository.dart'
    as _i3;
import 'package:my_portfolio/features/shared_features/packages_and_subscriptions/domain/usecase/add_optinal_subject.dart'
    as _i1046;
import 'package:my_portfolio/features/shared_features/packages_and_subscriptions/domain/usecase/add_subject.dart'
    as _i368;
import 'package:my_portfolio/features/shared_features/packages_and_subscriptions/domain/usecase/delete_subject.dart'
    as _i407;
import 'package:my_portfolio/features/shared_features/packages_and_subscriptions/domain/usecase/subject_subscription_usecase.dart'
    as _i791;
import 'package:my_portfolio/features/shared_features/packages_and_subscriptions/presentation/view_model/packages_and_subscriptions_bloc.dart'
    as _i552;
import 'package:my_portfolio/features/shared_features/payment_successfully_for_nafees_and_simulated/data/remote/pay_success_for_nafees_remote_data.dart'
    as _i430;
import 'package:my_portfolio/features/shared_features/payment_successfully_for_nafees_and_simulated/data/repository/pay_success_repo.dart'
    as _i298;
import 'package:my_portfolio/features/shared_features/payment_successfully_for_nafees_and_simulated/domain/repository/pay_for_nafees_success_repo.dart'
    as _i486;
import 'package:my_portfolio/features/shared_features/payment_successfully_for_nafees_and_simulated/domain/use_case/pay_success_for_nafees_use_case.dart'
    as _i28;
import 'package:my_portfolio/features/shared_features/payment_successfully_for_nafees_and_simulated/presentation/view_model/pay_success_for_nafees_bloc.dart'
    as _i178;
import 'package:my_portfolio/features/shared_features/profile/edit_profile/edit_profile.dart'
    as _i924;
import 'package:my_portfolio/features/shared_features/quran/quran.dart'
    as _i1004;
import 'package:my_portfolio/features/shared_features/rank/rank.dart' as _i697;
import 'package:my_portfolio/features/shared_features/review/data/remote_data_source/review_remote_data_source.dart'
    as _i708;
import 'package:my_portfolio/features/shared_features/review/data/repository/review_repository.dart'
    as _i342;
import 'package:my_portfolio/features/shared_features/review/domain/repository/review_repository.dart'
    as _i858;
import 'package:my_portfolio/features/shared_features/review/domain/usecase/add_review.dart'
    as _i656;
import 'package:my_portfolio/features/shared_features/review/domain/usecase/all_reviews.dart'
    as _i584;
import 'package:my_portfolio/features/shared_features/review/domain/usecase/delete_review.dart'
    as _i628;
import 'package:my_portfolio/features/shared_features/review/presentation/view_model/review_bloc.dart'
    as _i73;
import 'package:my_portfolio/features/shared_features/sign_with_social_media/data/social_login_remote_data_source/social_login_remote_data_source.dart'
    as _i723;
import 'package:my_portfolio/features/shared_features/sign_with_social_media/data/social_login_repository/social_login_repository_impl.dart'
    as _i791;
import 'package:my_portfolio/features/shared_features/sign_with_social_media/domain/social_login_base_repository/social_login_base_repository.dart'
    as _i705;
import 'package:my_portfolio/features/shared_features/sign_with_social_media/domain/use_cases/get_google_id_and_user_data_by_google_account.dart'
    as _i618;
import 'package:my_portfolio/features/shared_features/sign_with_social_media/domain/use_cases/social_login_use_case.dart'
    as _i374;
import 'package:my_portfolio/features/shared_features/sign_with_social_media/presentation/social_media_view_model/social_media_bloc.dart'
    as _i176;
import 'package:my_portfolio/features/shared_features/simulated_plans/simulated_plans.dart'
    as _i155;
import 'package:my_portfolio/features/shared_features/statics/statics.dart'
    as _i247;
import 'package:my_portfolio/features/shared_features/subjects_shared_features/subjects_shared_features.dart'
    as _i335;
import 'package:my_portfolio/features/shared_features/subscriptions_and_packages/free_grade_subscriptions/free_grade_subscriptions.dart'
    as _i619;
import 'package:my_portfolio/features/shared_features/subscriptions_and_packages/free_subjects_subscriptions/free_subjects_subscriptions.dart'
    as _i1018;
import 'package:my_portfolio/features/shared_features/subscriptions_and_packages/free_term_subscriptions/free_term_subscriptions.dart'
    as _i340;
import 'package:my_portfolio/features/shared_features/subscriptions_and_packages/optional_subjects/data/data_source/add_optional_subject_datasource.dart'
    as _i395;
import 'package:my_portfolio/features/shared_features/subscriptions_and_packages/optional_subjects/data/repository/repository.dart'
    as _i841;
import 'package:my_portfolio/features/shared_features/subscriptions_and_packages/optional_subjects/domain/repository/repository.dart'
    as _i448;
import 'package:my_portfolio/features/shared_features/subscriptions_and_packages/optional_subjects/domain/usecase/add_optional_subject_usecase.dart'
    as _i15;
import 'package:my_portfolio/features/shared_features/subscriptions_and_packages/optional_subjects/optional_subject_bloc/optional_subject_bloc_bloc.dart'
    as _i863;
import 'package:my_portfolio/features/shared_features/subscriptions_and_packages/packages/data/remote/packages_remote_data_source.dart'
    as _i620;
import 'package:my_portfolio/features/shared_features/subscriptions_and_packages/packages/data/repository/packages_repository.dart'
    as _i139;
import 'package:my_portfolio/features/shared_features/subscriptions_and_packages/packages/domain/repository/packages_repository.dart'
    as _i175;
import 'package:my_portfolio/features/shared_features/subscriptions_and_packages/packages/domain/usecase/add_classroom_to_cart_usecase.dart'
    as _i380;
import 'package:my_portfolio/features/shared_features/subscriptions_and_packages/packages/domain/usecase/add_subject_to_cart_usecase.dart'
    as _i566;
import 'package:my_portfolio/features/shared_features/subscriptions_and_packages/packages/domain/usecase/add_term_to_cart_usecase.dart'
    as _i268;
import 'package:my_portfolio/features/shared_features/subscriptions_and_packages/packages/presentation/view_model/packages_bloc.dart'
    as _i613;
import 'package:my_portfolio/features/shared_features/subscriptions_and_packages/payment_successfully/data/remote/pay_success_remote_data.dart'
    as _i232;
import 'package:my_portfolio/features/shared_features/subscriptions_and_packages/payment_successfully/data/repository/pay_success_repo.dart'
    as _i338;
import 'package:my_portfolio/features/shared_features/subscriptions_and_packages/payment_successfully/domain/repository/pay_success_repo.dart'
    as _i605;
import 'package:my_portfolio/features/shared_features/subscriptions_and_packages/payment_successfully/domain/use_case/pay_success_use_case.dart'
    as _i943;
import 'package:my_portfolio/features/shared_features/subscriptions_and_packages/payment_successfully/presentation/view_model/pay_success_bloc.dart'
    as _i923;
import 'package:my_portfolio/features/shared_features/subscriptions_and_packages/receipt/data/check_coupon_data_source/check_coupon_remote_data_source.dart'
    as _i702;
import 'package:my_portfolio/features/shared_features/subscriptions_and_packages/receipt/data/check_coupon_repository/check_coupon_repository.dart'
    as _i319;
import 'package:my_portfolio/features/shared_features/subscriptions_and_packages/receipt/domain/check_coupon_base_repository/check_coupon_base_repository.dart'
    as _i39;
import 'package:my_portfolio/features/shared_features/subscriptions_and_packages/receipt/domain/check_coupon_usecases/check_coupon_usecase.dart'
    as _i816;
import 'package:my_portfolio/features/shared_features/subscriptions_and_packages/receipt/domain/check_coupon_usecases/get_payment_data.dart'
    as _i589;
import 'package:my_portfolio/features/shared_features/subscriptions_and_packages/receipt/presentation/receipt_view_model/coupon_bloc.dart'
    as _i731;
import 'package:my_portfolio/features/shared_features/subscriptions_and_packages/subscription_subjects/view_model/subscriptions_and_packages_subjects_bloc.dart'
    as _i379;
import 'package:my_portfolio/features/shared_features/terms_and_conditions/terms_and_conditions.dart'
    as _i635;
import 'package:my_portfolio/features/shared_features/un_link/un_link.dart'
    as _i28;
import 'package:my_portfolio/features/shared_logic/classrooms_logic/classrooms_logic.dart'
    as _i218;
import 'package:my_portfolio/features/shared_logic/classrooms_logic/domain/grade_choosing_usecases/get_classroom_use_case.dart'
    as _i496;
import 'package:my_portfolio/features/shared_logic/classrooms_logic/domain/grade_choosing_usecases/get_path_usecase.dart'
    as _i86;
import 'package:my_portfolio/features/shared_logic/classrooms_logic/domain/grade_choosing_usecases/get_stages_use_case.dart'
    as _i565;
import 'package:my_portfolio/features/shared_logic/classrooms_logic/domain/grade_choosing_usecases/get_system_types_usecase.dart'
    as _i412;
import 'package:my_portfolio/features/shared_logic/classrooms_logic/domain/grade_choosing_usecases/get_terms_use_case.dart'
    as _i868;
import 'package:my_portfolio/features/shared_logic/localization_logic/presentation/localization_view_model/localization_bloc.dart'
    as _i166;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final injectableModule = _$InjectableModule();
    gh.factory<_i941.ImagePickBloc>(() => _i941.ImagePickBloc());
    gh.factory<_i476.HomeLayoutBloc>(() => _i476.HomeLayoutBloc());
    gh.factory<_i166.LanguageBloc>(() => _i166.LanguageBloc());
    gh.lazySingleton<_i419.AppInterceptors>(() => _i419.AppInterceptors());
    gh.lazySingleton<_i361.Dio>(() => injectableModule.dio);
    gh.lazySingleton<_i973.InternetConnectionChecker>(
        () => injectableModule.internetConnectionChecker);
    gh.lazySingleton<_i571.NetworkInfo>(
        () => _i571.NetworkInfoImpl(gh<_i973.InternetConnectionChecker>()));
    gh.lazySingleton<_i499.BaseRepository>(() => _i499.BaseRepositoryImpl());
    gh.lazySingleton<_i616.BaseLocalDataSource>(
        () => _i616.BaseLocalDataSourceImpl());
    gh.lazySingleton<_i423.GetContactUsLocalDataSource>(() =>
        _i423.GetContactUsLocalDataSourceImpl(
            localDataSource: gh<_i616.BaseLocalDataSource>()));
    gh.lazySingleton<_i707.HomeLocalDataSource>(
        () => _i707.HomeLocalDataSourceImpl(gh<_i616.BaseLocalDataSource>()));
    gh.lazySingleton<_i350.ChildCommonQuestionsLocalDataSource>(() =>
        _i350.ChildCommonQuestionsLocalDataSourceImpl(
            baseLocalDataSource: gh<_i616.BaseLocalDataSource>()));
    gh.lazySingleton<_i568.ApiConsumer>(
        () => _i344.DioConsumer(client: gh<_i361.Dio>()));
    gh.lazySingleton<_i1004.QuranLocalDataSource>(() =>
        _i1004.QuranLocalDataSourceImpl(
            baseLocalDataSource: gh<_i616.BaseLocalDataSource>()));
    gh.lazySingleton<_i231.ParentPreviewForChildLocalDataSource>(() =>
        _i231.ParentPreviewForChildLocalDataSourceImpl(
            baseLocalDataSource: gh<_i616.BaseLocalDataSource>()));
    gh.lazySingleton<_i335.SubjectsSharedFeaturesLocalDataSource>(() =>
        _i335.SubjectsSharedFeaturesLocalDataSourceImpl(
            baseLocalDataSource: gh<_i616.BaseLocalDataSource>()));
    gh.lazySingleton<_i156.OnBoardingLocalData>(() =>
        _i156.OnBoardingLocalDataImpl(
            baseLocalDataSource: gh<_i616.BaseLocalDataSource>()));
    gh.lazySingleton<_i850.UserLocalDataSource>(() =>
        _i850.UserLocalDataSourceImpl(
            baseLocalDataSource: gh<_i616.BaseLocalDataSource>()));
    gh.lazySingleton<_i742.BaseAppSecurityData>(() => _i742.AppSecurityData(
        localDataSource: gh<_i616.BaseLocalDataSource>()));
    gh.lazySingleton<_i69.BaseRemoteDataSource>(
        () => _i69.BaseRemoteDataSourceImpl(
              apiConsumer: gh<_i568.ApiConsumer>(),
              networkInfo: gh<_i571.NetworkInfo>(),
            ));
    gh.lazySingleton<_i635.GetTermsAndConditionsLocalDataSource>(() =>
        _i635.GetTermsAndConditionsLocalDataSourceImpl(
            localDataSource: gh<_i616.BaseLocalDataSource>()));
    gh.lazySingleton<_i744.InstitutionAddChildRemoteDataSource>(
        () => _i744.InstitutionAddChildRemoteDataSourceImpl(
              apiConsumer: gh<_i568.ApiConsumer>(),
              baseDataSource: gh<_i69.BaseRemoteDataSource>(),
            ));
    gh.lazySingleton<_i416.AddParentRemoteDataSource>(
        () => _i416.AddParentRemoteDataSourceImpl(
              apiConsumer: gh<_i568.ApiConsumer>(),
              baseDataSource: gh<_i69.BaseRemoteDataSource>(),
            ));
    gh.lazySingleton<_i85.CartRemoteDataSource>(
        () => _i85.CartRemoteDataSourceImpl(gh<_i69.BaseRemoteDataSource>()));
    gh.lazySingleton<_i676.NotificationSetup>(
        () => _i676.NotificationSetup(apiConsumer: gh<_i568.ApiConsumer>()));
    gh.lazySingleton<_i608.VerificationRemoteDataSource>(
        () => _i608.VerificationRemoteDataSourceImpl(
              apiConsumer: gh<_i568.ApiConsumer>(),
              networkInfo: gh<_i571.NetworkInfo>(),
              baseDataSource: gh<_i69.BaseRemoteDataSource>(),
            ));
    gh.lazySingleton<_i235.GetBannerRemoteDataSource>(() =>
        _i235.GetBannerRemoteDataSourceImpl(gh<_i69.BaseRemoteDataSource>()));
    gh.lazySingleton<_i665.BannerRepository>(() => _i364.BannerRepositoryImpl(
          gh<_i499.BaseRepository>(),
          gh<_i235.GetBannerRemoteDataSource>(),
        ));
    gh.lazySingleton<_i990.LoginRemoteDataSource>(
        () => _i990.LoginRemoteDataSourceImpl(
              baseDataSource: gh<_i69.BaseRemoteDataSource>(),
              userLocalDataSource: gh<_i850.UserLocalDataSource>(),
            ));
    gh.lazySingleton<_i935.LevelsRemoteDataSource>(() =>
        _i935.LevelsRemoteDataSourceImpl(
            baseRemoteDataSource: gh<_i69.BaseRemoteDataSource>()));
    gh.lazySingleton<_i434.AddParentRepository>(
        () => _i571.AddParentRepositoryImpl(
              remoteDataSource: gh<_i416.AddParentRemoteDataSource>(),
              baseRepository: gh<_i499.BaseRepository>(),
            ));
    gh.lazySingleton<_i57.ChildSubscriptionsRemoteDataSource>(() =>
        _i57.GradeChoosingRemoteDataSourceImpl(
            baseRemoteDataSource: gh<_i69.BaseRemoteDataSource>()));
    gh.lazySingleton<_i935.LevelsBaseRepository>(() => _i935.LevelsRepository(
          remoteDataSource: gh<_i935.LevelsRemoteDataSource>(),
          baseRepository: gh<_i499.BaseRepository>(),
        ));
    gh.lazySingleton<_i711.ForgetPasswordRemoteDataSource>(() =>
        _i711.ForgetPasswordRemoteDataSourceImpl(
            baseDataSource: gh<_i69.BaseRemoteDataSource>()));
    gh.lazySingleton<_i80.ChildSubscriptionsBaseRepository>(
        () => _i639.ChildSubscriptionsRepository(
              remoteDataSource: gh<_i57.ChildSubscriptionsRemoteDataSource>(),
              baseRepository: gh<_i499.BaseRepository>(),
            ));
    gh.lazySingleton<_i178.ContactUsRemoteDataSource>(() =>
        _i178.ContactUssRemoteDataSourceImpl(gh<_i69.BaseRemoteDataSource>()));
    gh.lazySingleton<_i702.CheckCouponRemoteDataSource>(() =>
        _i702.CheckCouponRemoteDataSourceImpl(
            baseRemoteDataSource: gh<_i69.BaseRemoteDataSource>()));
    gh.lazySingleton<_i551.CollectionsRemoteDataSource>(() =>
        _i551.CollectionsRemoteDataSourceImpl(
            baseRemoteDataSource: gh<_i69.BaseRemoteDataSource>()));
    gh.lazySingleton<_i350.ChildCommonQuestionsRemoteDataSource>(() =>
        _i350.ChildCommonQuestionsRemoteDataSourceImpl(
            baseRemoteDataSource: gh<_i69.BaseRemoteDataSource>()));
    gh.lazySingleton<_i684.GetSocialDataBaseRemoteDataSource>(() =>
        _i684.GetSocialDataRemoteDataSourceImpl(
            gh<_i69.BaseRemoteDataSource>()));
    gh.lazySingleton<_i102.GetBannerUseCase>(
        () => _i102.GetBannerUseCase(gh<_i665.BannerRepository>()));
    gh.lazySingleton<_i277.HomeRemoteDataSource>(() =>
        _i277.HomeRemoteDataSourceImpl(
            baseRemoteDataSource: gh<_i69.BaseRemoteDataSource>()));
    gh.factory<_i555.BannerBloc>(
        () => _i555.BannerBloc(gh<_i102.GetBannerUseCase>()));
    gh.lazySingleton<_i178.InstitutionHomeRemoteDataSource>(() =>
        _i178.InstitutionHomeRemoteDataSourceImpl(
            gh<_i69.BaseRemoteDataSource>()));
    gh.lazySingleton<_i232.PaymentSuccessRemoteDataSource>(() =>
        _i232.PaymentSuccessRemoteDataSourceImpl(
            baseRemoteDataSource: gh<_i69.BaseRemoteDataSource>()));
    gh.lazySingleton<_i723.SocialLoginBaseRemoteDataSource>(() =>
        _i723.SocialLoginRemoteDataSourceImpl(gh<_i69.BaseRemoteDataSource>()));
    gh.lazySingleton<_i247.BaseStaticsRemoteDataSource>(() =>
        _i247.StaticsRemoteDataSource(
            dataSource: gh<_i69.BaseRemoteDataSource>()));
    gh.lazySingleton<_i926.QuestionsRemoteDataSource>(() =>
        _i926.QuestionsRemoteDataSourceImpl(
            baseRemoteDataSource: gh<_i69.BaseRemoteDataSource>()));
    gh.lazySingleton<_i293.MoreBaseRemoteDataSource>(
        () => _i293.MoreRemoteDataSourceImpl(
              networkInfo: gh<_i571.NetworkInfo>(),
              apiConsumer: gh<_i568.ApiConsumer>(),
              baseRemoteDataSource: gh<_i69.BaseRemoteDataSource>(),
            ));
    gh.lazySingleton<_i353.SocialRegisterBaseRemoteDataSource>(() =>
        _i353.SocialRegisterRemoteDataSourceImpl(
            baseDataSource: gh<_i69.BaseRemoteDataSource>()));
    gh.lazySingleton<_i727.AllSubscriptionRemoteDataSource>(() =>
        _i727.AllSubscriptionRemoteDataSourceImpl(
            baseRemoteDataSource: gh<_i69.BaseRemoteDataSource>()));
    gh.lazySingleton<_i211.RandomExamsRemoteDataSource>(() =>
        _i211.RandomExamsRemoteDataSourceImpl(
            baseRemoteDataSource: gh<_i69.BaseRemoteDataSource>()));
    gh.lazySingleton<_i935.LevelsUseCase>(() =>
        _i935.LevelsUseCase(repository: gh<_i935.LevelsBaseRepository>()));
    gh.lazySingleton<_i39.CheckCouponBaseRepository>(() => _i319.CartRepository(
          remoteDataSource: gh<_i702.CheckCouponRemoteDataSource>(),
          baseRepository: gh<_i499.BaseRepository>(),
        ));
    gh.lazySingleton<_i592.SignUpRemoteDataSource>(() =>
        _i592.SignUpRemoteDataSourceImpl(gh<_i69.BaseRemoteDataSource>()));
    gh.lazySingleton<_i218.GradeChoosingRemoteDataSource>(() =>
        _i218.GradeChoosingRemoteDataSourceImpl(
            baseRemoteDataSource: gh<_i69.BaseRemoteDataSource>()));
    gh.lazySingleton<_i361.CheckUserTokenBaseRemoteDataSource>(
        () => _i361.CheckUserTokenRemoteDataSourceImpl(
              networkInfo: gh<_i571.NetworkInfo>(),
              apiConsumer: gh<_i568.ApiConsumer>(),
              baseRemoteDataSource: gh<_i69.BaseRemoteDataSource>(),
            ));
    gh.lazySingleton<_i711.ForgetPasswordBaseRepository>(
        () => _i711.ForgetPasswordRepository(
              remoteDataSource: gh<_i711.ForgetPasswordRemoteDataSource>(),
              baseRepository: gh<_i499.BaseRepository>(),
            ));
    gh.lazySingleton<_i848.NotificationRemoteDataSource>(
        () => _i848.NotificationRemoteDataSourceImpl(
              remoteDataSource: gh<_i69.BaseRemoteDataSource>(),
              apiConsumer: gh<_i568.ApiConsumer>(),
            ));
    gh.lazySingleton<_i620.PackagesRemoteDataSource>(() =>
        _i620.PackagesRemoteDataSourceImpl(
            baseRemoteDataSource: gh<_i69.BaseRemoteDataSource>()));
    gh.lazySingleton<_i712.DownloadUploadRemoteDataSource>(() =>
        _i712.DownloadUploadRemoteDataSourceImpl(
            baseRemoteDataSource: gh<_i69.BaseRemoteDataSource>()));
    gh.lazySingleton<_i448.NafeesRemoteDataSource>(() =>
        _i448.NafeesRemoteDataSourceImpl(
            baseRemoteDataSource: gh<_i69.BaseRemoteDataSource>()));
    gh.lazySingleton<_i155.SimulatedRemoteDataSource>(() =>
        _i155.SimulatedRemoteDataSourceImpl(
            baseRemoteDataSource: gh<_i69.BaseRemoteDataSource>()));
    gh.lazySingleton<_i635.TermsAndConditionsRemoteDataSource>(() =>
        _i635.TermsAndConditionsRemoteDataSourceImpl(
            gh<_i69.BaseRemoteDataSource>()));
    gh.lazySingleton<_i608.VerificationBaseRepository>(
        () => _i608.VerificationRepository(
              userLocalDataSource: gh<_i850.UserLocalDataSource>(),
              remoteDataSource: gh<_i608.VerificationRemoteDataSource>(),
              baseRepository: gh<_i499.BaseRepository>(),
            ));
    gh.lazySingleton<_i277.HomeBaseRepository>(() => _i277.HomeRepository(
          localDataSource: gh<_i707.HomeLocalDataSource>(),
          remoteDataSource: gh<_i277.HomeRemoteDataSource>(),
          baseRepository: gh<_i499.BaseRepository>(),
        ));
    gh.lazySingleton<_i1018.FreeSubjectsSubscriptionsRemoteDataSource>(() =>
        _i1018.FreeSubjectsSubscriptionsRemoteDataSourceImpl(
            baseRemoteDataSource: gh<_i69.BaseRemoteDataSource>()));
    gh.lazySingleton<_i1004.QuranRemoteDataSource>(() =>
        _i1004.QuranRemoteDataSourceImpl(
            baseRemoteDataSource: gh<_i69.BaseRemoteDataSource>()));
    gh.lazySingleton<_i968.ParentHomeRemoteDataSource>(() =>
        _i968.ParentHomeRemoteDataSourceImpl(gh<_i69.BaseRemoteDataSource>()));
    gh.lazySingleton<_i743.GlobalBaseRemoteDataSource>(
        () => _i743.GlobalRemoteDataSourceImpl(
              networkInfo: gh<_i571.NetworkInfo>(),
              apiConsumer: gh<_i568.ApiConsumer>(),
              baseRemoteDataSource: gh<_i69.BaseRemoteDataSource>(),
            ));
    gh.lazySingleton<_i528.LessonsRemoteDataSource>(() =>
        _i528.LessonsRemoteDataSourceImpl(
            baseRemoteDataSource: gh<_i69.BaseRemoteDataSource>()));
    gh.lazySingleton<_i685.ExamsRemoteDataSource>(() =>
        _i685.ExamsRemoteDataSourceImpl(
            baseRemoteDataSource: gh<_i69.BaseRemoteDataSource>()));
    gh.lazySingleton<_i231.ParentPreviewForChildRemoteDataSource>(() =>
        _i231.ParentPreviewForChildRemoteDataSourceImpl(
            baseRemoteDataSource: gh<_i69.BaseRemoteDataSource>()));
    gh.lazySingleton<_i697.RankRemoteDataSource>(() =>
        _i697.RankRemoteDataSourceImpl(
            baseRemoteDataSource: gh<_i69.BaseRemoteDataSource>()));
    gh.lazySingleton<_i231.ParentPreviewForChildBaseRepository>(() =>
        _i231.ParentPreviewForChildRepository(
          parentLocalDataSource:
              gh<_i231.ParentPreviewForChildLocalDataSource>(),
          remoteDataSource: gh<_i231.ParentPreviewForChildRemoteDataSource>(),
          baseRepository: gh<_i499.BaseRepository>(),
        ));
    gh.lazySingleton<_i430.PaymentSuccessForNafeesRemoteDataSource>(() =>
        _i430.PaymentSuccessForNafeesRemoteDataSourceImpl(
            baseRemoteDataSource: gh<_i69.BaseRemoteDataSource>()));
    gh.lazySingleton<_i71.CouponRemoteDataSource>(() =>
        _i71.CouponRemoteDataSourceImpl(
            baseRemoteDataSource: gh<_i69.BaseRemoteDataSource>()));
    gh.lazySingleton<_i517.InstitutionHomeBaseRepository>(
        () => _i723.InstitutionHomeRepository(
              registry: gh<_i499.BaseRepository>(),
              remoteDataSource: gh<_i178.InstitutionHomeRemoteDataSource>(),
            ));
    gh.lazySingleton<_i924.EditProfileRemoteDataSource>(() =>
        _i924.EditProfileRemoteDataSourceImpl(
            baseRemoteDataSource: gh<_i69.BaseRemoteDataSource>()));
    gh.lazySingleton<_i712.DownloadUploadBaseRepository>(
        () => _i712.DownloadUploadRepository(
              remoteDataSource: gh<_i712.DownloadUploadRemoteDataSource>(),
              baseRepository: gh<_i499.BaseRepository>(),
            ));
    gh.lazySingleton<_i335.SubjectsSharedFeaturesRemoteDataSource>(() =>
        _i335.SubjectsSharedFeaturesRemoteDataSourceImpl(
            baseRemoteDataSource: gh<_i69.BaseRemoteDataSource>()));
    gh.lazySingleton<_i395.AddOptionalSubjectDataSource>(() =>
        _i395.AddOptionalSubjectDataSourceImpl(
            baseRemoteDataSource: gh<_i69.BaseRemoteDataSource>()));
    gh.lazySingleton<_i744.InstitutionAddChildRepository>(
        () => _i744.InstitutionAddChildRepositoryImpl(
              remoteDataSource: gh<_i744.InstitutionAddChildRemoteDataSource>(),
              baseRepository: gh<_i499.BaseRepository>(),
            ));
    gh.lazySingleton<_i28.UnLinkRemoteDataSource>(
        () => _i28.UnLinkRemoteDataSourceImpl(gh<_i69.BaseRemoteDataSource>()));
    gh.lazySingleton<_i1034.ParentAddNewChildRemoteDataSource>(() =>
        _i1034.ParentAddNewChildRemoteDataSourceImpl(
            baseRemoteDataSource: gh<_i69.BaseRemoteDataSource>()));
    gh.lazySingleton<_i1004.QuranBaseRepository>(() => _i1004.QuranRepository(
          remoteDataSource: gh<_i1004.QuranRemoteDataSource>(),
          baseRepository: gh<_i499.BaseRepository>(),
          localDataSource: gh<_i1004.QuranLocalDataSource>(),
        ));
    gh.lazySingleton<_i46.ParentHomeBaseRepository>(
        () => _i946.ParentHomeRepository(
              registry: gh<_i499.BaseRepository>(),
              remoteDataSource: gh<_i968.ParentHomeRemoteDataSource>(),
            ));
    gh.lazySingleton<_i813.NotificationRepository>(
        () => _i262.NotificationRepositoryImpl(
              notificationRemoteDataSource:
                  gh<_i848.NotificationRemoteDataSource>(),
              baseRepository: gh<_i499.BaseRepository>(),
            ));
    gh.lazySingleton<_i791.CartRepository>(() => _i60.CartRepositoryImpl(
          gh<_i499.BaseRepository>(),
          gh<_i85.CartRemoteDataSource>(),
        ));
    gh.lazySingleton<_i140.CouponBaseRepository>(() => _i1042.CouponRepository(
          remoteDataSource: gh<_i71.CouponRemoteDataSource>(),
          baseRepository: gh<_i499.BaseRepository>(),
        ));
    gh.lazySingleton<_i911.GetAllChildForParentUseCase>(() =>
        _i911.GetAllChildForParentUseCase(
            repository: gh<_i46.ParentHomeBaseRepository>()));
    gh.lazySingleton<_i708.ReviewRemoteDataSource>(() =>
        _i708.ReviewRemoteDataSourceImpl(gh<_i69.BaseRemoteDataSource>()));
    gh.lazySingleton<_i614.SocialRegisterBaseRepository>(
        () => _i870.SocialRegisterRepository(
              remoteDataSource: gh<_i353.SocialRegisterBaseRemoteDataSource>(),
              baseRepository: gh<_i499.BaseRepository>(),
              userLocalDataSource: gh<_i850.UserLocalDataSource>(),
            ));
    gh.lazySingleton<_i551.CollectionsBaseRepository>(
        () => _i551.CollectionsRepository(
              remoteDataSource: gh<_i551.CollectionsRemoteDataSource>(),
              baseRepository: gh<_i499.BaseRepository>(),
            ));
    gh.lazySingleton<_i1020.GetChildSubscriptionsClassRoomUseCase>(() =>
        _i1020.GetChildSubscriptionsClassRoomUseCase(
            repository: gh<_i80.ChildSubscriptionsBaseRepository>()));
    gh.lazySingleton<_i1060.GetChildSubscriptionsPathsUseCase>(() =>
        _i1060.GetChildSubscriptionsPathsUseCase(
            repository: gh<_i80.ChildSubscriptionsBaseRepository>()));
    gh.lazySingleton<_i327.GetChildSubscriptionsStagesUseCase>(() =>
        _i327.GetChildSubscriptionsStagesUseCase(
            repository: gh<_i80.ChildSubscriptionsBaseRepository>()));
    gh.lazySingleton<_i508.GetChildSubscriptionsSubjectsUseCase>(() =>
        _i508.GetChildSubscriptionsSubjectsUseCase(
            repository: gh<_i80.ChildSubscriptionsBaseRepository>()));
    gh.lazySingleton<_i1004.GetChildSubscriptionsTermsUseCase>(() =>
        _i1004.GetChildSubscriptionsTermsUseCase(
            repository: gh<_i80.ChildSubscriptionsBaseRepository>()));
    gh.lazySingleton<_i717.GetChildSubscriptionsSystemsUseCase>(() =>
        _i717.GetChildSubscriptionsSystemsUseCase(
            repository: gh<_i80.ChildSubscriptionsBaseRepository>()));
    gh.lazySingleton<_i107.SubjectSubscriptionRemoteDataSource>(() =>
        _i107.SubjectSubscriptionRemoteDataSourceImpl(
            gh<_i69.BaseRemoteDataSource>()));
    gh.lazySingleton<_i3.SubjectSubscriptionRepository>(
        () => _i305.SubjectSubscriptionRepositoryImpl(
              gh<_i499.BaseRepository>(),
              gh<_i107.SubjectSubscriptionRemoteDataSource>(),
            ));
    gh.lazySingleton<_i837.CheckUserTokenBaseRepository>(
        () => _i427.CheckUserTokenRepository(
              remoteDataSource: gh<_i361.CheckUserTokenBaseRemoteDataSource>(),
              baseRepository: gh<_i499.BaseRepository>(),
              userLocalDataSource: gh<_i850.UserLocalDataSource>(),
            ));
    gh.lazySingleton<_i1018.FreeSubjectsSubscriptionsBaseRepository>(
        () => _i1018.FreeSubjectsSubscriptionsRepository(
              remoteDataSource:
                  gh<_i1018.FreeSubjectsSubscriptionsRemoteDataSource>(),
              baseRepository: gh<_i499.BaseRepository>(),
            ));
    gh.lazySingleton<_i155.SimulatedBaseRepository>(
        () => _i155.SimulatedRepository(
              baseRepository: gh<_i499.BaseRepository>(),
              remoteDataSource: gh<_i155.SimulatedRemoteDataSource>(),
            ));
    gh.lazySingleton<_i231.ContactUsBaseRepository>(
        () => _i254.ContactUsRepository(
              localDataSource: gh<_i423.GetContactUsLocalDataSource>(),
              remoteDataSource: gh<_i178.ContactUsRemoteDataSource>(),
              baseRepository: gh<_i499.BaseRepository>(),
            ));
    gh.lazySingleton<_i833.AllSubscriptionRepository>(
        () => _i833.AllSubscriptionRepositoryImpl(
              remoteDataSource: gh<_i727.AllSubscriptionRemoteDataSource>(),
              baseRepository: gh<_i499.BaseRepository>(),
            ));
    gh.lazySingleton<_i841.GetSocialDataBaseRepository>(
        () => _i941.GetSocialDataRepositoryImpl(
              getSocialDataBaseRemoteDataSource:
                  gh<_i684.GetSocialDataBaseRemoteDataSource>(),
              userLocalDataSource: gh<_i850.UserLocalDataSource>(),
              baseRepository: gh<_i499.BaseRepository>(),
              networkInfo: gh<_i571.NetworkInfo>(),
            ));
    gh.lazySingleton<_i580.GetInvitationRemoteDataSource>(() =>
        _i580.GetInvitationRemoteDataSourceImpl(
            gh<_i69.BaseRemoteDataSource>()));
    gh.lazySingleton<_i608.CheckVerificationCodeUseCase>(() =>
        _i608.CheckVerificationCodeUseCase(
            repository: gh<_i608.VerificationBaseRepository>()));
    gh.lazySingleton<_i608.ResendVerificationCodeUseCase>(() =>
        _i608.ResendVerificationCodeUseCase(
            repository: gh<_i608.VerificationBaseRepository>()));
    gh.lazySingleton<_i608.SignUpUseCase>(() => _i608.SignUpUseCase(
        repository: gh<_i608.VerificationBaseRepository>()));
    gh.lazySingleton<_i247.BaseStaticsRepository>(() => _i247.StaticsRepository(
          registry: gh<_i499.BaseRepository>(),
          remoteDataSource: gh<_i247.BaseStaticsRemoteDataSource>(),
        ));
    gh.lazySingleton<_i448.AddParentUseCase>(() =>
        _i448.AddParentUseCase(repository: gh<_i434.AddParentRepository>()));
    gh.lazySingleton<_i175.PackagesRepository>(
        () => _i139.PackagesRepositoryImpl(
              gh<_i499.BaseRepository>(),
              gh<_i620.PackagesRemoteDataSource>(),
            ));
    gh.lazySingleton<_i543.CheckUserTokenUseCase>(() =>
        _i543.CheckUserTokenUseCase(
            repository: gh<_i837.CheckUserTokenBaseRepository>()));
    gh.lazySingleton<_i543.EditUserDataUseCase>(() => _i543.EditUserDataUseCase(
        repository: gh<_i837.CheckUserTokenBaseRepository>()));
    gh.lazySingleton<_i592.SignUpBaseRepository>(() => _i592.SignUpRepository(
          remoteDataSource: gh<_i592.SignUpRemoteDataSource>(),
          baseRepository: gh<_i499.BaseRepository>(),
        ));
    gh.lazySingleton<_i282.CouponUseCase>(() =>
        _i282.CouponUseCase(repository: gh<_i140.CouponBaseRepository>()));
    gh.lazySingleton<_i231.GetParentPreviewForChildUseCase>(() =>
        _i231.GetParentPreviewForChildUseCase(
            repository: gh<_i231.ParentPreviewForChildBaseRepository>()));
    gh.lazySingleton<_i572.GetAllParentsForInstitutionUseCase>(() =>
        _i572.GetAllParentsForInstitutionUseCase(
            repository: gh<_i517.InstitutionHomeBaseRepository>()));
    gh.lazySingleton<_i155.GetSimulatedPlansUseCase>(() =>
        _i155.GetSimulatedPlansUseCase(
            repository: gh<_i155.SimulatedBaseRepository>()));
    gh.lazySingleton<_i155.GetSimulatedExamsUseCase>(() =>
        _i155.GetSimulatedExamsUseCase(
            repository: gh<_i155.SimulatedBaseRepository>()));
    gh.lazySingleton<_i155.GetSimulatedModelAnswersUseCase>(() =>
        _i155.GetSimulatedModelAnswersUseCase(
            repository: gh<_i155.SimulatedBaseRepository>()));
    gh.lazySingleton<_i155.SubmitExamAnswerUseCase>(() =>
        _i155.SubmitExamAnswerUseCase(
            repository: gh<_i155.SimulatedBaseRepository>()));
    gh.lazySingleton<_i816.CheckCouponUseCase>(() => _i816.CheckCouponUseCase(
        repository: gh<_i39.CheckCouponBaseRepository>()));
    gh.lazySingleton<_i589.GetPaymentDataUseCase>(() =>
        _i589.GetPaymentDataUseCase(
            repository: gh<_i39.CheckCouponBaseRepository>()));
    gh.lazySingleton<_i1018.GetSubjectsFreeSubjectsSubscriptionsUseCase>(() =>
        _i1018.GetSubjectsFreeSubjectsSubscriptionsUseCase(
            repository: gh<_i1018.FreeSubjectsSubscriptionsBaseRepository>()));
    gh.lazySingleton<_i543.ParentAddNewChildBaseRepository>(
        () => _i335.ParentAddNewChildRepository(
              remoteDataSource: gh<_i1034.ParentAddNewChildRemoteDataSource>(),
              baseRepository: gh<_i499.BaseRepository>(),
            ));
    gh.lazySingleton<_i551.CollectionsUseCase>(() => _i551.CollectionsUseCase(
        repository: gh<_i551.CollectionsBaseRepository>()));
    gh.lazySingleton<_i711.ForgetPasswordUseCase>(() =>
        _i711.ForgetPasswordUseCase(
            repository: gh<_i711.ForgetPasswordBaseRepository>()));
    gh.lazySingleton<_i218.GradeChoosingBaseRepository>(
        () => _i218.GradeChoosingRepository(
              remoteDataSource: gh<_i218.GradeChoosingRemoteDataSource>(),
              baseRepository: gh<_i499.BaseRepository>(),
            ));
    gh.lazySingleton<_i926.QuestionsBaseRepository>(
        () => _i926.QuestionsRepository(
              remoteDataSource: gh<_i926.QuestionsRemoteDataSource>(),
              baseRepository: gh<_i499.BaseRepository>(),
            ));
    gh.lazySingleton<_i990.LoginBaseRepository>(() => _i990.LoginRepository(
          remoteDataSource: gh<_i990.LoginRemoteDataSource>(),
          baseRepository: gh<_i499.BaseRepository>(),
          userLocalDataSource: gh<_i850.UserLocalDataSource>(),
        ));
    gh.lazySingleton<_i448.NafeesBaseRepository>(() => _i448.NafeesRepository(
          baseRepository: gh<_i499.BaseRepository>(),
          remoteDataSource: gh<_i448.NafeesRemoteDataSource>(),
        ));
    gh.lazySingleton<_i46.MoreBaseRepository>(() => _i412.MoreRepository(
          remoteDataSource: gh<_i293.MoreBaseRemoteDataSource>(),
          baseRepository: gh<_i499.BaseRepository>(),
        ));
    gh.lazySingleton<_i335.SubjectsSharedFeaturesBaseRepository>(() =>
        _i335.SubjectsSharedFeaturesRepository(
          baseRepository: gh<_i499.BaseRepository>(),
          remoteDataSource: gh<_i335.SubjectsSharedFeaturesRemoteDataSource>(),
          localeDataSource: gh<_i335.SubjectsSharedFeaturesLocalDataSource>(),
        ));
    gh.lazySingleton<_i528.LessonsBaseRepository>(() => _i528.LessonsRepository(
          remoteDataSource: gh<_i528.LessonsRemoteDataSource>(),
          baseRepository: gh<_i499.BaseRepository>(),
        ));
    gh.factory<_i1001.SplashBloc>(() => _i1001.SplashBloc(
          gh<_i543.CheckUserTokenUseCase>(),
          gh<_i543.EditUserDataUseCase>(),
        ));
    gh.lazySingleton<_i64.ViewCartUseCase>(
        () => _i64.ViewCartUseCase(gh<_i791.CartRepository>()));
    gh.lazySingleton<_i28.UnLinkRepository>(() => _i28.UnLinkRepositoryImpl(
          remoteDataSource: gh<_i28.UnLinkRemoteDataSource>(),
          baseRepository: gh<_i499.BaseRepository>(),
        ));
    gh.lazySingleton<_i528.GetLessonsUseCase>(() =>
        _i528.GetLessonsUseCase(repository: gh<_i528.LessonsBaseRepository>()));
    gh.lazySingleton<_i528.GetLessonsByUnitUseCase>(() =>
        _i528.GetLessonsByUnitUseCase(
            repository: gh<_i528.LessonsBaseRepository>()));
    gh.lazySingleton<_i277.GetSubjectsUseCase>(() =>
        _i277.GetSubjectsUseCase(repository: gh<_i277.HomeBaseRepository>()));
    gh.lazySingleton<_i277.GetPuzzleAndAdviceUseCase>(() =>
        _i277.GetPuzzleAndAdviceUseCase(
            repository: gh<_i277.HomeBaseRepository>()));
    gh.lazySingleton<_i350.ChildCommonQuestionsBaseRepository>(() =>
        _i350.ChildCommonQuestionsRepository(
          childCommonQuestionsLocalDataSource:
              gh<_i350.ChildCommonQuestionsLocalDataSource>(),
          remoteDataSource: gh<_i350.ChildCommonQuestionsRemoteDataSource>(),
          baseRepository: gh<_i499.BaseRepository>(),
        ));
    gh.factory<_i935.LevelsBloc>(
        () => _i935.LevelsBloc(gh<_i935.LevelsUseCase>()));
    gh.lazySingleton<_i218.GradeChoosingUseCase>(() =>
        _i218.GradeChoosingUseCase(
            repository: gh<_i218.GradeChoosingBaseRepository>()));
    gh.lazySingleton<_i496.GetClassRoomUseCase>(() => _i496.GetClassRoomUseCase(
        repository: gh<_i218.GradeChoosingBaseRepository>()));
    gh.lazySingleton<_i86.GetPathsUseCase>(() => _i86.GetPathsUseCase(
        repository: gh<_i218.GradeChoosingBaseRepository>()));
    gh.lazySingleton<_i565.GetStagesUseCase>(() => _i565.GetStagesUseCase(
        repository: gh<_i218.GradeChoosingBaseRepository>()));
    gh.lazySingleton<_i412.GetSystemTypesUseCase>(() =>
        _i412.GetSystemTypesUseCase(
            repository: gh<_i218.GradeChoosingBaseRepository>()));
    gh.lazySingleton<_i868.GetTermsUseCase>(() => _i868.GetTermsUseCase(
        repository: gh<_i218.GradeChoosingBaseRepository>()));
    gh.lazySingleton<_i705.SocialLoginBaseRepository>(
        () => _i791.SocialLoginRepositoryImpl(
              socialLoginBaseRemoteDataSource:
                  gh<_i723.SocialLoginBaseRemoteDataSource>(),
              userLocalDataSource: gh<_i850.UserLocalDataSource>(),
              baseRepository: gh<_i499.BaseRepository>(),
              networkInfo: gh<_i571.NetworkInfo>(),
            ));
    gh.lazySingleton<_i605.PaymentSuccessBaseRepository>(
        () => _i338.PaymentSuccessRepositoryImpl(
              gh<_i499.BaseRepository>(),
              gh<_i232.PaymentSuccessRemoteDataSource>(),
            ));
    gh.lazySingleton<_i924.EditProfileBaseRepository>(
        () => _i924.EditProfileRepository(
              remoteDataSource: gh<_i924.EditProfileRemoteDataSource>(),
              baseRepository: gh<_i499.BaseRepository>(),
              userLocalDataSource: gh<_i850.UserLocalDataSource>(),
            ));
    gh.lazySingleton<_i926.GetQuestionsUseCase>(() => _i926.GetQuestionsUseCase(
        repository: gh<_i926.QuestionsBaseRepository>()));
    gh.lazySingleton<_i926.SendTheAnswerOfQuestionUseCase>(() =>
        _i926.SendTheAnswerOfQuestionUseCase(
            repository: gh<_i926.QuestionsBaseRepository>()));
    gh.lazySingleton<_i926.ReportQuestionUseCase>(() =>
        _i926.ReportQuestionUseCase(
            repository: gh<_i926.QuestionsBaseRepository>()));
    gh.lazySingleton<_i247.GetFailSkillsQuestionsUseCase>(() =>
        _i247.GetFailSkillsQuestionsUseCase(
            repository: gh<_i247.BaseStaticsRepository>()));
    gh.lazySingleton<_i247.GetFailSkillsStaticsUseCase>(() =>
        _i247.GetFailSkillsStaticsUseCase(
            repository: gh<_i247.BaseStaticsRepository>()));
    gh.lazySingleton<_i247.GetTimeInAppUseCase>(() => _i247.GetTimeInAppUseCase(
        repository: gh<_i247.BaseStaticsRepository>()));
    gh.lazySingleton<_i247.GetSubjectsForStaticsUseCase>(() =>
        _i247.GetSubjectsForStaticsUseCase(
            repository: gh<_i247.BaseStaticsRepository>()));
    gh.lazySingleton<_i247.GetLessonsStaticsUseCase>(() =>
        _i247.GetLessonsStaticsUseCase(
            repository: gh<_i247.BaseStaticsRepository>()));
    gh.lazySingleton<_i247.GetLevelStaticsUseCase>(() =>
        _i247.GetLevelStaticsUseCase(
            repository: gh<_i247.BaseStaticsRepository>()));
    gh.lazySingleton<_i247.GetBestSubjectsUseCase>(() =>
        _i247.GetBestSubjectsUseCase(
            repository: gh<_i247.BaseStaticsRepository>()));
    gh.lazySingleton<_i407.GlobalBaseRepository>(() => _i987.GlobalRepository(
          remoteDataSource: gh<_i743.GlobalBaseRemoteDataSource>(),
          baseRepository: gh<_i499.BaseRepository>(),
          userLocalDataSource: gh<_i850.UserLocalDataSource>(),
        ));
    gh.lazySingleton<_i211.RandomExamsBaseRepository>(
        () => _i211.RandomExamsRepository(
              remoteDataSource: gh<_i211.RandomExamsRemoteDataSource>(),
              baseRepository: gh<_i499.BaseRepository>(),
            ));
    gh.factory<_i155.SimulatedBloc>(() => _i155.SimulatedBloc(
          gh<_i155.GetSimulatedPlansUseCase>(),
          gh<_i155.GetSimulatedExamsUseCase>(),
          gh<_i155.GetSimulatedModelAnswersUseCase>(),
          gh<_i155.SubmitExamAnswerUseCase>(),
        ));
    gh.lazySingleton<_i335.GetSharedSubjectsUseCase>(() =>
        _i335.GetSharedSubjectsUseCase(
            repository: gh<_i335.SubjectsSharedFeaturesBaseRepository>()));
    gh.lazySingleton<_i211.CreateRandomExamsUseCase>(() =>
        _i211.CreateRandomExamsUseCase(
            repository: gh<_i211.RandomExamsBaseRepository>()));
    gh.lazySingleton<_i211.RandomExamsQuestionsAnswersUseCase>(() =>
        _i211.RandomExamsQuestionsAnswersUseCase(
            repository: gh<_i211.RandomExamsBaseRepository>()));
    gh.lazySingleton<_i211.AllRandomExamsUseCase>(() =>
        _i211.AllRandomExamsUseCase(
            repository: gh<_i211.RandomExamsBaseRepository>()));
    gh.lazySingleton<_i211.RepeatRandomExamsUseCase>(() =>
        _i211.RepeatRandomExamsUseCase(
            repository: gh<_i211.RandomExamsBaseRepository>()));
    gh.lazySingleton<_i793.SocialRegisterCodeUseCase>(() =>
        _i793.SocialRegisterCodeUseCase(
            repository: gh<_i614.SocialRegisterBaseRepository>()));
    gh.lazySingleton<_i697.RankBaseRepository>(() => _i697.RankRepository(
          remoteDataSource: gh<_i697.RankRemoteDataSource>(),
          baseRepository: gh<_i499.BaseRepository>(),
        ));
    gh.lazySingleton<_i635.TermsAndConditionsBaseRepository>(
        () => _i635.TermsAndConditionsRepository(
              localDataSource: gh<_i635.GetTermsAndConditionsLocalDataSource>(),
              remoteDataSource: gh<_i635.TermsAndConditionsRemoteDataSource>(),
              baseRepository: gh<_i499.BaseRepository>(),
            ));
    gh.lazySingleton<_i697.GetStageRankUseCase>(() =>
        _i697.GetStageRankUseCase(repository: gh<_i697.RankBaseRepository>()));
    gh.lazySingleton<_i697.GetClassroomRankUseCase>(() =>
        _i697.GetClassroomRankUseCase(
            repository: gh<_i697.RankBaseRepository>()));
    gh.lazySingleton<_i697.GetTermRankUseCase>(() =>
        _i697.GetTermRankUseCase(repository: gh<_i697.RankBaseRepository>()));
    gh.lazySingleton<_i697.GetSubjectRankUseCase>(() =>
        _i697.GetSubjectRankUseCase(
            repository: gh<_i697.RankBaseRepository>()));
    gh.lazySingleton<_i269.DeleteAllDataInCartUseCase>(
        () => _i269.DeleteAllDataInCartUseCase(gh<_i791.CartRepository>()));
    gh.factory<_i608.VerificationBloc>(() => _i608.VerificationBloc(
          gh<_i608.CheckVerificationCodeUseCase>(),
          gh<_i608.ResendVerificationCodeUseCase>(),
          gh<_i608.SignUpUseCase>(),
        ));
    gh.factory<_i379.SubscriptionsAndPackagesSubjectsBloc>(() =>
        _i379.SubscriptionsAndPackagesSubjectsBloc(
            gh<_i277.GetSubjectsUseCase>()));
    gh.lazySingleton<_i1011.GetAppleDataUseCase>(() =>
        _i1011.GetAppleDataUseCase(
            getSocialDataBaseRepository:
                gh<_i841.GetSocialDataBaseRepository>()));
    gh.lazySingleton<_i445.GetGoogleDataUseCase>(() =>
        _i445.GetGoogleDataUseCase(
            getSocialDataBaseRepository:
                gh<_i841.GetSocialDataBaseRepository>()));
    gh.factory<_i746.SubscriptionSystemsBloc>(
        () => _i746.SubscriptionSystemsBloc(
              gh<_i717.GetChildSubscriptionsSystemsUseCase>(),
              gh<_i327.GetChildSubscriptionsStagesUseCase>(),
              gh<_i1020.GetChildSubscriptionsClassRoomUseCase>(),
              gh<_i1004.GetChildSubscriptionsTermsUseCase>(),
              gh<_i1060.GetChildSubscriptionsPathsUseCase>(),
              gh<_i508.GetChildSubscriptionsSubjectsUseCase>(),
            ));
    gh.lazySingleton<_i1010.GetAllSubscriptionUseCase>(() =>
        _i1010.GetAllSubscriptionUseCase(
            repository: gh<_i833.AllSubscriptionRepository>()));
    gh.lazySingleton<_i685.ExamsBaseRepository>(() => _i685.ExamsRepository(
          remoteDataSource: gh<_i685.ExamsRemoteDataSource>(),
          baseRepository: gh<_i499.BaseRepository>(),
        ));
    gh.lazySingleton<_i28.UnLinkUseCase>(
        () => _i28.UnLinkUseCase(repository: gh<_i28.UnLinkRepository>()));
    gh.lazySingleton<_i28.ChildAddNewParentUseCase>(() =>
        _i28.ChildAddNewParentUseCase(repository: gh<_i28.UnLinkRepository>()));
    gh.lazySingleton<_i28.ChildAddExistParentScreenUseCase>(() =>
        _i28.ChildAddExistParentScreenUseCase(
            repository: gh<_i28.UnLinkRepository>()));
    gh.lazySingleton<_i28.ParentAddNewChildUseCase>(() =>
        _i28.ParentAddNewChildUseCase(repository: gh<_i28.UnLinkRepository>()));
    gh.lazySingleton<_i28.ParentAddExistChildUseCase>(() =>
        _i28.ParentAddExistChildUseCase(
            repository: gh<_i28.UnLinkRepository>()));
    gh.lazySingleton<_i486.PaymentForNafeesSuccessBaseRepository>(
        () => _i298.PaymentForNafeesSuccessBaseRepositoryImpl(
              gh<_i499.BaseRepository>(),
              gh<_i430.PaymentSuccessForNafeesRemoteDataSource>(),
            ));
    gh.lazySingleton<_i745.ParentAddNewChildUseCase>(() =>
        _i745.ParentAddNewChildUseCase(
            repository: gh<_i543.ParentAddNewChildBaseRepository>()));
    gh.lazySingleton<_i744.InstitutionAddChildUseCase>(() =>
        _i744.InstitutionAddChildUseCase(
            repository: gh<_i744.InstitutionAddChildRepository>()));
    gh.lazySingleton<_i23.SocialLoginUseCase>(() =>
        _i23.SocialLoginUseCase(repository: gh<_i990.LoginBaseRepository>()));
    gh.lazySingleton<_i990.LoginUseCase>(
        () => _i990.LoginUseCase(repository: gh<_i990.LoginBaseRepository>()));
    gh.lazySingleton<_i712.DownloadUseCase>(() => _i712.DownloadUseCase(
        repository: gh<_i712.DownloadUploadBaseRepository>()));
    gh.lazySingleton<_i712.UploadUseCase>(() => _i712.UploadUseCase(
        repository: gh<_i712.DownloadUploadBaseRepository>()));
    gh.factory<_i231.ParentPreviewForChildBloc>(() =>
        _i231.ParentPreviewForChildBloc(
            gh<_i231.GetParentPreviewForChildUseCase>()));
    gh.lazySingleton<_i662.GetContactUsUseCase>(() => _i662.GetContactUsUseCase(
        repository: gh<_i231.ContactUsBaseRepository>()));
    gh.lazySingleton<_i448.AddOptionalSubjectRepository>(
        () => _i841.AddOptionalSubjectRepositoryImpl(
              gh<_i499.BaseRepository>(),
              gh<_i395.AddOptionalSubjectDataSource>(),
            ));
    gh.lazySingleton<_i592.SendVerificationCodeUseCase>(() =>
        _i592.SendVerificationCodeUseCase(
            repository: gh<_i592.SignUpBaseRepository>()));
    gh.factory<_i660.CouponsBloc>(
        () => _i660.CouponsBloc(gh<_i282.CouponUseCase>()));
    gh.factory<_i528.LessonsBloc>(() => _i528.LessonsBloc(
          gh<_i528.GetLessonsUseCase>(),
          gh<_i528.GetLessonsByUnitUseCase>(),
        ));
    gh.lazySingleton<_i1004.GetQuranTextUseCase>(() =>
        _i1004.GetQuranTextUseCase(
            repository: gh<_i1004.QuranBaseRepository>()));
    gh.lazySingleton<_i1004.GetQuranAudioUseCase>(() =>
        _i1004.GetQuranAudioUseCase(
            repository: gh<_i1004.QuranBaseRepository>()));
    gh.lazySingleton<_i1004.GetQuranTafseerUseCase>(() =>
        _i1004.GetQuranTafseerUseCase(
            repository: gh<_i1004.QuranBaseRepository>()));
    gh.lazySingleton<_i1004.GetQuranPageUseCase>(() =>
        _i1004.GetQuranPageUseCase(
            repository: gh<_i1004.QuranBaseRepository>()));
    gh.lazySingleton<_i234.NotificationUseCase>(() => _i234.NotificationUseCase(
        repository: gh<_i813.NotificationRepository>()));
    gh.lazySingleton<_i234.ReadAllNotificationUseCase>(() =>
        _i234.ReadAllNotificationUseCase(
            repository: gh<_i813.NotificationRepository>()));
    gh.lazySingleton<_i234.UpdateNotificationUseCase>(() =>
        _i234.UpdateNotificationUseCase(
            repository: gh<_i813.NotificationRepository>()));
    gh.factory<_i908.AddParentBloc>(
        () => _i908.AddParentBloc(gh<_i448.AddParentUseCase>()));
    gh.factory<_i1018.FreeSubjectsSubscriptionsBloc>(
        () => _i1018.FreeSubjectsSubscriptionsBloc(
              gh<_i412.GetSystemTypesUseCase>(),
              gh<_i565.GetStagesUseCase>(),
              gh<_i496.GetClassRoomUseCase>(),
              gh<_i868.GetTermsUseCase>(),
              gh<_i86.GetPathsUseCase>(),
              gh<_i1018.GetSubjectsFreeSubjectsSubscriptionsUseCase>(),
            ));
    gh.lazySingleton<_i350.GetAllCommonQuestionUseCase>(() =>
        _i350.GetAllCommonQuestionUseCase(
            repository: gh<_i350.ChildCommonQuestionsBaseRepository>()));
    gh.lazySingleton<_i858.ReviewRepository>(() => _i342.ReviewRepositoryImpl(
          gh<_i499.BaseRepository>(),
          gh<_i708.ReviewRemoteDataSource>(),
        ));
    gh.lazySingleton<_i541.InvitationRepository>(
        () => _i658.InvitationRepositoryImpl(
              gh<_i499.BaseRepository>(),
              gh<_i580.GetInvitationRemoteDataSource>(),
            ));
    gh.lazySingleton<_i1046.AddOptionalSubjectUseCase>(() =>
        _i1046.AddOptionalSubjectUseCase(
            gh<_i3.SubjectSubscriptionRepository>()));
    gh.lazySingleton<_i368.AddSubjectUseCase>(
        () => _i368.AddSubjectUseCase(gh<_i3.SubjectSubscriptionRepository>()));
    gh.lazySingleton<_i407.DeleteSubjectUseCase>(() =>
        _i407.DeleteSubjectUseCase(gh<_i3.SubjectSubscriptionRepository>()));
    gh.lazySingleton<_i791.SubjectSubscriptionsUseCase>(() =>
        _i791.SubjectSubscriptionsUseCase(
            gh<_i3.SubjectSubscriptionRepository>()));
    gh.factory<_i744.InstitutionAddChildBloc>(() =>
        _i744.InstitutionAddChildBloc(gh<_i744.InstitutionAddChildUseCase>()));
    gh.lazySingleton<_i448.GetNafeesPlansUseCase>(() =>
        _i448.GetNafeesPlansUseCase(
            repository: gh<_i448.NafeesBaseRepository>()));
    gh.lazySingleton<_i448.GetNafeesExamsUseCase>(() =>
        _i448.GetNafeesExamsUseCase(
            repository: gh<_i448.NafeesBaseRepository>()));
    gh.lazySingleton<_i448.GetNafeesModelAnswersUseCase>(() =>
        _i448.GetNafeesModelAnswersUseCase(
            repository: gh<_i448.NafeesBaseRepository>()));
    gh.lazySingleton<_i448.SubmitExamAnswerUseCase>(() =>
        _i448.SubmitExamAnswerUseCase(
            repository: gh<_i448.NafeesBaseRepository>()));
    gh.factory<_i340.FreeTermSubscriptionsBloc>(
        () => _i340.FreeTermSubscriptionsBloc(
              gh<_i412.GetSystemTypesUseCase>(),
              gh<_i565.GetStagesUseCase>(),
              gh<_i496.GetClassRoomUseCase>(),
              gh<_i868.GetTermsUseCase>(),
              gh<_i86.GetPathsUseCase>(),
            ));
    gh.factory<_i247.StaticsBloc>(() => _i247.StaticsBloc(
          gh<_i247.GetTimeInAppUseCase>(),
          gh<_i247.GetSubjectsForStaticsUseCase>(),
          gh<_i247.GetLessonsStaticsUseCase>(),
          gh<_i247.GetBestSubjectsUseCase>(),
        ));
    gh.lazySingleton<_i380.AddClassRoomToCartUseCase>(() =>
        _i380.AddClassRoomToCartUseCase(
            repository: gh<_i175.PackagesRepository>()));
    gh.lazySingleton<_i566.AddSubjectToCartUseCase>(() =>
        _i566.AddSubjectToCartUseCase(
            repository: gh<_i175.PackagesRepository>()));
    gh.lazySingleton<_i268.AddTermToCartUseCase>(() =>
        _i268.AddTermToCartUseCase(repository: gh<_i175.PackagesRepository>()));
    gh.factory<_i277.HomeBloc>(() => _i277.HomeBloc(
          gh<_i277.GetPuzzleAndAdviceUseCase>(),
          gh<_i277.GetSubjectsUseCase>(),
          gh<_i850.UserLocalDataSource>(),
        ));
    gh.factory<_i926.QuestionsBloc>(() => _i926.QuestionsBloc(
          gh<_i926.GetQuestionsUseCase>(),
          gh<_i926.SendTheAnswerOfQuestionUseCase>(),
          gh<_i926.ReportQuestionUseCase>(),
        ));
    gh.factory<_i247.SkillStaticsBloc>(() => _i247.SkillStaticsBloc(
          gh<_i247.GetFailSkillsStaticsUseCase>(),
          gh<_i247.GetFailSkillsQuestionsUseCase>(),
          gh<_i926.SendTheAnswerOfQuestionUseCase>(),
        ));
    gh.lazySingleton<_i401.GetInvitationUseCase>(
        () => _i401.GetInvitationUseCase(gh<_i541.InvitationRepository>()));
    gh.factory<_i173.CartBloc>(() => _i173.CartBloc(
          gh<_i64.ViewCartUseCase>(),
          gh<_i269.DeleteAllDataInCartUseCase>(),
        ));
    gh.factory<_i551.CollectionsBloc>(
        () => _i551.CollectionsBloc(gh<_i551.CollectionsUseCase>()));
    gh.factory<_i430.ParentHomeBloc>(
        () => _i430.ParentHomeBloc(gh<_i911.GetAllChildForParentUseCase>()));
    gh.lazySingleton<_i28.PaymentSuccessForNafeesUseCase>(() =>
        _i28.PaymentSuccessForNafeesUseCase(
            repository: gh<_i486.PaymentForNafeesSuccessBaseRepository>()));
    gh.lazySingleton<_i943.PaymentSuccessUseCase>(() =>
        _i943.PaymentSuccessUseCase(
            repository: gh<_i605.PaymentSuccessBaseRepository>()));
    gh.factory<_i552.PackagesAndSubscriptionsBloc>(
        () => _i552.PackagesAndSubscriptionsBloc(
              gh<_i368.AddSubjectUseCase>(),
              gh<_i1046.AddOptionalSubjectUseCase>(),
              gh<_i407.DeleteSubjectUseCase>(),
              gh<_i791.SubjectSubscriptionsUseCase>(),
            ));
    gh.factory<_i697.RankBloc>(() => _i697.RankBloc(
          gh<_i697.GetStageRankUseCase>(),
          gh<_i697.GetClassroomRankUseCase>(),
          gh<_i697.GetTermRankUseCase>(),
          gh<_i697.GetSubjectRankUseCase>(),
          gh<_i508.GetChildSubscriptionsSubjectsUseCase>(),
        ));
    gh.lazySingleton<_i635.GetTermsAndConditionsUseCase>(() =>
        _i635.GetTermsAndConditionsUseCase(
            repository: gh<_i635.TermsAndConditionsBaseRepository>()));
    gh.lazySingleton<_i15.AddOptionalSubjectUsecase>(() =>
        _i15.AddOptionalSubjectUsecase(
            repository: gh<_i448.AddOptionalSubjectRepository>()));
    gh.factory<_i28.UnLinkBloc>(() => _i28.UnLinkBloc(
          gh<_i28.UnLinkUseCase>(),
          gh<_i28.ChildAddExistParentScreenUseCase>(),
          gh<_i28.ChildAddNewParentUseCase>(),
          gh<_i28.ParentAddNewChildUseCase>(),
          gh<_i28.ParentAddExistChildUseCase>(),
        ));
    gh.factory<_i247.StaticsLevelBloc>(
        () => _i247.StaticsLevelBloc(gh<_i247.GetLevelStaticsUseCase>()));
    gh.lazySingleton<_i656.AddReviewUseCase>(
        () => _i656.AddReviewUseCase(gh<_i858.ReviewRepository>()));
    gh.lazySingleton<_i584.GetAllReviewUseCase>(
        () => _i584.GetAllReviewUseCase(gh<_i858.ReviewRepository>()));
    gh.lazySingleton<_i628.DeleteReviewUseCase>(
        () => _i628.DeleteReviewUseCase(gh<_i858.ReviewRepository>()));
    gh.factory<_i990.LoginBloc>(() => _i990.LoginBloc(
          loginUseCase: gh<_i990.LoginUseCase>(),
          socialLoginUseCase: gh<_i23.SocialLoginUseCase>(),
        ));
    gh.factory<_i619.FreeGradeSubscriptionsBloc>(
        () => _i619.FreeGradeSubscriptionsBloc(
              gh<_i412.GetSystemTypesUseCase>(),
              gh<_i565.GetStagesUseCase>(),
              gh<_i496.GetClassRoomUseCase>(),
            ));
    gh.factory<_i711.ForgetPasswordBloc>(
        () => _i711.ForgetPasswordBloc(gh<_i711.ForgetPasswordUseCase>()));
    gh.factory<_i218.GradeChoosingBloc>(() => _i218.GradeChoosingBloc(
          gh<_i218.GradeChoosingUseCase>(),
          gh<_i565.GetStagesUseCase>(),
          gh<_i496.GetClassRoomUseCase>(),
          gh<_i868.GetTermsUseCase>(),
          gh<_i412.GetSystemTypesUseCase>(),
          gh<_i86.GetPathsUseCase>(),
        ));
    gh.factory<_i613.PackagesBloc>(() => _i613.PackagesBloc(
          gh<_i380.AddClassRoomToCartUseCase>(),
          gh<_i268.AddTermToCartUseCase>(),
          gh<_i566.AddSubjectToCartUseCase>(),
        ));
    gh.factory<_i978.AllSubscriptionBloc>(() =>
        _i978.AllSubscriptionBloc(gh<_i1010.GetAllSubscriptionUseCase>()));
    gh.factory<_i731.CouponBloc>(() => _i731.CouponBloc(
          gh<_i816.CheckCouponUseCase>(),
          gh<_i589.GetPaymentDataUseCase>(),
        ));
    gh.factory<_i635.TermsAndConditionsBloc>(() =>
        _i635.TermsAndConditionsBloc(gh<_i635.GetTermsAndConditionsUseCase>()));
    gh.factory<_i335.SharedSubjectsBloc>(
        () => _i335.SharedSubjectsBloc(gh<_i335.GetSharedSubjectsUseCase>()));
    gh.factory<_i44.InstitutionHomeBloc>(() => _i44.InstitutionHomeBloc(
        gh<_i572.GetAllParentsForInstitutionUseCase>()));
    gh.lazySingleton<_i618.GetGoogleIdAndUserDataByGoogleAccountUseCase>(() =>
        _i618.GetGoogleIdAndUserDataByGoogleAccountUseCase(
            socialLoginBaseRepository: gh<_i705.SocialLoginBaseRepository>()));
    gh.factory<_i350.ChildCommonQuestionsBloc>(() =>
        _i350.ChildCommonQuestionsBloc(
            gh<_i350.GetAllCommonQuestionUseCase>()));
    gh.lazySingleton<_i533.LogoutUseCase>(
        () => _i533.LogoutUseCase(repository: gh<_i46.MoreBaseRepository>()));
    gh.factory<_i522.InvitationBloc>(
        () => _i522.InvitationBloc(gh<_i401.GetInvitationUseCase>()));
    gh.lazySingleton<_i326.SendTimeUseCase>(() =>
        _i326.SendTimeUseCase(repository: gh<_i407.GlobalBaseRepository>()));
    gh.lazySingleton<_i326.CheckAppVersionUseCase>(() =>
        _i326.CheckAppVersionUseCase(
            repository: gh<_i407.GlobalBaseRepository>()));
    gh.lazySingleton<_i326.GetInfoUseCase>(() =>
        _i326.GetInfoUseCase(repository: gh<_i407.GlobalBaseRepository>()));
    gh.factory<_i908.SocialRegisterBloc>(
        () => _i908.SocialRegisterBloc(gh<_i793.SocialRegisterCodeUseCase>()));
    gh.lazySingleton<_i924.EditProfileUseCase>(() => _i924.EditProfileUseCase(
        repository: gh<_i924.EditProfileBaseRepository>()));
    gh.lazySingleton<_i924.ChangePasswordUseCase>(() =>
        _i924.ChangePasswordUseCase(
            repository: gh<_i924.EditProfileBaseRepository>()));
    gh.lazySingleton<_i326.GetGuestDataUseCase>(
        () => _i326.GetGuestDataUseCase(gh<_i407.GlobalBaseRepository>()));
    gh.factory<_i547.GetSocialDataBloc>(() => _i547.GetSocialDataBloc(
          getGoogleDataUseCase: gh<_i445.GetGoogleDataUseCase>(),
          getAppleDataUseCase: gh<_i1011.GetAppleDataUseCase>(),
        ));
    gh.factory<_i158.GlobalBloc>(() => _i158.GlobalBloc(
          gh<_i326.SendTimeUseCase>(),
          gh<_i326.GetGuestDataUseCase>(),
          gh<_i326.CheckAppVersionUseCase>(),
          gh<_i326.GetInfoUseCase>(),
        ));
    gh.factory<_i923.PaySuccessBloc>(
        () => _i923.PaySuccessBloc(gh<_i943.PaymentSuccessUseCase>()));
    gh.factory<_i1004.QuranBloc>(() => _i1004.QuranBloc(
          getQuranTextUseCase: gh<_i1004.GetQuranTextUseCase>(),
          getQuranAudioUseCase: gh<_i1004.GetQuranAudioUseCase>(),
          getQuranTafseerUseCase: gh<_i1004.GetQuranTafseerUseCase>(),
          getQuranPageUseCase: gh<_i1004.GetQuranPageUseCase>(),
        ));
    gh.factory<_i211.RandomExamsBloc>(() => _i211.RandomExamsBloc(
          gh<_i211.AllRandomExamsUseCase>(),
          gh<_i211.CreateRandomExamsUseCase>(),
          gh<_i211.RepeatRandomExamsUseCase>(),
          gh<_i211.RandomExamsQuestionsAnswersUseCase>(),
        ));
    gh.lazySingleton<_i374.SocialLoginUseCase>(() => _i374.SocialLoginUseCase(
        repository: gh<_i705.SocialLoginBaseRepository>()));
    gh.factory<_i863.OptionalSubjectBlocBloc>(() =>
        _i863.OptionalSubjectBlocBloc(gh<_i15.AddOptionalSubjectUsecase>()));
    gh.factory<_i757.ContactUsBloc>(
        () => _i757.ContactUsBloc(gh<_i662.GetContactUsUseCase>()));
    gh.factory<_i448.NafeesBloc>(() => _i448.NafeesBloc(
          gh<_i448.GetNafeesPlansUseCase>(),
          gh<_i448.GetNafeesExamsUseCase>(),
          gh<_i448.GetNafeesModelAnswersUseCase>(),
          gh<_i448.SubmitExamAnswerUseCase>(),
        ));
    gh.factory<_i178.PaySuccessForNafeesBloc>(() =>
        _i178.PaySuccessForNafeesBloc(
            gh<_i28.PaymentSuccessForNafeesUseCase>()));
    gh.factory<_i13.DownloadBloc>(
        () => _i13.DownloadBloc(gh<_i712.DownloadUseCase>()));
    gh.factory<_i73.ReviewBloc>(() => _i73.ReviewBloc(
          gh<_i584.GetAllReviewUseCase>(),
          gh<_i656.AddReviewUseCase>(),
          gh<_i628.DeleteReviewUseCase>(),
        ));
    gh.lazySingleton<_i685.ExamsUseCase>(
        () => _i685.ExamsUseCase(repository: gh<_i685.ExamsBaseRepository>()));
    gh.factory<_i861.NotificationBloc>(() => _i861.NotificationBloc(
          gh<_i234.NotificationUseCase>(),
          gh<_i234.ReadAllNotificationUseCase>(),
          gh<_i234.UpdateNotificationUseCase>(),
        ));
    gh.factory<_i176.SignWithSocialMediaBloc>(
        () => _i176.SignWithSocialMediaBloc(
              getGoogleIdAndUserDataByGoogleAccountUserCase:
                  gh<_i618.GetGoogleIdAndUserDataByGoogleAccountUseCase>(),
              socialLoginUseCase: gh<_i374.SocialLoginUseCase>(),
            ));
    gh.factory<_i592.SignUpBloc>(() => _i592.SignUpBloc(
          gh<_i592.SendVerificationCodeUseCase>(),
          gh<_i374.SocialLoginUseCase>(),
        ));
    gh.factory<_i187.MoreBloc>(() => _i187.MoreBloc(gh<_i533.LogoutUseCase>()));
    gh.factory<_i924.EditProfileBloc>(() => _i924.EditProfileBloc(
          gh<_i924.EditProfileUseCase>(),
          gh<_i924.ChangePasswordUseCase>(),
        ));
    gh.factory<_i685.ExamsBloc>(
        () => _i685.ExamsBloc(gh<_i685.ExamsUseCase>()));
    gh.factory<_i712.DownloadUploadBloc>(() => _i712.DownloadUploadBloc(
          gh<_i712.UploadUseCase>(),
          gh<_i685.ExamsUseCase>(),
        ));
    return this;
  }
}

class _$InjectableModule extends _i139.InjectableModule {}
