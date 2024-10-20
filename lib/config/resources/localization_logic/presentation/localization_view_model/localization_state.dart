import 'package:equatable/equatable.dart';
import '../../data/models/localization_model.dart';

class LanguageState extends Equatable {
  const LanguageState({
    Language? selectedLanguage,
  }) : selectedLanguage = selectedLanguage ?? Language.arabic;

  final Language selectedLanguage;

  @override
  List<Object> get props => [selectedLanguage];

  LanguageState copyWith({Language? selectedLanguage}) {
    return LanguageState(
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
    );
  }
}