part of '../../collections.dart';

@Injectable()
class CollectionsBloc extends Bloc<CollectionsEvent, CollectionsState> {
  final CollectionsUseCase collectionsUseCase;
  // final CollectionsLocalDataSource collectionsLocalDataSource;


  CollectionsBloc(this.collectionsUseCase,
      // this.collectionsLocalDataSource,
      ) : super(const CollectionsState()) {
    on<GetCollectionsEvent>((event, emit) async {
      emit(state.copyWith(collectionsStates: RequestStates.loading));
      final response = await collectionsUseCase(event.parameters);
      response.fold(
        (failure) {
          emit(state.copyWith(
              collectionsStates: RequestStates.error,
              collectionsErrorMessage: failure.message));
        },
        (collections) {
          emit(state.copyWith(
              collectionsStates: RequestStates.loaded,
              collections: collections));
        },
      );
    });
    // on<UpdateCollectionsEvent>((event, emit) async {
    //   final listOfCollections = await collectionsLocalDataSource.getCollectionInLocalData
    //     (levelID: event.parameters.subjectId);
    //
    //   final LevelAndCollectionEntity updatedLesson =
    //   listOfCollections![event.parameters.index].copyWith(
    //     userPoints: listOfCollections[event.parameters.index]
    //           .userPoints);
    //   collectionsLocalDataSource.updateCollection(
    //       index: event.parameters.index,
    //       levelID: event.parameters.subjectId,
    //       updatedUserPoint: updatedLesson.userPoints);
    //   emit(state.copyWith(
    //     updateCollectionsState: RequestStates.loaded,
    //   ));
    // });

  }
}
