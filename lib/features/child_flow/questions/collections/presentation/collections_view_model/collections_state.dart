part of '../../collections.dart';

class CollectionsState extends Equatable {
  final RequestStates collectionsStates;
  final String collectionsErrorMessage;
  final List<LevelAndCollectionEntity> collections;

  final RequestStates updateCollectionsState;
  final String updateCollectionsErrorMessage;

  const CollectionsState(
      {this.collectionsStates = RequestStates.initial,
      this.collectionsErrorMessage = '',
      this.collections = const <LevelAndCollectionEntity>[],
      this.updateCollectionsState = RequestStates.initial,
      this.updateCollectionsErrorMessage = '',
      }
      );

  CollectionsState copyWith(
      {RequestStates? collectionsStates,
      String? collectionsErrorMessage,
      List<LevelAndCollectionEntity>? collections,
      RequestStates? updateCollectionsState,
      String? updateCollectionsErrorMessage,
      }) {
    return CollectionsState(
        collectionsStates: collectionsStates ?? this.collectionsStates,
        collectionsErrorMessage:
            collectionsErrorMessage ?? this.collectionsErrorMessage,
        collections: collections ?? this.collections,
        updateCollectionsState: updateCollectionsState ?? this.updateCollectionsState,
        updateCollectionsErrorMessage:
        updateCollectionsErrorMessage ?? this.updateCollectionsErrorMessage,
    );
  }

  @override
  List<Object> get props => [
        collectionsStates,
        collectionsErrorMessage,
        collections,
        updateCollectionsState,
        updateCollectionsErrorMessage
      ];
}
