library forget_password;

import 'package:dartz/dartz.dart' hide State;
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:injectable/injectable.dart';
import 'package:my_portfolio/config/base_repository/base_repository.dart';
import 'package:my_portfolio/config/resources/app_text_style.dart';
import 'package:my_portfolio/config/resources/app_values.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';
import 'package:my_portfolio/config/responsive/responsive_widget.dart';
import 'package:my_portfolio/core/api/end_points.dart';
import 'package:my_portfolio/core/base_widgets/loading_widget.dart';
import 'package:my_portfolio/core/base_widgets/snackbar_widget.dart';
import 'package:my_portfolio/core/enum/enum_generation.dart';
import 'package:my_portfolio/core/shared_widget/app_input_field/phone_filed.dart';
import 'package:my_portfolio/core/shared_widget/button_widget.dart';
import 'package:my_portfolio/core/shared_widget/select_type_of_user.dart';
import 'package:my_portfolio/core/shared_widget/text_back_button.dart';
import 'package:my_portfolio/my_app/app_reference.dart';

import '../../../../config/base_remote_data_source/base_remote_data_source.dart';
import '../../../../config/resources/app_assets.dart';
import '../../../../config/resources/app_strings.dart';
import '../../../../core/failure/failure.dart';
import '../../../../core/usecase/base_usecase.dart';

part 'data/forget_password_data_source/forget_password_remote_data_source.dart';
part 'data/forget_password_repository/forget_password_repository.dart';
part 'domain/forget_password_base_repository/forget_password_base_repository.dart';
part 'domain/forget_password_usecases/forget_password_usecase.dart';
part 'presentation/forget_password_screen/forget_password_screen.dart';
part 'presentation/forget_password_view_model/forget_password_bloc.dart';
part 'presentation/forget_password_view_model/forget_password_event.dart';
part 'presentation/forget_password_view_model/forget_password_state.dart';
