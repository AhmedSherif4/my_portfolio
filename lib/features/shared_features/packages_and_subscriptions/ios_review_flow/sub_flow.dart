import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_portfolio/config/resources/app_colors.dart';
import 'package:my_portfolio/config/resources/app_values.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';
import 'package:my_portfolio/config/routes/route_manager.dart';
import 'package:my_portfolio/config/routes/routes_names.dart';
import 'package:my_portfolio/features/shared_features/subscriptions_and_packages/packages/presentation/view_model/packages_bloc.dart';
import 'package:my_portfolio/features/shared_features/subscriptions_and_packages/packages/presentation/view_model/packages_state.dart';
import 'package:my_portfolio/features/shared_features/subscriptions_and_packages/widgets/header_widget.dart';
import 'package:my_portfolio/my_app/app_reference.dart';
import '../../../../config/resources/app_text_style.dart';
import '../../../../core/base_widgets/loading_widget.dart';
import '../../../../core/base_widgets/snackbar_widget.dart';
import '../../../../core/enum/enum_generation.dart';
import '../../../../core/services/services_locator.dart';
import '../../subscriptions_and_packages/free_grade_subscriptions/free_grade_subscriptions.dart';

class SubFLow extends StatefulWidget {
  const SubFLow({
    super.key,
  });

  @override
  State<SubFLow> createState() => _SubFLowState();
}

class _SubFLowState extends State<SubFLow> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PackagesBloc>(
          create: (context) => getIt<PackagesBloc>(),
        ),
        BlocProvider<FreeGradeSubscriptionsBloc>(
          create: (context) => getIt<FreeGradeSubscriptionsBloc>()
            ..add(const GetStagesFreeGrade(systemId: 1)),
        ),
      ],
      child: BlocListener<PackagesBloc, PackagesState>(
        listener: (context, state) {
          switch (state.addClassroomToCartState) {
            case RequestStates.loading:
              showLoadingDialog(context);
              break;
            case RequestStates.loaded:
              Navigator.pop(context);
              showSnackBar(
                  description: state.addClassroomToCartMessage,
                  state: ToastStates.congrats,
                  context: context);
              break;
            case RequestStates.error:
              Navigator.pop(context);
              showSnackBar(
                  description: state.addClassroomToCartMessage,
                  state: ToastStates.error,
                  context: context);
              break;
            default:
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                if (AppReference.userIsParent())
                  const AppBarSubscriptionsWidget(
                    childID: null,
                  ),
                Center(
                  child: Text(
                    'App  Subscriptions',
                    style: AppTextStyle.titleLarge22,
                  ),
                ),
                AppSize.s20.sizedBoxHeight,
                InkWell(
                  onTap: AppReference.userIsGuest()
                      ? () {
                          AppReference.guestDialogMustLogin(context);
                        }
                      : () {
                          RouteManager.rPushNamed(
                              context: context,
                              rName: AppRoutesNames.rInAppPurchasePayment,
                              arguments: ClassroomForCartEntity(
                                  classroomName: 'class room',
                                  classroomID: 1,
                                  classroomPrice: 219));
                        },
                  child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor2,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Classroom Subscription',
                            style: AppTextStyle.bodyMedium14,
                          ),
                          Row(
                            children: [
                              Text('219 ريال',
                                  style: AppTextStyle.bodyMedium14),
                              IconButton(
                                icon: const Icon(Icons.arrow_forward_ios),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ],
                      )),
                )
              ],
            ),
          ).paddingBody(),
        ),
      ),
    );
  }
}

class ClassroomForCartEntity {
  final String classroomName;
  final int classroomID;
  final int classroomPrice;

  ClassroomForCartEntity(
      {required this.classroomName,
      required this.classroomID,
      required this.classroomPrice});
}
