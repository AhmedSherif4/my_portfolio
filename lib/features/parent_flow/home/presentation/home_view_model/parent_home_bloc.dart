import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:my_portfolio/core/enum/enum_generation.dart';
import 'package:my_portfolio/core/shared_models/user/user_entity/user_entity.dart';
import 'package:my_portfolio/features/parent_flow/home/domain/use_cases/parent_use_case.dart';

import '../../../../child_flow/home/domain/home_entities/subjects_entity.dart';

part 'parent_home_event.dart';
part 'parent_home_state.dart';

@Injectable()
class ParentHomeBloc extends Bloc<ParentHomeEvent, ParentHomeState> {
  final GetAllChildForParentUseCase getAllChildForParentUseCase;

  ParentHomeBloc(
    this.getAllChildForParentUseCase,
  ) : super(const ParentHomeState()) {
    on<GetAllChildForParentEvent>((event, emit) async {
      emit(state.copyWith(allChildState: RequestStates.loading));
      final result = await getAllChildForParentUseCase(event.parentId);

      result.fold(
        (l) => emit(state.copyWith(
            allChildState: RequestStates.error,
            allChildErrorMessage: l.message.toString())),
        (r) => emit(
            state.copyWith(allChildState: RequestStates.loaded, allChild: r)),
      );
    });
  }
}
