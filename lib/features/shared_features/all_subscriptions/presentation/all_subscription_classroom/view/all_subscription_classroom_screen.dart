import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_portfolio/config/resources/app_colors.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';
import 'package:my_portfolio/core/shared_models/user/user_entity/user_entity.dart';
import 'package:my_portfolio/features/shared_features/all_subscriptions/presentation/all_subscription_classroom/view/wisget/all_subscription_header.dart';
import 'package:my_portfolio/features/shared_features/all_subscriptions/presentation/all_subscription_classroom/view/wisget/all_sububscription_item.dart';
import 'package:my_portfolio/features/shared_features/all_subscriptions/presentation/all_subscription_classroom/view_model/all_subscription_bloc.dart';
import '../../../../../../core/services/services_locator.dart';

class AllSubscriptionClassroomScreen extends StatelessWidget {
  final UserEntity userData;

  const AllSubscriptionClassroomScreen({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AllSubscriptionBloc>()
        ..add(GetAllSubscriptionEvent(
          childId: userData.userId,
        )),
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: Column(
            children: [
              const AllSubscriptionHeader(
                title: 'تفاصيل الاشتراك',
                body: 'الصفوف المشترك فيها',
              ),
              20.sizedBoxHeight,
              Expanded(
                  child: AllSubscriptionBuilder(
                childId: userData.userId,
              )),
            ],
          ),
        ),
      ),
    );
  }
}
