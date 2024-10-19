import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart' hide State;
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:my_portfolio/core/api/end_points.dart';
import 'package:my_portfolio/features/shared_logic/classrooms_logic/data/models/studying_model.dart';


import '../../../../../../core/usecase/base_usecase.dart';
import '../../../../config/base_remote_data_source/base_remote_data_source.dart';
import '../../../../config/base_repository/base_repository.dart';
import '../../../../core/failure/failure.dart';
import '../../../config/resources/app_strings.dart';
import '../../../core/enum/enum_generation.dart';
import '../../../core/services/services_locator.dart';
import '../../../core/shared_models/user/data/user_local_data_source/user_local_data_source.dart';
import '../../../core/shared_models/user/user_entity/user_entity.dart';
import '../../shared_features/subscriptions_and_packages/packages/data/model/classroom_data.dart';
import 'data/models/grade_choosing_model.dart';
import 'domain/grade_choosing_usecases/get_classroom_use_case.dart';
import 'domain/grade_choosing_usecases/get_path_usecase.dart';
import 'domain/grade_choosing_usecases/get_stages_use_case.dart';
import 'domain/grade_choosing_usecases/get_system_types_usecase.dart';
import 'domain/grade_choosing_usecases/get_terms_use_case.dart';


part 'data/grade_choosing_data_source/grade_choosing_remote_data_source.dart';
part 'data/grade_choosing_repository/grade_choosing_repository.dart';
part 'domain/grade_choosing_base_repository/grade_choosing_base_repository.dart';
part 'domain/grade_choosing_usecases/grade_choosing_usecase.dart';
part 'presentation/grade_choosing_view_model/grade_choosing_bloc.dart';
part 'presentation/grade_choosing_view_model/grade_choosing_event.dart';
part 'presentation/grade_choosing_view_model/grade_choosing_state.dart';
