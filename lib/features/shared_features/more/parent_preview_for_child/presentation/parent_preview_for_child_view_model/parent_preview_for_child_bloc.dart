part of '../../parent_preview_for_child.dart';

@Injectable()
class ParentPreviewForChildBloc
    extends Bloc<ParentPreviewForChildEvent, ParentPreviewForChildState> {
  final GetParentPreviewForChildUseCase getParentPreviewForChild;

  ParentPreviewForChildBloc(this.getParentPreviewForChild)
      : super(const ParentPreviewForChildState()) {
    on<GetAllParentsForChildEvent>(_getAllParents);
  }

  _getAllParents(GetAllParentsForChildEvent event,
      Emitter<ParentPreviewForChildState> emit) async {
    emit(
      state.copyWith(
        getParentState: RequestStates.loading,
      ),
    );
    final result = await getParentPreviewForChild(const NoParameter());

    result.fold((failure) {
      emit(
        state.copyWith(
          getParentState: RequestStates.error,
          getParentMessage: failure.message,
        ),
      );
    }, (allParents) {
      emit(state.copyWith(
        getParentState: RequestStates.loaded,
        allParent: allParents,
      ));
    });
  }
}
