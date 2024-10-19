library verification;

import 'dart:async';
import 'dart:convert';

import 'package:dartz/dartz.dart' hide State;
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:injectable/injectable.dart';
import 'package:my_portfolio/config/base_remote_data_source/base_remote_data_source.dart';
import 'package:my_portfolio/config/base_repository/base_repository.dart';
import 'package:my_portfolio/config/notification/notification_setup.dart';
import 'package:my_portfolio/config/resources/app_strings.dart';
import 'package:my_portfolio/config/resources/app_text_style.dart';
import 'package:my_portfolio/config/resources/app_values.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';
import 'package:my_portfolio/config/responsive/responsive_widget.dart';
import 'package:my_portfolio/config/routes/route_manager.dart';
import 'package:my_portfolio/config/routes/routes_names.dart';
import 'package:my_portfolio/config/storages/secure_storage.dart';
import 'package:my_portfolio/core/api/api_consumer.dart';
import 'package:my_portfolio/core/api/end_points.dart';
import 'package:my_portfolio/core/api/network_info.dart';
import 'package:my_portfolio/core/base_widgets/loading_widget.dart';
import 'package:my_portfolio/core/base_widgets/snackbar_widget.dart';
import 'package:my_portfolio/core/exceptions/exceptions.dart';
import 'package:my_portfolio/core/failure/failure.dart';
import 'package:my_portfolio/core/services/services_locator.dart';
import 'package:my_portfolio/core/shared_models/user/user_entity/user_entity.dart';
import 'package:my_portfolio/core/shared_widget/text_back_button.dart';
import 'package:my_portfolio/features/auth/shared_screens/sign_up/sign_up.dart';
import 'package:my_portfolio/features/auth/shared_screens/verification/data/model/sign_up_model.dart';
import 'package:my_portfolio/my_app/app_analytics.dart';

import '../../../../../../../core/usecase/base_usecase.dart';
import '../../../../config/resources/app_assets.dart';
import '../../../../config/storages/keys.dart';
import '../../../../core/enum/enum_generation.dart';
import '../../../../core/shared_models/auth_entity/auth_entity.dart';
import '../../../../core/shared_models/user/data/user_local_data_source/user_local_data_source.dart';
import '../../../../core/shared_widget/button_widget.dart';
import '../../../../core/shared_widget/pin_code_filed_item.dart';
import '../../../../core/shared_widget/text_button_widget.dart';
import '../../../../my_app/app_reference.dart';

part 'data/verification_data_source/verification_remote_data_source.dart';
part 'data/verification_repository/verification_repository.dart';
part 'domain/verification_base_repository/verification_base_repository.dart';
part 'domain/verification_usecases/verification_usecase.dart';
part 'presentation/verification_screen/verification_screen.dart';
part 'presentation/verification_view_model/verification_bloc.dart';
part 'presentation/verification_view_model/verification_event.dart';
part 'presentation/verification_view_model/verification_state.dart';
