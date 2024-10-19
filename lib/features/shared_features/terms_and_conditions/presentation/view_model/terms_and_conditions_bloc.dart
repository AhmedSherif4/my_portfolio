part of '../../terms_and_conditions.dart';

@Injectable()
class TermsAndConditionsBloc
    extends Bloc<TermsAndConditionsEvent, TermsAndConditionsState> {
  final GetTermsAndConditionsUseCase getTermsAndConditionsUseCase;

  TermsAndConditionsBloc(this.getTermsAndConditionsUseCase)
      : super(const TermsAndConditionsState()) {
    on<GetTermsAndConditionsEvent>(_getTermsAndConditions);
  }

  void _getTermsAndConditions(GetTermsAndConditionsEvent event,
      Emitter<TermsAndConditionsState> emit) async {
    emit(state.copyWith(
      getTermsAndConditionsStates: RequestStates.loading,
    ));
    final result = await getTermsAndConditionsUseCase(const NoParameter());
    result.fold(
      (failure) => emit(state.copyWith(
        getTermsAndConditionsStates: RequestStates.error,
        getTermsAndConditionsMessage: failure.message,
      )),
      (success) => emit(state.copyWith(
        getTermsAndConditionsStates: RequestStates.loaded,
        getTermsAndConditionsData: success,
      )),
    );
  }
}
