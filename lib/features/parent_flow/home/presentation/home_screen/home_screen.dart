import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_portfolio/config/resources/app_values.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';
import 'package:my_portfolio/config/routes/route_manager.dart';
import 'package:my_portfolio/config/routes/routes_names.dart';
import 'package:my_portfolio/core/shared_widget/add_parent_or_child_button.dart';

import '../../../../../config/extensions/color_extension.dart';
import '../../../../../config/resources/app_assets.dart';
import '../../../../../core/services/services_locator.dart';
import '../../../../../core/shared_models/user/data/user_local_data_source/user_local_data_source.dart';
import '../../../../../core/shared_widget/child_widget_for_parent_and_institution.dart';
import '../../../../institution_flow/institution_shared_widget/institution_header.dart';
import '../../../../shared_features/notification/presentation/view_model/notification_bloc.dart';
import '../home_view_model/parent_home_bloc.dart';

class ParentHomeScreen extends StatefulWidget {
  const ParentHomeScreen({super.key});

  @override
  State<ParentHomeScreen> createState() => _ParentHomeScreenState();
}

class _ParentHomeScreenState extends State<ParentHomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<ParentHomeBloc>().add(
              const GetAllChildForParentEvent(),
            );
        context.read<NotificationBloc>().add(
              const GetAllNotificationEvent(pageNumber: 1),
            );
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            InstitutionAndParentHeader(
              title: getIt<UserLocalDataSource>().getUserData()!.name,
              withBackButton: false,
            ),
            AppSize.s30.sizedBoxHeight,
            AddParentOrChildButton(
              onTap: () {
                RouteManager.rPushNamed(
                  context: context,
                  rName: AppRoutesNames.rParentAddChildWays,
                );
              },
              buttonLabel: 'أضف طفل',
              backgroundColor: HexColor.fromHex('#eaf1fa'),
              svgPath: AppImagesAssets.sAddUser,
            ),
            AppSize.s30.sizedBoxHeight,
            const AllChildBuilder(),
          ],
        ).paddingBody(),
      ),
    );
  }
}
