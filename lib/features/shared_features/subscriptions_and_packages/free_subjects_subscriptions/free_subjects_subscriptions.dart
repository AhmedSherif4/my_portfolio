import 'dart:async';

import 'package:dartz/dartz.dart' hide State;
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:my_portfolio/config/resources/app_strings.dart';
import 'package:my_portfolio/config/resources/app_text_style.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';
import 'package:my_portfolio/core/api/end_points.dart';
import 'package:my_portfolio/core/base_widgets/loading_shimmer_widget.dart';
import 'package:my_portfolio/core/enum/enum_generation.dart';
import 'package:my_portfolio/core/shared_models/user/user_entity/user_entity.dart';
import 'package:my_portfolio/core/shared_widget/button_widget.dart';
import 'package:my_portfolio/features/child_flow/home/data/home_models/subject_model.dart';
import 'package:my_portfolio/features/child_flow/home/domain/home_entities/subjects_entity.dart';
import 'package:my_portfolio/features/shared_features/subscriptions_and_packages/data/subject_data.dart';
import 'package:my_portfolio/my_app/app_reference.dart';


import '../../../../../../core/usecase/base_usecase.dart';
import '../../../../config/base_remote_data_source/base_remote_data_source.dart';
import '../../../../config/base_repository/base_repository.dart';
import '../../../../config/routes/route_manager.dart';
import '../../../../config/routes/routes_names.dart';
import '../../../../core/failure/failure.dart';
import '../../../../core/shared_widget/default_drop_down_button.dart';

import '../../../child_flow/questions/shared/data/go_to_question_parameter.dart';
import '../../../shared_logic/classrooms_logic/classrooms_logic.dart';
import '../../../shared_logic/classrooms_logic/data/models/studying_model.dart';
import '../../../shared_logic/classrooms_logic/domain/grade_choosing_usecases/get_classroom_use_case.dart';
import '../../../shared_logic/classrooms_logic/domain/grade_choosing_usecases/get_path_usecase.dart';
import '../../../shared_logic/classrooms_logic/domain/grade_choosing_usecases/get_stages_use_case.dart';
import '../../../shared_logic/classrooms_logic/domain/grade_choosing_usecases/get_system_types_usecase.dart';
import '../../../shared_logic/classrooms_logic/domain/grade_choosing_usecases/get_terms_use_case.dart';
import '../widgets/header_widget.dart';

part 'data/free_subjects_subscriptions_data_source/free_subjects_subscriptions_remote_data_source.dart';

part 'data/free_subjects_subscriptions_repository/free_subjects_subscriptions_repository.dart';

part 'domain/free_subjects_subscriptions_base_repository/free_subjects_subscriptions_base_repository.dart';

part 'domain/free_subjects_subscriptions_usecases/free_subjects_subscriptions_usecase.dart';

part 'presentation/free_subjects_subscriptions_screen/free_subjects_subscriptions_screen.dart';

part 'presentation/free_subjects_subscriptions_view_model/free_subjects_subscriptions_bloc.dart';

part 'presentation/free_subjects_subscriptions_view_model/free_subjects_subscriptions_event.dart';

part 'presentation/free_subjects_subscriptions_view_model/free_subjects_subscriptions_state.dart';

