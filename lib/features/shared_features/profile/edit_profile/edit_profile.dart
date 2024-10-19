import 'dart:async';
import 'dart:io';
import 'package:dartz/dartz.dart' hide State;
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:injectable/injectable.dart';
import 'package:my_portfolio/config/resources/app_assets.dart';
import 'package:my_portfolio/config/resources/app_strings.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';
import 'package:my_portfolio/core/api/end_points.dart';
import 'package:my_portfolio/core/base_widgets/loading_widget.dart';
import 'package:my_portfolio/core/base_widgets/snackbar_widget.dart';
import 'package:my_portfolio/core/enum/enum_generation.dart';
import 'package:my_portfolio/core/services/services_locator.dart';
import 'package:my_portfolio/core/shared_models/user/user_entity/user_entity.dart';
import 'package:my_portfolio/core/shared_models/user/user_model/user_model.dart';
import 'package:my_portfolio/core/shared_widget/button_widget.dart';
import 'package:my_portfolio/core/shared_widget/text_form_field.dart';
import 'package:my_portfolio/core/validation/app_validation.dart';
import 'package:my_portfolio/my_app/app_reference.dart';
import '../../../../../../core/usecase/base_usecase.dart';
import '../../../../config/base_remote_data_source/base_remote_data_source.dart';
import '../../../../config/base_repository/base_repository.dart';
import '../../../../config/resources/app_colors.dart';
import '../../../../config/resources/app_text_style.dart';
import '../../../../config/resources/app_values.dart';
import '../../../../config/responsive/responsive_widget.dart';
import '../../../../config/routes/route_manager.dart';
import '../../../../config/routes/routes_names.dart';
import '../../../../core/failure/failure.dart';
import '../../../../core/shared_models/user/data/user_local_data_source/user_local_data_source.dart';
import '../../../../core/shared_widget/app_input_field/password_filed.dart';
import '../../../../core/shared_widget/custom_inkwell.dart';
import '../../../../core/shared_widget/select_gender.dart';
import '../../more/presentation/more_widgets/header_for_more.dart';

part 'data/edit_profile_data_source/edit_profile_remote_data_source.dart';

part 'data/edit_profile_models/edit_profile_model.dart';

part 'data/edit_profile_repository/edit_profile_repository.dart';

part 'domain/edit_profile_base_repository/edit_profile_base_repository.dart';

part 'domain/edit_profile_usecases/edit_profile_usecase.dart';

part 'domain/edit_profile_usecases/change_password_usecase.dart';

part 'presentation/view/edit_profile_screen/edit_profile_screen.dart';

part 'presentation/view/change_password_screen/change_password_screen.dart';

part 'presentation/edit_profile_view_model/edit_profile_bloc.dart';

part 'presentation/edit_profile_view_model/edit_profile_event.dart';

part 'presentation/edit_profile_view_model/edit_profile_state.dart';

part 'presentation/edit_profile_widgets/edit_profile_widgets.dart';
