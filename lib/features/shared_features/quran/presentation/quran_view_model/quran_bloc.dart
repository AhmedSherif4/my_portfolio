part of '../../quran.dart';

@Injectable()
class QuranBloc extends Bloc<QuranEvent, QuranState> {
  final GetQuranTextUseCase getQuranTextUseCase;
  final GetQuranAudioUseCase getQuranAudioUseCase;
  final GetQuranTafseerUseCase getQuranTafseerUseCase;
  final GetQuranPageUseCase getQuranPageUseCase;

  QuranBloc(
      {required this.getQuranTextUseCase,
        required this.getQuranAudioUseCase,
        required this.getQuranTafseerUseCase,
        required this.getQuranPageUseCase})
      : super(const QuranState()) {

    on<GetQuranAudioEvent>(_getQuranAudio);
    on<GetQuranTafseerEvent>(_getQuranTafseer);
    on<GetQuranPageEvent>(_getQuranPage);
    on<ChangeAyahEvent>(_changeAyah);
    on<ChangeAudioStateEvent>(_changeAudioState);
  }
  int index =0;
  FutureOr<void> _getQuranPage(
      GetQuranPageEvent event, Emitter<QuranState> emit) async {
    emit(state.copyWith(
      getQuranPageState: RequestStates.loading,
      // getQuranTafseerState: RequestStates.initial,
    ));

    final result = await getQuranPageUseCase(
      event.pageNumber,
    );

    result.fold(
            (failure) => emit(state.copyWith(
          getQuranPageState: RequestStates.error,
          getQuranPageMessage: failure.message,
        )),
            (data) => emit(state.copyWith(
          getQuranPageState: RequestStates.loaded,
          getQuranPageData: data,
        )));
  }

  FutureOr<void> _getQuranAudio(
      GetQuranAudioEvent event, Emitter<QuranState> emit) async {
    emit(state.copyWith(
      getQuranAudioState: RequestStates.loading,
      getQuranTafseerState: RequestStates.initial,
    ));

    final result = await getQuranAudioUseCase(
      QuranParameter(
        selectionId: event.quranParameter.selectionId,
        typeOfSelection: event.quranParameter.typeOfSelection,
        selectionText: event.quranParameter.selectionText,
      ),
    );

    result.fold(
            (failure) => emit(state.copyWith(
          getQuranAudioState: RequestStates.error,
          getQuranAudioMessage: failure.message,
        )),
            (data) => emit(state.copyWith(
          getQuranAudioState: RequestStates.loaded,
          getQuranAudioData: data,
          currentAyah: data[0],
          currentIndex: 0,
        )));
  }

  FutureOr<void> _getQuranTafseer(
      GetQuranTafseerEvent event, Emitter<QuranState> emit) async {
    emit(state.copyWith(
      getQuranTafseerState: RequestStates.loading,

    ));

    final result = await getQuranTafseerUseCase(
      QuranParameter(
        selectionId: event.quranParameter.selectionId,
        typeOfSelection: event.quranParameter.typeOfSelection,
        selectionText: event.quranParameter.selectionText,
      ),
    );

    result.fold(
            (failure) => emit(state.copyWith(
          getQuranTafseerState: RequestStates.error,
          getQuranTafseerMessage: failure.message,
        )),
            (data) => emit(state.copyWith(
          getQuranTafseerState: RequestStates.loaded,
          getQuranTafseerData: data,
          currentTafseerAyah: data[state.currentIndex],
        )));
  }



  FutureOr<void> _changeAyah(ChangeAyahEvent event, Emitter<QuranState> emit) {
    emit(state.copyWith(
      currentAyah: state.getQuranAudioData[event.index],
      currentIndex: event.index,
      getQuranTafseerState: RequestStates.initial,
    ));
  }

  FutureOr<void> _changeAudioState(
      ChangeAudioStateEvent event, Emitter<QuranState> emit) {
    emit(state.copyWith(
      isAudioPlaying: event.isPlaying,
      getQuranTafseerState: RequestStates.initial,

    ));
  }




}