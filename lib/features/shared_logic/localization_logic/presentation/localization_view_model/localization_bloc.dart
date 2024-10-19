import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'localization_event.dart';
import 'localization_state.dart';

@Injectable()
class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(const LanguageState()) {
    on<ChangeLanguage>(onChangeLanguage);
  }

  onChangeLanguage(ChangeLanguage event, Emitter<LanguageState> emit) async {
    emit(state.copyWith(selectedLanguage: event.selectedLanguage));
  }
}