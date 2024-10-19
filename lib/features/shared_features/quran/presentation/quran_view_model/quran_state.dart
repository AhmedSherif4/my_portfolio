part of '../../quran.dart';

class QuranState extends Equatable {
  final RequestStates getQuranAudioState;
  final RequestStates getQuranTafseerState;
  final RequestStates getQuranPageState;

  final String getQuranAudioMessage;
  final String getQuranTafseerMessage;
  final String getQuranPageMessage;

  final List<AyahsEntity> getQuranAudioData;
  final List<AyahsEntity> getQuranTafseerData;
  final List<AyahsEntity> getQuranPageData;

  final AyahsEntity? currentAyah;
  final AyahsEntity? currentTafseerAyah;
  final int currentIndex;
  final bool isAudioPlaying;

  final ChangeTafseerStates changAyaTafseerState;
  final int currentAyaIndex;

  const QuranState({
    this.getQuranAudioState = RequestStates.initial,
    this.getQuranTafseerState = RequestStates.initial,
    this.getQuranPageState=RequestStates.initial,
    this.changAyaTafseerState=ChangeTafseerStates.initial,
    this.getQuranAudioMessage = '',
    this.getQuranTafseerMessage = '',
    this.getQuranPageMessage = '',
    this.getQuranAudioData = const [],
    this.getQuranTafseerData = const [],
    this.getQuranPageData = const [],
    this.currentAyah,
    this.currentTafseerAyah,
    this.currentIndex = 0,
    this.isAudioPlaying = false,
    this.currentAyaIndex =0,
  });

  QuranState copyWith({
    RequestStates? getQuranAudioState,
    RequestStates? getQuranTafseerState,
    RequestStates? getQuranPageState,
    String? getQuranAudioMessage,
    String? getQuranTafseerMessage,
    String? getQuranPageMessage,
    List<AyahsEntity>? getQuranAudioData,
    List<AyahsEntity>? getQuranTafseerData,
    List<AyahsEntity>? getQuranPageData,
    AyahsEntity? currentAyah,
    AyahsEntity? currentTafseerAyah,
    int? currentIndex,
    bool? isAudioPlaying,
    ChangeTafseerStates? changAyaTafseerState,
    int? currentAyaIndex,
  }) {
    return QuranState(
      getQuranAudioState: getQuranAudioState ?? this.getQuranAudioState,
      getQuranTafseerState: getQuranTafseerState ?? this.getQuranTafseerState,
      getQuranPageState: getQuranPageState ?? this.getQuranPageState,
      getQuranAudioMessage: getQuranAudioMessage ?? this.getQuranAudioMessage,
      getQuranTafseerMessage:
      getQuranTafseerMessage ?? this.getQuranTafseerMessage,
      getQuranPageMessage:
      getQuranPageMessage ?? this.getQuranPageMessage,
      getQuranAudioData: getQuranAudioData ?? this.getQuranAudioData,
      getQuranTafseerData: getQuranTafseerData ?? this.getQuranTafseerData,
      getQuranPageData: getQuranPageData ?? this.getQuranPageData,
      currentAyah: currentAyah ?? this.currentAyah,
      currentTafseerAyah: currentTafseerAyah ?? this.currentTafseerAyah,
      currentIndex: currentIndex ?? this.currentIndex,
      isAudioPlaying: isAudioPlaying ?? this.isAudioPlaying,
      changAyaTafseerState: changAyaTafseerState ?? this.changAyaTafseerState,
      currentAyaIndex: currentAyaIndex ?? this.currentAyaIndex,
    );
  }

  @override
  List<Object?> get props => [
    getQuranAudioState,
    getQuranTafseerState,
    getQuranPageState,
    getQuranAudioMessage,
    getQuranTafseerMessage,
    getQuranPageMessage,
    getQuranAudioData,
    getQuranTafseerData,
    getQuranPageData,
    currentAyah,
    currentTafseerAyah,
    currentIndex,
    isAudioPlaying,
    changAyaTafseerState,
    currentAyaIndex,
  ];
}