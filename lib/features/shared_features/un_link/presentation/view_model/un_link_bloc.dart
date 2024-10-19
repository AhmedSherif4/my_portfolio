part of '../../un_link.dart';


@Injectable()
class UnLinkBloc extends Bloc<UnLinkEvent, UnLinkState> {
  final UnLinkUseCase unLinkUseCase;
  final ChildAddNewParentUseCase childAddNewParentUseCase;
  final ChildAddExistParentScreenUseCase childAddExistParentScreenUseCase;
  final ParentAddNewChildUseCase parentAddNewChildUseCase;
  final ParentAddExistChildUseCase parentAddExistChildUseCase;

  UnLinkBloc(this.unLinkUseCase, this.childAddExistParentScreenUseCase, this.childAddNewParentUseCase, this.parentAddNewChildUseCase, this.parentAddExistChildUseCase) : super(const UnLinkState()) {
    on<UserUnLinkEvent>((event, emit) async {
      emit(state.copyWith(unLinkState: RequestStates.loading));
      final result = await unLinkUseCase(event.userId);
      result.fold(
          (l) => emit(state.copyWith(
              unLinkState: RequestStates.error,
              unLinkMessage: l.message.toString())),
          (r) => emit(state.copyWith(
                unLinkState: RequestStates.loaded,
                unLinkMessage: r,
              )));
    });
    on<ChildAddedNewParent>((event, emit) async {
        emit(state.copyWith(childAddNewParentStates: RequestStates.loading));
        final result = await childAddNewParentUseCase(event.emailOrPhone);
        result.fold(
              (failure) {
            emit(state.copyWith(
                childAddNewParentStates: RequestStates.error,
                childAddNewParentMessage: failure.message));
          },
              (success) {
            emit(state.copyWith(
                childAddNewParentStates: RequestStates.loaded,
                childAddNewParentMessage: success));
          },
        );
      });
    on<ChildAddedExistParent>((event, emit) async {
        emit(state.copyWith(childAddExitParentStates: RequestStates.loading));
        final result = await childAddExistParentScreenUseCase(
          event.username,
        );
        result.fold(
              (failure) {
            emit(state.copyWith(
                childAddExitParentStates: RequestStates.error,
                childAddExitParentMessage: failure.message));
          },
              (success) {
            emit(
              state.copyWith(
                childAddExitParentStates: RequestStates.loaded,
                childAddExitParentMessage: success,
              ),
            );
          },
        );
      });
    on<ParentAddedNewChild>((event, emit) async {
        emit(state.copyWith(parentAddNewChildStates: RequestStates.loading));
        final result = await parentAddNewChildUseCase(event.mailOrPhone);
        result.fold(
              (failure) {
            emit(state.copyWith(
                parentAddNewChildStates: RequestStates.error,
                parentAddNewChildMessage: failure.message));
          },
              (success) {
            emit(state.copyWith(
                parentAddNewChildStates: RequestStates.loaded,
                parentAddNewChildMessage: success));
          },
        );
      });
    on<ParentAddedExistChild>((event, emit) async {
        emit(state.copyWith(parentAddExistChildStates: RequestStates.loading));
        final result = await parentAddExistChildUseCase(event.username);
        result.fold(
              (failure) {
            emit(state.copyWith(
                parentAddExistChildStates: RequestStates.error,
                parentAddExistChildMessage: failure.message));
          },
              (success) {
            emit(state.copyWith(
                parentAddExistChildStates: RequestStates.loaded,
                parentAddExistChildMessage: success));
          },
        );
      },);
  }
}
