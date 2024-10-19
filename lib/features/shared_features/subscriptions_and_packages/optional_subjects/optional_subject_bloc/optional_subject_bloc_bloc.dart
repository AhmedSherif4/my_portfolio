import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:my_portfolio/core/enum/enum_generation.dart';
import 'package:my_portfolio/features/shared_features/subscriptions_and_packages/optional_subjects/domain/usecase/add_optional_subject_usecase.dart';

import 'optional_subject_bloc_event.dart';
import 'optional_subject_bloc_state.dart';

@Injectable()
class OptionalSubjectBlocBloc
    extends Bloc<OptionalSubjectBlocEvent, OptionalSubjectBlocState> {
  final AddOptionalSubjectUsecase addOptionalSubjectUsecase;
  OptionalSubjectBlocBloc(this.addOptionalSubjectUsecase)
      : super(const OptionalSubjectBlocState()) {
    on<AddOptionalSubjectEvent>(_addOptionalSubjectEvent);
  }

  void _addOptionalSubjectEvent(AddOptionalSubjectEvent event,
      Emitter<OptionalSubjectBlocState> emit) async {
    emit(state.copyWith(
      addOptinalSubjectsForClassroomState: RequestStates.loading,
    ));
    final result =
        await addOptionalSubjectUsecase(event.addOptionalSubjectParameters);

    result.fold(
        (l) => emit(state.copyWith(
              addOptinalSubjectsForClassroomState: RequestStates.error,
              addOptinalSubjectsForClassroomMessage: l.message,
            )),
        (r) => emit(state.copyWith(
              addOptinalSubjectsForClassroomState: RequestStates.loaded,
              addOptinalSubjectsForClassroomMessage: r,
            )));
  }
}
