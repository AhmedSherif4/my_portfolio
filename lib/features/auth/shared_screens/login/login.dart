library login;

import 'dart:async';
import 'package:dartz/dartz.dart' hide State;
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:injectable/injectable.dart';
import 'package:my_portfolio/config/base_remote_data_source/base_remote_data_source.dart';
import 'package:my_portfolio/config/base_repository/base_repository.dart';
import 'package:my_portfolio/config/resources/app_assets.dart';
import 'package:my_portfolio/config/resources/app_strings.dart';
import 'package:my_portfolio/config/resources/app_values.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';
import 'package:my_portfolio/config/responsive/responsive_widget.dart';
import 'package:my_portfolio/config/routes/routes_names.dart';
import 'package:my_portfolio/config/storages/secure_storage.dart';
import 'package:my_portfolio/core/api/end_points.dart';
import 'package:my_portfolio/core/base_widgets/loading_shimmer_widget.dart';
import 'package:my_portfolio/core/base_widgets/loading_widget.dart';
import 'package:my_portfolio/core/base_widgets/snackbar_widget.dart';
import 'package:my_portfolio/core/enum/enum_generation.dart';
import 'package:my_portfolio/core/failure/failure.dart';
import 'package:my_portfolio/core/services/services_locator.dart';
import 'package:my_portfolio/core/shared_widget/app_input_field/phone_filed.dart';
import 'package:my_portfolio/core/shared_widget/button_widget.dart';
import 'package:my_portfolio/core/shared_widget/default_drop_down_button.dart';
import 'package:my_portfolio/core/shared_widget/error_widget.dart';
import 'package:my_portfolio/core/shared_widget/select_type_of_user.dart';
import 'package:my_portfolio/core/shared_widget/text_button_widget.dart';
import 'package:my_portfolio/features/shared_features/contact_us/presentations/view_model/contact_us_bloc.dart';
import 'package:my_portfolio/features/shared_features/get_social_data/presentation/get_social_view/get_social_view.dart';
import 'package:my_portfolio/my_app/app_analytics.dart';
import 'package:my_portfolio/my_app/app_reference.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../../config/routes/route_manager.dart';
import '../../../../../../core/usecase/base_usecase.dart';
import '../../../../config/notification/notification_setup.dart';
import '../../../../config/resources/app_colors.dart';
import '../../../../core/shared_models/auth_entity/auth_entity.dart';
import '../../../../config/resources/app_text_style.dart';
import '../../../../core/shared_models/user/data/user_local_data_source/user_local_data_source.dart';
import '../../../../core/shared_models/user/user_entity/user_entity.dart';
import '../../../../core/shared_widget/app_input_field/password_filed.dart';
import '../../../../core/shared_widget/custom_inkwell.dart';
import '../../../../core/shared_widget/text_back_button.dart';
import '../../../shared_features/get_social_data/domain/entity/social_login_data_entity.dart';
import 'data/models/login_model.dart';
import 'domain/login_usecases/social_login_use_case.dart';

part 'data/login_data_source/login_remote_data_source.dart';

part 'data/login_repository/login_repository.dart';

part 'domain/login_base_repository/login_base_repository.dart';

part 'domain/login_usecases/login_usecase.dart';

part 'presentation/login_screen/login_screen.dart';

part 'presentation/login_view_model/login_bloc.dart';

part 'presentation/login_view_model/login_event.dart';

part 'presentation/login_view_model/login_state.dart';

part 'presentation/widgets/widgets.dart';
