part of '../../quran.dart';

abstract class QuranEvent extends Equatable {
  const QuranEvent();

  @override
  List<Object> get props => [];
}



class GetQuranAudioEvent extends QuranEvent {
  final QuranParameter quranParameter;

  const GetQuranAudioEvent({required this.quranParameter});

  @override
  List<Object> get props => [quranParameter];
}

class GetQuranTafseerEvent extends QuranEvent {
  final QuranParameter quranParameter;

  const GetQuranTafseerEvent({required this.quranParameter});

  @override
  List<Object> get props => [quranParameter];
}

class GetQuranPageEvent extends QuranEvent {
  final int pageNumber;

  const GetQuranPageEvent({required this.pageNumber});

  @override
  List<Object> get props => [pageNumber];
}

class ChangeAyahEvent extends QuranEvent {
  final int index;

  const ChangeAyahEvent({required this.index});

  @override
  List<Object> get props => [index];
}

class ChangeAudioStateEvent extends QuranEvent {
  final bool isPlaying;
  const ChangeAudioStateEvent({
    required this.isPlaying,
  });

  @override
  List<Object> get props => [isPlaying];
}


class NextAyaTafseerEvent extends QuranEvent{
  final int currentAyaIndex;

  const NextAyaTafseerEvent({required this.currentAyaIndex});


}
class BackAyaTafseerEvent extends QuranEvent{
  final int currentAyaIndex;

  const BackAyaTafseerEvent({required this.currentAyaIndex});


}