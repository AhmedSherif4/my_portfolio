import 'dart:async';

import 'package:dartz/dartz.dart' hide State;
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:my_portfolio/config/resources/app_animations.dart';
import 'package:my_portfolio/config/resources/app_strings.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';
import 'package:my_portfolio/config/responsive/responsive_widget.dart';
import 'package:my_portfolio/config/routes/route_manager.dart';
import 'package:my_portfolio/core/enum/enum_generation.dart';
import 'package:my_portfolio/core/services/services_locator.dart';
import 'package:my_portfolio/core/shared_widget/base_container_have_text_and_image.dart';
import 'package:my_portfolio/core/shared_widget/header_for_terms_levels_collections.dart';
import 'package:my_portfolio/features/child_flow/questions/lessons/data/lessons_models/lesson_with_unit_model.dart';
import 'package:my_portfolio/features/child_flow/questions/lessons/domain/lessons_entities/lessons_entity.dart';
import 'package:my_portfolio/features/child_flow/questions/lessons/presentation/lessons_widgets/genral_questions_button.dart';
import 'package:my_portfolio/features/child_flow/questions/lessons/presentation/lessons_widgets/lesson_builder.dart';
import 'package:my_portfolio/my_app/app_analytics.dart';
import 'package:my_portfolio/my_app/app_reference.dart';
import '../../../../../../core/usecase/base_usecase.dart';
import '../../../../config/base_remote_data_source/base_remote_data_source.dart';
import '../../../../config/base_repository/base_repository.dart';
import '../../../../config/resources/app_constants.dart';
import '../../../../config/resources/app_values.dart';
import '../../../../config/routes/routes_names.dart';
import '../../../../core/api/end_points.dart';
import '../../../../core/failure/failure.dart';
import '../../../../core/shared_models/user/data/user_local_data_source/user_local_data_source.dart';
import '../shared/data/go_to_question_parameter.dart';
import '../shared/data/go_to_questions_data.dart';
import 'data/lessons_models/lesson_model.dart';
import 'domain/lessons_entities/lessons_with_units_entity.dart';

part 'data/lessons_data_source/lessons_remote_data_source.dart';

part 'data/lessons_repository/lessons_repository.dart';

part 'domain/lessons_base_repository/lessons_base_repository.dart';

part 'domain/lessons_usecases/lessons_usecase.dart';

part 'presentation/lessons_screen/lessons_screen.dart';

part 'presentation/lessons_view_model/lessons_bloc.dart';

part 'presentation/lessons_view_model/lessons_event.dart';

part 'presentation/lessons_view_model/lessons_state.dart';
