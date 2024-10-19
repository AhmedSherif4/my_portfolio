part of '../../add_child.dart';


@Injectable()
class InstitutionAddChildBloc
    extends Bloc<InstitutionAddChildEvent, InstitutionAddChildState> {
  final InstitutionAddChildUseCase addChildUseCase;

  InstitutionAddChildBloc(this.addChildUseCase)
      : super(const InstitutionAddChildState()) {
    on<InstitutionAddNewChildEvent>((event, emit) async {
      emit(state.copyWith(
        institutionAddNewChildStates: RequestStates.loading,
      ));
      final result = await addChildUseCase(
        event.addChildParameter,
      );
      result.fold(
        (failure) {
          emit(state.copyWith(
              institutionAddNewChildStates: RequestStates.error,
              institutionAddNewChildMessage: failure.message));
        },
        (success) {
          emit(
            state.copyWith(
              institutionAddNewChildStates: RequestStates.loaded,
              institutionAddNewChildMessage: success,
            ),
          );
        },
      );
    });
  }
}
